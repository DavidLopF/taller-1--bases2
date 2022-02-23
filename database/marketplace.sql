CREATE SCHEMA IF NOT EXISTS marketplace;

CREATE TABLE marketplace.user(
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    cellphone VARCHAR(255) NOT NULL,
    document VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marketplace.admin(
    id  SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES marketplace.user(id) ON DELETE CASCADE
);

CREATE TABLE marketplace.supplier(
    id  SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    state VARCHAR(255) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES marketplace.user(id) ON DELETE CASCADE
);


CREATE TABLE marketplace.buyer(
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES marketplace.user(id) ON DELETE CASCADE
);

CREATE TABLE marketplace.product_categories(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marketplace.products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    brand VARCHAR(255) NOT NULL,
    product_categories_id INTEGER NOT NULL,
    FOREIGN KEY (product_categories_id) REFERENCES marketplace.product_categories(id) ON DELETE CASCADE,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE marketplace.product_details(
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    size VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES marketplace.products(id) ON DELETE CASCADE,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marketplace.shopping_cars(
    id SERIAL PRIMARY KEY,
    buyer_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES marketplace.buyer(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES marketplace.products(id) ON DELETE CASCADE,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marketplace.checkout_porcess(
    id SERIAL PRIMARY KEY,
    shopping_car_id INTEGER NOT NULL,
    FOREIGN KEY (shopping_car_id) REFERENCES marketplace.shopping_cars(id) ON DELETE CASCADE,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marketplace.shippment_details(
    id SERIAL PRIMARY KEY,
    checkout_porcess_id INTEGER NOT NULL,
    adress VARCHAR(255) NOT NULL,
    shippment_type VARCHAR(255) NOT NULL,
    FOREIGN KEY (checkout_porcess_id) REFERENCES marketplace.checkout_porcess(id) ON DELETE CASCADE,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marketplace.cards(
    id SERIAL PRIMARY KEY,
    buyer_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    number_card VARCHAR(255) NOT NULL,
    expiration_month VARCHAR(255) NOT NULL,
    cvv VARCHAR(255) NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES marketplace.buyer(id) ON DELETE CASCADE,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marketplace.payment_type(
    id SERIAL PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    card_id INTEGER NOT NULL,
    FOREIGN KEY (card_id) REFERENCES marketplace.cards(id) ON DELETE CASCADE,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE marketplace.payment(
    id SERIAL PRIMARY KEY,
    payment_type_id INTEGER NOT NULL,
    FOREIGN KEY (payment_type_id) REFERENCES marketplace.payment_type(id) ON DELETE CASCADE,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE marketplace.order(
    id SERIAL PRIMARY KEY,
    payment_id INTEGER NOT NULL,
    FOREIGN KEY (payment_id) REFERENCES marketplace.payment(id) ON DELETE CASCADE,
    buyer_id INTEGER NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES marketplace.buyer(id) ON DELETE CASCADE,
    shippment_details_id INTEGER NOT NULL,
    FOREIGN KEY (shippment_details_id) REFERENCES marketplace.shippment_details(id) ON DELETE CASCADE,
    status VARCHAR(255) NOT NULL DEFAULT 'pending',
    price DECIMAL(10,2) NOT NULL,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


/* vista carrito abandonado - admin */
CREATE VIEW marketplace.total_purchase_incomplete AS
SELECT marketplace.buyer.id, marketplace.buyer.user_id, SUM(marketplace.order.price) AS total_purchase
FROM marketplace.buyer
INNER JOIN marketplace.order ON marketplace.buyer.id = marketplace.order.buyer_id
WHERE marketplace.order.status = 'pending'
GROUP BY marketplace.buyer.id;

/*vista de productos - user*/
CREATE VIEW marketplace.product_details_view AS
SELECT marketplace.products.id, marketplace.products.name, marketplace.products.price, marketplace.products.brand, marketplace.product_categories.name AS category, marketplace.product_details.size, marketplace.product_details.color
FROM marketplace.products
INNER JOIN marketplace.product_details ON marketplace.products.id = marketplace.product_details.product_id
INNER JOIN marketplace.product_categories ON marketplace.products.product_categories_id = marketplace.product_categories.id;

/*obtener total de ordenes finalizadas - admin*/
CREATE VIEW marketplace.total_purchase_complete AS
SELECT marketplace.buyer.id, marketplace.buyer.user_id, SUM(marketplace.order.price) AS total_purchase
FROM marketplace.buyer
INNER JOIN marketplace.order ON marketplace.buyer.id = marketplace.order.buyer_id
WHERE marketplace.order.status = 'complete'
GROUP BY marketplace.buyer.id;}


/*indices */
CREATE INDEX marketplace_checkout_porcess_shopping_car_id_idx ON marketplace.checkout_porcess (shopping_car_id);
CREATE INDEX marketplace_payment_type_card_id_idx ON marketplace.payment_type (card_id);
CREATE INDEX marketplace_order_payment_id_idx ON marketplace.order (payment_id);


/*notas : 
    - se agrego stauts y price a la orden para saber si esta pendiente o no
    - Se le agrego un estado al proveedor para saber si esta activo o no
*/


