SELECT sum(quantity)
FROM phones_to_orders;

SELECT sum(quantity)
FROM phones;

SELECT avg(price)
"brand"
FROM phones 
GROUP BY "brand"; 

SELECT sum(price * quantity)
FROM phones
WHERE "price" BETWEEN 10000 AND 20000;

SELECT count(model),
brand
FROM phones
GROUP BY "brand";

SELECT min(quantity),
model 
FROM phones
GROUP BY model;

SELECT quantity
FROM phones
ORDER BY quantity ASC;
 
 SELECT sum(quantity) AS "AMOUNT OF BRAND PHONES", brand
 FROM phones
 GROUP BY brand
 ORDER BY "AMOUNT OF BRAND PHONES" ASC
 LIMIT 2;

SELECT *,extract('year' from age("birthday")) AS age
FROM "users"
ORDER BY "age" ASC, "firstName" DESC;

SELECT sum(quantity),
brand
FROM phones
GROUP BY brand
HAVING sum(quantity) > 70000;

SELECT id,
max(char_length(concat("firstName", ' ', "lastName"))) AS l
FROM "users" 
GROUP BY id
ORDER BY l DESC
LIMIT 1;

SELECT
char_length(concat("firstName", ' ', "lastName")) AS "name length",
count(*) AS "AMOUNT"
FROM "users"
GROUP BY "name length"
HAVING char_length(concat("firstName", ' ', "lastName")) < 18;

SELECT char_length("email") AS "length", count(*)
FROM "users"
-- WHERE "email" LIKE 'm%'
GROUP BY "length"
-- HAVING char_length("email") >= 25
HAVING count(*)>= 10
ORDER BY "length";

-- Извлечь все телефоны конкретного заказа

SELECT  phones.id, count(*)
FROM  phones
JOIN phones_to_orders ON phones_to_orders."orderId" = phones.id
JOIN orders ON  orders.id = phones_to_orders."orderId" 
WHERE orders.id = 2
GROUP BY phones.id;

-- Кол-во заказов каждого пользователя и его имеил
SELECT orders.id, count(*)
FROM orders
JOIN users ON  users.id = orders.id
GROUP BY orders.id;

SELECT  *
FROM  phones AS p
JOIN phones_to_orders AS pto ON p.id = pto."phoneId"
WHERE pto."orderId" = 2
ORDER BY p.id;

-- Кол-во заказов каждого пользователя и его имеил
SELECT u.id,u.email, count(o.id)
FROM users AS u
JOIN orders AS o ON u.id = o."userId"
GROUP BY u.id
ORDER BY u.id;

-- Кол-во позиций товара в определенном заказе
SELECT phones_to_orders."orderId", count(phones_to_orders."phoneId")
FROM phones_to_orders 
WHERE phones_to_orders."orderId" = 2
GROUP BY phones_to_orders."orderId";

-- Извлечь самый популярный телефон 
SELECT sum(pto.quantity) AS "Amount", p.id, p.model, p.brand
FROM phones AS p
JOIN phones_to_orders AS pto ON pto."phoneId" = p.id
WHERE p.model > 
GROUP BY p.id, p.model
ORDER BY p.id;

-- 1. Кол-во заказов каждого пользователя и вся инфа о пользователе
SELECT  u.*, count(orders.id) 
FROM users AS u
JOIN orders ON u.id = orders."userId"
GROUP BY u.id;

select count(orders.id)
FROM orders;

