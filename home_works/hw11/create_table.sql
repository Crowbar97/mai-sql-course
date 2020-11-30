CREATE TABLE books (
    book_id integer PRIMARY KEY,
    book_description text
);

COPY books FROM '/home/storm/Documents/1_update/projects/sql_course_mai/home_works/hw11/books3.txt';

ALTER TABLE books ADD COLUMN ts_description tsvector;

UPDATE books
SET ts_description = to_tsvector( 'russian', book_description );
