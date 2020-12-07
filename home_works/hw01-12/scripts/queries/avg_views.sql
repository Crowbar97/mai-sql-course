-- СTE, GROUP BY
-- Сгруппировать по id пользователей и для представителя
-- каждой группы вывести среднее количество просмотров всех его постов,
-- определить ники и имена пользователей по их id
WITH ids_with_stat AS (
    SELECT user_id, AVG(view_count) AS avg_count
    FROM posts
    GROUP BY user_id
)
SELECT users.nickname,
       users.first_name,
       ids_with_stat.avg_count
FROM
ids_with_stat JOIN users
on ids_with_stat.user_id = users.id