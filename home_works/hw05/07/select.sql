SET search_path = bookings;

-- Посмотрим, между какими городами летает боинг
SELECT DISTINCT r.departure_city, r.arrival_city
FROM routes AS r
JOIN aircrafts AS a
ON r.aircraft_code = a.aircraft_code
WHERE
a.model = 'Boeing 777-300'
AND r.departure_city < r.arrival_city
ORDER BY r.departure_city, r.arrival_city;