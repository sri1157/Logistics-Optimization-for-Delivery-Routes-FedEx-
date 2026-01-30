-- ---------------------------------------------------
-- TASK 5.1: Rank agents per route by on-time %
-- ---------------------------------------------------
WITH Agent_Performance AS (
    SELECT
        s.Route_ID,
        a.Agent_ID,
        a.Agent_Name,
        COUNT(*) AS Total_Deliveries,
        SUM(
            CASE 
                WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date)
                     <= r.Avg_Transit_Time_Hours
                THEN 1 ELSE 0
            END
        ) AS On_Time_Deliveries,
        ROUND(
            100.0 * SUM(
                CASE 
                    WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date)
                         <= r.Avg_Transit_Time_Hours
                    THEN 1 ELSE 0
                END
            ) / COUNT(*),
            2
        ) AS On_Time_Percentage
    FROM Shipments s
    JOIN Delivery_Agents a 
        ON s.Agent_ID = a.Agent_ID
    JOIN Routes r
        ON s.Route_ID = r.Route_ID
    GROUP BY s.Route_ID, a.Agent_ID, a.Agent_Name
)

SELECT *,
       RANK() OVER (
           PARTITION BY Route_ID
           ORDER BY On_Time_Percentage DESC
       ) AS Route_Rank
FROM Agent_Performance;

  -- ---------------------------------------------------
-- TASK 5.2: Agents with on-time % < 85%
-- ---------------------------------------------------
SELECT
    a.Agent_ID,
    a.Agent_Name,
    ROUND(
        100 * AVG(
            CASE 
                WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date)
                     <= r.Avg_Transit_Time_Hours
                THEN 1 ELSE 0
            END
        ),
        2
    ) AS On_Time_Percentage
FROM Shipments s
JOIN Delivery_Agents a 
    ON s.Agent_ID = a.Agent_ID
JOIN Routes r
    ON s.Route_ID = r.Route_ID
GROUP BY a.Agent_ID, a.Agent_Name
HAVING On_Time_Percentage < 85;


SELECT
    Agent_ID,
    Agent_Name,
    On_Time_Percentage,
    RANK() OVER (ORDER BY On_Time_Percentage ASC) AS Performance_Rank
FROM (
    SELECT
        a.Agent_ID,
        a.Agent_Name,
        ROUND(
            100 * AVG(
                CASE 
                    WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date)
                         <= r.Avg_Transit_Time_Hours
                    THEN 1 ELSE 0
                END
            ),
            2
        ) AS On_Time_Percentage
    FROM Shipments s
    JOIN Delivery_Agents a 
        ON s.Agent_ID = a.Agent_ID
    JOIN Routes r
        ON s.Route_ID = r.Route_ID
    GROUP BY a.Agent_ID, a.Agent_Name
) t
WHERE On_Time_Percentage < 85;


-- ---------------------------------------------------
-- TASK 5.3: Top 5 vs Bottom 5 agent speed
-- --------------------------------------------------

CREATE VIEW Agent_Performance AS
SELECT
    a.Agent_ID,
    a.Agent_Name,
    a.Avg_Rating AS Avg_Rating,
    a.Experience_Years,
    ROUND(
        100 * AVG(
            CASE 
                WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date)
                     <= r.Avg_Transit_Time_Hours
                THEN 1 ELSE 0
            END),2
    ) AS On_Time_Percentage
FROM Shipments s
JOIN Delivery_Agents a ON s.Agent_ID = a.Agent_ID
JOIN Routes r ON s.Route_ID = r.Route_ID
GROUP BY 
    a.Agent_ID,
    a.Agent_Name,
    a.Avg_Rating,
    a.Experience_Years;

SELECT 'Top 5 Agents', AVG(Avg_Rating), AVG(Experience_Years)
FROM (
    SELECT * FROM Agent_Performance
    ORDER BY On_Time_Percentage DESC
    LIMIT 5
) t
UNION ALL
SELECT 'Bottom 5 Agents', AVG(Avg_Rating), AVG(Experience_Years)
FROM (
    SELECT * FROM Agent_Performance
    ORDER BY On_Time_Percentage ASC
    LIMIT 5
) b;










