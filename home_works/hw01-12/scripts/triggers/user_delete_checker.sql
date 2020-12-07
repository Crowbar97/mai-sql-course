-- Цель триггера -- проверить корректность удаления аккаунта пользователя,
-- по правилам активные аккаунты удалять нельзя
-- (аккаунт должен быть предварительно заблокирован)

-- Создадим функцию, проверяющую статус аккаунта,
-- и вызывающую исключение в случае ошибки
CREATE OR REPLACE FUNCTION check_user_delete()
RETURNS TRIGGER
LANGUAGE PLPGSQL
AS
$$
BEGIN
	IF OLD._state = B'1' THEN
		RAISE EXCEPTION 'Нельзя удалять активный аккаунт!';
	END IF;
END;
$$;

-- Создадим триггер, который вызывает функцию
-- перед удалением в таблице с пользователями
DROP TRIGGER IF EXISTS user_delete_checker on users;
CREATE TRIGGER user_delete_checker
BEFORE DELETE
ON users
FOR EACH ROW
EXECUTE PROCEDURE check_user_delete();

-- Проверим результат
SELECT first_name, nickname, _state FROM users
WHERE nickname = 'Johny19';

DELETE FROM users
WHERE nickname = 'Johny19';

SELECT first_name, nickname, _state FROM users
WHERE nickname = 'Johny19';

