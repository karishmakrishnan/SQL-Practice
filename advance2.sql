--SECTION 5 — STRING FUNCTIONS (6 QUESTIONS)
--37. Extract first and last name from FullName.
--38. Mask email (k****a@gmail.com).
--39. Find employees whose names contain only vowels.
--40. Check if product name begins with a number.
--41. Replace spaces in product names with underscores.
--42. Extract domain from email using SUBSTRING + CHARINDEX.

SELECT 
    value AS NamePart
FROM STRING_SPLIT('Mary Ann Smith', ' ');

SELECT 
    LEFT(Name, CHARINDEX(' ', Name) - 1) AS FirstName,
    RIGHT(Name, CHARINDEX(' ', REVERSE(Name)) - 1) AS LastName
FROM Employees;

SELECT 
    SUBSTRING(Name, 1, (CHARINDEX(' ', Name) - 1)) AS FirstName,
    SUBSTRING(Name, CHARINDEX(' ', Name) + 1, LEN(Name)) AS LastName
FROM Employees;

SELECT (CHARINDEX(' ', Name) - 1)
FROM Employees

SELECt * FROM Employees

SELECT 
    CONCAT(
        LEFT(Email, 1),                          -- first character
        REPLICATE('*', CHARINDEX('@', Email)-2), -- mask middle part
        SUBSTRING(Email, CHARINDEX('@', Email)-1, LEN(Email)) -- last char + domain
    ) AS MaskedEmail
FROM Users;

--Find employees whose names contain only vowels.
SELECT Name
FROM Employees
WHERE Name NOT LIKE '%[^AEIOUaeiou]%';

SELECT ProductName
FROM Products
WHERE LEFT(ProductName, 1) LIKE '[0-9]';

SELECT 
    SUBSTRING(
        Email, 
        CHARINDEX('@', Email) + 1, 
        LEN(Email) - CHARINDEX('@', Email)
    ) AS Domain
FROM Users;
