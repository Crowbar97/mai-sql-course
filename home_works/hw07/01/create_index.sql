-- Создадим таблицу с двумя полями
CREATE TEMP TABLE students (
    doc_ser text,
    doc_num text
);

-- Создадим уникальный индекс для пары полей
CREATE UNIQUE INDEX students_unique
    ON students ( doc_ser, doc_num );

-- Попробуем добавить следующие строки:
-- ОК
INSERT INTO students
VALUES ( '1234', '345678' );
-- Ошибка: нарушение уникальности
INSERT INTO students
VALUES ( '1234', '345678' );
-- ОК
INSERT INTO students
VALUES ( '1234', NULL );
-- ОК
INSERT INTO students
VALUES ( '1234', NULL );

-- Проверим результат
-- Видим, что обе последние строки добавились, несмотря
-- на их кажущуюся одинаковость, это произошло
-- по той причине, что NULL значения не равны между собой
SELECT * FROM students;
