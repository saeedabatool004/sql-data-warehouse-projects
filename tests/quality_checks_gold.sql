/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to ensure the Gold layer is accurate,
    consistent, and reliable for reporting and analysis. The checks include:

    - Verifying the uniqueness of surrogate keys in dimension tables.
    - Ensuring referential integrity between fact and dimension tables.
    - Validating relationships across the data model.
    - Identifying any missing or unmatched records that could affect reporting.

Usage Notes:
    - Run these checks after the Gold layer has been created or refreshed.
    - Review and resolve any issues identified during the validation process.
===============================================================================
*/

-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results or Empty
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.product_key'
-- ====================================================================
-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No results or Empty
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL  


