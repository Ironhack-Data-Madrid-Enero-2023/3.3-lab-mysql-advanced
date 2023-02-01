-- SOLUTION 1 (SUBQUERIES)

select Author_ID, Profit
from
(select author_id as Author_ID, concat(a_s.first_name,' ',a_s.LAST_NAME) as Author_Name,title_id as Title_ID, Title, sum(sales_royalty)+advance as Profit

from
(select a.au_id as author_id, a.au_lname as LAST_NAME, a.au_fname as FIRST_NAME,t.title_id as title_id,t.title as title, pub.pub_name as pub_name,s.qty as saleqty,t.royalty, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty, t.advance

from authors as a
left join titleauthor as ta
on ta.au_id = a.au_id
left join titles as t
on t.title_id = ta.title_id
left join publishers as pub
on pub.pub_id = t.pub_id
left join sales as s
on s.title_id = t.title_id
left join roysched as roy
on roy.title_id = t.title_id
) as a_s

group by a_s.author_id , a_s.title_id) as b_s

order by Profit Desc


-- ALTERNATIVE SOLUTION 1 (TEMPORARY TABLES)

create temporary table temp
(select a.au_id as author_id, a.au_lname as LAST_NAME, a.au_fname as FIRST_NAME,t.title_id as title_id,t.title as title, pub.pub_name as pub_name,s.qty as saleqty,t.royalty,roy.royalty as roy2, (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty, t.advance as advance

from authors as a
left join titleauthor as ta
on ta.au_id = a.au_id
left join titles as t
on t.title_id = ta.title_id
left join publishers as pub
on pub.pub_id = t.pub_id
left join sales as s
on s.title_id = t.title_id
left join roysched as roy
on roy.title_id = t.title_id
);



;


-- Solution 2 (Create Table)

create table most_profiting_authors
as select temp.author_id as au_id, sum(temp.sales_royalty)+advance as profits 
from temp
group by temp.author_id, temp.title_id, temp.advance
order by profits desc
;