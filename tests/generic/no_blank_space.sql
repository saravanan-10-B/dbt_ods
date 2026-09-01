{% test no_blank_space(model,column_name) %}

select * from {{ model }}
where {{ column_name }} is null or trim({{ column_name }}) =''

{% endtest %}