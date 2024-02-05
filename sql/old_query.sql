'''
1.
We want to retrieve the names of all salespeople that have more than 1 order from the tables above. 
You can assume that each salesperson only has one ID.

select a.name from salesperson a, Orders b
where a.id=b.salesperson_id
group by a.id,a.name
having count(1) > 1;

2.Here is the problem: 
find the largest order amount for each salesperson and the associated order number,
 along with the customer to whom that order belongs to. You can present your answer in any database’s SQL – MySQL, 
 Microsoft SQL Server, Oracle, etc.

typ1:
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

typ2:
with vw as 
(select b.salesperson_id,max(b.number) as order_num,max(b.amount) as amount
from salesperson a,
orders b
where a.id=b.salesperson_id
group by b.salesperson_id)
select b.name salesperson_name, 
a.order_num,
a.amount,
d.name as cust_name from vw a,
salesperson b,
orders c, customer d
where a.salesperson_id=b.id
and a.order_num=c.number
and c.cust_id=d.id;

typ3:
select b.name salesperson_name, 
max(c.number) as order_num,
max(c.amount) as amount,
max(d.name) as cust_name from 
salesperson b,
orders c, customer d
where b.id=c.salesperson_id
and c.cust_id=d.id
group by c.salesperson_id,b.name;

'''