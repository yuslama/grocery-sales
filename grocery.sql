-- Task 1: Count Missing Year Added Values
SELECT COUNT(*) AS missing_year
FROM products
WHERE year_added IS NULL;

-- Task 2: Data Cleaning
WITH WeightMedian AS (
    SELECT
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CAST(SUBSTRING(weight, 1, LENGTH(weight) - 6) AS DOUBLE PRECISION)) AS median_weight
    FROM products
    WHERE weight IS NOT NULL AND weight LIKE '% grams'
),
PriceMedian AS (
    SELECT
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) AS median_price
    FROM products
    WHERE price IS NOT NULL
),
clean_data AS (
    SELECT
        product_id,
        COALESCE(NULLIF(product_type, ''), 'Unknown') AS product_type,
        CASE 
            WHEN brand = '-' THEN 'Unknown'
            ELSE COALESCE(NULLIF(brand, ''), 'Unknown')
        END AS brand,
        CAST(
            CASE 
                WHEN weight IS NULL THEN (SELECT median_weight FROM WeightMedian)
                WHEN weight LIKE '% grams' THEN CAST(SUBSTRING(weight, 1, LENGTH(weight) - 6) AS DOUBLE PRECISION)
                ELSE CAST(weight AS DOUBLE PRECISION)
            END AS DECIMAL(10, 2)
        ) AS weight,
        CAST(
            CASE 
                WHEN price IS NULL THEN (SELECT median_price FROM PriceMedian)
                ELSE price
            END AS DECIMAL(10, 2)
        ) AS price,
        COALESCE(average_units_sold, 0) AS average_units_sold,
        COALESCE(year_added, 2022) AS year_added,
        CASE 
            WHEN LOWER(stock_location) IN ('a', 'b', 'c', 'd') THEN UPPER(stock_location)
            ELSE 'unknown'
        END AS stock_location
    FROM
        products
)
SELECT * FROM clean_data;

-- Task 3: Minimum and Maximum Price by Product Type
SELECT
    product_type,
    MIN(price) AS min_price,
    MAX(price) AS max_price
FROM products
GROUP BY product_type;

-- Task 4: Detailed Analysis of Meat and Dairy Products
SELECT
    product_id,
    price,
    average_units_sold
FROM products
WHERE (product_type = 'Meat' OR product_type = 'Dairy')
  AND average_units_sold > 10;
