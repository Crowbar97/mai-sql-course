-- Опасная зона ------------------------------
DROP TABLE IF EXISTS post_comments;
DROP TABLE IF EXISTS post_marks_and_users;
DROP TABLE IF EXISTS topics_and_posts;
DROP TABLE IF EXISTS topics;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS banned_users;
DROP TABLE IF EXISTS ban_reasons;
DROP TABLE IF EXISTS users;
----------------------------------------------

-- Пользователи

CREATE TABLE users (
	id SERIAL NOT NULL,
	email varchar(100) NOT NULL,
	_login varchar(30) NOT NULL,
	_password varchar(30) NOT NULL,
	_level int NOT NULL,
	_state bit NOT NULL,
	nickname varchar(100) NOT NULL,
	balance int NOT NULL,
	first_name varchar(30) NOT NULL,
	middle_name varchar(30),
	last_name varchar(30),
	gender bit,
	birth_date date,
	locality varchar(30),
	info varchar(30),
	status_message varchar(30),
	registration_date date,
	last_visit_date date,
	activity_time time,

	CONSTRAINT pk_users PRIMARY KEY(id)
);

INSERT INTO users
( email,                            _login,         _password,             _level, _state, nickname,         balance, first_name,       last_name,    gender, birth_date,   registration_date) VALUES
( 'RealGordonFreeman@XPhysics.com', 'GF789',        'Black159Mesa',        0,      B'1',   'Crowbar97',      20,      'Gordon',         'Freeman',    B'1',   '01/01/1950', '05/30/2004' ),
( 'John1940@gmail.com',             'John40',       'YoYo40',              0,      B'1',   'Johny19',        80,      'Иван',           'Дубравин',   B'1',   '05/07/1940', '06/08/2008' ),
( 'MaryFlower@yandex.ru',           'Mary357',      'Blossom8And8Die',     0,      B'1',   'Blossom88',      90,      'Марья',          '-',          B'0',   '07/18/1988', '03/05/2006' ),
( 'WhatIsLove@yandex.ru',           'BloodVlad159', 'BabyDontHurtMe1',     0,      B'1',   'BloodVlad',      150,     'Владислав',      'Лихачев',    B'1',   '04/16/1997', '12/15/2012' ),
( 'HellFever999@yandex.ru',         'RomanG',       'GuitarForever!888',   0,      B'1',   'GuitarHero82',   1800,     'Роман',          'Конограй',   B'1',   '12/10/1982', '07/18/2014' ),
( 'LightBringer33@mail.ru',         'LB33',         'LastHope0',           0,      B'1',   'LightBringer',   1260,    'Святослав',      'Кондратов',  B'1',   '05/03/1933', '03/24/2010' ),
( 'Caesar100@yandex.ru',            'TheOne',       'The1Only1One',        0,      B'1',   'Julian',         1250,    'Юлиан',          'Белозеров',  B'1',   '01/02/0003', '04/08/2007' ),
( 'SuperAlex2010@gmail.com',        'Streamer7',    'RoadTo100k',          0,      B'1',   'DreamStream',    8800,    'Александр',      'Харитонов',  B'1',   '06/19/2010', '07/22/2016' ),
( 'Columbus51@yahoo.com',           'Columbus',     'Disc1492overy',       0,      B'1',   'IndiaFinder',    1200,    'Христофор',      'Колумбов',   B'1',   '12/10/1951', '12/03/1997' ),
( 'Sheep@gmail.com',                'WhiteSheep',   'H@CK_THE_W0RLD',      0,      B'0',   'WhiteSheep',     2100,    'Иван',           'Овечкин',    B'1',   '12/18/1997', '07/01/2017' ),
( 'SpamOverlord@gmail.com',         'SomeSpam',     'ALOTOFSPAMAHAHAH999', 0,      B'1',   'NoSpamFromHere', 500,     'Денис',          NULL,         B'1',   '03/28/1992', '10/09/2016' ),
( 'MyBlogAdmin@gmail.com',          'Admin',        '#ARENqAL220vFRfrst',  3,      B'1',   'Admin',          10000,   'Иван',           'Иванов',     B'1',   '01/15/1960', '03/01/1978' ),
( 'MyBlogModeror@gmail.com',        'Moderor',      '#MdrDsadppge78e',     2,      B'1',   'Moderor',        4500,    'Денис',          'Денисов',    B'1',   '02/20/1962', '03/01/1978' ),
( 'MyBlogSystem@gmail.com',         'System',       '#Ssxwzqr789S',        1,      B'1',   'MyBlogTeam',     3200,    'Команда MyBlog', NULL,         NULL,   NULL,         '03/01/1978' );

SELECT * FROM users;

-- Возможные причины бана

CREATE TABLE ban_reasons (
	id SERIAL NOT NULL,
	name varchar(30) NOT NULL,

	CONSTRAINT pk_ban_reasons PRIMARY KEY(id)
);

INSERT INTO ban_reasons
( name )
VALUES
( 'Рассылка спама' ),
( 'Попытка взлома сервиса' ),
( 'Неадекватное поведение' );

SELECT * FROM ban_reasons;

-- Забаненные пользователи

CREATE TABLE banned_users (
	user_id int NOT NULL,
	reason_id int NOT NULL,

	CONSTRAINT pk_banned_users PRIMARY KEY(user_id),
	CONSTRAINT fk_pk_banned_users_user_id FOREIGN KEY(user_id) REFERENCES users(id),
	CONSTRAINT fk_pk_banned_users_reason FOREIGN KEY(reason_id) REFERENCES ban_reasons(id)
);

