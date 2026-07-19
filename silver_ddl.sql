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
   STEP 3: Repeat for other tables
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
