
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
INSERT INTO suppliers
(supplier_name, contact_person, phone_number, email, country, created_at)
VALUES
('TechNova Solutions', 'Rahul Sharma', '+91-9876543210', 'contact@technova.com', 'India', '2024-01-10 10:15:00'),

('Global Electronics', 'John Miller', '+1-415-9988776', 'sales@globalelec.com', 'USA', '2024-02-05 14:30:00'),

('Alpha Components', 'Sneha Patil', '+91-9123456780', 'info@alphacomponents.in', 'India', '2024-03-12 09:45:00'),

('Euro Supply Co', NULL, '+49-170-556677', 'support@eurosupply.de', 'Germany', '2024-04-18 16:20:00'),

('Pacific Traders', 'Wei Zhang', '+86-138-66778899', 'trade@pacifictraders.cn', 'China', '2024-05-22 11:10:00'),

('Nordic Industrial', 'Erik Hansen', NULL, 'contact@nordicind.com', 'Norway', '2024-06-01 13:00:00'),

('Sunrise Imports', 'Amit Verma', '+91-9988776655', 'hello@sunriseimports.in', 'India', '2024-07-09 17:40:00'),

('Oceanic Supplies', NULL, NULL, 'admin@oceanicsupplies.com', 'Australia', '2024-08-15 08:25:00'),

('Desert Tech', 'Mohammed Ali', '+971-501234567', 'sales@deserttech.ae', 'UAE', '2024-09-20 19:55:00'),

('Latin Trade Hub', 'Carlos Mendes', '+55-21999887766', 'contact@latintrade.br', 'Brazil', '2024-10-30 12:05:00');

drop table suppliers;

select * from suppliers;

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

INSERT INTO warehouses
(warehouse_name, city, state, country, capacity_units, created_at)
VALUES
('Mumbai Central Warehouse', 'Mumbai', 'Maharashtra', 'India', 15000, '2024-01-05 09:30:00'),

('Pune Distribution Hub', 'Pune', 'Maharashtra', 'India', 8000, '2024-02-12 11:15:00'),

('Delhi NCR Warehouse', 'Gurugram', 'Haryana', 'India', 12000, '2024-03-18 14:45:00'),

('Bangalore Tech Storage', 'Bangalore', 'Karnataka', 'India', 10000, '2024-04-22 10:00:00'),

('Chennai Port Warehouse', 'Chennai', 'Tamil Nadu', 'India', 9000, '2024-05-30 16:20:00'),

('California Logistics Center', 'Los Angeles', 'California', 'USA', 20000, '2024-06-10 08:50:00'),

('Texas Supply Depot', 'Dallas', 'Texas', 'USA', 18000, '2024-07-14 13:35:00'),

('Berlin Storage Facility', 'Berlin', 'Berlin', 'Germany', 11000, '2024-08-19 15:10:00'),

('Dubai Free Zone Warehouse', 'Dubai', 'Dubai', 'UAE', 16000, '2024-09-25 18:40:00'),

('Sydney Regional Warehouse', 'Sydney', 'New South Wales', 'Australia', 14000, '2024-10-28 12:00:00');

select * from warehouses;

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

INSERT INTO customers
(customer_name, phone_number, email, city, country, created_at)
VALUES
('Amit Kulkarni', '+91-9876543211', 'amit.kulkarni@gmail.com', 'Pune', 'India', '2024-01-08 10:10:00'),

('Neha Sharma', '+91-9988776655', 'neha.sharma@yahoo.com', 'Delhi', 'India', '2024-02-14 12:45:00'),

('Rahul Mehta', NULL, 'rahul.mehta@outlook.com', 'Mumbai', 'India', '2024-03-20 09:30:00'),

('Priya Nair', '+91-9123456789', 'priya.nair@gmail.com', 'Kochi', 'India', '2024-04-05 15:20:00'),

('John Peterson', '+1-415-6677889', 'john.peterson@gmail.com', 'San Francisco', 'USA', '2024-05-11 11:05:00'),

('Emily Watson', NULL, 'emily.watson@icloud.com', 'New York', 'USA', '2024-06-18 14:55:00'),

('Carlos Gomez', '+34-612345678', 'carlos.gomez@hotmail.com', 'Madrid', 'Spain', '2024-07-23 17:40:00'),

('Wei Liu', '+86-13988776655', 'wei.liu@qq.com', 'Shanghai', 'China', '2024-08-29 08:25:00'),

