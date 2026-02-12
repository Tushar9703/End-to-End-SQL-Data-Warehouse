# End-to-End SQL Data Warehouse

A complete end-to-end SQL-based data warehouse implementation using Medallion Architecture (Bronze, Silver, Gold layers) to transform raw CRM and ERP data into analytics-ready datasets through structured ETL processing and dimensional modeling.

---

## 📌 Project Overview

This project demonstrates the design and implementation of a modern data warehouse built entirely using SQL. It integrates multiple source systems and applies layered transformations to deliver clean, validated, and business-ready analytical data.

### Source Systems

- **CRM System**
  - Customer master data
  - Product catalog
  - Sales transactions

- **ERP System**
  - Customer demographics
  - Geographic location data
  - Product categorization

The architecture ensures scalability, maintainability, and data reliability for analytics and reporting.

---

## 🏗 Architecture – Medallion Pattern

The warehouse follows a three-layer Medallion Architecture:

### 🥉 Bronze Layer – Raw Data
- Stores data as received from source systems
- Minimal transformation
- Maintains source-level traceability
- Acts as ingestion layer

### 🥈 Silver Layer – Cleansed & Standardized
- Data validation and transformation applied
- Deduplication using window functions
- Standardized formats (dates, text normalization)
- Business rule enforcement
- Data enrichment and cleansing

### 🥇 Gold Layer – Analytical Model
- Dimensional modeling (Star Schema)
- Surrogate keys
- Fact and dimension tables
- Optimized for reporting and BI tools

---

## 📊 Data Model

### Dimension Tables
- `dim_customers`
- `dim_products`

### Fact Table
- `fact_sales`

The Gold layer provides a star schema optimized for:
- Customer analytics
- Product performance analysis
- Sales trend reporting
- Business intelligence dashboards

---
## 📊 Business Intelligence

The Gold layer provides analytics-ready data for:

- **Customer Segmentation**: Demographics, geography, purchase behavior
- **Product Analysis**: Category performance, pricing strategies
- **Sales Analytics**: Trends, seasonality, growth metrics
- **Operational Insights**: Order fulfillment, shipping performance
│
