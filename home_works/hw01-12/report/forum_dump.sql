--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9 (Debian 11.9-0+deb10u1)
-- Dumped by pg_dump version 11.9 (Debian 11.9-0+deb10u1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: check_user_delete(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_user_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF OLD._state = B'1' THEN
		RAISE EXCEPTION 'Нельзя удалять активный аккаунт!';
	END IF;
END;
$$;


ALTER FUNCTION public.check_user_delete() OWNER TO postgres;

--
-- Name: increase_level(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.increase_level(user_id integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    user_level int;
BEGIN
    user_level := (SELECT _level FROM users WHERE id = user_id);
    IF user_level = 3 THEN
        RAISE EXCEPTION 'Пользователь имеет максимальный уровень привилегий!';
    END IF;

    UPDATE users SET _level = _level + 1
    WHERE id = user_id;

    COMMIT;
END;
$$;


ALTER PROCEDURE public.increase_level(user_id integer) OWNER TO postgres;

--
-- Name: increase_level(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.increase_level(user_id integer, user_level integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    user_level := (SELECT _level FROM users WHERE id = user_id);
    IF user_level = 3 THEN
        RAISE EXCEPTION 'Пользователь имеет максимальный уровень привилегий!';
    END IF;

    UPDATE users SET _level = _level + 1
    WHERE id = user_id;

    COMMIT;
END;
$$;


ALTER PROCEDURE public.increase_level(user_id integer, user_level integer) OWNER TO postgres;

--
-- Name: log_last_name_changes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_last_name_changes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW.last_name <> OLD.last_name THEN
		INSERT INTO user_audits(user_id, last_name, changed_on)
		VALUES(OLD.id, OLD.last_name, now());
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_last_name_changes() OWNER TO postgres;

--
-- Name: send_credits(integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.send_credits(receiver_id integer, sender_id integer, amount integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- subtracting the amount from the sender's account 
    UPDATE users 
    SET balance = balance - amount 
    WHERE id = sender_id;

    -- adding the amount to the receiver's account
    UPDATE users 
    SET balance = balance + amount 
    WHERE id = receiver_id;

    COMMIT;
END;
$$;


ALTER PROCEDURE public.send_credits(receiver_id integer, sender_id integer, amount integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ban_reasons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ban_reasons (
    id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.ban_reasons OWNER TO postgres;

--
-- Name: ban_reasons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ban_reasons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ban_reasons_id_seq OWNER TO postgres;

--
-- Name: ban_reasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ban_reasons_id_seq OWNED BY public.ban_reasons.id;


--
-- Name: banned_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banned_users (
    user_id integer NOT NULL,
    reason_id integer NOT NULL
);


ALTER TABLE public.banned_users OWNER TO postgres;

--
-- Name: post_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_comments (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    body character varying(1000) NOT NULL,
    date_and_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.post_comments OWNER TO postgres;

--
-- Name: post_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_comments_id_seq OWNER TO postgres;

--
-- Name: post_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_comments_id_seq OWNED BY public.post_comments.id;


--
-- Name: post_marks_and_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_marks_and_users (
    post_id integer NOT NULL,
    user_id integer NOT NULL,
    mark integer NOT NULL
);


ALTER TABLE public.post_marks_and_users OWNER TO postgres;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    _state bit(1) NOT NULL,
    title character varying(30) NOT NULL,
    body character varying(1000) NOT NULL,
    publication_date date NOT NULL,
    view_count integer NOT NULL
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.posts_id_seq OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topics (
    id integer NOT NULL,
    title character varying(30) NOT NULL
);


ALTER TABLE public.topics OWNER TO postgres;

--
-- Name: topics_and_posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topics_and_posts (
    topic_id integer NOT NULL,
    post_id integer NOT NULL
);


ALTER TABLE public.topics_and_posts OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.topics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.topics_id_seq OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;


--
-- Name: user_audits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_audits (
    id integer NOT NULL,
    user_id integer NOT NULL,
    last_name character varying(30) NOT NULL,
    changed_on timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.user_audits OWNER TO postgres;

--
-- Name: user_audits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.user_audits ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_audits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(100) NOT NULL,
    _login character varying(30) NOT NULL,
    _password character varying(30) NOT NULL,
    _level integer NOT NULL,
    _state bit(1) NOT NULL,
    nickname character varying(100) NOT NULL,
    balance integer NOT NULL,
    first_name character varying(30) NOT NULL,
    middle_name character varying(30),
    last_name character varying(30),
    gender bit(1),
    birth_date date,
    locality character varying(30),
    info character varying(30),
    status_message character varying(30),
    registration_date date,
    last_visit_date date,
    activity_time time without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: ban_reasons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ban_reasons ALTER COLUMN id SET DEFAULT nextval('public.ban_reasons_id_seq'::regclass);


--
-- Name: post_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_comments ALTER COLUMN id SET DEFAULT nextval('public.post_comments_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ban_reasons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ban_reasons (id, name) FROM stdin;
1	Рассылка спама
2	Попытка взлома сервиса
3	Неадекватное поведение
\.


--
-- Data for Name: banned_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banned_users (user_id, reason_id) FROM stdin;
10	2
8	3
\.


--
-- Data for Name: post_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_comments (id, post_id, user_id, body, date_and_time) FROM stdin;
1	1	2	Это потрясающе! Никогда не был равнодушен к физике!	2020-12-10 12:50:29.365845
2	1	5	Эта статья вдохновила меня на запись нового альбома!	2020-12-10 12:50:29.365845
3	6	4	Скоро сам буду учить друзей играть на гитаре!	2020-12-10 12:50:29.365845
4	2	10	Бесплатно рассылаю семена растений, для того, чтобы их получить, ввойдите в свой личный кабинет на сайте http://accStealing.com	2020-12-10 12:50:29.365845
\.


--
-- Data for Name: post_marks_and_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_marks_and_users (post_id, user_id, mark) FROM stdin;
1	2	5
1	4	3
1	7	2
1	8	4
2	1	5
2	2	1
2	4	2
2	5	4
3	8	3
3	9	2
3	10	1
3	5	4
3	4	4
4	9	3
4	2	2
4	4	2
4	3	5
4	11	5
4	12	5
4	13	3
5	4	4
5	3	5
5	11	4
5	12	3
5	13	2
6	2	4
6	5	4
6	3	4
6	11	2
6	12	3
6	13	3
7	2	2
7	3	4
7	8	3
7	7	3
7	1	3
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, user_id, _state, title, body, publication_date, view_count) FROM stdin;
1	1	0	Theoretical physics	Theoretical physics...	2005-06-10	5348
2	3	1	Flower Power	Garden roses...	2007-05-10	582
3	3	1	Autumn Garden	Autumn smell...	2008-05-09	2486
4	5	1	Guitar Lesson № 1	Today I will start...	2014-07-20	1328
5	5	1	Guitar Lesson № 2	Today we will continue...	2014-08-01	1526
6	5	1	Guitar Lesson № 3	Today we will play our first composition...	2014-08-15	2548
7	6	1	What is kindness?	What is kindness? It is a very good question...	2011-03-06	3459
\.


--
-- Data for Name: topics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics (id, title) FROM stdin;
1	Science
2	Tutorials
3	Common
4	Music
\.


--
-- Data for Name: topics_and_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.topics_and_posts (topic_id, post_id) FROM stdin;
1	1
2	2
2	3
3	3
2	4
4	4
2	5
4	5
2	6
4	6
3	7
\.


--
-- Data for Name: user_audits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_audits (id, user_id, last_name, changed_on) FROM stdin;
1	2	Дубравин	2020-12-07 10:14:49.155986
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, _login, _password, _level, _state, nickname, balance, first_name, middle_name, last_name, gender, birth_date, locality, info, status_message, registration_date, last_visit_date, activity_time) FROM stdin;
1	RealGordonFreeman@XPhysics.com	GF789	Black159Mesa	0	1	Crowbar97	20	Gordon	\N	Freeman	1	1950-01-01	\N	\N	\N	2004-05-30	\N	\N
2	John1940@gmail.com	John40	YoYo40	0	1	Johny19	80	Иван	\N	Дубравин	1	1940-05-07	\N	\N	\N	2008-06-08	\N	\N
3	MaryFlower@yandex.ru	Mary357	Blossom8And8Die	0	1	Blossom88	90	Марья	\N	-	0	1988-07-18	\N	\N	\N	2006-03-05	\N	\N
4	WhatIsLove@yandex.ru	BloodVlad159	BabyDontHurtMe1	0	1	BloodVlad	150	Владислав	\N	Лихачев	1	1997-04-16	\N	\N	\N	2012-12-15	\N	\N
5	HellFever999@yandex.ru	RomanG	GuitarForever!888	0	1	GuitarHero82	1800	Роман	\N	Конограй	1	1982-12-10	\N	\N	\N	2014-07-18	\N	\N
6	LightBringer33@mail.ru	LB33	LastHope0	0	1	LightBringer	1260	Святослав	\N	Кондратов	1	1933-05-03	\N	\N	\N	2010-03-24	\N	\N
7	Caesar100@yandex.ru	TheOne	The1Only1One	0	1	Julian	1250	Юлиан	\N	Белозеров	1	0003-01-02	\N	\N	\N	2007-04-08	\N	\N
8	SuperAlex2010@gmail.com	Streamer7	RoadTo100k	0	1	DreamStream	8800	Александр	\N	Харитонов	1	2010-06-19	\N	\N	\N	2016-07-22	\N	\N
9	Columbus51@yahoo.com	Columbus	Disc1492overy	0	1	IndiaFinder	1200	Христофор	\N	Колумбов	1	1951-12-10	\N	\N	\N	1997-12-03	\N	\N
10	Sheep@gmail.com	WhiteSheep	H@CK_THE_W0RLD	0	0	WhiteSheep	2100	Иван	\N	Овечкин	1	1997-12-18	\N	\N	\N	2017-07-01	\N	\N
11	SpamOverlord@gmail.com	SomeSpam	ALOTOFSPAMAHAHAH999	0	1	NoSpamFromHere	500	Денис	\N	\N	1	1992-03-28	\N	\N	\N	2016-10-09	\N	\N
12	MyBlogAdmin@gmail.com	Admin	#ARENqAL220vFRfrst	3	1	Admin	10000	Иван	\N	Иванов	1	1960-01-15	\N	\N	\N	1978-03-01	\N	\N
13	MyBlogModeror@gmail.com	Moderor	#MdrDsadppge78e	2	1	Moderor	4500	Денис	\N	Денисов	1	1962-02-20	\N	\N	\N	1978-03-01	\N	\N
14	MyBlogSystem@gmail.com	System	#Ssxwzqr789S	1	1	MyBlogTeam	3200	Команда MyBlog	\N	\N	\N	\N	\N	\N	\N	1978-03-01	\N	\N
\.


--
-- Name: ban_reasons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ban_reasons_id_seq', 3, true);


--
-- Name: post_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_comments_id_seq', 4, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 7, true);


--
-- Name: topics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.topics_id_seq', 4, true);


--
-- Name: user_audits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_audits_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 14, true);


--
-- Name: ban_reasons pk_ban_reasons; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ban_reasons
    ADD CONSTRAINT pk_ban_reasons PRIMARY KEY (id);


--
-- Name: banned_users pk_banned_users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banned_users
    ADD CONSTRAINT pk_banned_users PRIMARY KEY (user_id);


--
-- Name: post_comments pk_post_comments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_comments
    ADD CONSTRAINT pk_post_comments PRIMARY KEY (id);


--
-- Name: post_marks_and_users pk_post_marks_and_users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_marks_and_users
    ADD CONSTRAINT pk_post_marks_and_users PRIMARY KEY (post_id, user_id);


--
-- Name: posts pk_posts; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT pk_posts PRIMARY KEY (id);


--
-- Name: topics pk_topics; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT pk_topics PRIMARY KEY (id);


--
-- Name: topics_and_posts pk_topics_and_posts; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics_and_posts
    ADD CONSTRAINT pk_topics_and_posts PRIMARY KEY (topic_id, post_id);


--
-- Name: users pk_users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pk_users PRIMARY KEY (id);


--
-- Name: banned_users fk_pk_banned_users_reason; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banned_users
    ADD CONSTRAINT fk_pk_banned_users_reason FOREIGN KEY (reason_id) REFERENCES public.ban_reasons(id);


--
-- Name: banned_users fk_pk_banned_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banned_users
    ADD CONSTRAINT fk_pk_banned_users_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: post_comments fk_post_comments_post_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_comments
    ADD CONSTRAINT fk_post_comments_post_id FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: post_comments fk_post_comments_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_comments
    ADD CONSTRAINT fk_post_comments_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: post_marks_and_users fk_post_marks_and_users_post_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_marks_and_users
    ADD CONSTRAINT fk_post_marks_and_users_post_id FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: post_marks_and_users fk_post_marks_and_users_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_marks_and_users
    ADD CONSTRAINT fk_post_marks_and_users_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: posts fk_posts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT fk_posts_user_id FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: topics_and_posts fk_topics_and_posts_post_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics_and_posts
    ADD CONSTRAINT fk_topics_and_posts_post_id FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: topics_and_posts fk_topics_and_posts_topic_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topics_and_posts
    ADD CONSTRAINT fk_topics_and_posts_topic_id FOREIGN KEY (topic_id) REFERENCES public.topics(id);


--
-- PostgreSQL database dump complete
--

