-- 7. Создать два представления, в основе которых лежат сложные запросы.;
--
--топ-10 крупнейших покупок пользователей за 10 месяцев
CREATE VIEW top_10_largest_user_purchases_10_months AS
SELECT
    DISTINCT first_name,
    last_name,
    email,
    discount,
    SUM(cost) OVER (PARTITION BY user_id) AS amount_purchases
FROM
    orders
    JOIN users ON user_id = users.id
WHERE
    status = 'bought'
    AND status_date > (current_timestamp - interval '10 month')
ORDER BY
    amount_purchases DESC
LIMIT
    10;

--топ-10 наиболее покупаемых товаров
CREATE VIEW top_10_most_purchases_goods AS
SELECT
    DISTINCT name,
    count(goods_id) OVER (PARTITION BY goods_id) AS number_purchases
FROM
    orders
    CROSS JOIN UNNEST(goods_ids) AS goods_id
    JOIN goods ON goods_id = goods.id
ORDER BY
    number_purchases DESC
LIMIT
    10;
