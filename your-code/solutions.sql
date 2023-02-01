
-- CHALLENGE 1

-- STEP 1
select authors.au_id as AuthorID, titles.title as Title, (titles.price * sales.qty * titles.royalty / 100 *titleauthor.royaltyper / 100) as SalesRoyalty from authors
left join titleauthor on titleauthor.au_id = authors.au_id
left join titles on titles.title_id = titleauthor.title_id
left join sales on titles.title_id = sales.title_id
;


-- STEP 2
select authors.au_id as AuthorID, titles.title as Title, sum(titles.price * sales.qty * titles.royalty / 100 *titleauthor.royaltyper / 100) as SalesRoyalty from authors
left join titleauthor on titleauthor.au_id = authors.au_id
left join titles on titles.title_id = titleauthor.title_id
left join sales on titles.title_id = sales.title_id

group by authorid, title
order by salesroyalty desc
;


-- STEP 3
select authors.au_id as AuthorID, au_fname as `First Name`, au_lname as `Last Name`, (sum(titles.price * sales.qty * titles.royalty / 100 *titleauthor.royaltyper / 100) + sum(titles.advance)) as Profit from authors
left join titleauthor on titleauthor.au_id = authors.au_id
left join titles on titles.title_id = titleauthor.title_id
left join sales on titles.title_id = sales.title_id

group by authorid, `First Name`, `Last Name`
order by profit desc
limit 3
;


-- CHALLENGE 2

create temporary table profitbyauthor1
select authors.au_id as AuthorID, au_fname as `First Name`, au_lname as `Last Name`, (sum(titles.price * sales.qty * titles.royalty / 100 *titleauthor.royaltyper / 100) + sum(titles.advance)) as Profit from authors
left join titleauthor on titleauthor.au_id = authors.au_id
left join titles on titles.title_id = titleauthor.title_id
left join sales on titles.title_id = sales.title_id

group by authorid, `First Name`, `Last Name`
order by profit desc
limit 3
;


-- CHALLENGE 3

create table most_profiting_authors 
select authors.au_id as AuthorID, (sum(titles.price * sales.qty * titles.royalty / 100 *titleauthor.royaltyper / 100) + sum(titles.advance)) as Profit from authors
left join titleauthor on titleauthor.au_id = authors.au_id
left join titles on titles.title_id = titleauthor.title_id
left join sales on titles.title_id = sales.title_id

group by authorid
order by profit desc
limit 3
;
