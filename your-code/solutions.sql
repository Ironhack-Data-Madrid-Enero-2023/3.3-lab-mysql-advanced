-- Challenge 1 - Most Profiting Authors
-- Step 1: Calculate the royalties of each sales for each author

select titles.title_id, authors.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id=titles.title_id
left join sales 
on sales.title_id=titles.title_id;

-- Step 2: Aggregate the total royalties for each title for each author

select titles.title_id, authors.au_id, sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id=titles.title_id
left join sales 
on sales.title_id=titles.title_id
group by title_id , au_id;

-- Step 3: Calculate the total profits of each author

select authors.au_id, sum((titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)+ titles.advance) as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id=titles.title_id
left join sales 
on sales.title_id=titles.title_id
group by au_id  
order by sales_royalty desc
limit 3;

-- Challenge 2 - Alternative Solution

CREATE TEMPORARY TABLE table5
select titles.title_id as tt, authors.au_id as aa , (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty, titles.advance as ta
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id=titles.title_id
left join sales 
on sales.title_id=titles.title_id;

CREATE TEMPORARY TABLE table6
select tt , aa , sum(sales_royalty) as ssr, ta
from table5
group by aa , tt, ta;

select aa , (ssr + ta)
from table6
order by aa desc;

-- Challenge 3

create table most_profiting_authors
select authors.au_id, sum((titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100)+ titles.advance) as sales_royalty
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id=titles.title_id
left join sales 
on sales.title_id=titles.title_id
group by au_id  
order by sales_royalty desc;
