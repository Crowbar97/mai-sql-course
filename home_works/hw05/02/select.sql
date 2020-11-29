SET search_path = bookings;

-- Пассажиры, у которых имя состоит из 3 букв
SELECT passenger_name
FROM tickets
WHERE passenger_name LIKE '___ %'
LIMIT 10;

-- Пассажиры, у которых фамилия состоит из 5 букв
SELECT passenger_name
FROM tickets
WHERE passenger_name LIKE '% _____'
LIMIT 10;