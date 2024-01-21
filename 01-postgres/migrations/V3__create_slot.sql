SET schema 'public';
-- Create slot for CDC
SELECT pg_create_logical_replication_slot('airbyte_slot', 'pgoutput');

-- Add table to publication - use IDENTITY FULL for large fields
ALTER TABLE public.customers REPLICA IDENTITY DEFAULT;
ALTER PUBLICATION airbyte_pub ADD TABLE public.customers;

-- This would be created outside of the migrations but used to show seperate user
CREATE USER airbyte PASSWORD 'password';
GRANT CONNECT ON DATABASE source TO airbyte;
GRANT USAGE ON SCHEMA public TO airbyte;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO airbyte;

-- Allow airbyte user to see tables created in the future
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO airbyte;
ALTER USER airbyte REPLICATION LOGIN;