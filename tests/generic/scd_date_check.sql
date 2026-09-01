{% test scd_date_check(model, business_key) %}

with records as (

    select
        {{ business_key }},
        dbt_VALID_FROM,
        dbt_VALID_TO,
        lead(dbt_VALID_FROM) over (
            partition by {{ business_key }}
            order by dbt_VALID_FROM
        ) as next_valid_from
    from {{ model }}

)

select *
from records
where dbt_VALID_TO is not null
  and dbt_VALID_TO > next_valid_from

{% endtest %}