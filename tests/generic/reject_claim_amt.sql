{% test reject_claim_amt(model, stat_column, amt_column) %}

select * from {{model}}
where lower({{ stat_column }}) in ('rejected') 
and coalesce({{amt_column}},0) != 0

{% endtest %}