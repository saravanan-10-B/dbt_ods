{% snapshot t_claim_scd %}

{{
    config(
        unique_key = 'claim_id',
        strategy = 'timestamp',
        updated_at = 'UPDATED_AT'
    )
}}

select * from
{{source('src','SOURCE_CLAIMS')}}


{% endsnapshot %}