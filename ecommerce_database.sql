CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;
SELECT c.first_name, c.last_name, o.order_id, o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;
SELECT c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
-- All orders with customer info (including unmatched)
SELECT o.order_id, c.first_name
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;
-- Total revenue per product
SELECT p.product_name, SUM(o.total_amount) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;
-- Average quantity per category
SELECT p.category, AVG(o.quantity) AS avg_qty
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;
-- Customers who spent more than average
SELECT first_name, last_name FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (
        SELECT AVG(total_amount) FROM orders
    )
);
SELECT * FROM products
WHERE category = 'Electronics' AND price > 500
ORDER BY price DESC;
CREATE VIEW customer_orders AS
SELECT c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
CREATE INDEX idx_order_customer_id ON orders(customer_id);