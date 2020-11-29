-- Добавим студентов
INSERT INTO students
( record_book, name, doc_ser, doc_num )
VALUES
( 1, 'Иван', 5437, 445821 ),
( 2, 'Петр', 1277, 231231 );

-- -- Проверим установленные ограничения
-- -- Все правильно
INSERT INTO progress ( record_book, subject, acad_year, term, test_form, mark )
VALUES ( 1, 'Базы данных', '2020', 1, 'экзамен', 5 );

-- Проверим результат
SELECT * FROM progress;

-- Ошибка: по зачету нельзя получить 2
INSERT INTO progress ( record_book, subject, acad_year, term, test_form, mark )
VALUES ( 2, 'Базы данных', '2020', 1, 'зачет', 2 );

-- Проверим результат
SELECT * FROM progress;

-- Однако если мы попробуем вставить корректные данные по зачету,
-- то старое ограничение выдаст ошибку, что не является правильным
INSERT INTO progress ( record_book, subject, acad_year, term, test_form, mark )
VALUES ( 2, 'Базы данных', '2020', 2, 'зачет', 1 );

-- Проверим результат
SELECT * FROM progress;

-- поэтому мы удалим старое ограничение
ALTER TABLE progress DROP CONSTRAINT valid_mark;

-- и повторим операцию, на этот раз без ложных ошибок
INSERT INTO progress ( record_book, subject, acad_year, term, test_form, mark )
VALUES ( 2, 'Базы данных', '2020', 2, 'зачет', 1 );

-- Проверим результат
SELECT * FROM progress;

-- Дополнительным ограничением на таблицу "progress"
-- может быть ограничение на поле "acad_year",
-- где проверяется корректность указанного года

