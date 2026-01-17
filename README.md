Bank Customer Attrition & Retention Analysis
End-to-End Analytics: SQL Data Processing → Power BI Business Intelligence
Business Objective

This project investigates a 20.37% customer churn rate within a retail banking portfolio of 10,000 customers. The objective was to quantify financial impact, identify behavioral and demographic churn drivers, and translate analytical findings into actionable retention strategies.

The analysis revealed $185.59M in lost customer balances, providing clear evidence for prioritizing targeted retention initiatives.

Analytical Approach
1. Data Preparation  (SQL)

Raw customer data was transformed into analytics-ready structures using SQL Server.

Key transformations included:

Customer Segmentation
Developed age-based cohorts (Young Adult, Adult, Senior) to enable demographic analysis.

Status Normalization
Converted binary indicators into readable dimensions for:

Credit Card Ownership

Customer Activity Status

High-Value Churn Identification
Applied CTEs and window functions to isolate “Inactive Whales”—customers with high account balances but low engagement—representing the greatest financial risk.

2. Business Intelligence & Visualization (Power BI)

A three-page interactive Power BI dashboard was developed to guide stakeholders from executive KPIs to granular insights.

Executive Overview
High-level churn metrics with geographic segmentation, identifying Germany as the most critical risk region.

Market & Product Trends
Analysis of product ownership, customer value tiers, and their impact on total bank equity.

Demographic Deep Dive
Correlation analysis between age, credit score, and churn behavior to inform targeted retention programs.

Key Business Insights

Geographic Concentration of Risk
Germany alone accounts for $97.97M in lost balance, nearly 2× the losses observed in France or Spain.

Product Stickiness Matters
Customers holding only one product exhibit significantly higher churn, highlighting cross-sell opportunities as a retention lever.

Senior Segment Vulnerability
The Senior demographic shows the highest churn density, signaling a strong opportunity for tailored engagement and loyalty programs.

Business Recommendations

Prioritize Germany-focused retention campaigns targeting high-balance, low-engagement customers.

Implement multi-product bundling incentives to reduce single-product churn risk.

Design senior-focused relationship strategies, such as advisory services or loyalty benefits, to improve long-term retention.

Project Artifacts

analysis_logic.sql — SQL scripts for data cleansing, segmentation, and advanced analytics

Bank_Churn_Report.pbix — Fully interactive Power BI dashboard

Dataset/ — Source dataset used for data preparation, exploration, and model development
