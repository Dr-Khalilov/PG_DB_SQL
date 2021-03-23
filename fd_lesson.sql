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