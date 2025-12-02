-- Update existing products to set image_url values
-- Run this against your database after migration (replace your DB name if needed)

UPDATE products SET image_url = 'https://images.pexels.com/photos/4325462/pexels-photo-4325462.jpeg' WHERE name = 'Yoga Mat';
UPDATE products SET image_url = 'https://images.pexels.com/photos/20690251/pexels-photo-20690251.jpeg' WHERE name = 'Garden Tools Set';
UPDATE products SET image_url = 'https://images.pexels.com/photos/4974922/pexels-photo-4974922.jpeg' WHERE name = 'Web Development Guide';
UPDATE products SET image_url = 'https://images.pexels.com/photos/1181359/pexels-photo-1181359.jpeg' WHERE name = 'Python Programming Book';
UPDATE products SET image_url = 'https://images.pexels.com/photos/52518/jeans-pants-blue-shop-52518.jpeg' WHERE name = 'Jeans';
UPDATE products SET image_url = 'https://images.pexels.com/photos/996329/pexels-photo-996329.jpeg' WHERE name = 'T-Shirt';
UPDATE products SET image_url = 'https://images.pexels.com/photos/7974/pexels-photo.jpg' WHERE name = 'Laptop';
UPDATE products SET image_url = 'https://images.pexels.com/photos/1786433/pexels-photo-1786433.jpeg' WHERE name = 'Smartphone';

-- Verify changes
SELECT product_id, name, image_url FROM products WHERE name IN (
  'Yoga Mat','Garden Tools Set','Web Development Guide','Python Programming Book','Jeans','T-Shirt','Laptop','Smartphone'
);
