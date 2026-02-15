/*
===============================================================================================
Data Quality Checks for Gold Layer Views
===============================================================================================
Script Purpose:
    This script performs comprehensive data quality checks on the gold layer views:
    - dim_customers
    - dim_products  
    - fact_sales
    
    Checks include:
    1. Duplicate checks
    2. NULL value analysis
    3. Referential integrity
    4. Data consistency
    5. Business rule validation
    6. Statistical summaries
================================================================================================
*/

-- =============================================================================================
-- CHECK 1: Duplicate Checks
-- =============================================================================================

-- Check for duplicates in dim_customers
PRINT '>> Checking for duplicates in gold.dim_customers';
WITH duplicate_check AS (
    SELECT 
        customer_id,
        customer_number,
        COUNT(*) AS duplicate_count
    FROM gold.dim_customers
    GROUP BY customer_id, customer_number
    HAVING COUNT(*) > 1
)
SELECT 
    'dim_customers' AS table_name,
    'Duplicate Records' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM duplicate_check
UNION ALL
SELECT 
    'dim_customers' AS table_name,
    'Total Records' AS check_type,
    COUNT(*) AS issue_count,
    'INFO' AS status
FROM gold.dim_customers;
GO

-- Check for duplicates in dim_products
PRINT '>> Checking for duplicates in gold.dim_products';
WITH duplicate_check AS (
    SELECT 
        product_id,
        product_number,
        COUNT(*) AS duplicate_count
    FROM gold.dim_products
    GROUP BY product_id, product_number
    HAVING COUNT(*) > 1
)
SELECT 
    'dim_products' AS table_name,
    'Duplicate Records' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM duplicate_check
UNION ALL
SELECT 
    'dim_products' AS table_name,
    'Total Records' AS check_type,
    COUNT(*) AS issue_count,
    'INFO' AS status
FROM gold.dim_products;
GO

-- Check for duplicates in fact_sales (order_number + product_key + customer_key combination)
PRINT '>> Checking for duplicates in gold.fact_sales';
WITH duplicate_check AS (
    SELECT 
        order_number,
        product_key,
        customer_key,
        COUNT(*) AS duplicate_count
    FROM gold.fact_sales
    GROUP BY order_number, product_key, customer_key
    HAVING COUNT(*) > 1
)
SELECT 
    'fact_sales' AS table_name,
    'Duplicate Transactions' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM duplicate_check
UNION ALL
SELECT 
    'fact_sales' AS table_name,
    'Total Records' AS check_type,
    COUNT(*) AS issue_count,
    'INFO' AS status
FROM gold.fact_sales;
GO

-- =============================================================================================
-- CHECK 2: NULL Value Analysis
-- =============================================================================================

-- NULL check for dim_customers
PRINT '>> NULL value analysis for gold.dim_customers';
SELECT 
    'dim_customers' AS table_name,
    'NULL Customer Key' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_customers
WHERE customer_key IS NULL
UNION ALL
SELECT 
    'dim_customers' AS table_name,
    'NULL Customer ID' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_customers
WHERE customer_id IS NULL
UNION ALL
SELECT 
    'dim_customers' AS table_name,
    'NULL Customer Number' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_customers
WHERE customer_number IS NULL
UNION ALL
SELECT 
    'dim_customers' AS table_name,
    'NULL First Name' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_customers
WHERE first_name IS NULL
UNION ALL
SELECT 
    'dim_customers' AS table_name,
    'NULL Last Name' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_customers
WHERE last_name IS NULL
UNION ALL
SELECT 
    'dim_customers' AS table_name,
    'NULL Gender' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_customers
WHERE gender IS NULL;
GO

-- NULL check for dim_products
PRINT '>> NULL value analysis for gold.dim_products';
SELECT 
    'dim_products' AS table_name,
    'NULL Product Key' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_products
WHERE product_key IS NULL
UNION ALL
SELECT 
    'dim_products' AS table_name,
    'NULL Product ID' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_products
WHERE product_id IS NULL
UNION ALL
SELECT 
    'dim_products' AS table_name,
    'NULL Product Name' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_products
WHERE product_name IS NULL
UNION ALL
SELECT 
    'dim_products' AS table_name,
    'NULL Cost' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gold.dim_products
WHERE cost IS NULL;
GO

-- NULL check for fact_sales
PRINT '>> NULL value analysis for gold.fact_sales';
SELECT 
    'fact_sales' AS table_name,
    'NULL Order Number' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.fact_sales
WHERE order_number IS NULL
UNION ALL
SELECT 
    'fact_sales' AS table_name,
    'NULL Product Key' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.fact_sales
WHERE product_key IS NULL
UNION ALL
SELECT 
    'fact_sales' AS table_name,
    'NULL Customer Key' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.fact_sales
WHERE customer_key IS NULL
UNION ALL
SELECT 
    'fact_sales' AS table_name,
    'NULL Sales Amount' AS check_type,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gold.fact_sales
WHERE sales_amount IS NULL;
GO

-- =============================================================================================
-- CHECK 3: Referential Integrity (Foreign Key Checks)
-- =============================================================================================

-- Check for orphaned records in fact_sales
PRINT '>> Foreign Key Integrity Check - Orphaned Records';
SELECT 
    'fact_sales' AS fact_table,
    'Missing Customer References' AS check_type,
    COUNT(*) AS orphaned_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON c.customer_key = f.customer_key
