create database omkar;
use omkar;

drop table suppliers;

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50) not null,
    contact_person VARCHAR(50) not null,
    phone_number VARCHAR(20) unique,
    email VARCHAR(100) unique,
    country VARCHAR(50) not null,
    created_at DATETIME
);

INSERT INTO suppliers
(supplier_id, supplier_name, contact_person, phone_number, email, country, created_at)
VALUES
(1, 'Supplier 1', 'Contact 1', '+91-9619-216739', 'supplier1@example.com', 'India', '2025-10-16 23:11:14'),
(2, 'Supplier 2', 'Contact 2', '+91-8003-334053', 'supplier2@example.com', 'India', '2025-10-13 05:28:08'),
(3, 'Supplier 3', 'Contact 3', '+91-9771-876646', 'supplier3@example.com', 'India', '2025-09-18 13:20:40'),
(4, 'Supplier 4', 'Contact 4', '+91-7356-719176', 'supplier4@example.com', 'India', '2025-10-04 08:02:37'),
(5, 'Supplier 5', 'Contact 5', '+91-7122-198246', 'supplier5@example.com', 'India', '2025-10-11 00:43:47');


insert into suppliers values
(6, 'Supplier 6', 'Contact 6', '+91-7122-198299', 'supplier6@example.com', 'USA', '2025-10-12 00:43:47');


select * from suppliers;

create table warehouses
(
	warehouse_id int primary key,
    warehouse_name varchar(100) not null,
    city varchar(50) not null,
    state varchar(50) not null,
    country varchar(50)not null,
    capacity_units int check(capacity_units>0),
    created_at datetime
);

insert into warehouses(warehouse_id,warehouse_name,city,state,country,capacity_units,created_at)
values 
(1, 'Warehouse 1', 'Pune', 'Maharashtra', 'India', 1000, '2025-10-15 11:16:55'),
(2, 'Warehouse 2', 'Mumbai', 'Maharashtra', 'India', 1500, '2025-10-31 12:45:59'),
(3, 'Warehouse 3', 'Nashik', 'Maharashtra', 'India', 1200, '2025-10-25 09:32:21'),
(4, 'Warehouse 4', 'Nagpur', 'Maharashtra', 'India', 1800, '2025-10-09 13:21:36'),
(5, 'Warehouse 5', 'Aurangabad', 'Maharashtra', 'India', 2000, '2025-10-19 01:10:29');

select * from warehouses;

CREATE TABLE customers (
    customer_id INT primary key,
    customer_name VARCHAR(50) not null,
    phone_number VARCHAR(20) unique,
    email VARCHAR(100)unique,
    city VARCHAR(50)not null,
    country VARCHAR(50)not null,
    created_at DATETIME
);
INSERT INTO customers
(customer_id, customer_name, phone_number, email, city, country, created_at)
VALUES
(1, 'Customer 1', '+91-8839-717889', 'customer1@example.com', 'Pune', 'India', '2025-11-08 08:57:51'),
(2, 'Customer 2', '+91-7653-832052', 'customer2@example.com', 'Mumbai', 'India', '2025-11-02 20:48:45'),
(3, 'Customer 3', '+91-8138-263032', 'customer3@example.com', 'Thane', 'India', '2025-11-09 20:56:44'),
(4, 'Customer 4', '+91-7418-197251', 'customer4@example.com', 'Satara', 'India', '2025-11-04 05:40:46'),
(5, 'Customer 5', '+91-8470-988662', 'customer5@example.com', 'Kolhapur', 'India', '2025-11-04 11:13:11');

CREATE TABLE purchase_orders (
    po_id INT primary key,
    supplier_id INT not null,
    po_date DATE not null,
    expected_date DATE not null,
    status VARCHAR(20) not null,
    total_amount DECIMAL(10,2) not null check(total_amount>0),
    created_at DATETIME
);
INSERT INTO purchase_orders
(po_id, supplier_id, po_date, expected_date, status, total_amount, created_at)
VALUES
(1, 1, '2025-11-18', '2025-11-21', 'Open', 12500.00, '2025-11-16 16:28:25'),
(2, 2, '2025-11-09', '2025-11-13', 'Approved', 8900.50, '2025-11-22 06:19:54'),
(3, 3, '2025-11-09', '2025-11-16', 'Received', 15420.75, '2025-11-17 10:40:52'),
(4, 4, '2025-11-15', '2025-11-27', 'Closed', 6100.00, '2025-11-25 06:40:06'),
(5, 5, '2025-11-25', '2025-12-08', 'Cancelled', 3000.25, '2025-11-24 22:39:52');

select * from purchase_orders;

CREATE TABLE purchase_order_items (
    po_item_id INT primary key,
    po_id INT not null,
    product_id INT not null,
    quantity INT not null check(quantity>0),
    unit_price DECIMAL(10,2) not null check(unit_price>0),
    created_at DATETIME
);
INSERT INTO purchase_order_items
(po_item_id, po_id, product_id, quantity, unit_price, created_at)
VALUES
(1, 1, 101, 10, 250.00, '2025-11-30 00:43:30'),
(2, 1, 102, 5, 500.00, '2025-11-29 19:21:39'),
(3, 2, 101, 12, 200.00, '2025-11-26 16:41:33'),
(4, 3, 103, 7, 350.00, '2025-11-20 19:55:03'),
(5, 4, 104, 3, 1000.00, '2025-11-28 19:43:22');

