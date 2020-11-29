SET search_path = bookings;

-- Возьмем все города (кроме Москвы) и вычтем из них те,
-- в которые можно долететь из Москвы
SELECT city
    FROM airports
    WHERE city <> 'Москва'
EXCEPT
SELECT arrival_city
    FROM routes
    WHERE departure_city = 'Москва'
ORDER BY city;