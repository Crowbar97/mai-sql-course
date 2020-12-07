-- Процедура, позволяющая пересылать средства
-- от одного аккаунта в другой
-- Повысить уровень привилегий аккаунта
CREATE OR REPLACE PROCEDURE increase_level (
   user_id int
)
LANGUAGE PLPGSQL   
AS
$$
DECLARE
    user_level int;
BEGIN
    -- Сначала проверим текущий уровень привилегий
    user_level := (SELECT _level FROM users WHERE id = user_id);
    IF user_level = 3 THEN
        RAISE EXCEPTION 'Пользователь имеет максимальный уровень привилегий!';
    END IF;

    -- Если все ОК, то повышаем уровень
    UPDATE users SET _level = _level + 1
    WHERE id = user_id;

    COMMIT;
END;
$$;

-- Проверим результат
SELECT id, nickname, _level FROM users
WHERE id = 13;

CALL increase_level(13);

SELECT id, nickname, _level FROM users
WHERE id = 13;

CALL increase_level(13);

SELECT id, nickname, _level FROM users
WHERE id = 13;