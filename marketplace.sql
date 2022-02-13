CREATE SCHEMA users

    CREATE TABLE users.user(

        id SERIAL PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL,
        phone_number VARCHAR(255) NOT NULL,
        document VARCHAR(255) NOT NULL,
        address VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        role VARCHAR(255) NOT NULL,
        created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )

    CREATE TABLE users.admin(
        id  SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users.user(id) ON DELETE CASCADE
    )
    
    CREATE TABLE users.supplier(
        id  SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users.user(id) ON DELETE CASCADE
    )
    

    CREATE TABLE  users.buyer(
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users.user(id) ON DELETE CASCADE
    )

/*
    Esquema productos en donde se guardan los productos normales, el tipo y los detalles del mismo
*/

CREATE SCHEMA products

    CREATE TABLE products.product(
        id SERIAL PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        description VARCHAR(255) NOT NULL,
        category VARCHAR(255) NOT NULL,
        quantity INTEGER NOT NULL,
        trademark VARCHAR(255) NOT NULL,
        price INTEGER NOT NULL,
        image VARCHAR(255) NOT NULL,
        created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )

    CREATE TABLE products.product_type(
        id SERIAL PRIMARY KEY,
        product_id INTEGER NOT NULL,
        type VARCHAR(255) NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products.product(id) ON DELETE CASCADE
    )
    
    CREATE TABLE products.product_clothe(
        id SERIAL PRIMARY KEY,
        product_id INTEGER NOT NULL,
        size VARCHAR(255) NOT NULL,
        color VARCHAR(255) NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products.product(id) ON DELETE CASCADE
    )



