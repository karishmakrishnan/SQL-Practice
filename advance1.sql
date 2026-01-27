--sales(order_date, region, product, amount)
--1 Write a query to calculate total sales by region and product, including region totals and the grand
--total.
--2 Modify the above query to exclude rows added by ROLLUP / CUBE.
--3 Display subtotals such that:- Region subtotal rows show 'ALL REGIONS'- Product subtotal rows show 'ALL PRODUCTS'
--4 Return only rows where the amount is greater than the region average (requires a window function).

--1 Write a query to calculate total sales by region and product, including region totals and the grand
--total.
SELECT region,product, SUM(amount)
FROM Sales
GROUP BY ROLLUP(region, product)
--2 Modify the above query to exclude rows added by ROLLUP / CUBE.
SELECT region,product, SUM(amount),
GROUPING(region),
GROUPING(product)
FROM Sales
GROUP BY ROLLUP(region, product)
--3 Display subtotals such that:- Region subtotal rows show 'ALL REGIONS'- Product subtotal rows show 'ALL PRODUCTS'
SELECT region,product, SUM(amount)
FROM Sales
GROUP BY
GROUPING SETS(
(region),
(product)
)
--4 Return only rows where the amount is greater than the region average (requires a window function).
WITH region_avg_table AS(
SELECT region,amount,
AVG(amount) OVER(PARTITION BY region ORDER BY order_date
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS region_avg
FROM Sales
)
SELECT * FROM region_avg_table
WHERE amount > region_avg
