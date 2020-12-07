-- Цель триггера -- записывать в журнал
-- изменения фамилий пользователей

-- Создадим журнал изменений фамилий
DROP TABLE IF EXISTS user_audits;
CREATE TABLE user_audits (
   id int GENERATED ALWAYS AS IDENTITY,
   user_id int NOT NULL,
   last_name varchar(30) NOT NULL,
   changed_on timestamp(6) NOT NULL
);

-- Создадим функцию для триггера,
-- которая будет делать запись в журнал,
-- если у пользователя меняется фамилия
CREATE OR REPLACE FUNCTION log_last_name_changes()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
	IF NEW.last_name <> OLD.last_name THEN
		INSERT INTO user_audits(user_id, last_name, changed_on)
		VALUES(OLD.id, OLD.last_name, now());
	END IF;
	RETURN NEW;
END;
$$;

-- Создадим триггер, который вызывает функцию
-- перед обновлением
DROP TRIGGER IF EXISTS last_name_changes on users;
CREATE TRIGGER last_name_changes
BEFORE UPDATE
ON users
FOR EACH ROW
EXECUTE PROCEDURE log_last_name_changes();

-- Проверим результат
UPDATE users SET last_name = 'Овчинников'
WHERE nickname = 'Johny19';

SELECT * FROM user_audits;

