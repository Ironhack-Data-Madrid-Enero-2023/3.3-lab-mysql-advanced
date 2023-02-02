Challenge I.I

select  titles.title_id, titleauthor.au_id, 

titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100) as sales_royalty
	
    from titleauthor
    
    left join titles
    on titleauthor.title_id=titles.title_id
    left join sales 
    on sales.title_id= titles.title_id
    
    ;

I.II

select  titles.title_id, titleauthor.au_id, 

sum(titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100)) as sales_royalty
	
    from titleauthor
    
    left join titles
    on titleauthor.title_id=titles.title_id
    left join sales 
    on sales.title_id= titles.title_id
    group by titleauthor.title_id, titleauthor.au_id
   

   ;

I.III



select  titleauthor.au_id, 

sum(titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100)) + titles.advance as profits
	
    from titleauthor
    
    left join titles
    on titleauthor.title_id=titles.title_id
    left join sales 
    on sales.title_id= titles.title_id
    group by titleauthor.title_id, titleauthor.au_id
   order by profits desc 
   limit 3
   
;

CHALLENGE II

CREATE TEMPORARY TABLE publications.top_3_profits

select  titleauthor.au_id, 

sum(titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100)) + titles.advance as profits
	
    from titleauthor
    
    left join titles
    on titleauthor.title_id=titles.title_id
    left join sales 
    on sales.title_id= titles.title_id
    group by titleauthor.title_id, titleauthor.au_id
   order by profits desc 
   limit 3
   
;

CHALLENGE III

CREATE TABLE publications.most_profiting_authors

select  titleauthor.au_id, 

sum(titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100)) + titles.advance as profits
	
    from titleauthor
    
    left join titles
    on titleauthor.title_id=titles.title_id
    left join sales 
    on sales.title_id= titles.title_id
    group by titleauthor.title_id, titleauthor.au_id
   order by profits desc 
   limit 3
   
;



