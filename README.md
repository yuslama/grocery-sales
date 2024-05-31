# Grocery Store Sales Analysis

## Overview

This project analyzes the sales data of a grocery store chain, FoodYum, based in the United States. FoodYum sells a variety of products, including produce, meat, dairy, baked goods, snacks, and other household food staples. With rising food costs, the goal is to ensure that the store continues to stock products in all categories that cover a range of prices, catering to a broad range of customers.

## Data

The data for this analysis is available in the table `products`, which contains records of customers for their last full year of the loyalty program. The dataset includes the following columns:

| Column Name        | Criteria                                                                                   |
|--------------------|--------------------------------------------------------------------------------------------|
| product_id         | Nominal. Unique identifier of the product. Missing values are not possible.                |
| product_type       | Nominal. Category type of the product (Produce, Meat, Dairy, Bakery, Snacks). Missing values are replaced with "Unknown".  |
| brand              | Nominal. The brand of the product. One of 7 possible values. Missing values are replaced with "Unknown".  |
| weight             | Continuous. The weight of the product in grams, rounded to 2 decimal places. Missing values are replaced with the overall median weight.  |
| price              | Continuous. The price of the product in US dollars, rounded to 2 decimal places. Missing values are replaced with the overall median price.  |
| average_units_sold | Discrete. The average number of units sold each month. Missing values are replaced with 0.  |
| year_added         | Nominal. The year the product was first added to FoodYum stock. Missing values are replaced with 2022.  |
| stock_location     | Nominal. The stock origin location, one of four warehouse locations (A, B, C, D). Missing values are replaced with "Unknown".  |

## Tasks

### Task 1: Identify Missing Year Added Values

There was a bug in the product system last year (2022), which caused the `year_added` value to be missing for some products. It is important to identify how many products have the `year_added` value missing.

**Query:**
```sql
SELECT COUNT(*) AS missing_year
FROM products
WHERE year_added IS NULL;
