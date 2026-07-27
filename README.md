# UPI-Transaction-Analysis

A SQL-based UPI analytics project exploring transaction trends, failure patterns, payment behaviour, and ecosystem performance through a simulated digital payments dataset.

---

# Project Overview

The project simulates a real-world UPI ecosystem consisting of users, banks, bank accounts, Payment Service Providers (PSPs), merchants, transaction records, and failure reasons.

Using SQL Server, a layered data warehouse was designed to transform raw transactional data into business-ready analytical datasets. The project focuses on identifying transaction trends, evaluating PSP performance, understanding customer behaviour, analysing merchant activity, and generating insights similar to those produced by analytics teams in financial institutions.

---

# Project Highlights

- Built a **Bronze–Silver–Gold** layered Data Warehouse using SQL Server.
- Analyzed **100,000 simulated UPI transactions** across **2024–2025**.
- Designed and analyzed **8 relational datasets** representing the UPI ecosystem.
- Solved **15 real-world business problems** using SQL.
- Applied advanced SQL concepts including:
  - Joins
  - Common Table Expressions (CTEs)
  - Window Functions
  - CASE Statements
  - Aggregate Functions
  - Ranking Functions
  - Stored Procedures
  - Date Functions
- Generated business insights for customer behaviour, merchant performance, transaction reliability, PSP performance, and payment trends.

---

# Business Objective

The project aims to answer key business questions related to UPI operations, including:

- What is the overall transaction success rate?
- Which PSPs demonstrate better transaction reliability?
- What are the major reasons behind failed payments?
- How do transaction volumes change over time?
- Which customer segments contribute the highest business value?
- Which merchant categories generate the highest revenue?
- Which cities generate the highest merchant transaction value?
- Which PSP is most preferred for merchant payments?
- Who are the highest-value customers?

---

# Dataset Design

A simulated UPI dataset was created to represent the major entities involved in the digital payments ecosystem.

| Dataset | Description |
|----------|-------------|
| Users | Customer demographic and registration information |
| Locations | Standardized city and state mapping |
| Banks | Banking institution details |
| Bank Accounts | Relationship between users and banking institutions |
| PSP | UPI application providers |
| Merchants | Merchant information and categories |
| Failure Reasons | Classification of transaction failures |
| Transactions | Core UPI payment records |

---

# Data Preparation

The dataset was generated and validated using Microsoft Excel to ensure:

- Consistent primary and foreign keys
- Accurate entity relationships
- Realistic customer and transaction behaviour
- Correct P2P and P2M transaction logic
- Meaningful transaction status distribution
- Proper failure reason mapping

The validated datasets were then imported into SQL Server for database modelling, transformation, and analytical reporting.

---

# Data Architecture

The project follows a layered data warehouse architecture.

```text
UPI Database

├── Bronze Layer
│   └── Raw CSV ingestion tables
│
├── Silver Layer
│   └── Data validation and transformation
│       • Data quality checks
│       • Standardization
│       • Relationship validation
│
└── Gold Layer
    └── Analytical tables
        • KPI calculations
        • Performance summaries
        • Business insights
```

---

# Technologies Used

- Microsoft SQL Server
- Microsoft Excel
- GitHub

---

# SQL Concepts Demonstrated

- INNER JOIN
- LEFT JOIN
- Common Table Expressions (CTEs)
- Window Functions (`RANK`, `LAG` etc.)
- Aggregate Functions (`SUM`, `COUNT`, `AVG` etc.)
- CASE Statements
- GROUP BY & HAVING
- Date Functions
- Ranking & Segmentation
- Business KPI Calculations
- Data Validation Techniques

---

# Key Analysis Areas

## Transaction Performance

- Transaction success and failure analysis
- Month-over-month transaction trends
- Peak transaction hours
- Response time analysis

## PSP Performance

- Transaction distribution across PSPs
- PSP reliability comparison
- Failure rate analysis
- Response time benchmarking

## Banking Analysis

- Bank-wise transaction performance
- User-bank relationship analysis
- Transaction reliability

## User & Merchant Behaviour

- Customer segmentation
- Spending behaviour
- Merchant category performance
- Merchant ranking
- Geographic transaction analysis

---

# Business Insights

## Transaction Performance

- Achieved an overall **89.94% transaction success rate**, with only **7.08% failed** and **2.98% pending** transactions.
- Transaction volume remained **stable throughout 2024 and 2025**, indicating consistent customer adoption.
- The highest monthly transaction volume occurred in **May 2024**, while **February 2025** recorded the largest month-over-month decline.

## Customer Behaviour

- **Middle-Aged Adults** performed the highest number of UPI transactions.
- Customer segmentation identified:
  - **3,783 Low Value customers**
  - **1,080 Medium Value customers**
  - **137 High Value customers**
- Although High Value customers represented only **2.74%** of the customer base, they contributed a significant share of overall transaction value.

## PSP Performance

- **BHIM** processed the highest number of successful transactions.
- **Google Pay** was the most preferred PSP for Person-to-Merchant (P2M) transactions.
- **WhatsApp Pay** recorded the fastest average transaction response time.
- PSP failure rates ranged between **6.71% and 7.33%**, indicating relatively consistent reliability across providers.

## Merchant Analysis

- **Food & Beverage**, **Grocery**, and **Electronics** generated the highest merchant revenues.
- **Royal Sweets** ranked as the highest revenue-generating merchant.
- **Jamshedpur**, **Mumbai**, and **Kanpur** recorded the highest merchant transaction values among all cities.

## Transaction Reliability

- The leading causes of transaction failures were:
  - UPI Service Unavailable
  - Account Blocked
  - Transaction Declined by Bank
- Approximately **95% of failed transactions** occurred on mobile devices, reflecting the dominant use of mobile-based UPI payments.

---

# Data Quality Checks

The project includes validation checks for:

- Primary key uniqueness
- Referential integrity
- Transaction type consistency
- Failure reason mapping
- Null value handling
- Response time categorization

---

# Project Goal

The goal of this project is to demonstrate how SQL and analytical thinking can be applied to understand large-scale digital payment systems and generate meaningful business insights that support operational monitoring, customer behaviour analysis, transaction reliability assessment, merchant performance evaluation, and data-driven decision-making.

The project showcases practical SQL skills while solving real-world business problems commonly encountered in banking, fintech, and digital payments analytics.

---

# Future Enhancements

- Build an interactive Power BI dashboard using the analytical tables.
- Expand the dataset to include fraud detection and customer churn analysis.
- Integrate Python for predictive analytics and advanced customer segmentation.
