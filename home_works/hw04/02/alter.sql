-- Посмотрим столбцы исходной таблицы
SELECT * FROM progress;

-- Добавим новый столбец с формой отчетности
ALTER TABLE progress
ADD COLUMN
test_form text NOT NULL DEFAULT 'экзамен'
CONSTRAINT valid_test_form
CHECK ( test_form = 'экзамен' OR test_form = 'зачет' );

-- Проверим результат
SELECT * FROM progress;

-- Добавим ограничение, учитывающее форму отчетности
ALTER TABLE progress
    ADD CONSTRAINT new_valid_mark
    CHECK (
        ( test_form = 'экзамен' AND mark IN ( 3, 4, 5 ) )
        OR ( test_form = 'зачет' AND mark IN ( 0, 1 ) )
    );
