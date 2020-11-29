SET search_path = bookings;

-- Посмотрим, сколько рейсов выполняется
-- из Москвы в Питер
SELECT departure_city, arrival_city, count(*)
FROM routes
WHERE departure_city = 'Москва'
AND arrival_city = 'Санкт-Петербург'
GROUP BY departure_city, arrival_city;