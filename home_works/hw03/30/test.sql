-- ОК
INSERT INTO test_bool VALUES ( TRUE, 'yes' );

-- Ошибка: неизвестный идентификатор "yes" на первой позиции
INSERT INTO test_bool VALUES ( yes, 'yes' );

-- ОК
INSERT INTO test_bool VALUES ( 'yes', true );
INSERT INTO test_bool VALUES ( 'yes', TRUE );
INSERT INTO test_bool VALUES ( '1', 'true' );

-- Ошибка: первое поле должно содержать логическое значение,
-- а не целочисленное. Автоматическое приведение типов не осуществляется
INSERT INTO test_bool VALUES ( 1, 'true' );

-- ОК
INSERT INTO test_bool VALUES ( 't', 'true' );

-- Ошибка: неизвестный идентификатор "truth" на второй позиции
INSERT INTO test_bool VALUES ( 't', truth );

-- ОК
INSERT INTO test_bool VALUES ( true, true );
INSERT INTO test_bool VALUES ( 1::boolean, 'true' );
INSERT INTO test_bool VALUES ( 111::boolean, 'true' );