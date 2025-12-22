use omkar;

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
select * from customers where phone_number is null or phone_number not like '+%';

-- 16 List purchase orders where status = 'Pending' OR status = 'Approved'.
select * from sales_orders where status='Pending' OR status = 'Approved';


-- 17 Find purchase orders for supplier_id = 5 AND total_amount > 100000.
select * from suppliers where supplier_id = 5 AND total_amount > 100000;

-- 18 Show purchase orders expected_date < po_date (late entry) OR expected_date IS NULL.
select * from purchase_orders;
select * from purchase_orders where expected_date<po_date or expected_date is null;

-- 19 Return purchase orders in 2025 (po_date between 2025-01-01 and 2025-12-31).
select * from purchase_orders where po_date between 2025-01-01 and 2025-12-31;

-- 20 Get purchase orders with total_amount BETWEEN 5000 AND 20000 AND status <>'Cancelled'.
select * from purchase_orders where total_amount between 5000 and 20000 and status <>'Cancelled';

-- 21 List PO items where quantity >= 100 AND unit_price <= 50.
select * from purchase_order_items;
select * from purchase_order_items where quantity >= 10 AND unit_price <= 500;

-- 22 Find PO items for a given po_id (e.g., 101) OR product_id IN (10, 20, 30).
select * from purchase_order_items where po_id=101 or product_id in (101,104);

-- 23 Show PO items created_at IS NOT NULL AND quantity % 2 = 0 (even quantities).
select * from purchase_order_items where created_at is not null and quantity%2=0;

-- 24 Return PO items where unit_price * quantity > 5000 OR unit_price IS NULL.
-- 25 Get PO items with quantity BETWEEN 1 AND 10 AND NOT (unit_price > 100).
select * from purchase_order_items where quantity BETWEEN 1 AND 10 AND NOT (unit_price > 100);

-- 26 List inventory rows where quantity_on_hand < reorder_level OR quantity_on_hand = 0.
select * from inventory;
select * from inventory where quantity_on_hand > reorder_level OR quantity_on_hand = 0;

-- 27 Find inventory for warehouse_id = 3 AND product_id = 1001.
select * from inventory where warehouse_id = 1 AND product_id = 101;

-- 28 Show inventory last_updated > now() - interval '7 days' OR quantity_on_hand > 1000.
select * from inventory where last_updated > now() - interval 7 day or quantity_on_hand>1000;

-- 29 Return inventory with product_id IN (SELECT product_id FROM purchase_order_items) AND quantity_on_hand > 0.
select * from inventory where product_id in (SELECT product_id FROM purchase_order_items) AND quantity_on_hand > 0;

-- 30 Get inventory records where warehouse_id IN (SELECT warehouse_id FROM warehouses WHERE country = 'India') AND reorder_level >= 50.
select * from inventory where warehouse_id in (SELECT warehouse_id FROM warehouses WHERE country = 'India') AND reorder_level >= 50;

-- 31 List sales orders where status IN ('Pending','Shipped') AND total_amount > 20000.
select * from sales_orders;
select * from sales_orders where status IN ('Pending','Shipped') AND total_amount > 2000;

-- 32 Find sales order items for sales_order_id = 200 OR quantity >= 50.
select * from sales_orders where sales_order_id = 2 OR status ='Confirmed';

-- 33 Show shipments where shipment_status = 'Delivered' AND delivery_date BETWEEN '2025-01-01' AND '2025-12-31'.
select * from sales_orders where status='Delivered' and delivery_date BETWEEN '2025-01-01' AND '2025-12-31';


