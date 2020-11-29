SET search_path = bookings;

-- Создадим копию таблицы посадочных мест
CREATE TEMP TABLE seats_tmp (
    LIKE seats INCLUDING CONSTRAINTS INCLUDING INDEXES
);

-- Скопируем данные в нашу временную таблицу
INSERT INTO seats_tmp SELECT * FROM seats;

-- Проверим результат
SELECT * FROM seats_tmp
ORDER BY seat_no
LIMIT 10;

-- Попробуем добавить данные,
-- в случае конфликта  -- не добавлять
-- Условие по паре значений ( aircraft_code, seat_no )
INSERT INTO seats_tmp
( aircraft_code, seat_no, fare_conditions )
VALUES
( '321', '10A', 'Economy' ),
( '321', '10AA', 'Economy' )
ON CONFLICT ( aircraft_code, seat_no ) DO NOTHING;

-- Проверим результат
SELECT * FROM seats_tmp
ORDER BY seat_no
LIMIT 10;

-- Попробуем добавить данные,
-- в случае конфликта  -- не добавлять
-- Условие по ограничению первичного ключа seats_tmp_pkey
INSERT INTO seats_tmp
( aircraft_code, seat_no, fare_conditions )
VALUES
( '321', '10A', 'Economy' ),
( '321', '10AA', 'Economy' ),
( '321', '10BB', 'Economy' )
ON CONFLICT ON CONSTRAINT seats_tmp_pkey DO NOTHING;

-- Проверим результат
SELECT * FROM seats_tmp
ORDER BY seat_no
LIMIT 10;
