SELECT ta.title_id, ta.au_id, titles.price * sales.qty * titles.royalty / 100 * ta.royaltyper / 100 AS SALES_ROYALTY
FROM titleauthor as ta

LEFT JOIN titles ON ta.title_id = titles.title_id
LEFT JOIN sales ON sales.title_id = titles.title_id


-- Por no dejarla vacía he hecho la primera query, pero estoy con fiebre y no puedo. Cuando pueda intento volver sobre ello




