-- SET search_path = bookings;

BEGIN;

-- Видим, что копия данных в этой транзакции
-- осталась неизменной, 2700
SELECT * FROM aircrafts_tmp
    WHERE aircraft_code = 'CR2';

-- Ждем завершения первой транзакции
-- < Очередь первой транзакции >
UPDATE aircrafts_tmp
    SET range = 2500
    WHERE aircraft_code = 'CR2';

-- Видим обновленную копию своих данных, 2500
SELECT * FROM aircrafts_tmp
    WHERE aircraft_code = 'CR2';

-- Сохраняем
COMMIT;

-- Видим, что обновление первой транзакции
-- было потеряно, 2500
-- (Было потеряно сразу ПОСЛЕ
-- завершения первой транзакции)
SELECT * FROM aircrafts_tmp
    WHERE aircraft_code = 'CR2';