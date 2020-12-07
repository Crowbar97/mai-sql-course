-- Процедура, позволяющая пересылать средства
-- от одного аккаунта в другой
CREATE OR REPLACE PROCEDURE send_credits (
   receiver_id int, 
   sender_id int,
   amount int
)
LANGUAGE PLPGSQL   
AS
$$
BEGIN
    -- забираем количество пересылаемых средств
    -- у аккаунта отправителя
    UPDATE users 
    SET balance = balance - amount 
    WHERE id = sender_id;

    -- начисляем средства на аккаунт получателя
    UPDATE users 
    SET balance = balance + amount 
    WHERE id = receiver_id;

    COMMIT;
END;
$$;

-- Проверим результат
SELECT id, nickname, balance FROM users
WHERE id = 2 OR id = 5;

CALL send_credits(2, 5, 100);

SELECT id, nickname, balance FROM users
WHERE id = 2 OR id = 5;