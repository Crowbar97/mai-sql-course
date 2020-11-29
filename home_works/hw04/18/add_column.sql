SET search_path = bookings;

-- В таблицу "airports" можно добавить json-поле "chief",
-- которое будет содержать данные о его начальнике
ALTER TABLE airports ADD COLUMN chief jsonb;

-- Обновим данные
UPDATE airports
SET chief =
'{ "name": "Дядя Степа",
   "phone": "+7-960-223-32-22",
   "email": "stepa@ya.ru"
}'::jsonb
WHERE airport_name = 'Внуково';

-- Проверим результат
SELECT * FROM airports WHERE airport_name = 'Внуково';