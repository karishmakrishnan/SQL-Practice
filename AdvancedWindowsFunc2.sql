--1. Show each employee’s last order amount using LAG().
--2. Show difference between current order amount and previous order.
--3. Identify employees whose order amount increased compared to previous order.
--4. Get FIRST_VALUE() of order amount per employee and compare with all orders.
--5. Calculate running total sales per employee.
--6. Calculate running average sales per employee.
--7. Calculate 3 order moving average per employee.
--8. Show cumulative count of orders per employee.
--9. Rank orders by amount per employee; show only ranks 2 and 3.
--10. Return employee with 2nd highest salary per department (DENSE_RANK).
--11. Show salary contribution % per employee using window SUM().
--12. Return percentile ranking (PERCENT_RANK + CUME_DIST) for order amounts.

--1. Show each employee’s last order amount using LAG().
SELECT E.EmpID,E.Name,O.Amount,
LAG(O.Amount) OVER(PARTITION BY E.EmpID ORDER BY O.OrderDate) AS PreviousOrder
FROM Employees E
JOIN Orders O On O.EmpID = E.EmpID

--2. Show difference between current order amount and previous order.
SELECT E.EmpID,E.Name,O.Amount,O.Amount - 
LAG(O.Amount) OVER(PARTITION BY E.EmpID ORDER BY O.OrderDate) AS PreviousOrderDifference
FROM Employees E
JOIN Orders O On O.EmpID = E.EmpID

--3. Identify employees whose order amount increased compared to previous order.
WITH CTE AS(
SELECT E.EmpID,E.Name,O.Amount,
LAG(O.Amount) OVER(PARTITION BY E.EmpID ORDER BY O.OrderDate) AS PreviousOrder
FROM Employees E
JOIN Orders O On O.EmpID = E.EmpID) 
SELECT *, 
CASE
	WHEN PreviousOrder IS NULL THEN 'First Order'
	WHEN Amount > PreviousOrder THEN 'Increased'
	ELSE 'Decreased'
END AS Comparison
FROM CTE

--4. Get FIRST_VALUE() of order amount per employee and compare with all orders.
SELECT E.EmpID, E.Name, O.Amount, 
FIRST_VALUE(O.Amount) OVER(PARTITION BY E.EmpID ORDER BY O.OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS firstValue,
O.Amount - 
FIRST_VALUE(O.Amount) OVER(PARTITION BY E.EmpID ORDER BY O.OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS firstValueDiffrence
FROM Employees E
LEFT JOIN Orders O ON E.EmpID = O.EmpID

--5. Calculate running total sales per employee.
SELECT E.EmpID, E.Name, O.Amount,
SUM(O.Amount) OVER(PARTITION BY E.EmpID ORDER BY O.OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ruuning_total
FROM Employees E
LEFT JOIN Orders O ON E.EmpID = O.EmpID

--6. Calculate running average sales per employee.
SELECT E.EmpID, E.Name, O.Amount,
AVG(O.Amount) OVER(PARTITION BY E.EmpID ORDER BY O.OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ruuning_avg
FROM Employees E
LEFT JOIN Orders O ON E.EmpID = O.EmpID

--7. Calculate 3 order moving average per employee.
SELECT E.EmpID, E.Name, O.Amount,
AVG(O.Amount) OVER(PARTITION BY E.EmpID ORDER BY O.OrderDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS ruuning_avg
FROM Employees E
LEFT JOIN Orders O ON E.EmpID = O.EmpID

--8. Show cumulative count of orders per employee.
SELECT E.EmpID, E.Name, O.Amount,
COUNT(O.OrderID) OVER(PARTITION BY E.EmpID ORDER BY O.OrderDate
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ruuning_avg
FROM Employees E
LEFT JOIN Orders O ON E.EmpID = O.EmpID

--9. Rank orders by amount per employee; show only ranks 2 and 3.
WITH CTE AS(
SELECT E.EmpID, E.Name, O.Amount,
RANK() OVER(PARTITION BY E.EmpID ORDER BY O.Amount DESC) AS emp_rank
FROM Employees E
LEFT JOIN Orders O ON E.EmpID = O.EmpID)
SELECT * FROM CTE 
WHERE emp_rank = 2 OR emp_rank = 3

--10. Return employee with 2nd highest salary per department (DENSE_RANK).
WITH CTE AS(
SELECT EmpID, Name,Department,
DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS Highest_salary_Rank
FROM Employees)
SELECT * FROM CTE
WHERE Highest_salary_Rank = 2

--11. Show salary contribution % per employee using window SUM().
SELECT EmpID, Name,
(Salary*100)/Sum(Salary) OVER() AS Contribution_precent
FROM Employees

--12. Return percentile ranking (PERCENT_RANK + CUME_DIST) for order amounts.
SELECT OrderID, EmpID, Amount,
PERCENT_RANK() OVER (ORDER BY Amount DESC) AS percent_rank,
CUME_DIST() OVER (ORDER BY Amount DESC) AS cume_dist
FROM Orders