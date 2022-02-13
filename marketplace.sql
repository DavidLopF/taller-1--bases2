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
    );



