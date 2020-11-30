WITH books (description) AS ( VALUES
    ( 'Дейт, К. Дж. Введение в системы баз данных : пер. 
    с англ. / Крис Дж. Дейт. – 8-е изд. –  М. : Вильямс, 2005. –  1328 с.'),
    ( 'Грофф, Дж. SQL. Полное руководство : пер. с англ. / Джеймс Р. Грофф, 
    Пол Н. Вайнберг, Эндрю Дж. Оппель. – 3-е изд. – М. : Вильямс, 
    2015. – 960 c.' ),
    ( 'Лузанов, П. PostgreSQL для начинающих / П. Лузанов, 
    Е. Рогов, И. Лёвшин ; Postgres Professional. – М., 2017. – 146 с.' )
),
books_2 (description, ts_description) AS ( select description, 
to_tsvector(description) FROM books )

SELECT description FROM books_2 WHERE
ts_description @@ 
to_tsquery( 'SQL | PostgreSQL' );
