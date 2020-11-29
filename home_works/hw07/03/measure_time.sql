SET search_path = bookings;

\timing on

-- Посмотрим, сколько займет каждый запрос
-- без индекса
SELECT count(*)
    FROM ticket_flights
    WHERE fare_conditions = 'Comfort';

SELECT count(*)
    FROM ticket_flights
    WHERE fare_conditions = 'Business';

SELECT count(*)
    FROM ticket_flights
    WHERE fare_conditions = 'Economy';

-- Добавим индекс
CREATE INDEX ON ticket_flights ( fare_conditions );

-- Проверим, насколько изменилось время
-- Как и следовало ожидать, наибольший прирост
-- производительности оказался у запроса 'Comfort',
-- т.к. объем этой выборки значительно меньше остальных
SELECT count(*)
    FROM ticket_flights
    WHERE fare_conditions = 'Comfort';

SELECT count(*)
    FROM ticket_flights
    WHERE fare_conditions = 'Business';

SELECT count(*)
    FROM ticket_flights
    WHERE fare_conditions = 'Economy';

