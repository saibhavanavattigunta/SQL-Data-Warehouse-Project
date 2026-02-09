# Data Dictionary for Gold Layer

## Overview

The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases.
It consists of dimension tables and fact tables for specific business metrics.

---

## 1. `gold.dim_customers`

**Purpose:**
Stores customer details enriched with demographic and geographic data.

### Columns

| Column Name       | Data Type    | Description                                                                          | Example         |
| ----------------- | ------------ | ------------------------------------------------------------------------------------ | --------------- |
| `customer_key`    | INT          | Surrogate key generated in the Gold layer to uniquely identify each customer record. | `1001`          |
| `customer_id`     | INT          | Natural customer identifier from the CRM source system.                              | `456789`        |
| `customer_number` | VARCHAR(50)  | Business customer reference key used across CRM and ERP systems.                     | `CUST-00045`    |
| `first_name`      | VARCHAR(100) | Customer’s first name as stored in CRM.                                              | `Sai`           |
| `last_name`       | VARCHAR(100) | Customer’s last name as stored in CRM.                                               | `Bhavana`       |
| `country`         | VARCHAR(100) | Country associated with the customer, derived from ERP location data.                | `United States` |
| `marital_status`  | VARCHAR(20)  | Customer’s marital status recorded in CRM.                                           | `Single`        |
| `gender`          | VARCHAR(10)  | Customer gender; sourced from CRM, with ERP as fallback when CRM value is `N/a`.     | `Female`        |
| `birthdate`       | DATE         | Customer’s date of birth sourced from ERP.                                           | `1992-07-18`    |
| `create_date`     | DATE         | Date when the customer record was created in the CRM system.                         | `2021-11-05`    |

---

## 2. `gold.dim_products`

**Purpose:**
Provides information about the products and their attributes.

### Columns

| Column Name      | Data Type     | Description                                                                         | Example                |
| ---------------- | ------------- | ----------------------------------------------------------------------------------- | ---------------------- |
| `product_key`    | INT           | Surrogate key generated in the Gold layer to uniquely identify each active product. | `5012`                 |
| `product_id`     | INT           | Natural product identifier from the CRM system.                                     | `98234`                |
| `product_number` | VARCHAR(50)   | Business product reference key used across source systems.                          | `PRD-00982`            |
| `product_name`   | VARCHAR(255)  | Descriptive name of the product.                                                    | `Smart Fitness Watch`  |
| `category_id`    | INT           | Identifier for the product category from the source system.                         | `15`                   |
| `category`       | VARCHAR(100)  | High-level product category name.                                                   | `Wearables`            |
| `subcategory`    | VARCHAR(100)  | More granular product classification within a category.                             | `Smart Watches`        |
| `maintenance`    | VARCHAR(20)   | Indicates whether the product requires maintenance or ongoing support.              | `Yes`                  |
| `cost`           | DECIMAL(10,2) | Standard cost of the product.                                                       | `249.99`               |
| `product_line`   | VARCHAR(100)  | Product line or business line to which the product belongs.                         | `Consumer Electronics` |
| `start_date`     | DATE          | Date when the product became active or available for sale.                          | `2023-04-01`           |

---

## 3. `gold.fact_sales`

**Purpose:**
Stores transactional sales data for analytical purposes.

### Columns

| Column Name     | Data Type     | Description                                                                                                 | Example      |
| --------------- | ------------- | ----------------------------------------------------------------------------------------------------------- | ------------ |
| `order_number`  | VARCHAR(50)   | Unique sales order number from the CRM system identifying each sales transaction.                           | `SO-100245`  |
| `product_key`   | INT           | Surrogate key referencing `gold.dim_products.product_key`, identifying the product sold.                    | `3056`       |
| `customer_key`  | INT           | Surrogate key referencing `gold.dim_customers.customer_key`, identifying the customer who placed the order. | `10245`      |
| `order_date`    | DATE          | Date when the sales order was created.                                                                      | `2024-06-15` |
| `shipping_date` | DATE          | Date when the order was shipped to the customer.                                                            | `2024-06-18` |
| `due_date`      | DATE          | Expected or contractual due date for order delivery or completion.                                          | `2024-06-20` |
| `sales_amount`  | DECIMAL(12,2) | Total sales amount for the order line, typically calculated as quantity × price.                            | `1499.99`    |
| `quantity`      | INT           | Number of product units sold in the order line.                                                             | `3`          |
| `price`         | DECIMAL(10,2) | Unit selling price of the product at the time of sale.                                                      | `499.99`     |

---

