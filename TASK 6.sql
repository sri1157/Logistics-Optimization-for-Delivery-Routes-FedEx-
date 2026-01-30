SELECT
    s.Shipment_ID,
    s.Delivery_Status,
    s.Delivery_Date
FROM Shipments s
JOIN (
    SELECT
        Shipment_ID,
        MAX(Delivery_Date) AS Latest_Delivery_Date
    FROM Shipments
    GROUP BY Shipment_ID
) latest
ON s.Shipment_ID = latest.Shipment_ID
AND s.Delivery_Date = latest.Latest_Delivery_Date;

-- ---------------------------------------------------
-- TASK 6.2: Most common delay reason
-- ---------------------------------------------------

SELECT
    Route_ID,
    COUNT(*) AS Total_Shipments,
    SUM(
        CASE
            WHEN Delivery_Status IN ('In Transit', 'Returned') THEN 1
            ELSE 0
        END
    ) AS Problem_Shipments
FROM Shipments
GROUP BY Route_ID
HAVING
    SUM(
        CASE
            WHEN Delivery_Status IN ('In Transit', 'Returned') THEN 1
            ELSE 0
        END
    ) > COUNT(*) / 2;

SELECT
    Route_ID,
    COUNT(*) AS Total_Shipments,
    SUM(
        CASE
            WHEN Delivery_Status IN ('In Transit', 'Returned') THEN 1
            ELSE 0
        END
    ) AS Problem_Shipments
FROM Shipments
GROUP BY Route_ID;

-- ---------------------------------------------------
-- TASK 6.2: Most common delay reason
-- ---------------------------------------------------

SELECT
    Delay_Reason,
    COUNT(*) AS Frequency
FROM Shipments
WHERE Delay_Reason IS NOT NULL
GROUP BY Delay_Reason
ORDER BY Frequency DESC;

- ---------------------------------------------------
-- TASK 6.3: Orders with >2 delayed checkpoints
-- ---------------------------------------------------
SELECT
    Shipment_ID,
    Route_ID,
    Pickup_Date,
    Delivery_Date,
    TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date) AS Delay_Hours
FROM Shipments
WHERE TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date) > 120;

