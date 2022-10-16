-- 5.Создать два сложных (многотабличных) запроса с использованием подзапросов.(Запросы не должны быть коррелирующими);
SELECT
    *
FROM
    goods
WHERE
    cost > (
        SELECT
            AVG(cost)
        FROM
            goods
    )
    AND category_id = (
        SELECT
            id
        FROM
            categories
        WHERE
            category = 'Напитки'
    )
    AND subcategory_id = (
        SELECT
            id
        FROM
            subcategories
        WHERE
            subcategory = 'seafood2'
    );

SELECT
    *
FROM
    orders
    CROSS JOIN UNNEST(goods_ids) AS goods_id
WHERE
    receive_type = 'delivery'
    AND user_id = (
        SELECT
            id
        FROM
            users
        WHERE
            first_name = 'Felix'
    )
    AND goods_id = (
        SELECT
            id
        FROM
            goods
        WHERE
            cost = (
                SELECT
                    MIN(cost)
                FROM
                    goods
            )
    );

-- 6.Создать два сложных запроса с использованием объединения
-- JOIN и без использования подзапросов.;
SELECT
    order_number,
    first_name,
    last_name,
    phone,
    (cost * (100 - discount) / 100) AS cost_with_discount
FROM
    delivery
    JOIN orders USING (order_number)
    JOIN users ON orders.user_id = users.id
WHERE
    delivery.status = 'deliver';

SELECT
    order_number,
    pickup.status,
    goods_id,
    name,
    quantity AS quantity_in_stores
FROM
    pickup
    JOIN orders USING (order_number)
    CROSS JOIN UNNEST(goods_ids) AS goods_id
    JOIN goods ON goods_id = goods.id
    LEFT JOIN quantity_in_stores USING (goods_id)
WHERE
    pickup.status = 'collect'
    AND quantity IS NOT NULL;
