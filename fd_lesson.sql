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

SELECT *,extract('year' from age("birthday")) as age
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
SELECT  phones.id
FROM  phones
JOIN phones_to_orders ON phones_to_orders."orderId" = phones.id
JOIN orders ON  orders.id = phones_to_orders."orderId" 
WHERE orders.id = 2
ORDER BY orders.id;

-- Кол-во заказов каждого пользователя и его имеил
SELECT *
FROM users
