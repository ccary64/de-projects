SET schema 'public';

CREATE EXTENSION pgcrypto;

-- Create initial customer table
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    balance INT
);

-- Seed the table for example
INSERT INTO 
    customers 
        (first_name, last_name, email, balance)
    VALUES 
        ('John', 'Doe', 'john_doe@gmail.com', 9000),
        ('Jane', 'Doe', 'jane_doe@gmail.com', 9000);