select advance + royaltotal as res, step2.au_id from 
(select sum(step1.roysalaut) as royaltotal, step1.au_id, step1.title_id, step1.advance as advance
from
(select titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as roysalaut, titles.title_id, titleauthor.au_id, titles.advance

from titles 
left join titleauthor
on titles.title_id = titleauthor.title_id
left join roysched as roy
on titles.title_id = roy.title_id
left join sales 
on titles.title_id = sales.title_id )step1

group by step1.title_id, step1.au_id)step2
order by res desc;

-- challenge 2
-- create temporary table first1
-- select titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as roysalaut, titles.title_id, titleauthor.au_id, titles.advance

-- from titles 
-- left join titleauthor
-- on titles.title_id = titleauthor.title_id
-- left join roysched as roy
-- on titles.title_id = roy.title_id
-- left join sales 
-- on titles.title_id = sales.title_id 

-- create temporary table second2 
-- select sum(first1.roysalaut) as royaltotal, first1.au_id, first1.title_id, first1.advance as advance
-- from first1

-- group by first1.title_id, first1.au_id, first1.advance

-- order by res desc;
-- create temporary table third3
-- select advance + royaltotal as res, second2.au_id from second2

-- order by res desc;

-- create table most_profiting_authors 
-- select advance + royaltotal as profits, second2.au_id from second2
-- order by profits desc