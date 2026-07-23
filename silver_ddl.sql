/* ==========================================
   STEP 1: Create Silver Users Table
   Create the Silver table to store cleaned,
   validated, and transformed data from the
   Bronze Users.
  ========================================= */

CREATE TABLE silver.users (
    user_id           VARCHAR (50)  PRIMARY KEY,
    name              VARCHAR (100),
    gender            VARCHAR (50) ,
    mobile_number     VARCHAR (10) ,
    city              VARCHAR (50) ,
    state             VARCHAR (50) ,
    date_of_birth     DATE         ,
    registration_date DATE         ,
    kyc_status        VARCHAR (50) 
);

/* ==========================================
   STEP 2: Insert Data into Silver Table
   Load and transform user data from the
   Bronze layer into the Silver layer by
   combining names, enriching location
   details, and standardizing data formats.
========================================== */


INSERT INTO silver.users (user_id, name, gender, mobile_number, city, state, date_of_birth, registration_date, kyc_status)
SELECT u.user_id,
       CONCAT(u.first_name, ' ', u.last_name) AS name,
       u.gender,
       u.mobile_number,
       l.city,
       l.state,
       u.dob,
       CAST (u.registration_date AS DATE) AS registration_date,
       u.kyc_status
FROM   bronze.users AS u
       LEFT OUTER JOIN
       bronze.locations AS l
       ON u.location_id = l.location_id;

/* ==========================================
   STEP 3: Repeat for other tables.
   ========================================= */

CREATE TABLE silver.psp (
    psp_id   VARCHAR (10) PRIMARY KEY,
    psp_name VARCHAR (50),
    company  VARCHAR (50),
    app_type VARCHAR (50)
);

INSERT INTO silver.psp
SELECT psp_id,
       psp_name,
       company,
       app_type
FROM   bronze.psp;

 -- ========================================= 

CREATE TABLE silver.merchants (
    merchant_id       VARCHAR (15) PRIMARY KEY,
    merchant_name     VARCHAR (50),
    merchant_category VARCHAR (50),
    city              VARCHAR (50),
    state             VARCHAR (50),
    onboarding_date   DATE        ,
    merchant_status   VARCHAR (50)
);

INSERT INTO silver.merchants

SELECT 
m.merchant_id,
TRIM(m.merchant_name) AS merchant_name,
CASE m.merchant_category
WHEN 'GR' THEN 'Grocery'
WHEN 'SM' THEN 'Supermarket'
WHEN 'FB' THEN 'Food & Beverage'
WHEN 'E' THEN 'Electronics'
WHEN 'P' THEN 'Pharmacy'
WHEN 'C' THEN 'Clothing'
WHEN 'W' THEN 'Wholesale'
WHEN 'ST' THEN 'Stationery'
WHEN 'S' THEN 'Sports'
WHEN 'HH' THEN 'Household'
WHEN 'R' THEN 'Retail'
WHEN 'F' THEN 'Fashion'
WHEN 'AM' THEN 'Automobiles'
WHEN 'SE' THEN 'Services'
WHEN 'JW' THEN 'Jewellery'
WHEN 'B' THEN 'Books'
WHEN 'T' THEN 'Travel'
WHEN 'PC' THEN 'Personal care'
END AS merchant_category,
l.city AS city,
l.state AS state,
m.onboarding_date,
m.merchant_status
FROM bronze.merchants m
LEFT JOIN bronze.locations l
ON m.location_id=l.location_id

 -- ========================================= 










/* ==========================================
   Note: Lookup tables (locations, banks,
   bank_accounts, and failure_reasons) were 
   not promoted to the silver layer because they
   already contained clean, standardized 
   reference data and required no transformations.
   The Silver layer was created only for datasets  
   that required data quality improvements, 
   standardization, or business rule application
 ========================================= */
