{% test duplicate_comb_check(model, col1, col2) %}

select {{ col1 }}, {{ col2 }}, count(*) as cnt from {{ model }}
group by {{ col1 }}, {{ col2 }}
having count(*) >1

{% endtest %}