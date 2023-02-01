-- C1S1
SELECT titleauthor.title_id, titleauthor.au_id, coalesce((titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100),0) as sales_royalty
FROM titles
left join titleauthor on titles.title_id = titleauthor.title_id
left join authors on titleauthor.au_id = authors.au_id
left join sales on titleauthor.title_id = sales.title_id
where titleauthor.au_id is not null;
-- C1S2
SELECT tabla.title_id, tabla.au_id, sum(sales_royalty) as sales
FROM (SELECT titleauthor.title_id, titleauthor.au_id, coalesce((titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100),0) as sales_royalty
FROM titles
left join titleauthor on titles.title_id = titleauthor.title_id
left join authors on titleauthor.au_id = authors.au_id
left join sales on titleauthor.title_id = sales.title_id
where titleauthor.au_id is not null) as tabla
group by tabla.title_id, tabla.au_id order by sum(sales_royalty) desc
;
-- C1S3
SELECT tabla.au_id, sum(sales)
FROM (SELECT tabla.title_id, tabla.au_id, sum(sales_royalty) as sales
FROM (SELECT titleauthor.title_id, titleauthor.au_id, coalesce((titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100),0) as sales_royalty
FROM titles
left join titleauthor on titles.title_id = titleauthor.title_id
left join authors on titleauthor.au_id = authors.au_id
left join sales on titleauthor.title_id = sales.title_id
where titleauthor.au_id is not null) as tabla
group by tabla.title_id, tabla.au_id order by sum(sales_royalty) desc) as tabla
group by  tabla.au_id order by sum(sales) desc
limit 3
;

-- challenge 2
-- p1
CREATE TEMPORARY TABLE tabla_temp AS
SELECT titleauthor.title_id, titleauthor.au_id, coalesce((titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100),0) as sales_royalty
FROM titles
left join titleauthor on titles.title_id = titleauthor.title_id
left join authors on titleauthor.au_id = authors.au_id
left join sales on titleauthor.title_id = sales.title_id
where titleauthor.au_id is not null;

-- p2
SELECT tabla_temp.title_id, tabla_temp.au_id, sum(sales_royalty) as sales
FROM tabla_temp
group by tabla_temp.title_id, tabla_temp.au_id order by sum(sales_royalty) desc;

-- p3
SELECT tabla_temp.au_id, sum(sales_royalty) as sales
from tabla_temp
group by  tabla_temp.au_id order by sum(sales_royalty) desc
limit 3
;
-- challenge 3 
create table most_profiting_authors
SELECT tabla_temp.au_id, sum(sales_royalty) as profits
from tabla_temp
group by  tabla_temp.au_id order by sum(sales_royalty) desc
limit 3


