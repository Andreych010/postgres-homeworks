SELECT * FROM order_details
SELECT * FROM products
SELECT * FROM discontinued_products
SELECT * FROM order_details_test_all

-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT chk_products_unit_price CHECK (unit_price > 0);
INSERT INTO products (product_id, product_name, unit_price, discontinued) VALUES (78, 'gjh', -1, 1)

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT chk_products_discontinued CHECK (discontinued IN (0, 1));
INSERT INTO products (product_id, product_name, unit_price, discontinued) VALUES (79, 'shugar', 1, 3)

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
SELECT * INTO discontinued_products FROM products WHERE discontinued = 1;
SELECT * INTO order_details_test_all FROM order_details;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
ALTER TABLE order_details DROP CONSTRAINT fk_order_details_products;
DELETE FROM products WHERE discontinued = 1;
DELETE FROM order_details WHERE product_id in (1,2,5,9,17,24,28,29,42,53);
ALTER TABLE order_details ADD CONSTRAINT fk_order_details_products FOREIGN KEY(product_id) REFERENCES products(product_id);
