#Challenge 2
drop temporary table if exists tablatem ;
create temporary table tablatem
select  titles.title_id as Title_ID, authors.au_id as AUTHOR_ID,
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on titleauthor.title_id = sales.title_id
order by sales_royalty desc
;

select   Title_ID, AUTHOR_ID, SUM(sales_royalty) as total
from tablatem
group by Title_ID, AUTHOR_ID;

drop table if exists most_profiting_authors ;
create table most_profiting_authors
select   Title_ID, AUTHOR_ID, SUM(sales_royalty) as profits
from tablatem
group by Title_ID, AUTHOR_ID
;