-- Попробуем вставить запись с пустой строкой для имени
INSERT INTO students ( record_book, name, doc_ser, doc_num )
VALUES ( 12300, '', 0402, 543281 );

-- Видим, что она вставилась успешно,
-- что не является корректным в случае этой таблицы
SELECT * FROM students;

-- Удалим некорректные данные
DELETE FROM students WHERE name = '';

-- Добавим ограничение на ввод пустой строки
ALTER TABLE students ADD CHECK ( name <> '' );

-- Пустая строка теперь не допускается
INSERT INTO students ( record_book, name, doc_ser, doc_num )
VALUES ( 12345, '', 0401, 523281 );

-- Однако такое ограничение не спасает от ввода пробелов
INSERT INTO students VALUES ( 12346, ' ', 0406, 112233 );
INSERT INTO students VALUES ( 12347, '  ', 0407, 112234 );
SELECT *, length(name) FROM students;

-- Очистим таблицу с некорректными данными
DELETE FROM students;

-- Добавим ограничение на пробелы
ALTER TABLE students ADD CHECK ( trim(name) <> '');

-- Видим, что теперь некорректные данные не допускаются
INSERT INTO students VALUES ( 12346, ' ', 0406, 112233 );
INSERT INTO students VALUES ( 12347, '  ', 0407, 112234 );
SELECT *, length(name) FROM students;

-- Аналогичная проблема возникнет и с таблицей "progress",
-- где поле "subject" также может принять пустую или
-- состоящую из одних пробелов строку, поэтому
-- в этой таблице тоже требуется соответствующее ограничение