Write a SELECT query to obtain the following output:

* Title ID
* Author ID
* Royalty of each sale for each author
    * The formular is:
        sales_royalty = titles.price * sales.qty titles.royalty / 100 * titleauthor.royaltyper / 100

-----------------

Select ti.title_id as "TITLE ID", a.au_id as "Author ID", (ti.price * s.qty * ti.royalty / 100 * ta.royaltyper / 100) AS "Royalties"

    From authors as a
    left join titleauthor as ta on a.au_id = ta.au_id
    left join titles as ti on ta.title_id = ti.title_id
    left join sales as s on ti.title_id = s.title_id
    left join roysched as r on s.title_id = ti.title_id
;


### Step 2: Aggregate the total royalties for each title for each author

Using the output from Step 1, write a query to obtain the following output:

* Title ID
* Author ID
* Aggregated royalties of each title for each author
    * Hint: use the *SUM* subquery and group by both `au_id` and `title_id`

In the output of this step, each title should appear only once for each author.
    
----------

Select ti.title_id as "TITLE ID", a.au_id as "Author ID", sum((ti.price * s.qty * ti.royalty / 100 * ta.royaltyper / 100)) AS "Royalties agg"

    From authors as a
    left join titleauthor as ta on a.au_id = ta.au_id
    left join titles as ti on ta.title_id = ti.title_id
    left join sales as s on ti.title_id = s.title_id
    left join roysched as r on s.title_id = ti.title_id
    
    GROUP BY a.au_id, ti.title_id
    ;


### Step 3: Calculate the total profits of each author

Now that each title has exactly one row for each author where the advance and royalties are available, we are ready to obtain the eventual output. Using the output from Step 2, write a query to obtain the following output:

* Author ID
* Profits of each author by aggregating the advance and total royalties of each title

Sort the output based on a total profits from high to low, and limit the number of rows to 3.

--------------------------

SELECT a.au_id AS "Author ID", SUM("Royalties agg" + ti.advance) AS "Profits of each author"

		From authors as a
		left join titleauthor as ta on a.au_id = ta.au_id
		left join titles as ti on ta.title_id = ti.title_id
		left join sales as s on ti.title_id = s.title_id
		left join roysched as r on s.title_id = ti.title_id
		
GROUP BY a.au_id
ORDER BY "Profits of each author" desc
LIMIT 3



-------------------------





CREATE TEMPORARY TABLE step1
AS
(SELECT a.au_id AS 'AUTHOR ID', a.au_lname AS 'LAST NAME', a.au_fname AS 'FIRST NAME', count(title) AS "Title Count", pu.pub_name AS  "Publisher"
FROM authors AS a  
LEFT JOIN titleauthor AS ta ON a.au_id = ta.au_id
LEFT JOIN titles as ti ON ta.title_id = ti.title_id
LEFT JOIN publishers AS pu ON ti.pub_id = pu.pub_id
left join roysched as r on s.title_id = ti.title_id

GROUP BY a.au_id, pu.pub_name)
;


CREATE TEMPORARY TABLE step2
AS
(SELECT 'AUTHOR ID', ti.title_id as 'TITLE ID', SUM(ti.price * s.qty * ti.royalty / 100 * ta.royaltyper / 100) as royalties_agg
FROM step1 AS s1  
LEFT JOIN authors AS au  ON s1.`AUTHOR ID`
LEFT JOIN titleauthor AS ta ON s1.`AUTHOR ID` = ta.au_id
LEFT JOIN titles as ti ON ta.title_id = ti.title_id
left join sales as s on ti.title_id = s.title_id

GROUP BY s1.`AUTHOR ID`, ti.title_id)
;


CREATE TABLE permanent_table
AS
SELECT * FROM step1
UNION ALL
SELECT * FROM step2;