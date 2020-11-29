-- SET search_path = bookings;

BEGIN;

SELECT * FROM aircrafts_tmp
    WHERE range < 2000;

UPDATE aircrafts_tmp
    SET range = 2100
    WHERE aircraft_code = 'CN1';

UPDATE aircrafts_tmp
    SET range = 1900
    WHERE aircraft_code = 'CR2';

-- < Очередь второй транзакции >

-- Выбранная строка не удалилась,
-- поскольку ее значение перестало
-- удовлетворять условию
-- COMMIT;

-- Выбранная строка удалилась,
-- поскольку ее значение после завершения
-- транзакции также удовлетворяет условию
ROLLBACK;