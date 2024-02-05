with recursive vw_numbers (rownm) as
        (select 1001 as rownm
        union all
        select a.rownm -1 as rownm from vw_numbers a
        where a.rownm -1 > 1)
select STRING_AGG(cast(rownm as varchar),'&' order by rownm) as prime 
from vw_numbers al 
where not exists 
(select 1 from 
            (select distinct b.rownm from vw_numbers a, vw_numbers b
                    where a.rownm < b.rownm and mod(b.rownm,a.rownm)=0) np 
                    where al.rownm=np.rownm);
