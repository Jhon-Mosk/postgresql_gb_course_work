--таблица пользователей
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(20) UNIQUE,
    discount INT CHECK (discount < 30),
    created_at TIMESTAMP,
    selected_goods INT []
);

--история обращений пользователя
CREATE TABLE requests_history (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    date TIMESTAMP NOT NULL,
    text VARCHAR(1000) NOT NULL
);

--статусы заказов
CREATE TYPE order_statuses AS ENUM (
    'returned',
    'bought',
    'placed',
    'delivery',
    'pickup'
);

--способ получения товара
CREATE TYPE receive_types AS ENUM ('delivery', 'pickup');

--таблица заказов
CREATE TABLE orders (
    order_number UUID PRIMARY KEY,
    goods_ids INT [] NOT NULL,
    user_id INT NOT NULL,
    cost INT NOT NULL,
    status order_statuses NOT NULL,
    receive_type receive_types NOT NULL,
    status_date TIMESTAMP NOT NULL,
    order_placed_date TIMESTAMP NOT NULL,
    returned_goods INT [],
    refund_amount INT,
    CHECK (refund_amount < cost)
);

--товары
CREATE TABLE goods (
    id SERIAL PRIMARY KEY,
    category_id INT NOT NULL,
    subcategory_id INT,
    cost INT NOT NULL,
    characteristics JSON NOT NULL,
    description VARCHAR(500) NOT NULL,
    discount INT,
    photo VARCHAR(30) NOT NULL,
    name VARCHAR(20) NOT NULL
);

--рейтинги товаров
CREATE TABLE rating (
    user_id INT NOT NULL,
    goods_id INT NOT NULL,
    rating INT NOT NULL,
    rating_date TIMESTAMP NOT NULL,
    PRIMARY KEY (goods_id, user_id)
);

--категории товаров
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category VARCHAR(20) NOT NULL UNIQUE
);

--подкатегории товаров
CREATE TABLE subcategories (
    id SERIAL PRIMARY KEY,
    subcategory VARCHAR(20) NOT NULL UNIQUE
);

--количество в магазинах
CREATE TABLE quantity_in_stores (
    store_id INT NOT NULL,
    goods_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (store_id, goods_id)
);

--количество на складе
CREATE TABLE quantity_in_stock (
    goods_id INT PRIMARY KEY,
    quantity INT NOT NULL
);

--список магазинов
CREATE TABLE stores (
    id SERIAL PRIMARY KEY,
    adress VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(50) NOT NULL UNIQUE
);

--статусы доставки
CREATE TYPE delivery_statuses AS ENUM ('collect', 'deliver', 'delivered');

--доставки
CREATE TABLE delivery (
    order_number UUID PRIMARY KEY,
    adress VARCHAR(50) NOT NULL,
    status delivery_statuses NOT NULL,
    status_date TIMESTAMP NOT NULL
);

--статусы самовывоза
CREATE TYPE pickup_statuses AS ENUM ('collect', 'waiting', 'taken');

--самовывоз
CREATE TABLE pickup (
    order_number UUID PRIMARY KEY,
    adress VARCHAR(50) NOT NULL,
    status pickup_statuses NOT NULL,
    status_date TIMESTAMP NOT NULL
);

--реклама
CREATE TABLE ad (
    id SERIAL PRIMARY KEY,
    ad VARCHAR(30) NOT NULL UNIQUE
);
