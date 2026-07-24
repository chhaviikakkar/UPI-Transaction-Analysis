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
Dimension: dim_psp
======================================================*/

CREATE VIEW gold.dim_psp AS
SELECT
    ROW_NUMBER() OVER (ORDER BY psp_name) AS psp_key,
    psp_name
FROM silver.transactions
GROUP BY psp_name;

/*======================================================
Fact: fact_transactions
======================================================*/

CREATE VIEW gold.fact_transactions AS
SELECT ROW_NUMBER() OVER (ORDER BY transaction_id) AS transaction_key,
       t.transaction_id,
       t.transaction_date,
       t.transaction_time,
       u.user_key,
       r.user_key AS recipient_key,
       m.merchant_key,
       t.transaction_category,
       p.psp_key,
       t.transaction_mode,
       t.device_type,
       t.amount,
       t.transaction_status,
       ISNULL(t.failure_reason, 'N/A') AS failure_reason,
       t.response_time
FROM   silver.transactions AS t
       LEFT OUTER JOIN
       gold.dim_users AS u
       ON t.sender_user_id = u.user_id
       LEFT OUTER JOIN
       gold.dim_users AS r
       ON r.user_id = t.recipient_id
       LEFT OUTER JOIN
       gold.dim_merchants AS m
       ON m.merchant_id = t.recipient_id
       LEFT OUTER JOIN
       gold.dim_psp AS p
       ON t.psp_name = p.psp_name;

