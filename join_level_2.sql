--11. For each order, show order_id, customer_name, product_name, supplier_name.
-- 12. Show products that belong to category 'Electronics' along with supplier.
-- 13. Find total revenue (price * quantity) per order.
-- 14. List customers and total revenue they generated (sum of price*quantity).
-- 15. Show suppliers that supply products in more than 1 category.
-- 16. List products that have never been ordered.
-- 17. For each category, list category_name and total quantity sold.
-- 18. Show orders where ship_city != customer's city.
-- 19. List customers who ordered products from more than 3 different suppliers.
-- 20. For each month, show total orders and total revenue.

--11. For each order, show order_id, customer_name, product_name, supplier_name.
SELECT Orders.order_id,Customers.customer_name, Products.product_name, Suppliers.supplier_name
FROM ((Orders
LEFT JOIN Customers ON Orders.customer_id = Customers.customer_id)
LEFT JOIN Products ON Orders.product_id = Products.product_id)
LEFT JOIN Suppliers ON Products.supplier_id = Suppliers.supplier_id

-- 12. Show products that belong to category 'Electronics' along with supplier.
SELECT Products.product_id, Products.product_name,Categories.category_name, Suppliers.supplier_name
FROM (Products
INNER JOIN Categories ON Products.category_id = Categories.category_id)
LEFT JOIN Suppliers ON Suppliers.supplier_id = Products.supplier_id
WHERE Categories.category_name = 'Electronics'

-- 13. Find total revenue (price * quantity) per order.
SELECT Orders.order_id, Products.price*Orders.quantity AS revenue
FROM Orders
LEFT JOIN Products ON Products.product_id = Orders.order_id

-- 14. List customers and total revenue they generated (sum of price*quantity).
SELECT Customers.customer_name, SUM(Orders.quantity*Products.price) AS revenue
FROM (Customers
LEFT JOIN Orders ON Orders.customer_id = Customers.customer_id)
LEFT JOIN Products ON Products.product_id = Orders.product_id
GROUP BY Customers.customer_name

-- 15. Show suppliers that supply products in more than 1 category.
SELECT Suppliers.supplier_name, COUNT(DISTINCT Products.category_id)
FROM Suppliers
INNER JOIN Products ON Suppliers.supplier_id = Products.supplier_id
GROUP BY Suppliers.supplier_name HAVING COUNT(DISTINCT Products.category_id) > 1

-- 16. List products that have never been ordered.
SELECT Products.product_id, Products.product_name, Orders.order_id
FROM Products
LEFT JOIN Orders ON Products.product_id = Orders.product_id
WHERE Orders.product_id IS NULL

-- 17. For each category, list category_name and total quantity sold.
SELECT Categories.category_name, SUM(Orders.quantity) AS total_quantity
FROM (Categories
LEFT JOIN Products ON Categories.category_id = Products.category_id)
LEFT JOIN Orders ON Orders.product_id = Products.product_id
GROUP BY Categories.category_name

-- 18. Show orders where ship_city != customer's city.
SELECT Orders.order_id, Customers.city, Orders.ship_city
FROM Orders
LEFT JOIN Customers ON Orders.customer_id = Customers.customer_id
WHERE Orders.ship_city NOT IN(SELECT Customers.city FROM Customers)

---- 19. List customers who ordered products from more than 3 different suppliers.
SELECT Customers.customer_name, COUNT(DISTINCT Products.supplier_id) AS No_Of_Supplier
FROM (Orders
LEFT JOIN Products ON Orders.product_id = Products.product_id)
INNER JOIN Customers ON Customers.customer_id = Orders.customer_id
GROUP BY Customers.customer_name HAVING COUNT(DISTINCT Products.supplier_id) > 3

---- 20. For each month, show total orders and total revenue.
SELECT DATENAME(MONTH, Orders.order_date),COUNT(Orders.order_id) AS total_order, SUM(Orders.quantity*Products.price) AS total_revenue
FROM Orders
LEFT JOIN Products ON Products.product_id = Orders.product_id
GROUP BY DATENAME(MONTH, Orders.order_date)
ORDER BY DATENAME(MONTH, Orders.order_date)

