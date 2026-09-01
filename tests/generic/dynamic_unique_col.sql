{% test dynamic_unique_col(model, columns) %}

select {% for col in columns %} {{col}}
     {%if not loop.last%} , {% endif %} 
     {% endfor %}  , count(*) as cnt from {{ model }}
group by 
{% for col in columns %} {{col}}
{% if not loop.last%} , {% endif %}
{% endfor %}
having count(*) >1
{% endtest %}