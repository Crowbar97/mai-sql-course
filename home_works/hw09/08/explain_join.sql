SET search_path = bookings;

EXPLAIN ANALYZE
SELECT a.aircraft_code AS a_code,
       a.model,
       count( r.aircraft_code ) AS num_routes
FROM aircrafts a
LEFT OUTER JOIN routes r
    ON r.aircraft_code = a.aircraft_code
GROUP BY 1, 2
ORDER BY 3 DESC;