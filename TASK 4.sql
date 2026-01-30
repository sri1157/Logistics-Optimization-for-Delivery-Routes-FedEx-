-- ---------------------------------------------------
-- TASK 4.1: Top 3 warehouses with highest processing time
-- ---------------------------------------------------
SELECT
    w.Warehouse_ID,
    w.City,
    w.Country,
    AVG(s.Delay_Hours) AS Avg_Delay
FROM Shipments s
JOIN Warehouses w
    ON s.Warehouse_ID = w.Warehouse_ID
GROUP BY w.Warehouse_ID, w.City, w.Country
ORDER BY Avg_Delay DESC
LIMIT 3;

-- ---------------------------------------------------
-- TASK 4.1: Top 3 warehouses with highest processing time
-- ---------------------------------------------------
SELECT
    Warehouse_ID,
    COUNT(*) AS Total_Shipments,
    SUM(Delay_Hours > 0) AS Delayed_Shipments
FROM Shipments
GROUP BY Warehouse_ID
ORDER BY warehouse_id ASC;

-- ---------------------------------------------------
-- TASK 4.1: Top 3 warehouses with highest processing time
-- ---------------------------------------------------
WITH Global_Avg_Delay AS (
    SELECT 
        AVG(Delay_Hours) AS Global_Avg
    FROM Shipments
),
Warehouse_Avg_Delay AS (
    SELECT
        Warehouse_ID,
        AVG(Delay_Hours) AS Warehouse_Avg
    FROM Shipments
    GROUP BY Warehouse_ID
)
SELECT
    w.Warehouse_ID,
    w.City,
    w.Country,
    ROUND(wad.Warehouse_Avg, 2) AS Warehouse_Avg_Delay,
    ROUND(gad.Global_Avg, 2) AS Global_Avg_Delay
FROM Warehouse_Avg_Delay wad
JOIN Warehouses w
    ON wad.Warehouse_ID = w.Warehouse_ID
CROSS JOIN Global_Avg_Delay gad
WHERE wad.Warehouse_Avg > gad.Global_Avg;


WITH Avg_Delays AS (
    SELECT
        Warehouse_ID,
        AVG(Delay_Hours) AS Warehouse_Avg,
        AVG(Delay_Hours) OVER () AS Global_Avg
    FROM Shipments
    GROUP BY Warehouse_ID
)
SELECT
    w.Warehouse_ID,
    w.City,
    w.Country,
    ROUND(a.Warehouse_Avg, 2) AS Warehouse_Avg_Delay,
    ROUND(a.Global_Avg, 2) AS Global_Avg_Delay
FROM Avg_Delays a
JOIN Warehouses w
    ON a.Warehouse_ID = w.Warehouse_ID
WHERE a.Warehouse_Avg > a.Global_Avg;


-- ---------------------------------------------------
-- TASK 4.1: Top 3 warehouses with highest processing time
-- ---------------------------------------------------

SELECT
    Warehouse_ID,
    ROUND(
        SUM(Delay_Hours <= 0) * 100.0 / COUNT(*),
        2
    ) AS On_Time_Percentage,
    RANK() OVER (
        ORDER BY SUM(Delay_Hours <= 0) * 1.0 / COUNT(*) DESC
    ) AS Warehouse_Rank
FROM Shipments
GROUP BY Warehouse_ID;

WITH Warehouse_Performance AS (
    SELECT
        Warehouse_ID,
        COUNT(*) AS Total_Shipments,
        SUM(
            CASE
                WHEN Delay_Hours <= 0 THEN 1
                ELSE 0
            END
        ) AS On_Time_Shipments
    FROM Shipments
    GROUP BY Warehouse_ID
)
SELECT
    w.Warehouse_ID,
    w.City,
    w.Country,
    wp.Total_Shipments,
    wp.On_Time_Shipments,
    ROUND(
        (wp.On_Time_Shipments * 100.0) / wp.Total_Shipments,
        2
    ) AS On_Time_Percentage,
    RANK() OVER (
        ORDER BY (wp.On_Time_Shipments * 1.0 / wp.Total_Shipments) DESC
    ) AS Warehouse_Rank
FROM Warehouse_Performance wp
JOIN Warehouses w
    ON wp.Warehouse_ID = w.Warehouse_ID;

