-- Если бренд Iphone то в колонке написать Apple 
SELECT *,
    (
        CASE
            WHEN brand = 'IPhone' THEN 'Apple'
            ELSE 'UNKNOWN'
        END
    ) AS "PRODUCTIONS"
FROM phones;
-- -- Цена <10 k - available
-- цена 10 K - 20 K
- - price > 20 k - дорогой
SELECT *,
    (
        CASE
            WHEN price < 10000 THEN 'Available'
            WHEN price BETWEEN 10000 AND 20000 THEN 'Middle'
            WHEN price > 20000 THEN 'Flagman'
        END
    ) AS "Cost phones"
FROM phones;
-- ПО кол-ву заказов определить статус пользователя.
-- Если заказов больше 10 постоянные покупатель.
-- Если больше 5 активный пользователь. 
-- В другом случае покупатель.
SELECT users.id,
    users.email,
    count(orders.id),
    (
        CASE
            WHEN count(orders.id) >= 5 THEN 'Постоянный покупатель'
            WHEN count(orders.id) >= 2 THEN 'Активный покупатель'
            ELSE 'Покупатель'
        END
    ) AS "Status"
FROM orders
    JOIN users ON users.id = orders."userId"
GROUP BY users.id;

CREATE OR REPLACE VIEW "base_inf_about_users" AS(
    SELECT "id",
        concat("firstName", ' ', "lastName") AS "Full name",
        "email", "isMale",
        extract(
            'year'
            from age("birthday")
        ) AS "Age user",
        (
            CASE
                WHEN "isMale" THEN 'Male'
                WHEN NOT "isMale" THEN 'Female'
                ELSE 'Other'
            END
        ) AS "Gender"
    FROM users
);

