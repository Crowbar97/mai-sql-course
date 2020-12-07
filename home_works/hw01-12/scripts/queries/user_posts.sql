-- OUTER JOIN (Left)
-- Вывести список пользователей и их постов,
-- в котором содержатся все зарегистрированные пользователи
SELECT nickname, title
FROM users LEFT OUTER JOIN posts
ON user_id = users.id;