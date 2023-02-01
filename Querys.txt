Challenge 1

- Primera query
SELECT titles.title_id, titleauthor.au_id,
titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100) as sales_royalty
	FROM titleauthor
	LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales
		ON sales.title_id = titles.title_id

-Segunda query

SELECT titles.title_id, titleauthor.au_id,
SUM(titles.price * sales.qty * (titles.royalty / 100) * 
(titleauthor.royaltyper / 100)) 
as total_royalty
	FROM titleauthor
	LEFT JOIN titles ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales ON sales.title_id = titles.title_id
	GROUP BY titles.title_id, titleauthor.au_id

-Tercera query
SELECT titleauthor.au_id,
SUM(titles.price * sales.qty * (titles.royalty / 100) * 
(titleauthor.royaltyper / 100) +  (titles.advance))
as profits
	FROM titleauthor
	LEFT JOIN titles ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales ON sales.title_id = titles.title_id
	GROUP BY titles.title_id, titleauthor.au_id
    ORDER BY profits DESC
    LIMIT 3   
CHALLENGE 2

CREATE TEMPORARY TABLE LOL
SELECT titleauthor.au_id,
SUM(titles.price * sales.qty * (titles.royalty / 100) * 
(titleauthor.royaltyper / 100)) + (titles.advance)
as profits
	FROM titleauthor
	LEFT JOIN titles ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales ON sales.title_id = titles.title_id
	GROUP BY titles.title_id, titleauthor.au_id
    ORDER BY profits DESC
    LIMIT 3   

SELECT * 
FROM LOL

CHALLENGE 3


CREATE TABLE most_profiting_authors
SELECT titleauthor.au_id,
SUM(titles.price * sales.qty * (titles.royalty / 100) * 
(titleauthor.royaltyper / 100)) + (titles.advance)
as profits
	FROM titleauthor
	LEFT JOIN titles ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales ON sales.title_id = titles.title_id
	GROUP BY titles.title_id, titleauthor.au_id
    ORDER BY profits DESC
    LIMIT 3   
