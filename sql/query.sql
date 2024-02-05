select res from 
(select 1 as seq,name||'('||substr(occupation,1,1)||')' as res from occupations
union all
select 2 as seq,'There are a total of '||cnt||' '||lower(occupation)||'s.'
from (select occupation,count(1) as cnt from occupations
group by occupation) a ) b 
order by seq,res;