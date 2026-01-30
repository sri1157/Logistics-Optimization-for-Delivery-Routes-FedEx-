-- ---------------------------------------------------
-- TASK 2.1: Calculate delivery delay (in days)
-- ---------------------------------------------------
SELECT 
    Shipment_ID,
    Pickup_Date,
    Delivery_Date,
    TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date) AS Delivery_Delay_Hours
FROM Shipments;

-- ---------------------------------------------------
-- TASK 2.2: Top 10 delayed routes based on average delay
-- ---------------------------------------------------

SELECT route_id,
    AVG(Delay_Hours) AS Avg_Delay_Hours
FROM Shipments
GROUP BY Route_ID
ORDER BY Avg_Delay_Hours DESC
LIMIT 10;

-- ---------------------------------------------------
-- TASK 2.3: Rank orders by delay within each warehouse
-- ---------------------------------------------------
SELECT
    Shipment_ID,
    Warehouse_ID,
    Delay_Hours,
    RANK() OVER (
        PARTITION BY Warehouse_ID
        ORDER BY Delay_Hours DESC
    ) AS Delay_Rank
FROM Shipments;

-- ---------------------------------------------------
-- TASK 2.3: Rank orders by delay within each warehouse
-- ---------------------------------------------------

SELECT
    o.Delivery_Type,
    AVG(s.Delay_Hours) AS Avg_Delay_Hours
FROM Shipments s
JOIN Orders o
    ON s.Order_ID = o.Order_ID
GROUP BY o.Delivery_Type;

SELECT
    o.Delivery_Type,
    AVG(
        TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date)
    ) AS Avg_Delivery_Delay_Hours
FROM Shipments s
JOIN Orders o
    ON s.Order_ID = o.Order_ID
GROUP BY o.Delivery_Type;


