{% test case_insensistive_status(model, column_name, values) %}

select * from {{ model }}
where upper({{ column_name }} ) not in (
{% for value in values %}
    '{{ value | upper }}'
{% if not loop.last %} , {% endif %}
{% endfor %}

)

{% endtest %}