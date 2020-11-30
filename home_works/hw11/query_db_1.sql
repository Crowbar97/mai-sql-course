SELECT * FROM books
WHERE ts_description @@ to_tsquery( 'SQL' );