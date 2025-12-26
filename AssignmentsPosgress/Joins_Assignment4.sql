select * from purchase_orders;
select * from suppliers;
select * from customers;
select * from sales_order_items;
select * from sales_orders;
select * from warehouses;




-- 1)Show all purchase orders along with the supplier name who provided them.
select p.po_id,p.po_date,p.status,s.supplier_name 
from purchase_orders as p
inner join suppliers as s
on p.supplier_id=s.supplier_id;

-- 2)Show all customers and any sales orders they have placed. Include customers who have not placed any orders.
select c.customer_name,s.sales_order_id,s.order_date 
from customers as c
left join sales_orders as s
on c.customer_id=s.sales_order_id;

-- 3)Show all sales orders and the name of the customer who placed them. Include orders even if customer info is missing.
select s.sales_order_id,s.order_date,c.customer_name
from sales_orders as s
left join customers as c
on s.sales_order_id=c.customer_id;


--4)Show all suppliers and all warehouses together. Include suppliers without warehouses and warehouses without suppliers.
SELECT
    s.supplier_name,
    w.warehouse_name
FROM suppliers s
FULL OUTER JOIN warehouses w
ON s.country = w.country;

--5)Show each sales order along with its shipment details (shipment date and status).
-- sales_order_id order_date shipment_date shipment_status
-- 1 2025-11-10 2025-11-12 Processing
select * from sales_orders;
select * from shipments;

select so.sales_order_id,so.order_date,sh.shipment_date,sh.shipment_status
from sales_orders as so
inner join shipments as sh
on so.sales_order_id=sh.sales_order_id


-- 6)Show all warehouses and the inventory stored in them. Include warehouses with no inventory.
-- warehouse_name product_id quantity_on_hand
-- Warehouse 1 101 50
-- Warehouse 2 NULL NULL

select * from warehouses;
select * from inventory;

select w.warehouse_name,i.product_id,i.quantity_on_hand
from warehouses as w
left join
inventory as i
on w.warehouse_id=i.warehouse_id;

--7)Show all purchase orders and all purchase order items together. Include orders without items and items without orders.
	select * from purchase_orders;
	select * from purchase_order_items;
	
	-- po_id po_item_id
	-- 	1 1
	-- 	1 2
	-- 	2 NULL
select por.po_id,poi.po_item_id from purchase_orders as por
full outer join
purchase_order_items as poi
on por.po_id=poi.po_id;


	
--8)Show each customer along with the products they ordered and the quantity.

-- customer_name product_id quantity
-- Customer 1 101 2
-- Customer 1 102 1

select * from customers;
select * from sales_orders;
select * from sales_order_items; --pid quantity


select c.customer_name,soi.product_id, soi.quantity
from sales_order_items as soi
join sales_orders as so
on soi.sales_order_id=so.sales_order_id
join customers as c
on c.customer_id=so.customer_id;




--9)Show all suppliers and the purchase orders linked to them. Include suppliers with no purchase orders.
select * from suppliers;
select * from purchase_orders;

select supplier_name,po_id,status
from suppliers as s
left join
purchase_orders as p
on s.supplier_id=p.supplier_id;

-- 10)Show all warehouses and any inventory linked to them. Include warehouses even if inventory is missing.
select * from warehouses;
select * from inventory;

select w.warehouse_name,i.product_id
from warehouses as w
left join inventory as i
on w.warehouse_id=i.warehouse_id;

select i.product_id,w.warehouse_name
from  inventory as i
right join warehouses as w
on w.warehouse_id=i.warehouse_id;

--11)Show all customers and all suppliers together. Include unmatched rows from both sides.
select c.customer_name,s.supplier_name
from customers as c
full join suppliers as s
on c.country=s.country;

select *from customers;
select *from suppliers;

--12)Show all shipments along with the warehouse name from which they were shipped.
-- shipment_id warehouse_name shipment_status
-- 1 Warehouse 1 Processing
select * from shipments;
select * from warehouses;

select s.shipment_id,w.warehouse_name,s.shipment_status
from shipments as s
inner join warehouses as w
on s.warehouse_id=w.warehouse_id;

--13)Show all sales orders and their shipment dates. Include orders that have not been shipped yet
-- sales_order_id shipment_date
-- 1 2025-11-12
-- 5 NULL
select * from sales_orders;
select * from shipments;

select so.sales_order_id,sh.shipment_date
from sales_orders as so
left join shipments as sh
on so.sales_order_id=sh.sales_order_id;

--14)Show all purchase orders and the supplier names. Include orders even if supplier info is missing.
select * from suppliers;
select * from purchase_orders;
-- po_id supplier_name
-- 1 Supplier 1
-- 5 NULL
select p.po_id,s.supplier_name
from purchase_orders as p
left join suppliers as s
on p.supplier_id=s.supplier_id;

--15)Show all sales orders and all purchase orders together. Include unmatched rows from both sides.
-- sales_order_id po_id
-- 1 NULL
-- NULL 1
select * from sales_orders; --customer refer
select * from purchase_orders; --suppliers refer

select sales_order_id,po_id 
from sales_orders as s
right join purchase_orders as p
on s.

--16 Show inventory details along with the purchase order item price for the same product
-- product_id unit_price
-- 101 250.00
select * from inventory;
select * from purchase_order_items;

select i.product_id,p.unit_price
from inventory as i
inner join purchase_order_items as p
on i.product_id=p.product_id;

-- 17)Show all customers and the shipment status of their orders. Include customers without shipments.
-- customer_name shipment_status
-- Customer 1 Processing
-- Customer 5 NULL
select * from shipments;
select * from customers;
select * from sales_orders;
-- shipment-sales_order-customer

select customer_name,sh.shipment_status
from shipments as sh
join sales_orders as so
on sh.sales_order_id=so.sales_order_id
right join customers as cu on cu.customer_id=so.customer_id;

--18) Show all warehouses and the shipment status of orders shipped from them. Include warehouses with no shipments.
-- warehouse_name shipment_status
-- Warehouse 1 Processing
-- Warehouse 5 NULL
select * from shipments;
select warehouse_name,shipment_status
from shipments as s
right join warehouses as w
on s.warehouse_id=w.warehouse_id;


--19)Show all inventory items and all sales order items together. Include unmatched rows from both sides.
-- product_id quantity
-- 101 2
-- 105 NULL
select *from sales_order_items;
select * from inventory;

select i.product_id,s.quantity
from inventory as i
full join sales_order_items as s
on i.product_id=s.product_id;

--20)Show all purchase order items along with the purchase order details (order date and status).
-- po_item_id po_id po_date      status
-- 1            1    2025-11-01   Open
select * from purchase_order_items;
select * from purchase_orders;

select poi.po_item_id,poi.po_id,po.po_date,po.status
from purchase_order_items as poi
inner join purchase_orders as po
on poi.po_id=po.po_id;
