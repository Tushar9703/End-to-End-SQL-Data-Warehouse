/*
===============================================================================
 Project      : End-to-End Data Warehouse
 Layer        : Bronze (Raw Data Layer)

 Description:
    This DDL script creates raw ingestion tables inside the 'bronze' schema.
    The Bronze layer stores source system data in its original format 
    with minimal or no transformation.

    Tables are dropped and recreated to allow clean reload during 
    development and testing.

 Note:
    - This script is intended for DEVELOPMENT environment.
    - No primary keys or constraints are applied at this stage.
    - Data cleansing and transformations will occur in the Silver layer.
===============================================================================
*/

-------------------------------------------------------------------------------
-- CRM SOURCE TABLES (Customer Relationship Management System)
-------------------------------------------------------------------------------

-- Customer Information (Raw Customer Master Data)
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info (
    cst_id              INT,              -- Customer unique identifier
    cst_key             NVARCHAR(50),     -- Business customer key
    cst_firstname       NVARCHAR(50),     -- First name
    cst_lastname        NVARCHAR(50),     -- Last name
    cst_marital_status  NVARCHAR(50),     -- Marital status (raw values)
    cst_gndr            NVARCHAR(50),     -- Gender (raw format)
    cst_create_date     DATE              -- Record creation date
);
GO


-- Product Information (Raw Product Master Data)
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
GO

CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,              -- Product unique identifier
    prd_key      NVARCHAR(50),     -- Business product key
    prd_nm       NVARCHAR(50),     -- Product name
    prd_cost     INT,              -- Product cost (raw value)
    prd_line     NVARCHAR(50),     -- Product line/category
    prd_start_dt DATETIME,         -- Product availability start date
    prd_end_dt   DATETIME          -- Product availability end date
);
GO


-- Sales Transaction Details (Raw Transaction Data)
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
GO

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),     -- Sales order number
    sls_prd_key  NVARCHAR(50),     -- Product key reference
    sls_cust_id  INT,              -- Customer ID reference
    sls_order_dt INT,              -- Order date (stored as integer - requires transformation)
    sls_ship_dt  INT,              -- Shipping date (raw integer format)
    sls_due_dt   INT,              -- Due date (raw integer format)
    sls_sales    INT,              -- Total sales amount
    sls_quantity INT,              -- Quantity sold
    sls_price    INT               -- Unit price
);
GO


-------------------------------------------------------------------------------
-- ERP SOURCE TABLES (Enterprise Resource Planning System)
-------------------------------------------------------------------------------

-- Location Data
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
GO

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),   -- Customer ID (source system format)
    cntry  NVARCHAR(50)    -- Country name
);
GO


-- Additional Customer Demographics
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
GO

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),   -- Customer ID reference
    bdate  DATE,           -- Birth date
    gen    NVARCHAR(50)    -- Gender (may differ from CRM format)
);
GO


-- Product Category Mapping
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
GO

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),   -- Product ID reference
    cat          NVARCHAR(50),   -- Product category
    subcat       NVARCHAR(50),   -- Product subcategory
    maintenance  NVARCHAR(50)    -- Maintenance classification
);
GO


-------------------------------------------------------------------------------
-- End of Bronze Layer DDL
-------------------------------------------------------------------------------
PRINT 'Bronze layer tables created successfully.';
PRINT 'Raw data ingestion layer ready for loading.';
