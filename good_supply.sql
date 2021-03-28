CREATE TABLE products(
    id serial PRIMARY KEY,
    name_of_product varchar(65) NOT NULL CHECK(name_of_product != ''),
    price_of_the_product decimal(10, 2) NOT NULL CHECK(price_of_the_product > 0)
);
CREATE TABLE customers(
    id serial PRIMARY KEY,
    customer_name varchar(64) NOT NULL CHECK(customer_name <> ''),
    addres JSONB NOT NULL,
    number_of_phone int NOT NULL
);
CREATE TABLE contracts(
    id serial PRIMARY KEY,
    created_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
    customer_id int REFERENCES customers
);
CREATE TABLE orders(
    id serial PRIMARY KEY,
    contract_id int REFERENCES contracts,
    name_of_product varchar(65) REFERENCES products(name_of_product),
    planned_delivery int NOT NULL
);

CREATE TABLE products_to_orders(
    product_id int REFERENCES products,
    order_id int REFERENCES orders
    PRIMARY KEY (product_id, order_id)
);

CREATE TABLE shipments(
    id serial PRIMARY KEY,
    order_code int REFERENCES orders,
    goods_shipped int NOT NULL CHECK(goods_shipped > 0),
    shipment_time TIMESTAMP NOT NULL DEFAULT current_timestamp
);
CREATE TABLE shipments_to_orders_product(
    shipment_id int REFERENCES shipments,
    product_id int REFERENCES products,
    order_id int REFERENCES orders,
    quantity int NOT NULL CHECK(quantity > 0),
    PRIMARY KEY (shipment_id, product_id, order_id),
    FOREIGN KEY( product_id, order_id) REFERENCES products_to_orders(product_id, order_id)
)