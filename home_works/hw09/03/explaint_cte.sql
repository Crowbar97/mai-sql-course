SET search_path = bookings;

-- Создадим копию таблицы самолетов
CREATE TEMP TABLE aircrafts_tmp (
    LIKE aircrafts INCLUDING CONSTRAINTS INCLUDING INDEXES
);

-- Создадим журнал изменений
CREATE TEMP TABLE aircrafts_log AS
    SELECT * FROM aircrafts WITH NO DATA;
-- Добавим поле времени изменения со значением по умолчанию
ALTER TABLE aircrafts_log
    ADD COLUMN when_add timestamp DEFAULT CURRENT_TIMESTAMP;
-- Добавим поле типа операции
ALTER TABLE aircrafts_log
    ADD COLUMN operation text;

-- Скопируем данные в нашу временную таблицу
-- Посмотрим план выполнения
EXPLAIN
WITH add_row AS (
    INSERT INTO aircrafts_tmp SELECT * FROM aircrafts
    RETURNING *
)
-- Добавим информацию об изменении в наш журнал,
-- время добавления будет выставлено по умолчанию -- текущее
INSERT INTO aircrafts_log
( aircraft_code, model, range, operation )
SELECT add_row.aircraft_code, add_row.model, add_row.range, 'INSERT'
FROM add_row;

-- Проверим результат
SELECT * FROM aircrafts_tmp;
SELECT * FROM aircrafts_log;