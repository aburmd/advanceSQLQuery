'''HackerRank:
1.Draw The Triangle 1:
P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):
* * * * * 
* * * * 
* * * 
* * 
*
Write a query to print the pattern P(20).
recursive - redshift,postgre,mysql need this word after with
oracle - only with should be there
'''

with recursive
    vw_p20_pattern (pattern,rownm)
        as (
    select b.pattern,20 as rownm from (select 'a' as pattern) b
    union all
    select a.pattern,a.rownm -1 as rownm from vw_p20_pattern a,(select 'a' as pattern) b
    where a.pattern=b.pattern and a.rownm -1 > 0)
select replace(repeat(pattern,rownm),'a','* ') from vw_p20_pattern;

'''
2.Query all columns for all American cities in the CITY table with populations larger than 100000. 
The CountryCode for America is USA.

select * from city where CountryCode='USA' and population > 100000;

3.Write a query to print all prime numbers less than or equal to . Print your result on a single line, and use the ampersand () character as your separator (instead of a space).

For example, the output for all prime numbers  would be:
2&3&5&7

/**
create 2-1000 entry using recursive view, then using sub alias, make a result set as below:
for mainset,subset values like .. 3:[2], 4:[3,2], 5:[4,3,2],6:[5,4,3,2] and so on. untill 1000
then apply filter if mainset holds mod as 0 for any entry.
The above set contains non-prime list, if they will be negate with full list which gets prime number

oracle, resdhsift - list aggr:
list_aggr(col,'delimter') within group (order by col)
postgre - string_agg
string_agg(col,'delimter' order by col)
note: col needs to cast as varchar
mysql - group_concat
group_concat(col order by col seperator 'delimter')
**/
'''

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
'''
4.The PADS

Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, 
immediately followed by the first letter of each profession as a parenthetical 
(i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).

Query the number of ocurrences of each occupation in OCCUPATIONS. 
Sort the occurrences in ascending order, and output them in the following format:
There are a total of [occupation_count] [occupation]s.
'''

select res from 
(select 1 as seq,name||'('||substr(occupation,1,1)||')' as res from occupations
union all
select 2 as seq,'There are a total of '||cnt||' '||lower(occupation)||'s.'
from (select occupation,count(1) as cnt from occupations
group by occupation) a ) b 
order by seq,res;

'''
5.Occupations

Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.

Input Format

The OCCUPATIONS table is described as follows:

'''

select max(doctor) as doctor,max(professor) as professor,
        max(singer) as singer,
        max(actor) as actor
from 
(select row_number() over(partition by occupation order by name) as rnk,
(case when occupation='Doctor' then name else null end) as doctor,
(case when occupation='Professor' then name else null end) as professor,
(case when occupation='Singer' then name else null end) as singer,
(case when occupation='Actor' then name else null end) as actor
 from occupations) a group by rnk order by rnk;

'''
6.
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, 
and P is the parent of N.

column,type
N,integer
P,integer

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
Sample Input

N|P
1|2
3|2
6|8
9|8
2|5
8|5
5|null
'''

select n,(case when p is null then 'Root' else 
            (case when n in (select distinct p from bst) then 'Inner' else 'Leaf' end) end) from bst
order by n;
'''
7. New Companies
Amber''s conglomerate corporation just acquired some new companies. Each of the companies follows

Founder -> Lead Manager -> Senior Manger -> Manager -> Employee
this hierarchy: 

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

Note:

The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.
Input Format

The following tables contain company data:

Company: The company_code is the code of the company and founder is the founder of the company. 

Lead_Manager: The lead_manager_code is the code of the lead manager, and the company_code is the code of the working company. 

Senior_Manager: The senior_manager_code is the code of the senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 

Manager: The manager_code is the code of the manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 

Employee: The employee_code is the code of the employee, the manager_code is the code of its manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 

'''

select a.company_code,a.founder,b.cnt_lead_manager,c.cnt_senior_manager,d.cnt_manager,e.cnt_employee 
from 
(select distinct company_code,founder from company) a,
(select company_code,count(1) as cnt_lead_manager from 
(select distinct company_code,lead_manager_code from lead_manager) a
group by company_code) b,
(select company_code,count(1) as cnt_senior_manager from
(select distinct company_code,senior_manager_code from senior_manager) a
group by company_code) c,
(select company_code,count(1) as cnt_manager from
(select distinct company_code,manager_code from manager) a
group by company_code) d,
(select company_code,count(1) as cnt_employee from
(select distinct company_code,employee_code from employee)  a
group by company_code) e
where a.company_code=b.company_code
and a.company_code=c.company_code
and a.company_code=d.company_code
and a.company_code=e.company_code
order by a.company_code;

'''
8.Weather Observation Station 18
Consider  and  to be two points on a 2D plane.

 happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
 happens to equal the minimum value in Western Longitude (LONG_W in STATION).
 happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
 happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.

Input Format

The STATION table is described as follows:

manhattan distance p(x1,y1) & q(x2,y2) = |x1-x2|+|y1-y2|

where LAT_N is the northern latitude and LONG_W is the western longitude.
'''

select round(cast((abs(min(lat_n)-max(lat_n)) + abs(min(long_w)-max(long_w))) as decimal),4) P1P2_distance from station;
