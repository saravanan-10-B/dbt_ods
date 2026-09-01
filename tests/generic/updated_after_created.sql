{% test updated_after_created(model, column_name, compare_column) %}

select * from {{ model }}
where {{ column_name }} < {{ compare_column }}


{% endtest %}