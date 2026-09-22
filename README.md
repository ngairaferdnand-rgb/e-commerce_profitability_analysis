# BRIGHTCART PROFITABILITY ANALYSIS: A DEEP DIVE INTO D2C MARGINS AND MARKETING ROI

## 📌 Project Overview
This repository contains an end-to-end data analytics project evaluating e-commerce transactional data. The objective is to engineer a clean data pipeline from raw, unstandardized data (orders, marketing spend, and product logs) into interactive executive dashboards and visualizations that surface insights on net profit margin, return & discount rates, return on advertising spend (ROAS), cost per acquisition (CPA), cost per click (CPC), revenue & cost leakages, marketing attribution patterns, and so on.

---

## 📂 Project Structure and Code Artifacts
To explore the technical implementation of this pipeline and visualization layers, access the files directly via the links below:

*   **Data Engineering and Pipelines:**
    *    [Python Data Cleaning Notebook](https://nbviewer.org/github/Madivoli/e-commerce_profitability_analysis/blob/main/orders.ipynb) — *The complete automated data pipeline used for handling missing values, standardizing datetime objects, downcasting integer columns to memory-efficient types, and creating & saving the database*:

*   **Data Layers:**
    *   [Raw Transaction Dataset](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/Dataset.zip) — *The uncleaned, raw transactional ledger containing initial format discrepancies and missing customer identifiers.*
    *   [Processed and Cleaned Dataset](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/Cleaned.zip) — *The optimized, structurally sound datasets engineered for direct ingestion into DBeaver, Excel, and Tableau Desktop.*

*   **Data Analysis:**
    *   [SQL](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/brightcart_analysis.sql) — *The repository of structured queries used to calculate margin percent, determine revenue and cost drivers, carry out marketing attribution and channel audit, and so on. Using SELECT statements, JOINS, GROUP BY & ORDER BY functions, WHERE filter, Common Table Expression (CTE), etc.*
    *   [Excel](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/ROAS%20vs%20Actual%20ROI.xlsx) — *Using Pivot Tables, Pivot Charts, Conditional Formatting, Combi-Charts, 100% Stacked Bar Charts, and Line Charts.*

*   **Business Intelligence and Dashboards:**
    *   [Tableau Workbook (Packaged)](./dashboards/ecommerce_executive_analytics.twbx) — *The interactive workbook containing KPIs, executive-ready visual stories, dashboards, calculated fields, actions, and parameters.*

*   **Executive Summary and Reports:**
    *   [Executive Summary](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/EXECUTIVESUMMARY.md) — *Summary of numerous reports containing main findings and numbers, recommendations, conclusion, and call-to-action sections for management.*
    *   [Profitability and Cost Analysis Report](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/PROFITABILITY%20AND%20COST%20ANALYSIS%20REPORT.pdf)
    *   [Products and Channel Analysis Report](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/PRODUCTS%20AND%20CHANNEL%20ANALYSIS%20REPORT.pdf)
    *   [Marketing Spend Analysis Report](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/MARKETING%20SPEND%20REPORT.pdf)
    *   [Payment Method Analysis Report](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/PAYMENT%20METHOD%20ANALYSIS%20REPORT.pdf)
    *   [Supplier Analysis Report](https://github.com/Madivoli/e-commerce_profitability_analysis/blob/main/SUPPLIER%20ANALYSIS%20REPORT.pdf)
---

## 🛠️ Data Pipeline Architecture (Python Implementation)
The data cleaning process achieved the following data-quality benchmarks:
1. **Installing and Importing Pandas:** Installed the `Pandas` module first since it is not pre-installed in the `Jupyter Notebook IDE`.
2. **Loading the Data:** Loaded and read the CSV files into DataFrames. Since I was working with 3 different files, I called the dataframes with readable names (orders, marketing spend, and products).
3. **Understanding the Data:** Used the `df.info()` command to check the columns, what type they are, and how many non-null values they have. 
4. **Handling Missing Values:** Checked for missing values. There were no NaN or missing values in the datasets.
5. **Converting Data Types:** Converted columns (e.g., `channel`, `payment_method`, `region`) from objects/strings to categorical data types to save memory and improve speed.
6. **Saving the Clean Data:** Saved the cleaned data into CSV files.
7. **Creating a Database:** Installed the `sqlite3` module. Created and saved the cleaned dataframe into databases (orders, marketing spend, and product db) for further analysis using DBeaver's (Database Management Software) SQL, Excel, and Tableau Desktop.
