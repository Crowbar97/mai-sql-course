-- Проверим исходную таблицу
SELECT * FROM tree_test();

-- Создадим малый цикл
-- Кошка -> Собака -> Кошка
INSERT INTO personnel
( emp_nbr, emp_name, address, birth_date )
VALUES
( 9, 'Кошка', 'кресло', '2019-05-19' ),
( 10, 'Собака', 'будка', '2019-08-25' );

INSERT INTO org_chart
( job_title, emp_nbr, boss_emp_nbr, salary )
VALUES
( 'Кошка', 9, 10, 10 ),
( 'Собака', 10, 9, 10 );

-- Проверим
SELECT * FROM tree_test();

-- Создадим большой цикл
-- Кошка -> Cобака -> Архитектор -> Кошка
UPDATE org_chart
    SET boss_emp_nbr = 4
    WHERE job_title = 'Собака';

UPDATE org_chart
    SET boss_emp_nbr = 9
    WHERE job_title = 'Архитектор';

-- -- Проверим
SELECT * FROM tree_test();