/*======================================================
Gold Layer
Purpose:
- The Gold layer is designed for analytics and reporting.
- It follows a star schema where dimensions store descriptive
  business attributes and facts store measurable events.
========================================================
Dimension: dim_users
Transformation Steps:
1. Retrieve cleaned user data from the Silver layer.
2. Generate a surrogate key (user_key) for each user.
3. Retain the business key (user_id) for traceability.
4. Include descriptive user attributes such as name, gender,
   location, and KYC status.
5. Calculate the user's age from the date of birth to provide
   a business-friendly attribute for reporting.
6. Expose the result as the dim_users view, ready for joining
   with the fact_transactions table.
=========================================================*/

CREATE VIEW gold.dim_users
AS
SELECT ROW_NUMBER() OVER (ORDER BY user_id) AS user_key,
       user_id,
       name,
       gender,
       mobile_number,
       city,
       state,
       date_of_birth,
       DATEDIFF(YEAR, date_of_birth, GETDATE()) AS age,
       registration_date,
       kyc_status
FROM   silver.users;

/*======================================================
Dimension: dim_merchants
======================================================*/

CREATE VIEW gold.dim_merchants AS
SELECT
    ROW_NUMBER() OVER (ORDER BY merchant_id) AS merchant_key,
    merchant_id,
    merchant_name,
    merchant_category,
    city,
    state,
    CAST(onboarding_date AS DATE) AS onboarding_date,
    merchant_status
FROM silver.merchants;

/*======================================================
Dimension: dim_banks
======================================================*/

CREATE VIEW gold.dim_banks AS 
SELECT * FROM silver.banks
