-- Оконная функция, CTE
-- Вывести пользователей с их постами,
-- отранжированными по убыванию популярности
WITH top_ids AS (
    SELECT user_id, view_count, rank()
    OVER ( PARTITION BY user_id ORDER BY view_count DESC )
    FROM posts
)
SELECT users.nickname,
       users.first_name,
       top_ids.view_count,
       rank
FROM
top_ids JOIN users
ON top_ids.user_id = users.id;