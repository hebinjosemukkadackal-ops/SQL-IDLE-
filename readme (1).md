# 📊 SQL for Data Analysis — Ecommerce Database

## 🧾 Internship Task

**Data Analyst Internship — Task 3**

**Objective:**
Use SQL queries to extract and analyze data from an ecommerce database.

This project demonstrates practical SQL skills including data creation, querying, aggregation, joins, subqueries, views, and optimization.

---

## 🗄️ Database Used

* SQLite (also compatible with MySQL & PostgreSQL with minor syntax changes)

---

## 📁 Project Structure

```
SQL_Task3/
 ├── task3_ecommerce_complete.sql
 ├── screenshots/
 │     ├── revenue.png
 │     ├── joins.png
 │     ├── groupby.png
 │     └── view.png
 └── README.md
```

---

## 🧱 Database Schema

### Tables Created

1. **customers** — stores customer details
2. **products** — product catalog
3. **orders** — order records
4. **order_items** — products included in each order

This simulates a real ecommerce system where:

* One customer → many orders
* One order → many products

---

## 📊 SQL Concepts Implemented

### 1️⃣ Basic Queries

* `SELECT`
* `WHERE`
* `ORDER BY`

### 2️⃣ Aggregations

* `SUM()`
* `AVG()`
* Revenue calculation

### 3️⃣ GROUP BY Analysis

* Revenue per product
* Spending per customer

### 4️⃣ Joins

* `INNER JOIN` → orders with customer names
* `LEFT JOIN` → customers without orders

### 5️⃣ Subqueries

* Customers spending above average

### 6️⃣ Business Metric

**ARPU (Average Revenue Per User)** calculation

### 7️⃣ Views

Reusable analysis view created:

```
customer_spending
```

### 8️⃣ NULL Handling

Handled missing values using:

```
IFNULL()
```

### 9️⃣ Query Optimization

Indexes added for performance:

```
orders(customer_id)
order_items(product_id)
```

---

## 📈 Example Insights Generated

* Total company revenue
* Most profitable product
* Highest spending customer
* Customers who never ordered
* Average revenue per user (ARPU)

---

## ▶️ How to Run

1. Open SQLite Online / DB Browser / MySQL Workbench
2. Paste contents of `task3_ecommerce_complete.sql`
3. Execute the script
4. Run individual queries
5. Capture screenshots

---

## 🎯 Outcome

Learned how to manipulate and analyze structured data using SQL including real-world analytical queries and performance optimization.

---

## 👨‍💻 Author

Hebin Jose M
