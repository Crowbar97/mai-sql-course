SET search_path = bookings;

EXPLAIN ANALYZE
SELECT a.aircraft_code AS a_code,
       a.model,
       ( SELECT count( r.aircraft_code )
            FROM routes r
            WHERE r.aircraft_code = a.aircraft_code
       ) AS num_routes
FROM aircrafts a
GROUP BY 1, 2
ORDER BY 3 DESC;