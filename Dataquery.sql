/* =====================================================
   DATA ANALYST INTERNSHIP - TASK 3 COMPLETE SQL FILE
   Ecommerce Data Analysis
   ===================================================== */

/* ---------------------------
   1. CLEAN START (avoid errors)
--------------------------- */
DROP VIEW IF EXISTS customer_spending;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;


/* ---------------------------
   2. CREATE TABLES
--------------------------- */

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    city TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price REAL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/* ---------------------------
   3. INSERT SAMPLE DATA
--------------------------- */

-- Customers (10)
INSERT INTO customers VALUES
(1,'Aarav','Mumbai'),
(2,'Riya','Delhi'),
(3,'John','Bangalore'),
(4,'Emma','Chennai'),
(5,'David','Hyderabad'),
(6,'Sara','Pune'),
(7,'Ali','Kolkata'),
(8,'Noah','Jaipur'),
(9,'Maya','Delhi'),
(10,'Kabir','Mumbai');

-- Products (8)
INSERT INTO products VALUES
(101,'Laptop','Electronics',60000),
(102,'Phone','Electronics',25000),
(103,'Headphones','Electronics',2000),
(104,'Shoes','Fashion',3000),
(105,'Watch','Fashion',5000),
(106,'Backpack','Fashion',1500),
(107,'Keyboard','Electronics',1200),
(108,'Mouse','Electronics',800);

-- Orders (11)
INSERT INTO orders VALUES
(1001,1,'2024-01-10'),
(1002,2,'2024-01-12'),
(1003,3,'2024-01-15'),
(1004,4,'2024-02-01'),
(1005,5,'2024-02-03'),
(1006,1,'2024-02-10'),
(1007,6,'2024-02-11'),
(1008,7,'2024-02-15'),
(1009,8,'2024-02-20'),
(1010,9,'2024-02-25'),
(1011,10,'2024-03-01');

-- Order Items (20 rows)
INSERT INTO order_items VALUES
(1,1001,101,1),
(2,1001,103,2),
(3,1002,102,1),
(4,1002,108,1),
(5,1003,104,2),
(6,1004,105,1),
(7,1004,106,3),
(8,1005,101,1),
(9,1006,107,2),
(10,1007,108,2),
(11,1007,103,1),
(12,1008,104,1),
(13,1008,105,1),
(14,1009,102,1),
(15,1009,106,2),
(16,1010,103,3),
(17,1010,107,1),
(18,1011,104,2),
(19,1011,108,2),
(20,1011,105,1);


/* ---------------------------
   4. BASIC QUERIES
--------------------------- */

-- Customers from Mumbai
SELECT * FROM customers
WHERE city='Mumbai';

-- Products sorted by price
SELECT * FROM products
ORDER BY price DESC;


/* ---------------------------
   5. AGGREGATE FUNCTIONS
--------------------------- */

-- Total Revenue
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- Average Product Price
SELECT AVG(price) AS avg_price FROM products;


/* ---------------------------
   6. GROUP BY ANALYSIS
--------------------------- */

-- Revenue per product
SELECT p.product_name,
       SUM(p.price * oi.quantity) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;


/* ---------------------------
   7. JOINS
--------------------------- */

-- INNER JOIN (orders with customer name)
SELECT o.order_id, c.name, o.order_date
FROM orders o
INNER JOIN customers c
ON o.customer_id=c.customer_id;

-- LEFT JOIN (customers without orders)
SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
WHERE o.order_id IS NULL;


/* ---------------------------
   8. SUBQUERY
--------------------------- */

-- Customers spending above average
SELECT name
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id=oi.order_id
    JOIN products p ON oi.product_id=p.product_id
    GROUP BY o.customer_id
    HAVING SUM(p.price*oi.quantity) >
    (
        SELECT AVG(p.price*oi.quantity)
        FROM order_items oi
        JOIN products p ON oi.product_id=p.product_id
    )
);


/* ---------------------------
   9. ARPU (Average Revenue Per User)
--------------------------- */

SELECT 
    SUM(p.price*oi.quantity) / COUNT(DISTINCT o.customer_id) AS ARPU
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id;


/* ---------------------------
   10. VIEW
--------------------------- */

CREATE VIEW customer_spending AS
SELECT c.name,
       SUM(p.price*oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
GROUP BY c.name;

-- Use view
SELECT * FROM customer_spending
ORDER BY total_spent DESC;


/* ---------------------------
   11. NULL HANDLING
--------------------------- */

SELECT name,
       IFNULL(city,'Unknown City') AS city
FROM customers;


/* ---------------------------
   12. INDEX OPTIMIZATION
--------------------------- */

CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_orderitems_product
ON order_items(product_id);

