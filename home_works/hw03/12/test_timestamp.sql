-- попробуем разные форматы вывода даты
-- SET datestyle TO 'Postgres, DMY';
-- SET datestyle TO 'SQL, DMY';
SET datestyle TO 'German, DMY';
SHOW datestyle;

SELECT '18-05-2016'::timestamp;

SELECT '05-18-2016'::timestamp;

SELECT '2016-05-18'::timestamp;

SET datestyle TO 'MDY';

-- Будет ошибка т.к. теперь сначала должен вводиться
-- месяц, а не день
SELECT '18-05-2016'::timestamp;

-- Здесь все правильно, поскольку формат введенных
-- данных соответствует ожидаемому
SELECT '05-18-2016'::timestamp;

SET datestyle TO DEFAULT;