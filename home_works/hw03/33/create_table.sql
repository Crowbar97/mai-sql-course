CREATE TABLE pilots (
    pilot_name text,
    schedule integer[],
    meal text[]
);

INSERT INTO pilots
VALUES ( 'Ivan', '{ 1, 3, 5, 6, 7 }'::integer[],
         '{ "сосиска", "макароны", "кофе" }'::text[] ),
       ( 'Petr', '{ 1, 2, 5, 7 }'::integer [],
         '{ "котлета", "каша", "кофе" }'::text[] ),
       ( 'Pavel', '{ 2, 5 }'::integer[],
         '{ "сосиска", "каша", "кофе" }'::text[] ),
       ( 'Boris', '{ 3, 5, 6 }'::integer[],
         '{ "котлета", "каша", "чай" }'::text[] );