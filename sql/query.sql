with vw as 
(select b.salesperson_id,max(b.amount) as amount
from salesperson a,
orders b
where a.id=b.salesperson_id
group by b.salesperson_id)
select 
b.name salesperson_name,
a.amount,
c.number as order_num,
d.name as cust_name from vw a,
salesperson b,
orders c, customer d
where a.salesperson_id=b.id and a.amount=c.amount and a.salesperson_id=c.salesperson_id
and c.cust_id=d.id;
