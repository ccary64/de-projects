SET schema 'public';

-- We need this for UUID
CREATE EXTENSION pgcrypto;

-- Use this for common UTC now
--create function now_utc() returns timestamp as $$
--  select now() at time zone 'utc';
--$$ language sql;

-- Create initial customer table
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    balance INT,
    -- look at how JSON in sent to destination
    info JSONB DEFAULT '{}',
    updated_at timestamp without time zone default now(),
    created_at timestamp without time zone default now()
);

-- Update the updated_at no matter what
CREATE  FUNCTION updated_at_task()
    RETURNS TRIGGER AS $$
    BEGIN
        NEW.updated_at = now();
        RETURN NEW;
    END;
    $$ language 'plpgsql';

CREATE TRIGGER updated_customers_updated_on
    BEFORE UPDATE
    ON
        customers
    FOR EACH ROW
EXECUTE PROCEDURE updated_at_task();


-- Seed the table for example
-- Leave this here so we can see what happens with data that is added before
-- replication is turned on
INSERT INTO 
    customers 
        (first_name, last_name, email, balance, info)
    VALUES 
        ('John', 'Doe', 'john_doe@gmail.com', 9000, '{ "phones":[ {"type": "mobile", "phone": "001001"} , {"type": "fix", "phone": "002002"} ] }' ),
        ('Jane', 'Doe', 'jane_doe@gmail.com', 9000, '{}');