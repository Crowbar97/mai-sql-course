SET search_path = bookings;

WITH t AS (
    SELECT *
    FROM ( SELECT DISTINCT city FROM airports ) AS a1
    JOIN ( SELECT DISTINCT city FROM airports ) AS a2
    ON a1.city <> a2.city
)
SELECT count(*) FROM t;


