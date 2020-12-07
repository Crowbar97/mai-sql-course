-- CTE, Самосоединение
-- Вывести список таких пар пользователей, в которых год регистрации
-- одного пользователя совпадает с годом рождения другого
WITH users_bds AS (
      SELECT nickname, EXTRACT(YEAR FROM birth_date) as year
      FROM users
),
users_regs AS (
      SELECT nickname, EXTRACT(YEAR FROM registration_date) as year
      FROM users
)
SELECT users_regs.nickname,
       users_bds.nickname,
       users_bds.year
FROM users_bds, users_regs
WHERE users_regs.year = users_bds.year;