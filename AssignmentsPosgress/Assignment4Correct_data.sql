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


INSERT INTO suppliers (supplier_name, contact_person, phone_number, email, country) VALUES
('Supplier 1', 'Alice', '111-222', 'alice@s1.com', 'India'),
('Supplier 2', 'Bob', '333-444', 'bob@s2.com', 'USA'),
('Supplier 3', 'Charlie', '555-666', 'charlie@s3.com', 'UK'),
('Supplier 5', 'No Order User', '000-000', 'none@s5.com', 'Germany');

-----------------------------------------------------------------------------------------------------------------------
create table warehouses
(
	warehouse_id serial primary key,
    warehouse_name varchar(150) not null,
    city varchar(100) not null,
    state varchar(100),
    country varchar(100) not null,
    capacity_units int check(capacity_units>0) not null,
    created_at timestamp default current_timestamp
);
drop table warehouses;
select * from warehouses;

INSERT INTO warehouses (warehouse_name, city, state, country, capacity_units) VALUES
('Warehouse 1', 'Mumbai', 'Maharashtra', 'India', 10000),
('Warehouse 2', 'Pune', 'Maharashtra', 'India', 5000),
('Warehouse 5', 'Empty City', NULL, 'India', 1000);

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

INSERT INTO customers (customer_name, phone_number, email, city, country) VALUES
('Customer 1', '+91 1', 'c1@gmail.com', 'Mumbai', 'India'),
('Customer 2', '+91 2', 'c2@gmail.com', 'Pune', 'India'),
('Customer 3', '+91 3', 'c3@gmail.com', 'Delhi', 'India'),
('Customer 5', NULL, 'c5@gmail.com', 'Nagpur', 'India');


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


INSERT INTO purchase_orders (supplier_id, po_date,expected_date, status, total_amount) VALUES
(1, '2025-11-01','2025-11-21', 'Open', 5000.00),
(2, '2025-11-02', '2025-11-13','Approved', 7500.00);

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

INSERT INTO purchase_order_items (po_id, product_id, quantity, unit_price) VALUES
(1, 101, 10, 250.00),
(1, 102, 5, 100.00);

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


INSERT INTO inventory (warehouse_id, product_id, quantity_on_hand, reorder_level) VALUES
(1, 101, 50, 10),
(1, 105, 0, 5);

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

INSERT INTO sales_orders (customer_id, order_date, status, total_amount,created_at) VALUES
(1, '2025-11-10', 'Shipped', 25000.00,'2025-11-30 23:22:20'),
(2, '2025-11-11', 'Pending', 30000.00,'2025-11-26 01:12:17'),
(3, '2025-12-20', 'Pending', 1200.00,'2025-12-03 07:09:51');

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

INSERT INTO sales_order_items (sales_order_id, product_id, quantity, unit_price,created_at) VALUES
(1, 101, 2, 500.00,'2025-12-10 12:33:01'),
(1, 102, 1, 200.00,'2025-12-09 01:27:33'),
(3, 505, 5, 1200.00,'2025-12-03 15:01:27');

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

-- INSERT INTO shipments
-- (sales_order_id,warehouse_id,shipment_date,delivery_date,shipment_status, tracking_number, created_at)
-- VALUES
-- (1, 1, '2025-12-07', '2025-12-10', 'Processing', 'TRK10001', '2025-12-11 12:45:43'),

-- (2, 2, '2025-12-06', '2025-12-11', 'In Transit', 'TRK10002', '2025-12-05 17:36:07'),

-- (3, 2, '2025-12-06', '2025-12-13', 'Delivered', 'TRK10003', '2025-12-10 01:12:56'),

-- (4, 3, '2025-12-10', '2025-12-19', 'Delayed', 'TRK10004', '2025-12-08 05:53:27'),

-- (5, 4, '2025-12-12', '2025-12-13', 'Returned', 'TRK10005', '2025-12-14 03:38:09');

 INSERT INTO shipments (sales_order_id, warehouse_id, shipment_date, delivery_date, shipment_status, tracking_number,created_at) VALUES
(1, 1, '2025-11-12', '2025-11-15', 'Processing', 'TRK-JOIN-001','2025-12-11 12:45:43');

