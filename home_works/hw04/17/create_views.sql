SET search_path = bookings;

-- Пассажирам может понадобиться знание
-- о соответствии между именами моделей самолетов
-- и их кодами, при этом дальность им не интересна
-- Вертикальное представление
CREATE VIEW aircrafts_for_passengers AS
    SELECT aircraft_code, model
    FROM aircrafts;

SELECT * FROM aircrafts_for_passengers limit 10;

-- Также пассажирам вряд ли пригодится информация
-- о широте и долготе аэропортов, поэтому
-- эти поля тоже имеет смысл исключить
-- Вертикальное представление
CREATE VIEW airports_for_passengers AS
    SELECT airport_code, airport_name, city, timezone
    FROM airports;

SELECT * FROM airports_for_passengers limit 10;

-- Диспетчерам может потребоваться информация
-- о рейсах определенной модели самолета
-- Горизонтальное представление
CREATE VIEW routes_su9 AS
    SELECT * FROM routes
    WHERE aircraft_code='SU9';

SELECT * FROM routes_su9 limit 10;

-- При этом пассажиров и кассиров может заинтересовать
-- информация о том, куда можно долететь из конкретного города
-- Горизонтальное представление
CREATE VIEW routes_msk AS
    SELECT * FROM routes
    WHERE departure_city='Москва';

SELECT * FROM routes_msk limit 10;
