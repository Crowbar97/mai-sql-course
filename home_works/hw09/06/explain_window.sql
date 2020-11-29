SET search_path = bookings;

EXPLAIN
SELECT ticket_no, flight_id, fare_conditions, amount, rank()
OVER ( PARTITION BY flight_id ORDER BY amount DESC )
FROM ticket_flights;