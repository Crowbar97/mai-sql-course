-- Подзапрос, EXISTS
-- Вывести список пользователей, имеющих свои посты,
-- количество просмотров которых больше 1000
SELECT nickname
FROM users
WHERE EXISTS (
    SELECT * FROM posts
    WHERE user_id = users.id AND view_count > 1000
);