INSERT INTO banned_users
( user_id, reason_id )
VALUES
( 10, 2 ),
( 8, 3 );

SELECT * FROM banned_users;

-- Публикации пользователей

CREATE TABLE posts (
	id SERIAL NOT NULL,
	user_id int NOT NULL,
	_state bit NOT NULL,
	title varchar(30) NOT NULL,
	body varchar(1000) NOT NULL,
	publication_date date NOT NULL,
	view_count int NOT NULL,

	CONSTRAINT pk_posts PRIMARY KEY(id),
	CONSTRAINT fk_posts_user_id FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO posts
(user_id, _state, title, body, publication_date, view_count) VALUES
(1, B'0', 'Theoretical physics', 'Theoretical physics...', '06/10/2005', 5348 ),
(3, B'1', 'Flower Power', 'Garden roses...', '05/10/2007', 582 ),
(3, B'1', 'Autumn Garden', 'Autumn smell...', '05/09/2008', 2486 ),
(5, B'1', 'Guitar Lesson № 1', 'Today I will start...', '07/20/2014', 1328 ),
(5, B'1', 'Guitar Lesson № 2', 'Today we will continue...', '08/01/2014', 1526 ),
(5, B'1', 'Guitar Lesson № 3', 'Today we will play our first composition...', '08/15/2014', 2548 ),
(6, B'1', 'What is kindness?', 'What is kindness? It is a very good question...', '03/06/2011', 3459 );

SELECT * FROM posts;

-- Темы постов

CREATE TABLE topics (
	id SERIAL NOT NULL,
	title varchar(30) NOT NULL,

	CONSTRAINT pk_topics PRIMARY KEY(id)
);

INSERT INTO topics
( title )
VALUES
( 'Science' ),
( 'Tutorials' ),
( 'Common' ),
( 'Music' );

SELECT * FROM topics;

-- Соответствия между темами и постами

CREATE TABLE topics_and_posts (
	topic_id int NOT NULL,
	post_id int NOT NULL,

	CONSTRAINT pk_topics_and_posts PRIMARY KEY(topic_id, post_id),
	CONSTRAINT fk_topics_and_posts_topic_id FOREIGN KEY(topic_id) REFERENCES topics(id),
	CONSTRAINT fk_topics_and_posts_post_id FOREIGN KEY(post_id) REFERENCES posts(id)
);

INSERT INTO topics_and_posts
( post_id, topic_id )
VALUES
( 1, 1 ),
( 2, 2 ),
( 3, 2 ),
( 3, 3 ),
( 4, 2 ),
( 4, 4 ),
( 5, 2 ),
( 5, 4 ),
( 6, 2 ),
( 6, 4 ),
( 7, 3 );

SELECT * FROM topics_and_posts;

-- Оценки постов пользователями

CREATE TABLE post_marks_and_users (
	post_id int NOT NULL,
	user_id int NOT NULL,
	mark int NOT NULL,

	CONSTRAINT pk_post_marks_and_users PRIMARY KEY(post_id, user_id),
	CONSTRAINT fk_post_marks_and_users_post_id FOREIGN KEY(post_id) REFERENCES posts(id),
	CONSTRAINT fk_post_marks_and_users_user_id FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO post_marks_and_users
( post_id, user_id, mark )
VALUES
( 1, 2, 5 ),
( 1, 4, 3 ),
( 1, 7, 2 ),
( 1, 8, 4 ),
( 2, 1, 5 ),
( 2, 2, 1 ),
( 2, 4, 2 ),
( 2, 5, 4 ),
( 3, 8, 3 ),
( 3, 9, 2 ),
( 3, 10, 1 ),
( 3, 5, 4 ),
( 3, 4, 4 ),
( 4, 9, 3 ),
( 4, 2, 2 ),
( 4, 4, 2 ),
( 4, 3, 5 ),
( 4, 11, 5 ),
( 4, 12, 5 ),
( 4, 13, 3 ),
( 5, 4, 4 ),
( 5, 3, 5 ),
( 5, 11, 4 ),
( 5, 12, 3 ),
( 5, 13, 2 ),
( 6, 2, 4 ),
( 6, 5, 4 ),
( 6, 3, 4 ),
( 6, 11, 2 ),
( 6, 12, 3 ),
( 6, 13, 3 ),
( 7, 2, 2 ),
( 7, 3, 4 ),
( 7, 8, 3 ),
( 7, 7, 3 ),
( 7, 1, 3 );

SELECT * FROM post_marks_and_users;

-- Комментарии пользователей к постам

CREATE TABLE post_comments (
	id SERIAL NOT NULL,
	post_id int NOT NULL,
	user_id int NOT NULL,
	body varchar(1000) NOT NULL,
	date_and_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT pk_post_comments PRIMARY KEY(id),
	CONSTRAINT fk_post_comments_post_id FOREIGN KEY(post_id) REFERENCES posts(id),
	CONSTRAINT fk_post_comments_user_id FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO post_comments
( post_id, user_id, body ) VALUES
( 1, 2, 'Это потрясающе! Никогда не был равнодушен к физике!' ),
( 1, 5, 'Эта статья вдохновила меня на запись нового альбома!' ),
( 6, 4, 'Скоро сам буду учить друзей играть на гитаре!' ),
( 2, 10, 'Бесплатно рассылаю семена растений, для того, чтобы их получить, ввойдите в свой личный кабинет на сайте http://accStealing.com' );

SELECT * FROM post_comments;