('Fatima Khan', '+971-509988776', 'fatima.khan@gmail.com', 'Dubai', 'UAE', '2024-09-15 19:10:00'),

('Oliver Brown', NULL, 'oliver.brown@protonmail.com', 'London', 'UK', '2024-10-21 13:00:00');


select * from customers;

create table purchase_orders
(
	po_id serial primary key,
	supplier_id int not null,
	po_date date not null,
	expected_date date check(expected_date is null or expected_date>=po_date) ,
	purchase_status varchar(50) default 'Pending' not null,
	total_amount numeric(12,2) not null default 0.00 check(total_amount>=0),
	created_at timestamp default current_timestamp,
    foreign key(supplier_id) references suppliers(supplier_id)
);

INSERT INTO purchase_orders
(supplier_id, po_date, expected_date, purchase_status, total_amount, created_at)
VALUES
(1, '2024-01-10', '2024-01-20', 'Pending',   25000.00, '2024-01-10 10:30:00'),

(2, '2024-02-05', '2024-02-15', 'Confirmed', 42000.50, '2024-02-05 11:45:00'),

(3, '2024-03-12', '2024-03-25', 'Shipped',   18000.75, '2024-03-12 09:20:00'),

(4, '2024-04-18', NULL,         'Pending',   30000.00, '2024-04-18 14:10:00'),

(5, '2024-05-22', '2024-06-01',  'Delivered',55000.00, '2024-05-22 16:40:00'),

(1, '2024-06-10', '2024-06-18',  'Confirmed', 27000.00, '2024-06-10 12:00:00'),

(2, '2024-07-14', '2024-07-25',  'Cancelled', 12000.00, '2024-07-14 15:30:00'),

(3, '2024-08-19', '2024-08-30',  'Delivered', 64000.90, '2024-08-19 10:50:00'),

(4, '2024-09-25', '2024-10-05',  'Shipped',   21500.00, '2024-09-25 18:20:00'),

(5, '2024-10-30', '2024-11-10',  'Confirmed', 39000.00, '2024-10-30 13:15:00');

select * from purchase_orders;

drop table purchase_order_items;

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

INSERT INTO purchase_order_items
(po_id, product_id, quantity, unit_price, created_at)
VALUES
(1, 101, 10, 2500.00, '2024-01-10 11:00:00'),
(1, 102, 5,  3000.00, '2024-01-10 11:05:00'),

(2, 103, 20, 2100.50, '2024-02-05 12:00:00'),
(2, 104, 10, 1900.00, '2024-02-05 12:10:00'),

(3, 105, 8,  2250.75, '2024-03-12 10:00:00'),
(3, 106, 6,  1800.00, '2024-03-12 10:15:00'),

(4, 107, 12, 2500.00, '2024-04-18 15:00:00'),

(5, 108, 25, 2200.00, '2024-05-22 17:00:00'),
(5, 109, 10, 3300.00, '2024-05-22 17:10:00'),

(6, 110, 15, 1800.00, '2024-06-10 12:30:00');


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
drop table inventory;

INSERT INTO inventory
(warehouse_id, product_id, quantity_on_hand, reorder_level)
VALUES
-- Warehouse 1 (new products)
(1, 201, 45, 15),
(1, 202, 90, 25),

-- Warehouse 2 (new products)
(2, 203, 30, 20),
(2, 204, 150, 40),

-- Warehouse 3 (new products)
(3, 205, 8, 20),
(3, 206, 60, 30);



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

select * from sales_orders;

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

INSERT INTO sales_order_items
(sales_order_id, product_id, quantity, unit_price)
VALUES
-- Sales Order 1
(1, 101, 2, 1500.00),
(1, 102, 1, 3200.50),

-- Sales Order 2
(2, 103, 3, 700.25),
(2, 104, 4, 245.00),

-- Sales Order 3
(3, 105, 5, 300.00);


select * from sales_order_items;

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

INSERT INTO shipments
(sales_order_id, warehouse_id, shipment_date, delivery_date, shipment_status, tracking_number)
VALUES
-- Delivered shipment
(1, 1, '2025-01-05', '2025-01-08', 'Delivered', 'TRK100001'),

-- In transit
(2, 2, '2025-01-07', NULL, 'In Transit', 'TRK100002'),

-- Created (not shipped yet)
(3, 1, '2025-01-10', NULL, 'Created', 'TRK100003'),

-- Delivered from another warehouse
(4, 3, '2025-01-03', '2025-01-06', 'Delivered', 'TRK100004');

select * from shipments;