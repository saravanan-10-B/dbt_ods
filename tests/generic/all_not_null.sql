{% test all_not_null(model) %}

{% set columns = adapter.get_columns_in_relation(model) %}

{% for column in columns %}

select '{{ column.name }}', count(*) as not_null_cnt
from {{ model }}
where {{ column.name }} is null 
having count(*) > 0

{% if not loop.last %}
    union all
{% endif %}
{% endfor %}
{% endtest %}