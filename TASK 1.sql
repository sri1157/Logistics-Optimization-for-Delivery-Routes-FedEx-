use project;
-- ----------------------------------------------------------------
-- TASK 1.1: Identify duplicate and delete Order_ID records from orders table 
-- ----------------------------------------------------------------
SELECT Order_ID, COUNT(*) AS duplicate_count
FROM orders 
GROUP BY Order_ID
HAVING COUNT(*) > 1;
-- ----------------------------------------------------------------
-- TASK 1.1: Identify duplicate and delete shipment_id records from shipments table 
-- ----------------------------------------------------------------
SELECT Shipment_ID, COUNT(*) AS duplicate_count
FROM shipments
GROUP BY Shipment_ID
HAVING COUNT(*) > 1;


-- ----------------------------------------------------------------
-- TASK 1.2: Identify duplicate and delete shipment_id records from shipments table 
-- ----------------------------------------------------------------
select delay_hours from shipments;

UPDATE shipments ship
JOIN (
    SELECT Route_ID, AVG(Delay_Hours) AS avg_delay
    FROM shipments
    WHERE Delay_Hours IS NOT NULL
    GROUP BY Route_ID
) route
ON ship.Route_ID = route.Route_ID
SET ship.Delay_Hours = route.avg_delay
WHERE ship.Delay_Hours IS NULL;

SELECT COUNT(*) AS remaining_nulls
FROM shipments
WHERE Delay_Hours IS NULL;

-- ----------------------------------------------------------------
-- TASK 1.2: Identify duplicate and delete shipment_id records from shipments table 
-- ----------------------------------------------------------------
Select order_date from orders;
desc orders;
desc shipments;

UPDATE orders
SET Order_Date = STR_TO_DATE(Order_Date, '%Y-%m-%d %H:%i:%s')
WHERE Order_Date IS NOT NULL;

ALTER TABLE orders
MODIFY Order_Date DATETIME;

desc orders;

UPDATE shipments
SET
    Pickup_Date   = STR_TO_DATE(Pickup_Date, '%Y-%m-%d %H:%i:%s'),
    Delivery_Date = STR_TO_DATE(Delivery_Date, '%Y-%m-%d %H:%i:%s')
WHERE Pickup_Date IS NOT NULL
   OR Delivery_Date IS NOT NULL;

ALTER TABLE shipments
MODIFY Pickup_Date datetime,
modify Delivery_Date DATETIME;

desc shipments;

-- ----------------------------------------------------------------
-- TASK 1.2: Identify duplicate and delete shipment_id records from shipments table 
-- ----------------------------------------------------------------
SELECT Shipment_ID,Pickup_Date,Delivery_Date FROM shipments
WHERE Delivery_Date < Pickup_Date;

-- ----------------------------------------------------------------
-- TASK 1.2: Identify duplicate and delete shipment_id records from shipments table 
-- ----------------------------------------------------------------
-- orders - route 
SELECT o.Order_ID, o.Route_ID
FROM orders o
LEFT JOIN routes r
ON o.Route_ID = r.Route_ID
WHERE r.Route_ID IS NULL;

-- orders - warehouse
SELECT o.Order_ID, o.Warehouse_ID
FROM orders o
LEFT JOIN warehouses w
ON o.Warehouse_ID = w.Warehouse_ID
WHERE w.Warehouse_ID IS NULL;

-- orders-shipment 
SELECT s.Shipment_ID, s.Order_ID
FROM shipments s
LEFT JOIN orders o
ON s.Order_ID = o.Order_ID
WHERE o.Order_ID IS NULL;

-- shipment-route
SELECT s.Shipment_ID, s.Route_ID
FROM shipments s
LEFT JOIN routes r
ON s.Route_ID = r.Route_ID
WHERE r.Route_ID IS NULL;

--  shipments - warehouse 
SELECT s.Shipment_ID, s.Warehouse_ID
FROM shipments s
LEFT JOIN warehouses w
ON s.Warehouse_ID = w.Warehouse_ID
WHERE w.Warehouse_ID IS NULL;






