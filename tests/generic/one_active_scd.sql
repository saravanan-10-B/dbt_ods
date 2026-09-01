{% test one_active_scd(model, business_key) %}

select 
{{business_key}}, count(*) as con from {{model}}
where dbt_valid_to is null
group by {{business_key}}
having count(*) >1

{% endtest %}