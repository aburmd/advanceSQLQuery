select n,(case when p is null then 'Root' else 
            (case when n in (select distinct p from bst) then 'Inner' else 'Leaf' end) end) from bst
order by n;