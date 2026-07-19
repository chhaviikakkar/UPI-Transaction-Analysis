/*=============================================================
    UPI Analytics Database Setup
    Purpose:
    - Create the database for UPI transaction analysis
    - Create a layered architecture:
        Bronze  : Raw data ingestion layer
        Silver  : Cleaned and transformed data layer
        Gold    : Business-ready analytical layer
=============================================================*/


/*=============================================================
    STEP 1: Switch to master database 
    Purpose:
    - master is the system database where we create new databases
=============================================================*/

USE master;
GO

/*=============================================================
    STEP 2: Create UPI Analytics Database
    Purpose:
    - This database will store all UPI-related tables:
        Users
        Banks
        Accounts
        PSPs
        Merchants
        Transactions
        Analysis tables
=============================================================*/

CREATE DATABASE upi_db;
GO

/*=============================================================
    STEP 3: Switch into the newly created database
    Purpose:
    - All schemas and tables will now be created inside upi_db
=============================================================*/

USE upi_db;
GO

/*=============================================================
    STEP 4: Create Bronze Layer Schema
    Purpose:
    - Stores raw imported CSV data
    - Data remains close to original source
    - Minimal transformations are applied here
=============================================================*/

CREATE SCHEMA bronze;
GO

/*=============================================================
    STEP 5: Create Silver Layer Schema
    Purpose:
    - Stores cleaned and validated data
    - Handles:
        - Removing duplicates
        - Data type corrections
        - Standardisation
        - Data quality checks
=============================================================*/

CREATE SCHEMA silver;
GO

/*=============================================================
    STEP 6: Create Gold Layer Schema
    Purpose:
    - Stores business-ready analytical tables
    - Used for reporting and insights
=============================================================*/

CREATE SCHEMA gold;
GO
