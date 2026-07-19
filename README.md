# UPI-Transaction-Analysis

A SQL-based UPI analytics project exploring transaction trends, failure patterns, payment behaviour, and ecosystem performance through a simulated digital payments dataset.

## Project Overview

The project simulates a real-world UPI environment consisting of users, banks, bank accounts, Payment Service Providers (PSPs), merchants, transaction records, and failure reasons. The objective is to understand transaction trends, identify failure patterns, evaluate ecosystem performance, and generate insights similar to analytics performed in financial institutions.

## Business Objective

The project aims to answer key questions related to UPI operations:

- What is the overall transaction success rate?
- Which PSPs have higher transaction failure rates?
- What are the major reasons behind failed payments?
- Which banks demonstrate better transaction reliability?
- How do transaction patterns change across time and locations?
- What are the spending patterns of users and merchants?
- How does transaction processing time affect payment performance?

## Dataset Design

A simulated UPI dataset was created to represent the major entities involved in the digital payments ecosystem.

| Dataset | Description |
|---|---|
| Users | Customer demographic and registration information |
| Locations | Standardized city and state mapping |
| Banks | Banking institution details |
| Bank Accounts | Relationship between users and banking institutions |
| PSP | UPI application providers |
| Merchants | Merchant information and categories |
| Failure Reasons | Classification of transaction failures |
| Transactions | Core UPI payment records |

## Data Preparation

The dataset was generated and validated using Excel to ensure:

- Consistent identification keys across tables
- Accurate entity relationships
- Realistic transaction behaviour
- Correct P2P and P2M transaction logic
- Meaningful transaction status distribution
- Proper failure classification

The validated datasets were then imported into SQL Server for database modelling, transformation, and analysis.

## Data Architecture

The project follows a layered data warehouse approach:

```
UPI Database

├── Bronze Layer
│   └── Raw CSV ingestion tables
│
├── Silver Layer
│   └── Data validation and transformation
│       - Data quality checks
│       - Standardization
│       - Relationship validation
│
└── Gold Layer
    └── Analytical tables
        - KPI calculations
        - Performance summaries
        - Business insights
```

## Technologies Used

- Microsoft SQL Server (DDL, DML, Joins, CTEs, Window Functions, CASE Statements)
- Microsoft Excel
- PowerBI
- GitHub

## Key Analysis Areas

### Transaction Performance

- Transaction success and failure analysis
- Payment volume trends
- Response time classification

### PSP Performance

- Transaction distribution across PSPs
- Failure rate comparison
- Platform reliability analysis

### Banking Analysis

- Bank-wise transaction performance
- Failure concentration analysis
- User-bank relationship analysis

### User and Merchant Behaviour

- User payment patterns
- Merchant category analysis
- Payment mode trends

## Data Quality Checks

The project includes validation checks for:

- Primary key uniqueness
- Referential integrity between tables
- Transaction type consistency
- Failure reason mapping
- Null value handling
- Response time categorization

## Project Goal

The goal of this project is to demonstrate how SQL and analytical thinking can be applied to understand large-scale digital payment systems and generate insights that support operational monitoring, risk analysis, and decision-making.

