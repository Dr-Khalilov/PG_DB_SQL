/* 
 Типы ассоциации
 
 1 => : <= 1 
 1  : <= m   
 m : <= m_to_n => : n
 
 <= - REFERENCES
 */

/*  Посчитать кол-во телефонов, которые были проданы  */
SELECT sum(quantity* price)
FROM phones;
/*  */
-- Кол-во телефонов которые есть на складе
SELECT sum(quantity)
FROM phones;
-- Средняя цена всех телефонов
SELECT avg(price) as "Средняя цена телефлнов" FROM phones;
-- Средняя цена каждого бренда
SELECT avg(price), brand FROM phones
GROUP BY brand;
-- Стоимость всех телефонов в диапазоне цены от 10К до 20К
SELECT sum(price*quantity), brand, model FROM phones
WHERE price BETWEEN 10000 AND 20000
GROUP BY brand, model;
-- Кол-во моделей каждого бренда
SELECT count(model), brand FROM phones
GROUP BY brand;
-- Каких моделей телефонов осталось меньше всего
SELECT sum(quantity), brand, model FROM phones
GROUP BY brand, model
ORDER BY brand, model;
-- Кол-во заказов каждого пользователя, которые совершали заказы
SELECT count(id), "userId" FROM orders
GROUP BY "userId";

SELECT * FROM users
ORDER BY height;

SELECT extract('year' from age(birthday)) AS "Age", concat("firstName", ' ', "lastName") AS "Full name" 
FROM users
GROUP BY "Age", "Full name"
ORDER BY "Age" ASC, "Full name" ASC;

SELECT sum(quantity), brand FROM phones
GROUP BY brand
HAVING sum(quantity)>10000;

SELECT * FROM users
WHERE "firstName" LIKE 'M%n';

SELECT * FROM users
JOIN orders ON orders."userId" = users.id
WHERE users.id = 1;