WHERE c.customer_key IS NULL
UNION ALL
SELECT 
    'fact_sales' AS fact_table,
    'Missing Product References' AS check_type,
    COUNT(*) AS orphaned_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'FAILED'
        ELSE 'PASSED'
    END AS status
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p ON p.product_key = f.product_key
WHERE p.product_key IS NULL;
GO

-- =============================================================================================
-- CHECK 4: Data Consistency Checks
-- =============================================================================================

-- Gender consistency check (based on your example)
PRINT '>> Gender Consistency Check';
WITH gender_check AS (
    SELECT DISTINCT
        ci.cst_gndr AS source_gender_crm,
        ca.gen AS source_gender_erp,
        cu.gender AS gold_gender,
        CASE WHEN ci.cst_gndr != 'N/a' THEN ci.cst_gndr
             ELSE COALESCE(ca.gen, 'N/a')
        END AS expected_gender
    FROM silver.crm_cust_info ci
    LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
    LEFT JOIN gold.dim_customers cu ON ci.cst_id = cu.customer_id
)
SELECT 
    'Gender Transformation' AS check_name,
    COUNT(*) AS inconsistent_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gender_check
WHERE gold_gender != expected_gender
   OR (gold_gender IS NULL AND expected_gender IS NOT NULL);
GO

-- Product category consistency
PRINT '>> Product Category Consistency Check';
WITH category_check AS (
    SELECT DISTINCT
        pn.cat_id AS source_category_id,
        pc.cat AS source_category,
        pc.subcat AS source_subcategory,
        dp.category AS gold_category,
        dp.subcategory AS gold_subcategory
    FROM silver.crm_prd_info pn
    LEFT JOIN silver.erp_px_cat_g1v2 pc ON pn.cat_id = pc.id
    LEFT JOIN gold.dim_products dp ON pn.prd_id = dp.product_id
)
SELECT 
    'Product Category' AS check_name,
    COUNT(*) AS inconsistent_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM category_check
WHERE source_category != gold_category 
   OR source_subcategory != gold_subcategory;
GO

-- =============================================================================================
-- CHECK 5: Business Rule Validation
-- =============================================================================================

-- Sales amount validation (sales_amount should equal quantity * price)
PRINT '>> Sales Amount Validation';
SELECT 
    'Sales Calculation' AS check_name,
    COUNT(*) AS invalid_calculations,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gold.fact_sales
WHERE sales_amount != quantity * price
   AND sales_amount IS NOT NULL
   AND quantity IS NOT NULL
   AND price IS NOT NULL;
GO

-- Negative or zero value checks
PRINT '>> Negative/Zero Value Checks';
SELECT 
    'Negative Sales Amount' AS check_name,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gold.fact_sales
WHERE sales_amount < 0
UNION ALL
SELECT 
    'Zero Sales Amount' AS check_name,
    COUNT(*) AS issue_count,
    'INFO' AS status
FROM gold.fact_sales
WHERE sales_amount = 0
UNION ALL
SELECT 
    'Negative Quantity' AS check_name,
    COUNT(*) AS issue_count,
    CASE 
        WHEN COUNT(*) > 0 THEN 'WARNING'
        ELSE 'PASSED'
    END AS status
FROM gold.fact_sales
WHERE quantity < 0;
GO

-- =============================================================================================
-- CHECK 6: Statistical Summary Report
-- =============================================================================================

PRINT '>> Statistical Summary Report';
SELECT 
    'Customer Demographics' AS report_section,
    COUNT(DISTINCT gender) AS unique_genders,
    COUNT(DISTINCT marital_status) AS unique_marital_status,
    COUNT(DISTINCT country) AS unique_countries,
    MIN(birthdate) AS oldest_birthdate,
    MAX(birthdate) AS youngest_birthdate
FROM gold.dim_customers;

SELECT 
    'Product Summary' AS report_section,
    COUNT(DISTINCT category) AS unique_categories,
    COUNT(DISTINCT subcategory) AS unique_subcategories,
    COUNT(DISTINCT product_line) AS unique_product_lines,
    MIN(cost) AS min_cost,
    MAX(cost) AS max_cost,
    AVG(cost) AS avg_cost
FROM gold.dim_products;

SELECT 
    'Sales Summary' AS report_section,
    COUNT(DISTINCT order_number) AS unique_orders,
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order,
    SUM(sales_amount) AS total_sales,
    AVG(sales_amount) AS avg_sale_amount,
    SUM(quantity) AS total_quantity_sold
FROM gold.fact_sales;
GO

-- =============================================================================================
-- CHECK 7: Detailed Issue Investigation (Based on Your Sample Queries)
-- =============================================================================================

-- Detailed gender distribution (as per your example)
PRINT '>> Detailed Gender Distribution in Gold Layer';
SELECT 
    gender,
    COUNT(*) AS count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS percentage
FROM gold.dim_customers
GROUP BY gender
ORDER BY gender;

-- Sample of fact records with missing dimension references
PRINT '>> Sample of Orphaned Records (if any)';
SELECT TOP 10
    f.order_number,
    f.product_key,
    f.customer_key,
    f.sales_amount
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p ON p.product_key = f.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL;
GO

PRINT '==================================================';
PRINT 'Data Quality Checks Completed';
PRINT '==================================================';
