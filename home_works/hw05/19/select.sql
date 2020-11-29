SET search_path = bookings;

WITH RECURSIVE ranges (min_sum, max_sum, iter) AS (
    VALUES
        ( 0, 100000, 1 ),
        ( 100000, 200000, 2 ),
        ( 200000, 300000, 3 )
    UNION
    SELECT min_sum + 100000, max_sum + 100000, iter + 1
        FROM ranges
        WHERE max_sum < ( SELECT max(total_amount) FROM bookings )
)
SELECT * FROM ranges;