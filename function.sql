CREATE FUNCTION total_quantity_goods(search_goods_id INT) RETURNS INT AS $ $
SELECT
    (
        COALESCE(quantity_in_stock.quantity, 0) + COALESCE(quantity_in_stores.quantity, 0)
    ) AS total_quantity
FROM
    quantity_in_stock FULL
    JOIN quantity_in_stores USING (goods_id)
WHERE
    goods_id = search_goods_id;

$ $ LANGUAGE SQL;

SELECT
    total_quantity_goods(23);
