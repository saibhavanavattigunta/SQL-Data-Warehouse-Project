/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose       :
    This script creates all tables required for the Bronze layer in the
    Data Warehouse. The Bronze layer stores raw, untransformed data ingested
    directly from source systems (CRM and ERP).

    Each table is dropped and recreated to ensure schema consistency with
    the source files before data ingestion.

Key Characteristics:
    - Represents raw source data (no transformations applied)
    - Schema closely mirrors source CSV structures
    - Designed to support full-refresh (truncate-and-load) ingestion

⚠️ WARNING:
    Running this script will DROP and RECREATE all Bronze tables.
    Any existing data in these tables will be permanently deleted.
    Proceed only if you intend to reset the Bronze layer.

Execution Order:
    - Run after creating the database and Bronze schema
    - Run before executing the Bronze load procedure

===============================================================================
*/

IF OBJECT_ID ('bronze.crm_cust_info' ,'U') IS NOT NULL
   DROP TABLE bronze.crm_cust_info;
GO
  
CREATE TABLE bronze.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE
);


IF OBJECT_ID ('bronze.crm_prd_info' ,'U') IS NOT NULL
   DROP TABLE bronze.crm_prd_info;
GO
  
CREATE TABLE bronze.crm_prd_info (
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);


IF OBJECT_ID ('bronze.crm_sales_details' ,'U') IS NOT NULL
   DROP TABLE bronze.crm_sales_details;
GO
  
CREATE TABLE bronze.crm_sales_details (
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);


IF OBJECT_ID ('bronze.erp_cust_az12' ,'U') IS NOT NULL
   DROP TABLE bronze.erp_cust_az12;
GO
  
CREATE TABLE bronze.erp_cust_az12 (
cid NVARCHAR(50),
bdate DATE,
gen NVARCHAR(50)
);


IF OBJECT_ID ('bronze.erp_loc_a101' ,'U') IS NOT NULL
   DROP TABLE bronze.erp_loc_a101;
GO
  
CREATE TABLE bronze.erp_loc_a101 (
cid NVARCHAR(50),
cntry NVARCHAR(50)
);



IF OBJECT_ID ('bronze.erp_px_cat_g1v2' ,'U') IS NOT NULL
   DROP TABLE bronze.erp_px_cat_g1v2;
GO
  
CREATE TABLE bronze.erp_px_cat_g1v2 (
id NVARCHAR(50),
cat NVARCHAR(50),
subcat NVARCHAR(50),
maintenance NVARCHAR(50)
);