select * from purchase_order_items;

CREATE TABLE inventory (
    inventory_id INT primary key,
    warehouse_id INT not null,
    product_id INT not null,
    quantity_on_hand INT not null,
    reorder_level INT not null,
    last_updated DATETIME
);
INSERT INTO inventory
(inventory_id, warehouse_id, product_id, quantity_on_hand, reorder_level, last_updated)
VALUES
(1, 1, 101, 50, 20, '2025-12-06 01:34:22'),
(2, 2, 102, 30, 15, '2025-12-06 09:36:23'),
(3, 3, 103, 70, 25, '2025-12-09 11:01:22'),
(4, 4, 104, 20, 10, '2025-12-08 13:45:12'),
(5, 5, 105, 90, 30, '2025-12-08 03:15:05');

select * from inventory;


CREATE TABLE sales_orders (
    sales_order_id INT not null,
    customer_id INT primary key,
    order_date DATE,
    status VARCHAR(20) not null,
    total_amount DECIMAL(10,2) not null check(total_amount>0),
    created_at DATETIME
);
INSERT INTO sales_orders
(sales_order_id, customer_id, order_date, status, total_amount, created_at)
VALUES
(1, 1, '2025-12-04', 'Pending', 3200.50, '2025-11-30 23:22:20'),
(2, 2, '2025-12-01', 'Confirmed', 4500.00, '2025-11-26 01:12:17'),
(3, 3, '2025-12-01', 'Shipped', 2100.75, '2025-12-03 07:09:51'),
(4, 4, '2025-12-08', 'Delivered', 980.00, '2025-12-11 21:42:55'),
(5, 5, '2025-12-05', 'Cancelled', 1500.00, '2025-12-05 06:47:27');

select * from sales_orders;

CREATE TABLE sales_order_items (
    so_item_id INT primary key,
    sales_order_id INT not null,
    product_id INT not null,
    quantity INT check(quantity>0) not null,
    unit_price DECIMAL(10,2) check(unit_price>0) not null ,
    created_at DATETIME
);

INSERT INTO sales_order_items
(so_item_id, sales_order_id, product_id, quantity, unit_price, created_at)
VALUES
(1, 1, 101, 2, 1600.00, '2025-12-10 12:33:01'),
(2, 1, 102, 1, 4500.00, '2025-12-09 01:27:33'),
(3, 2, 103, 3, 700.25, '2025-12-03 15:01:27'),
(4, 3, 104, 4, 245.00, '2025-12-07 09:47:43'),
(5, 4, 105, 5, 300.00, '2025-12-07 03:59:56');

SELECT * FROM sales_order_items;


-- 1)List all suppliers located in India.
select * from suppliers where Country='India';

-- Find suppliers where supplier_name contains 'Tech' and country is not 'USA'

select * from suppliers where supplier_name like '%Tech%' and Country not in('USA');

-- Show suppliers created after 2024-01-01 and before 2024-12-31

select * from suppliers where created_at between '2025-01-01'and '=2025-12-31';

-- Return suppliers where contact_person IS NULL OR email IS NULL.

select * from suppliers where contact_person is null or email is null;

-- 5 Get suppliers whose phone_number starts with '+91' AND email ends with '.com'.

select * from suppliers where phone_number like '+91%' and email like '%.com';

-- 6 List warehouses in the state 'Maharashtra' OR city = 'Pune'.
select * from warehouses where state='Maharashtra' or city='Pune';

-- 7 Find warehouses in India AND capacity_units >= 10000.
select * from warehouses where Country='India' and capacity_units >= 10000;

-- 8 Show warehouses where warehouse_name LIKE '%central%' AND country = 'India'.

select * from warehouses;
select * from warehouses where warehouse_name LIKE '%central%' AND country = 'India';

-- 9 Return warehouses created in the last 30 days (use current_date) OR capacity_units <1000;

select * from warehouses where created_at >= current_date() - interval 30 day or capacity_units <1000;

-- 10 Get warehouses where state IS NULL OR city IS NULL (missing location details).
select * from warehouses where state is null or city is null;

select * from customers;
-- 1 List customers with email ending in '@gmail.com' AND country = 'India'.
select * from customers where email like'%@example.com' and Country='India';

-- 12 Find customers whose city IN ('Mumbai', 'Pune', 'Delhi') OR phone_number LIKE '022%'.
select * from customers where city in ('Mumbai', 'Pune', 'Delhi') or phone_number LIKE '052%';

-- 13 Show customers created_at between two dates, e.g., 2025-01-01 AND 2025-06-30.
select * from customers where created_at between 2025-11-08 AND 2025-11-09;

-- 14 Return customers where customer_name ILIKE '%store%' OR ILIKE '%mart%'.
select * from customers where customer_name LIKE '%Cust%' OR '%r%';

-- 15 Get customers with missing phone_number OR invalid phone_number (NOT LIKE '+%').
select * from customers phone_number is null or phone_number not like '+%';

16 List purchase orders where status = 'Pending' OR status = 'Approved'.
17 Find purchase orders for supplier_id = 5 AND total_amount > 100000.
18 Show purchase orders expected_date < po_date (late entry) OR expected_date IS NULL.
19 Return purchase orders in 2025 (po_date between 2025-01-01 and 2025-12-31).
20 Get purchase orders with total_amount BETWEEN 5000 AND 20000 AND status <>
'Cancelled'.
21 List PO items where quantity >= 100 AND unit_price <= 50.



