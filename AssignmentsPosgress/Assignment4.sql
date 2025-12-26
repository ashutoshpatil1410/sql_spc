drop table suppliers;
drop table warehouses;
drop table customers;
drop table purchase_orders;
drop table purchase_order_items;
drop table inventory;
drop table sales_orders;
drop table shipments;

-----------------------------------------------------------------------------------------------------------------------
create table suppliers
(
	supplier_id serial primary key,
    supplier_name varchar(150) not null,
    contact_person varchar(100),
    phone_number varchar(20),
    email varchar(150) not null unique,
    country varchar(100) not null,
    created_at timestamp not null default current_timestamp
);
drop table suppliers;
select * from suppliers;


INSERT INTO suppliers
(supplier_name, contact_person, phone_number, email, country, created_at)
VALUES
('Supplier 1', 'Contact 1', '+91-9619-216739', 'supplier1@example.com', 'India', '2025-10-16 23:11:14'),
('Supplier 2', 'Contact 2', '+91-8003-334053', 'supplier2@example.com', 'India', '2025-10-13 05:28:08'),
('Supplier 3', 'Contact 3', '+91-9771-876646', 'supplier3@example.com', 'India', '2025-09-18 13:20:40'),
('Supplier 4', 'Contact 4', '+91-7356-719176', 'supplier4@example.com', 'India', '2025-10-04 08:02:37'),
('Supplier 5', 'Contact 5', '+91-7122-198246', 'supplier5@example.com', 'India', '2025-10-11 00:43:47');

-----------------------------------------------------------------------------------------------------------------------
create table warehouses
(
	warehouse_id serial primary key,
    warehouse_name varchar(150) not null,
    city varchar(100) not null,
    state varchar(100) not null,
    country varchar(100) not null,
    capacity_units int check(capacity_units>0) not null,
    created_at timestamp default current_timestamp
);
drop table warehouses;
select * from warehouses;



insert into warehouses(warehouse_name,city,state,country,capacity_units,created_at)
values 
('Warehouse 1', 'Pune', 'Maharashtra', 'India', 1000, '2025-10-15 11:16:55'),
('Warehouse 2', 'Mumbai', 'Maharashtra', 'India', 1500, '2025-10-31 12:45:59'),
('Warehouse 3', 'Nashik', 'Maharashtra', 'India', 1200, '2025-10-25 09:32:21'),
('Warehouse 4', 'Nagpur', 'Maharashtra', 'India', 1800, '2025-10-09 13:21:36'),
('Warehouse 5', 'Aurangabad', 'Maharashtra', 'India', 2000, '2025-10-19 01:10:29');

-----------------------------------------------------------------------------------------------------------------------
create table customers
(
	customer_id serial primary key,
    customer_name varchar(150) not null,
    phone_number varchar(20) ,
    email varchar(150) unique not null,
    city varchar(100),
    country varchar(100) not null,
    created_at timestamp default current_timestamp
);

drop table customers;

select * from customers;

INSERT INTO customers
(customer_name, phone_number, email, city, country, created_at)
VALUES
('Customer 1', '+91-8839-717889', 'customer1@example.com', 'Pune', 'India', '2025-11-08 08:57:51'),
('Customer 2', '+91-7653-832052', 'customer2@example.com', 'Mumbai', 'India', '2025-11-02 20:48:45'),
('Customer 3', '+91-8138-263032', 'customer3@example.com', 'Thane', 'India', '2025-11-09 20:56:44'),
('Customer 4', '+91-7418-197251', 'customer4@example.com', 'Satara', 'India', '2025-11-04 05:40:46'),
('Customer 5', '+91-8470-988662', 'customer5@example.com', 'Kolhapur', 'India', '2025-11-04 11:13:11');


-----------------------------------------------------------------------------------------------------------------------
create table purchase_orders
(
	po_id serial primary key,
	supplier_id int not null,
	po_date date not null,
	expected_date date check(expected_date is null or expected_date>=po_date) ,
	status varchar(50) default 'Pending' not null,
	total_amount numeric(12,2) not null default 0.00 check(total_amount>=0),
	created_at timestamp default current_timestamp,
    foreign key(supplier_id) references suppliers(supplier_id)
);
drop table purchase_orders;

select * from purchase_orders;
INSERT INTO purchase_orders
(supplier_id, po_date, expected_date, status, total_amount, created_at)
VALUES
(1, '2025-11-18', '2025-11-21', 'Open', 12500.00, '2025-11-16 16:28:25'),
(2, '2025-11-09', '2025-11-13', 'Approved', 8900.50, '2025-11-22 06:19:54'),
(3, '2025-11-09', '2025-11-16', 'Received', 15420.75, '2025-11-17 10:40:52'),
(4, '2025-11-15', '2025-11-27', 'Closed', 6100.00, '2025-11-25 06:40:06'),
(5, '2025-11-25', '2025-12-08', 'Cancelled', 3000.25, '2025-11-24 22:39:52');

