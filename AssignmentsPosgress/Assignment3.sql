drop table suppliers;
drop table warehouses;
drop table customers;
drop table purchase_orders;
drop table purchase_order_items;
drop table inventory;
drop table sales_orders;
drop table shipments;

--------------------------------------------------------------------------------------------------------

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

select * from shipments;