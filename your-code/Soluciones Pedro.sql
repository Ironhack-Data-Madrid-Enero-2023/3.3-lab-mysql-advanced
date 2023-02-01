#QUERY 1 (1 FEBRERO)
#STEP 1

SELECT titleauthor.title_id, titleauthor.au_id, (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as sales_royalty
FROM titleauthor
  LEFT JOIN titles ON titleauthor.title_id = titles.title_id
  LEFT JOIN sales ON sales.title_id = titles.title_id

#STEP 2

SELECT titleauthor.title_id, titleauthor.au_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as total_royalties
FROM titleauthor
  LEFT JOIN titles ON titleauthor.title_id = titles.title_id
  LEFT JOIN sales ON sales.title_id = titles.title_id
GROUP BY titleauthor.title_id, titleauthor.au_id;

#STEP 3

SELECT titleauthor.au_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) + (titles.advance) as profits
FROM titleauthor
  LEFT JOIN titles ON titleauthor.title_id = titles.title_id
  LEFT JOIN sales ON sales.title_id = titles.title_id
GROUP BY titleauthor.title_id, titleauthor.au_id
ORDER BY profits DESC
LIMIT 3 


#QUERY 2

CREATE TEMPORARY TABLE publication.top3profits
SELECT titleauthor.title_id, titleauthor.au_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as total_royalties
FROM titleauthor
  LEFT JOIN titles ON titleauthor.title_id = titles.title_id
  LEFT JOIN sales ON sales.title_id = titles.title_id
GROUP BY titleauthor.title_id, titleauthor.au_id;


#QUERY 3

CREATE TABLE publication.top3profits
SELECT titleauthor.title_id, titleauthor.au_id, SUM(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) as total_royalties
FROM titleauthor
  LEFT JOIN titles ON titleauthor.title_id = titles.title_id
  LEFT JOIN sales ON sales.title_id = titles.title_id
GROUP BY titleauthor.title_id, titleauthor.au_id;