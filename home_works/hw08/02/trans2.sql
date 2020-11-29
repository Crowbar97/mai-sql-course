-- SET search_path = bookings;

BEGIN;

SELECT * FROM aircrafts_tmp
    WHERE range < 2000;

DELETE FROM aircrafts_tmp WHERE range < 2000;

-- < Очередь первой транзакции >

COMMIT;