---------- CHALLENGE 1 -----------



STEP 1

SELECT t.title_id as 'Title ID', 
       au.au_id as 'Author ID', 
       (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty

FROM titles as t

LEFT JOIN titleauthor as ta
ON ta.title_id = t.title_id
LEFT JOIN authors as au
ON au.au_id = ta.au_id
LEFT JOIN sales as s
ON s.title_id = t.title_id
;



--------- STEP 2

SELECT t.title_id as 'Title ID', 
       au.au_id as 'Author ID', 
       SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sum_sales_royalty

FROM titles as t

LEFT JOIN titleauthor as ta
ON ta.title_id = t.title_id
LEFT JOIN authors as au
ON au.au_id = ta.au_id
LEFT JOIN sales as s
ON s.title_id = t.title_id

GROUP BY au.au_id, t.title_id
;



--------- STEP 3

SELECT  au.au_id as 'Author ID', 
	SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) 
        + t.advance as sales_royalty_plus_advance

FROM titles as t

LEFT JOIN titleauthor as ta
ON ta.title_id = t.title_id
LEFT JOIN authors as au
ON au.au_id = ta.au_id
LEFT JOIN sales as s
ON s.title_id = t.title_id

GROUP BY au.au_id, t.title_id
ORDER BY sales_royalty_plus_advance DESC
LIMIT 3
;



---------- CHALLENGE 2 -----------

---------- STEP 1

SELECT t.title_id as 'Title ID', 
       au.au_id as 'Author ID', 
       (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty

FROM titles as t

LEFT JOIN titleauthor as ta
ON ta.title_id = t.title_id
LEFT JOIN authors as au
ON au.au_id = ta.au_id
LEFT JOIN sales as s
ON s.title_id = t.title_id
;


---------- STEP 2

CREATE TEMPORARY TABLE step11
AS

(SELECT t.title_id as 'Title ID', 
       au.au_id as 'Author ID', 
       (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) as sales_royalty

FROM titles as t

LEFT JOIN titleauthor as ta
ON ta.title_id = t.title_id
LEFT JOIN authors as au
ON au.au_id = ta.au_id
LEFT JOIN sales as s
ON s.title_id = t.title_id
);


---------- STEP 3

CREATE TEMPORARY TABLE step2
AS

(SELECT 'Title ID', 
       'Author ID', 
       sales_royalty + t.advance  as sales_royalty_plus_advance

FROM step11 as s1

LEFT JOIN titles as t
ON t.title_id = s1.`Title ID`)
;






---------- CHALLENGE 3 -----------

CREATE TABLE most_profiting_authors
AS

SELECT  au.au_id as 'Author ID', 
	SUM(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) 
        + t.advance as profits

FROM titles as t

LEFT JOIN titleauthor as ta
ON ta.title_id = t.title_id
LEFT JOIN authors as au
ON au.au_id = ta.au_id
LEFT JOIN sales as s
ON s.title_id = t.title_id

GROUP BY au.au_id, t.title_id
ORDER BY profits DESC
LIMIT 3
;

SELECT *
FROM most_profiting_authors
;