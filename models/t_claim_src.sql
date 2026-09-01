{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = 'claim_id',
        database = env_var("DBT_DB") ,
        schema = env_var("DBT_SCH"),
        on_schema_change = 'sync_all_columns'
    )
}}

with dedup as 
(select * from {{ source('src','SOURCE_CLAIMS')}} 
qualify  row_number () over(partition by claim_id order by updated_at desc) =1
)

select 
 a.CLAIM_ID        ,
    a.POLICY_ID       ,
    a.CUSTOMER_ID     ,
    a.CLAIM_STATUS    ,
    a.CLAIM_AMOUNT    ,
    a.RESERVE_AMOUNT  ,
    {% if is_incremental() %}
        case when b.claim_id is not null 
        then b.created_at else a.updated_at end
    {% else %}
        a.updated_at 
    {% endif %} as created_at,
    current_timestamp() as  changed_at  from dedup a 
{% if is_incremental() %}
    left join {{ this }} b on (a.claim_id = b.claim_id)
    where a.updated_at > (select max(created_at) - interval '3' day from {{ this }})
{% endif %}