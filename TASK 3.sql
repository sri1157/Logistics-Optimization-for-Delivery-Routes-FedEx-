-- ---------------------------------------------------
-- TASK 3.1: Avg delivery time, traffic delay, and efficiency ratio
-- ---------------------------------------------------
SELECT
    Route_ID,
    AVG(TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date)) 
        AS Avg_Transit_Time_Hours
FROM Shipments
GROUP BY Route_ID;


-- ---------------------------------------------------
-- TASK 3.1: Average Delay per Route (Hours)
-- ---------------------------------------------------
SELECT
    r.Route_ID,
    AVG(s.Delay_Hours) AS Avg_Delay_Hours
FROM Shipments s
JOIN Routes r 
    ON s.Route_ID = r.Route_ID
GROUP BY r.Route_ID;


SELECT
    Route_ID,
    AVG(Delay_Hours) AS Avg_Delay_Hours
FROM Shipments
GROUP BY Route_ID order by Route_id;

-- ---------------------------------------------------
-- TASK 3.1: Average Delay per Route (Hours)
-- ---------------------------------------------------
SELECT
    Route_ID,
    Distance_KM,
    Avg_Transit_Time_Hours,
    Distance_KM / Avg_Transit_Time_Hours AS efficiency_ratio 
FROM Routes;

-- ---------------------------------------------------
-- TASK 3.1: Average Delay per Route (Hours)
-- ---------------------------------------------------

SELECT
    Route_ID,
    Distance_KM,
    Avg_Transit_Time_Hours,
    Distance_KM / Avg_Transit_Time_Hours AS Distance_Time_Efficiency
FROM Routes
ORDER BY Distance_Time_Efficiency ASC
LIMIT 3;

-- ---------------------------------------------------
-- TASK 3.1: Average Delay per Route (Hours)
-- ---------------------------------------------------
WITH Route_Delay AS (
    SELECT
        s.Route_ID,
        COUNT(*) AS Total_Shipments,
        SUM(
            CASE
                WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date)
                     > r.Avg_Transit_Time_Hours
                THEN 1 ELSE 0
            END
        ) AS Delayed_Shipments,
        (SUM(
            CASE
                WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date)
                     > r.Avg_Transit_Time_Hours
                THEN 1 ELSE 0
            END
        ) * 100.0 / COUNT(*)) AS Delay_Percentage
    FROM Shipments s
    JOIN Routes r ON s.Route_ID = r.Route_ID
    GROUP BY s.Route_ID
)
SELECT *
FROM Route_Delay
WHERE Delay_Percentage > 20
ORDER BY Route_ID DESC;

-- ---------------------------------------------------
-- TASK 3.1: Average Delay per Route (Hours)
-- reccomendations 
-- ---------------------------------------------------

reccomendations 