-----------------------------------------------------------------------------------------------------------------------
create table purchase_order_items
(
	po_item_id serial,
    po_id int not null,
    product_id int not null,
    quantity int check(quantity>0) not null default 1,
    unit_price numeric(10,2) check(unit_price>=0) not null,
    created_at timestamp default current_timestamp,
    primary key(po_id,product_id),
    foreign key (po_id) references purchase_orders(po_id),
	unique(po_id,product_id)
);
drop table purchase_order_items;

INSERT INTO purchase_order_items
(po_id, product_id, quantity, unit_price, created_at)
VALUES
(1, 101, 10, 250.00, '2025-11-30 00:43:30'),
(1, 102, 5, 500.00, '2025-11-29 19:21:39'),
(2, 101, 12, 200.00, '2025-11-26 16:41:33'),
(3, 103, 7, 350.00, '2025-11-20 19:55:03'),
(4, 104, 3, 1000.00, '2025-11-28 19:43:22');

-----------------------------------------------------------------------------------------------------------------------
create table inventory
(
	inventory_id serial primary key,
    warehouse_id int not null,
    product_id int not null,
    quantity_on_hand int default 0 check(quantity_on_hand>=0) not null,
    reorder_level int not null default 10 check(reorder_level>=0),
    last_updated timestamp default current_timestamp,
    foreign key(warehouse_id) references warehouses(warehouse_id),
    unique(warehouse_id, product_id)
);

INSERT INTO inventory
(warehouse_id, product_id, quantity_on_hand, reorder_level, last_updated)
VALUES
(1, 101, 50, 20, '2025-12-06 01:34:22'),
(2, 102, 30, 15, '2025-12-06 09:36:23'),
(3, 103, 70, 25, '2025-12-09 11:01:22'),
(4, 104, 20, 10, '2025-12-08 13:45:12'),
(5, 105, 90, 30, '2025-12-08 03:15:05');

-----------------------------------------------------------------------------------------------------------------------
create table sales_orders
(
	sales_order_id serial primary key,
    customer_id int not null,
    order_date date not null,
    status varchar(50) default 'pending' not null,
    total_amount numeric(10,2)not null default 0.00 check(total_amount>=0),
    created_at timestamp  default current_timestamp,
    foreign key(customer_id) references customers(customer_id)
);
drop table sales_orders;

select * from sales_orders;

INSERT INTO sales_orders
(customer_id, order_date, status, total_amount, created_at)
VALUES
(1, '2025-12-04', 'Pending', 3200.50, '2025-11-30 23:22:20'),
(2, '2025-12-01', 'Confirmed', 4500.00, '2025-11-26 01:12:17'),
(3, '2025-12-01', 'Shipped', 2100.75, '2025-12-03 07:09:51'),
(4, '2025-12-08', 'Delivered', 980.00, '2025-12-11 21:42:55'),
(5, '2025-12-05', 'Cancelled', 1500.00, '2025-12-05 06:47:27');

-----------------------------------------------------------------------------------------------------------------------
create table sales_order_items
(
	so_item_id serial primary key,
    sales_order_id int not null ,
    product_id int not null,
    quantity int not null check(quantity>0),
    unit_price numeric(10,2) not null check(unit_price>=0),
    created_at timestamp default current_timestamp,
    foreign key (sales_order_id) references sales_orders(sales_order_id),
    unique(sales_order_id,product_id)
);

select * from sales_order_items;

INSERT INTO sales_order_items
(sales_order_id, product_id, quantity, unit_price, created_at)
VALUES
(1, 101, 2, 1600.00, '2025-12-10 12:33:01'),
(1, 102, 1, 4500.00, '2025-12-09 01:27:33'),
(2, 103, 3, 700.25, '2025-12-03 15:01:27'),
(3, 104, 4, 245.00, '2025-12-07 09:47:43'),
(4, 105, 5, 300.00, '2025-12-07 03:59:56');

-----------------------------------------------------------------------------------------------------------------------
create table shipments
(
	shipment_id serial primary key,
    sales_order_id int not null,
    warehouse_id int not null,
    shipment_date date not null,
    delivery_date date check(delivery_date is null or delivery_date>=shipment_date),
    shipment_status varchar(50) not null default 'Created',
    tracking_number varchar(100) unique,
    created_at timestamp default current_timestamp,
    foreign key(sales_order_id) references sales_orders(sales_order_id)
);

select * from shipments;


INSERT INTO shipments
(sales_order_id,warehouse_id,shipment_date,delivery_date,shipment_status, tracking_number, created_at)
VALUES
(1, 1, '2025-12-07', '2025-12-10', 'Processing', 'TRK10001', '2025-12-11 12:45:43'),

(2, 2, '2025-12-06', '2025-12-11', 'In Transit', 'TRK10002', '2025-12-05 17:36:07'),

(3, 2, '2025-12-06', '2025-12-13', 'Delivered', 'TRK10003', '2025-12-10 01:12:56'),

(4, 3, '2025-12-10', '2025-12-19', 'Delayed', 'TRK10004', '2025-12-08 05:53:27'),

(5, 4, '2025-12-12', '2025-12-13', 'Returned', 'TRK10005', '2025-12-14 03:38:09');

 