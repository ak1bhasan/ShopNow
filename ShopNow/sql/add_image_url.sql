-- Simple ALTER statement to add image_url column to products
-- Run this if you don't want to use the guarded migration.

ALTER TABLE products
ADD COLUMN image_url VARCHAR(255);

-- Note: this will fail if `image_url` already exists. Use
-- `sql/migration_add_image_url.sql` for a guarded approach.
