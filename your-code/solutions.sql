--Challenge 1 : 

create temporary table p1
(SELECT authors.au_id, au_lname, au_fname, titles.title_id, title, pub_name, advance, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty 
FROM authors

left join titleauthor 
on authors.au_id = titleauthor.au_id

left join titles 
on titleauthor.title_id = titles.title_id

left join publishers 
on titles.pub_id = publishers.pub_id

left join  sales
on titles.title_id = sales.title_id
)
;

Create temporary table p2
(select * 
from p1
group by au_id, title_id
)
;

select au_id, title_id, title, au_lname, au_fname, advance + sales_royalty as  total_profits
from p2


limit 10
;


--Challenge 2 : 

SELECT auths, aul, auf, ttid, tit, pubn, adv, total_profits

from
(select authors.au_id as auths, au_lname as aul, au_fname as auf, titles.title_id as ttid, title as tit, pub_name as pubn, advance as adv,
titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 + advance as total_profits

FROM authors

left join titleauthor 
on authors.au_id = titleauthor.au_id

left join titles 
on titleauthor.title_id = titles.title_id

left join publishers 
on titles.pub_id = publishers.pub_id

left join  sales
on titles.title_id = sales.title_id



group by authors.au_id, titles.title_id

limit 10
) youknow
;






--Challenge3 
create table Challenge_3

select au_id, total_profits as profits  
from challenge2

order by profits desc

;

select *
from challenge_3


