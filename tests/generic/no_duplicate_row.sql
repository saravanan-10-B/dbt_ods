{% test no_duplicate_row(model) %}

select *, count(*) as cont
from {{ model }}
group by all
having count(*) >1


{% endtest %}