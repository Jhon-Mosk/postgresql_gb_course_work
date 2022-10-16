EXPLAIN ANALYZE
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

"Nested Loop  (cost=1.28..4.82 rows=1 width=44) (actual time=0.019..0.036 rows=5 loops=1)" "  ->  Hash Join  (cost=1.14..4.41 rows=1 width=24) (actual time=0.015..0.027 rows=5 loops=1)" "        Hash Cond: (orders.order_number = delivery.order_number)" "        ->  Seq Scan on orders  (cost=0.00..3.00 rows=100 width=24) (actual time=0.004..0.009 rows=100 loops=1)" "        ->  Hash  (cost=1.12..1.12 rows=1 width=16) (actual time=0.006..0.006 rows=5 loops=1)" "              Buckets: 1024  Batches: 1  Memory Usage: 9kB" "              ->  Seq Scan on delivery  (cost=0.00..1.12 rows=1 width=16) (actual time=0.003..0.004 rows=5 loops=1)" "                    Filter: (status = 'deliver'::delivery_statuses)" "                    Rows Removed by Filter: 5" "  ->  Index Scan using users_pkey on users  (cost=0.14..0.40 rows=1 width=32) (actual time=0.001..0.001 rows=1 loops=5)" "        Index Cond: (id = orders.user_id)" "Planning Time: 0.172 ms" "Execution Time: 0.054 ms";

SELECT
    indexname
FROM
    pg_indexes
WHERE
    tablename = 'delivery';

SELECT
    indexname
FROM
    pg_indexes
WHERE
    tablename = 'orders';

SELECT
    indexname
FROM
    pg_indexes
WHERE
    tablename = 'users';

CREATE INDEX delivery_order_number_fk ON delivery (order_number);

CREATE INDEX delivery_status_idx ON delivery (status);

CREATE INDEX orders_user_id_fk ON orders (user_id);

"Nested Loop  (cost=1.28..4.82 rows=1 width=44) (actual time=0.019..0.035 rows=5 loops=1)" "  ->  Hash Join  (cost=1.14..4.41 rows=1 width=24) (actual time=0.014..0.026 rows=5 loops=1)" "        Hash Cond: (orders.order_number = delivery.order_number)" "        ->  Seq Scan on orders  (cost=0.00..3.00 rows=100 width=24) (actual time=0.004..0.009 rows=100 loops=1)" "        ->  Hash  (cost=1.12..1.12 rows=1 width=16) (actual time=0.007..0.007 rows=5 loops=1)" "              Buckets: 1024  Batches: 1  Memory Usage: 9kB" "              ->  Seq Scan on delivery  (cost=0.00..1.12 rows=1 width=16) (actual time=0.003..0.004 rows=5 loops=1)" "                    Filter: (status = 'deliver'::delivery_statuses)" "                    Rows Removed by Filter: 5" "  ->  Index Scan using users_pkey on users  (cost=0.14..0.40 rows=1 width=32) (actual time=0.001..0.001 rows=1 loops=5)" "        Index Cond: (id = orders.user_id)" "Planning Time: 0.173 ms" "Execution Time: 0.053 ms";
