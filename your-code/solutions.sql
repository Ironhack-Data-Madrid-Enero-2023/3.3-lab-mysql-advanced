#paso uno del challenge 1
select  titles.title_id as "Title ID", authors.au_id as "AUTHOR ID",
(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as "sales_royalty"
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on titleauthor.title_id = sales.title_id
order by sales_royalty desc
;

#paso 2 del challenge 1
select  titles.title_id as "Title ID", authors.au_id as "AUTHOR ID",
SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as "sales_royalty"
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on titleauthor.title_id = sales.title_id
group by titles.title_id, authors.au_id
order by sales_royalty desc
;
#paso 3 del callenge 1
select  authors.au_id as "AUTHOR ID",
SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as "sales_royalty"
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on titleauthor.title_id = sales.title_id
group by  authors.au_id
order by sales_royalty desc
limit 3
;
 