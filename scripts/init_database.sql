/*=====================================================================
    Project: Data Warehouse & Analytics Project
    File:    init_database.sql
    Author:  Sai Bhavana

    Purpose:
        This script creates a new SQL Server database named 'DataWarehouse'.
        It first checks whether the database already exists; if it does, the 
        script will DROP the existing database and RE-CREATE it from scratch.

        After recreating the database, it sets up three schemas:
            • bronze – Raw data ingestion layer
            • silver – Cleaned & standardized data layer
            • gold   – Analytics & reporting layer

    *** WARNING ***
        Running this script will PERMANENTLY DELETE the existing 
        'DataWarehouse' database, including all tables, data, schemas, 
        and objects it contains.

        Proceed with EXTREME caution.
        Ensure you have a full backup before executing this script.
=====================================================================*/
USE master,
GO

-----------------------------
-- Drop Database if Exists --
-----------------------------
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    PRINT 'Database "DataWarehouse" exists. Dropping it...';

    -- Force disconnect users
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Drop the database
    DROP DATABASE DataWarehouse;

    PRINT 'Existing Database "DataWarehouse" dropped successfully.';
END
ELSE
BEGIN
    PRINT 'Database "DataWarehouse" does not exist. Creating a new one...';
END
GO

--------------------------
-- Create New Database  --
--------------------------
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--------------------------
-- Create DWH Schemas   --
--------------------------
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO


  

Just let me know!
