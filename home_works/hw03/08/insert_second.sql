-- При выполнении этой команды СУБД выдаст сообщение об ошибке. Почему?
-- Ответ: Ошибка возникла из-за того, что для поля id типа serial 
-- была произведена попытка присвоить следующее значение счетчика -- 2,
-- а поскольку такое значение поля id уже есть в таблице, и поле id
-- является первичным ключом, то выдается ошибка, которая нам об этом сообщает
INSERT INTO test_serial ( name ) VALUES ( 'Грушевая' );
select * from test_serial;

-- Повторим эту же команду. Теперь все в порядке. Почему?
-- Ответ: потому что на этот раз текущее значение счетчика было равным 3,
-- что уже не противоречит ограничениям первичного ключа
INSERT INTO test_serial ( name ) VALUES ( 'Грушевая' );
select * from test_serial;