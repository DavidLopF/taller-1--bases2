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
    FOREIGN KEY (product_categories_id) REFERENCES marketplace.product_categories(id) ON DELETE CASCADE
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
    FOREMIGN KEY (shopping_car_id) REFERENCES marketplace.shopping_cars(id) ON DELETE CASCADE,
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
    number VARCHAR(255) NOT NULL,
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
    status VARCHAR(255) NOT NULL,
    created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

    



    



