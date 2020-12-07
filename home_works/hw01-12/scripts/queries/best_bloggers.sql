-- HAVING
-- Вывести id пользователей, у которых среднее количество
-- просмотров всех постов превышает 5000
SELECT user_id, AVG(view_count) AS avg_count, SUM(view_count) AS sum
FROM posts
GROUP BY user_id
HAVING SUM(view_count) > 5000;