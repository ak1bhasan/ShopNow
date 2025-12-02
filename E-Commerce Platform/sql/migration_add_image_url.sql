-- Migration: add image_url column to products table (if not present)
-- Run this against your MySQL database when migrating schema.
-- This migration adds an `image_url` column to the `products` table.
-- Run this against your MySQL database (e.g., using the mysql client):
--   mysql -u user -p your_database < sql/migration_add_image_url.sql

-- Check existence and add column only if it does not already exist.
SET @table := 'products';
SET @column := 'image_url';

SELECT COUNT(*) INTO @col_exists
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
	AND TABLE_NAME = @table
	AND COLUMN_NAME = @column;

-- If column doesn't exist, add it
SET @s = IF(@col_exists = 0,
	CONCAT('ALTER TABLE ', @table, ' ADD COLUMN ', @column, ' VARCHAR(255) NULL;'),
	'SELECT "column exists";'
);

PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- End migration
