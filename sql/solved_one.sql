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



