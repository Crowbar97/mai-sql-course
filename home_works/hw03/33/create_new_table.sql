CREATE TABLE new_pilots (
    pilot_name text,
    schedule integer[],
    meal text[][]
);

INSERT INTO new_pilots
VALUES ( 'Ivan', '{ 1, 3, 5, 6, 7 }'::integer[],
         '{ { "сосиска", "макароны", "кофе" },
            { "картофель", "свинина", "чай" },
            { "кукуруза", "суп", "кокос" },
            { "свекла", "морковь", "вода" } }'::text[] ),
       ( 'Petr', '{ 1, 2, 5, 7 }'::integer [],
         '{ { "котлета", "каша", "кофе" },
            { "рыба", "чечевица", "чай" },
            { "говядина", "пшено", "компот" },
            { "чипсы", "ментос", "кола" } }'::text[] ),
       ( 'Pavel', '{ 2, 5 }'::integer[],
         '{ { "сосиска", "каша", "какао" },
            { "борщ", "макароны", "энергетик" },
            { "суп", "гречка", "кофе" },
            { "солянка", "овсянка", "кофе" } }'::text[] ),
       ( 'Boris', '{ 3, 5, 6 }'::integer[],
         '{ { "котлета", "каша", "чай" },
            { "огурец", "редиска", "молоко" },
            { "сметана", "творог", "кефир" },
            { "сыр", "мандарин", "йогурт" } }'::text[] );