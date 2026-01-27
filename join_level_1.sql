--Level 1 - Basic joins:
-- 1. List all orders with customer name and product name.
-- 2. List customers and the total number of orders they placed.
-- 3. Show all products along with their category name.
-- 4. List all orders and include customers even if a customer has zero orders (use LEFT JOIN).
-- 5. Find all suppliers and the count of distinct products they supply.
-- 6. List orders where the product price is greater than 1000.
-- 7. Return customers who have never placed an order.
-- 8. List products and their suppliers (product may have a supplier).
-- 9. Show orders with order_date and customer city.
-- 10. List the top 5 customers by total quantity ordered.


-- 1. List all orders with customer name and product name.
SELECT Orders.order_id,Customers.customer_name,Products.product_name
FROM ((Orders
LEFT JOIN Customers ON [dbo].[Orders].customer_id=[dbo].[Customers].customer_ID)
LEFT JOIN Products ON [dbo].[Orders].product_id=[dbo].[Products].product_id)

-- 2. List customers and the total number of orders they placed.
SELECT Customers.customer_name,COUNT(Orders.customer_id) AS Total_Order
FROM Orders
INNER JOIN Customers ON Orders.customer_id=Customers.customer_id
GROUP BY Customers.customer_name

-- 3. Show all products along with their category name.
SELECT Products.product_name,Categories.category_name
FROM Products
LEFT JOIN Categories ON Products.category_id = Categories.category_id

-- 4. List all orders and include customers even if a customer has zero orders (use LEFT JOIN).
SELECT Orders.order_id,Customers.customer_id,Customers.customer_name
FROM Orders
LEFT JOIN Customers ON Orders.customer_id = Customers.customer_id

-- 5. Find all suppliers and the count of distinct products they supply.
SELECT Suppliers.supplier_id, COUNT(DISTINCT Products.product_id) AS product_count
FROM Suppliers
LEFT JOIN Products ON Suppliers.supplier_id = Products.supplier_id
GROUP BY Suppliers.supplier_id

-- 6. List orders where the product price is greater than 1000.
SELECT Orders.order_id,Products.product_name
FROM Orders
INNER JOIN Products ON Orders.product_id = Products.product_id
WHERE Products.price > 1000
order by Products.product_name

-- 8. List products and their suppliers (product may have a supplier).
SELECT Products.product_id,Products.product_name,Suppliers.supplier_id
FROM Products
FULL JOIN Suppliers ON Suppliers.supplier_id = Products.supplier_id

-- 9. Show orders with order_date and customer city.
SELECT Orders.order_date,Customers.city
FROM Orders
LEFT JOIN Customers ON Customers.customer_id = Orders.customer_id

-- 10. List the top 5 customers by total quantity ordered.
SELECT TOP 5 customer_id, SUM(quantity) AS Total_quantity
FROM Orders
GROUP BY customer_id
ORDER BY SUM(quantity) DESC