SET search_path = bookings;

-- Посмотрим направления, по которым не было продано
-- ни одного билета
SELECT * FROM
( SELECT f.departure_city, f.arrival_city,
  min(tf.amount) as min_price, max(tf.amount) as max_price
  FROM flights_v f
  LEFT OUTER JOIN ticket_flights tf
  ON f.flight_id = tf.flight_id
  GROUP BY 1, 2
  ORDER BY 1, 2 ) as t
WHERE t.min_price IS NULL AND t.max_price IS NULL;