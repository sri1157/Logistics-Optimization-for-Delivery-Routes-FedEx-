# Logistics-Optimization-for-Delivery-Routes-FedEx-

📌 Project Summary

FedEx operates one of the most complex global logistics networks, moving millions of shipments daily across air, ground, and last-mile delivery systems. With surging e-commerce demand and peak-season pressure, delivery delays and rising operational costs have become unavoidable pain points.

This project builds a SQL-driven logistics analytics system to analyze shipment performance, identify delay patterns, and optimize delivery routes and hub utilization using structured relational data.

This is an operations optimization project, not just reporting.

🎯 Business Problem

FedEx’s logistics operations face recurring challenges:

Transit delays due to customs, weather, congestion, and hub overload

Suboptimal international and regional routing decisions

Inconsistent agent and warehouse performance

Reduced on-time delivery rates during peak demand periods

Current systems generate data, but lack analytical insights that connect delays to routes, hubs, agents, and operational decisions.

🧠 Project Objectives

The objective is to use SQL analytics to:

Identify delay patterns and root causes

Optimize route and hub combinations for faster transit

Evaluate warehouse throughput and utilization

Measure delivery agent performance and service reliability

Recommend data-driven improvements to reduce delays and costs

🛠️ Tools & Technologies

SQL (MySQL / PostgreSQL / SQLite compatible)

Relational database concepts

Aggregations, joins, subqueries, CTEs

Performance metrics and operational KPIs

No visualization dependency — focus is on query logic and insight extraction.

📂 Dataset Overview
1. Orders Table

Order-level shipment and payment details.

Column	Description
Order_ID	Unique order identifier
Customer_ID	Customer reference
Order_Date	Date of order
Route_ID	Route used
Warehouse_ID	Fulfillment warehouse
Order_Amount	Order value
Delivery_Type	Standard / Express
Payment_Mode	Payment method
2. Routes Table

Route-level transportation and distance data.

Column	Description
Route_ID	Route identifier
Source_City / Country	Origin
Destination_City / Country	Destination
Distance_KM	Route distance
Avg_Transit_Time_Hours	Expected transit time
3. Warehouses Table

FedEx hubs and sortation centers.

Column	Description
Warehouse_ID	Warehouse identifier
City / Country	Location
Capacity_per_day	Daily throughput
Manager_Name	Operations manager
4. Delivery Agents Table

Last-mile and regional delivery performance data.

Column	Description
Agent_ID	Agent identifier
Agent_Name	Name
Zone	Assigned zone
Zone_Country	Country
Experience_Years	Experience
Avg_Rating	Customer rating
5. Shipment Tracking Table

Operational shipment-level tracking and delay metrics.

Column	Description
Shipment_ID	Shipment identifier
Order_ID	Linked order
Agent_ID	Delivery agent
Route_ID	Route used
Warehouse_ID	Handling warehouse
Pickup_Date	Pickup timestamp
Delivery_Date	Delivery timestamp
Delivery_Status	On-time / Delayed
Delay_Hours	Delay duration
Delivery_Feedback	Customer feedback
🔗 Data Relationships

Orders → Shipments (One-to-Many)

Routes → Orders / Shipments (One-to-Many)

Warehouses → Orders / Shipments (One-to-Many)

Delivery Agents → Shipments (One-to-Many)

This structure enables route-, hub-, and agent-level performance analysis.

📊 Key Analytical Focus Areas

On-time vs delayed shipment percentage

Average delay hours by route, country, and hub

High-delay international corridors

Warehouse capacity vs actual shipment load

Agent experience vs delivery performance

Route distance vs actual transit time deviation

🧠 Insights Generated

Identification of high-risk routes with recurring delays

Warehouses operating beyond effective capacity

Delivery agents with high workload but low ratings

Mismatch between average transit time benchmarks and reality

Bottlenecks during cross-border shipments

📌 Business Recommendations

Rebalance route usage away from consistently delayed corridors

Optimize hub allocation based on warehouse capacity and delay patterns

Improve agent deployment by matching experience with complex routes

Refine transit time benchmarks using real delivery data

These recommendations directly impact on-time delivery, customer satisfaction, and cost control.

🚨 Academic Integrity
