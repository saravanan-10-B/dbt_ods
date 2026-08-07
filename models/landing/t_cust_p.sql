{{ config(materialized = 'table',
          transient = 'false'
) }}
  select customer_id, split_part(name,' ',1) as first_name,
    split_part(name,' ',2 ) as last_name , email, city from ods.public.customers