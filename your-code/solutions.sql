    #challenge 1
select  titles.title_id, titleauthor.au_id,

titles.price * sales.qty * (titles.royalty / 100) * 
(titleauthor.royaltyper / 100) as sales_royalty
	
    from titleauthor
    left join titles
    on titleauthor.title_id=titles.title_id
    left join sales
    on sales.title_id= titles.title_id
    ;
    
    
    #step  2
   
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

#step 3
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
