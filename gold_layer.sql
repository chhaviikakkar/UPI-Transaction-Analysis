/*
=========================================================
Gold Layer - Dimension: dim_users
=========================================================

Purpose:
- The Gold layer is designed for analytics and reporting.
- It follows a star schema where dimensions store descriptive
  business attributes and facts store measurable events.

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
=========================================================

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

