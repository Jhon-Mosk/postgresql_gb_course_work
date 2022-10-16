ALTER TABLE
    requests_history
ADD
    CONSTRAINT requests_history_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;

ALTER TABLE
    orders
ADD
    CONSTRAINT orders_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;

ALTER TABLE
    goods
ADD
    CONSTRAINT goods_category_id_fk FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE
SET
    NULL;

ALTER TABLE
    goods
ADD
    CONSTRAINT goods_subcategory_id_fk FOREIGN KEY (subcategory_id) REFERENCES subcategories (id) ON DELETE
SET
    NULL;

ALTER TABLE
    rating
ADD
    CONSTRAINT rating_user_id_fk FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE
    rating
ADD
    CONSTRAINT rating_goods_id_fk FOREIGN KEY (goods_id) REFERENCES goods (id) ON DELETE CASCADE;

ALTER TABLE
    quantity_in_stores
ADD
    CONSTRAINT quantity_in_stores_store_id_fk FOREIGN KEY (store_id) REFERENCES stores (id) ON DELETE CASCADE;

ALTER TABLE
    quantity_in_stores
ADD
    CONSTRAINT quantity_in_stores_goods_id_fk FOREIGN KEY (goods_id) REFERENCES goods (id) ON DELETE CASCADE;

ALTER TABLE
    quantity_in_stock
ADD
    CONSTRAINT quantity_in_stock_goods_id_fk FOREIGN KEY (goods_id) REFERENCES goods (id) ON DELETE CASCADE;

ALTER TABLE
    delivery
ADD
    CONSTRAINT delivery_order_number_fk FOREIGN KEY (order_number) REFERENCES orders (order_number);

ALTER TABLE
    pickup
ADD
    CONSTRAINT pickup_order_number_fk FOREIGN KEY (order_number) REFERENCES orders (order_number);
