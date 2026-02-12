/*
===============================================================================
 Procedure Name : bronze.load_bronze
 Project        : End-to-End Data Warehouse
 Layer          : Bronze (Raw Ingestion Layer)
 Author         : Tushar Tamboli

 Description:
    This stored procedure performs full reload of Bronze layer tables 
    from external CSV source files using BULK INSERT.

    Process Flow:
        1. Truncate existing bronze tables
        2. Load fresh raw data from source files
        3. Log execution time for each table
        4. Capture and report errors (if any)

 Notes:
    - Designed for development / batch processing
    - Assumes source files are accessible to SQL Server instance
    - No transformations are applied at this stage
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @start_time        DATETIME,
        @end_time          DATETIME,
        @batch_start_time  DATETIME,
        @batch_end_time    DATETIME;

    BEGIN TRY

        -----------------------------------------------------------------------
        -- Batch Start
        -----------------------------------------------------------------------
        SET @batch_start_time = GETDATE();

        PRINT '================================================';
        PRINT 'Starting Bronze Layer Load Process';
        PRINT 'Start Time: ' + CAST(@batch_start_time AS NVARCHAR);
        PRINT '================================================';

        -----------------------------------------------------------------------
        -- CRM TABLES
        -----------------------------------------------------------------------
        PRINT 'Loading CRM Tables...';

        -----------------------------------------------------------------------
        -- crm_cust_info
        -----------------------------------------------------------------------
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\sql\dwh_project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'crm_cust_info Load Time: ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) 
              + ' seconds';


        -----------------------------------------------------------------------
        -- crm_prd_info
        -----------------------------------------------------------------------
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\sql\dwh_project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'crm_prd_info Load Time: ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) 
              + ' seconds';


        -----------------------------------------------------------------------
        -- crm_sales_details
        -----------------------------------------------------------------------
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\sql\dwh_project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'crm_sales_details Load Time: ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) 
              + ' seconds';


        -----------------------------------------------------------------------
        -- ERP TABLES
        -----------------------------------------------------------------------
        PRINT 'Loading ERP Tables...';

        -----------------------------------------------------------------------
        -- erp_loc_a101
        -----------------------------------------------------------------------
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.erp_loc_a101;

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\sql\dwh_project\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'erp_loc_a101 Load Time: ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) 
              + ' seconds';


        -----------------------------------------------------------------------
        -- erp_cust_az12
        -----------------------------------------------------------------------
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.erp_cust_az12;

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\sql\dwh_project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'erp_cust_az12 Load Time: ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) 
              + ' seconds';


        -----------------------------------------------------------------------
        -- erp_px_cat_g1v2
        -----------------------------------------------------------------------
        SET @start_time = GETDATE();

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\sql\dwh_project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'erp_px_cat_g1v2 Load Time: ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) 
              + ' seconds';


        -----------------------------------------------------------------------
        -- Batch End
        -----------------------------------------------------------------------
        SET @batch_end_time = GETDATE();

        PRINT '================================================';
        PRINT 'Bronze Layer Load Completed Successfully';
        PRINT 'Total Execution Time: ' 
              + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR)
              + ' seconds';
        PRINT '================================================';

    END TRY

    BEGIN CATCH

        PRINT '================================================';
        PRINT 'ERROR DURING BRONZE LAYER LOAD';
        PRINT 'Error Message  : ' + ERROR_MESSAGE();
        PRINT 'Error Number   : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State    : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT 'Error Line     : ' + CAST(ERROR_LINE() AS NVARCHAR);
        PRINT '================================================';

        THROW;  -- re-throw error for visibility

    END CATCH
END;
