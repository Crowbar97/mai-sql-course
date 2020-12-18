-- Выведем все посты
SELECT * FROM posts;

-- Построим таблицу с диапазонами просмотров
WITH RECURSIVE ranges (min_num, max_num) AS (
    VALUES
        ( 0, 100 )
    UNION ALL
    SELECT min_num + 100, max_num + 100
        FROM ranges
        WHERE max_num <= ( SELECT max(view_count) FROM posts )
)
-- Для каждого диапазона выведем количество постов,
-- имеющих соответствующее число просмотров
SELECT ranges.min_num, ranges.max_num, count(posts.title)
    FROM ranges LEFT JOIN posts
    ON posts.view_count >= ranges.min_num AND posts.view_count <= ranges.max_num
    GROUP BY ranges.min_num, ranges.max_num
    ORDER BY ranges.min_num, ranges.max_num;