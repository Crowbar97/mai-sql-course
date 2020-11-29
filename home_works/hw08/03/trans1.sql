-- SET search_path = bookings;

BEGIN;

UPDATE aircrafts_tmp
    SET range = 2100
    WHERE aircraft_code = 'CR2';

-- Видим, что обновление произошло, 2100
SELECT * FROM aircrafts_tmp
    WHERE aircraft_code = 'CR2';

-- < Очередь второй транзакции >

COMMIT;

-- < Очередь второй транзакции >