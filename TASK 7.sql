-- ---------------------------------------------------
-- TASK 7.1: Average delivery delay per region
-- ---------------------------------------------------
SELECT
    r.Source_Country,
    ROUND(AVG(s.Delay_Hours), 2) AS Avg_Delivery_Delay_Hours
FROM Shipments s
JOIN Routes r
    ON s.Route_ID = r.Route_ID
GROUP BY r.Source_Country;

-- ---------------------------------------------------
-- TASK 7.1: Average delivery delay per region
-- ---------------------------------------------------
SELECT
    ROUND(
        100 * AVG(
            CASE
                WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date)
                     <= r.Avg_Transit_Time_Hours
                THEN 1
                ELSE 0
            END
        ),
        2
    ) AS On_Time_Delivery_Percentage
FROM Shipments s
JOIN Routes r
    ON s.Route_ID = r.Route_ID;

-- ---------------------------------------------------
-- TASK 7.3: Average traffic delay per route
-- ---------------------------------------------------
SELECT
    Route_ID,
    ROUND(
        AVG(
            CASE
                WHEN Delay_Hours > 0
                THEN Delay_Hours
                ELSE 0
            END
        ),
        2
    ) AS Avg_Delay_Hours
FROM Shipments
GROUP BY Route_ID;

-- ---------------------------------------------------
-- TASK 7.3: Average traffic delay per route
-- ---------------------------------------------------
SELECT
    w.Warehouse_ID,
    w.City,
    w.Country,
    COUNT(s.Shipment_ID) AS Shipments_Handled,
    w.Capacity_per_day,
    ROUND(
        100 * COUNT(s.Shipment_ID) /
        CASE
            WHEN w.Capacity_per_day > 0
            THEN w.Capacity_per_day
            ELSE 1
        END,
        2
    ) AS Warehouse_Utilization_Percentage
FROM Warehouses w
LEFT JOIN Shipments s
    ON w.Warehouse_ID = s.Warehouse_ID
GROUP BY
    w.Warehouse_ID,
    w.City,
    w.Country,
    w.Capacity_per_day;



