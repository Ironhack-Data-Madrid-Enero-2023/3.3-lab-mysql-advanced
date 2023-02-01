QUERY 1.1.

SELECT titles.title_id, titleauthor.au_id,
titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100) as sales_royalty
	FROM titleauthor
	LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales
		ON sales.title_id = titles.title_id

QUERY 1.2.

SELECT titles.title_id, titleauthor.au_id,
SUM(titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100)) as sales_royalty
	FROM titleauthor
	LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales
		ON sales.title_id = titles.title_id
	GROUP BY titles.title_id, titleauthor.au_id

QUERY 1.3.

SELECT titleauthor.au_id,
SUM(titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100) + titles.advance) as profits
	FROM titleauthor
	LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales
		ON sales.title_id = titles.title_id
	GROUP BY titles.title_id, titleauthor.au_id
    ORDER BY profits DESC
    LIMIT 3

QUERY 2

CREATE TEMPORARY TABLE publications.top_3_profits
SELECT titleauthor.au_id,
SUM(titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100) + titles.advance) as profits
	FROM titleauthor
	LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales
		ON sales.title_id = titles.title_id
	GROUP BY titles.title_id, titleauthor.au_id
    ORDER BY profits DESC
    LIMIT 3

QUERY 3

CREATE TABLE most_profiting_authors
SELECT titleauthor.au_id,
SUM(titles.price * sales.qty * (titles.royalty / 100) * (titleauthor.royaltyper / 100) + titles.advance) as profits
	FROM titleauthor
	LEFT JOIN titles
		ON titleauthor.title_id = titles.title_id
	LEFT JOIN sales
		ON sales.title_id = titles.title_id
	GROUP BY titles.title_id, titleauthor.au_id
    ORDER BY profits DESC
    LIMIT 3
   
