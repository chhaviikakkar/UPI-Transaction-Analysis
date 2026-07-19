/* ============================================
   Step 1: Create the Bronze Users Table
   Description: Stores raw user data without any
   transformations or validations.
   ============================================*/

CREATE TABLE bronze.users (
    user_id           VARCHAR (50),
    first_name        VARCHAR (50),
    last_name         VARCHAR (50),
    gender            VARCHAR (10),
    mobile_number     VARCHAR (10),
    location_id       VARCHAR (5) ,
    dob               DATE        ,
    registration_date DATETIME    ,
    kyc_status        VARCHAR (50)
);

/* ============================================
   Step 2: Create the Bronze Locations Table
   Description: Stores raw data of the user's
   city and state. 
   ============================================*/

CREATE TABLE bronze.locations (
    location_id VARCHAR (50),
    city        VARCHAR (50),
    state       VARCHAR (50)
);

/* ============================================
   Step 3: Create the Bronze Bank Table
   Description: Stores raw data of the bank's
   name, type, headquarters and IFSC prefix.
   ============================================*/

CREATE TABLE bronze.banks (
    bank_id      VARCHAR (50),
    bank_name    VARCHAR (50),
    bank_type    VARCHAR (50),
    headquarters VARCHAR (50),
    ifsc_prefix  VARCHAR (10)
);

/* ============================================
   Step 4: Create the Bronze Bank Accounts Table
   Description: Stores raw data of the user's
   bank account number, type, balance etc. 
   ============================================*/

CREATE TABLE bronze.bank_accounts (
    account_id     VARCHAR (50)   ,
    user_id        VARCHAR (50)   ,
    bank_id        VARCHAR (50)   ,
    account_number VARCHAR (20)   ,
    account_type   VARCHAR (50)   ,
    balance        DECIMAL (18,2) ,
    account_status VARCHAR (20)   ,
    opening_date   DATETIME       
);

/* ============================================
   Step 5: Create the Bronze PSP Table
   Description: Stores raw information about
   Payment Service Providers (PSPs) such as
   Google Pay, PhonePe, Paytm, etc.
   ===========================================*/

CREATE TABLE bronze.psp (
    psp_id        VARCHAR (50),
    psp_name      VARCHAR (50),
    company       VARCHAR (50),
    app_type      VARCHAR (50),
    launch_year   DATE        ,
    active_status VARCHAR (50)
);

/* ============================================
   Step 6: Create the Bronze Merchants Table
   Description: Stores information about name,
   category, location etc. of the merchant.
   ============================================*/

CREATE TABLE bronze.merchants (
    merchant_id       VARCHAR (50),
    merchant_name     VARCHAR (50),
    merchant_category VARCHAR (50),
    location_id       VARCHAR (50),
    onboarding_date   DATE        ,
    merchant_status   VARCHAR (50)
);

/* ============================================
   Step 7: Create the Bronze Tranactions Table
   Description: Stores raw transaction details,
   including transaction type (P2P/P2M), amount,
   response time, status, payment mode, and
   other transaction-related information.
   ============================================*/

CREATE TABLE bronze.transactions (
    transaction_id     VARCHAR (50)   ,
    transaction_date   DATE           ,
    transaction_time   TIME           ,
    transaction_type   VARCHAR (10)   ,
    sender_user_id     VARCHAR (50)   ,
    receiver_user_id   VARCHAR (50)   ,
    merchant_id        VARCHAR (50)   ,
    psp_id             VARCHAR (50)   ,
    amount             DECIMAL (18,2) ,
    transaction_status VARCHAR (50)   ,
    failure_reason_id  VARCHAR (15)   ,
    transaction_mode   VARCHAR (50)   ,
    device_type        VARCHAR (50)   ,
    response_time      INT            
);

/* ============================================
   Step 8: Create the Bronze 'Fail' Reason Table
   Description: Stores information about 
   transaction failure reasons, including 
   category and severity.
   ============================================*/

   CREATE TABLE bronze.failure_reasons (
   failure_reason_id VARCHAR(50),
   failure_reason VARCHAR(100),
   category VARCHAR(50),
   severity VARCHAR(50)
   );

/* ==========================================
   STEP 9: Load Sample Data into the Bronze Layer

   After creating the Bronze tables, we will
   populate them with sample data representing
   a UPI transaction ecosystem.

   To streamline the data loading process, we
   will create a stored procedure that:
   - Clears existing data from each Bronze table.
   - Loads fresh data from the corresponding
     CSV files using BULK INSERT.

   Note: All data used in this project is
   fictional and intended solely for portfolio
   and demonstration purposes. Any resemblance
   to actual persons, organizations, bank
   accounts, phone numbers, or other entities
   is purely coincidental.
========================================== */

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    TRUNCATE TABLE bronze.users;
    BULK INSERT bronze.users FROM 'C:\Users\Admin\OneDrive\Desktop\UPI Project\users.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

    TRUNCATE TABLE bronze.locations;
    BULK INSERT bronze.locations FROM 'C:\Users\Admin\OneDrive\Desktop\UPI Project\locations.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

    TRUNCATE TABLE bronze.psp;
    BULK INSERT bronze.psp FROM 'C:\Users\Admin\OneDrive\Desktop\UPI Project\psp.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

    TRUNCATE TABLE bronze.bank_accounts;
    BULK INSERT bronze.bank_accounts FROM 'C:\Users\Admin\OneDrive\Desktop\UPI Project\bank_account.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

    TRUNCATE TABLE bronze.banks;
    BULK INSERT bronze.banks FROM 'C:\Users\Admin\OneDrive\Desktop\UPI Project\bank.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

    TRUNCATE TABLE bronze.failure_reasons;
    BULK INSERT bronze.failure_reasons FROM 'C:\Users\Admin\OneDrive\Desktop\UPI Project\failure_reason_id.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

    TRUNCATE TABLE bronze.merchants;
    BULK INSERT bronze.merchants FROM 'C:\Users\Admin\OneDrive\Desktop\UPI Project\merchants.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

    TRUNCATE TABLE bronze.transactions;
    BULK INSERT bronze.transactions FROM 'C:\Users\Admin\OneDrive\Desktop\UPI Project\transactions.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);

END;
GO

/* ==========================================
   STEP 10: Execute the Bronze Load Procedure
   Execute the stored procedure to populate
   all Bronze tables with the latest data
   from the source CSV files.
   ======================================= */

EXEC bronze.load_bronze;
