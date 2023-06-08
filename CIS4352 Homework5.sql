-- Question 1
CREATE INDEX idxHire
ON HumanResources.Employee(HireDate);

-- Question 2
CREATE VIEW vPersonNames AS 
SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS FullName
FROM Person.Person;

-- Question 3
SELECT * 
FROM [vPersonNames];

-- Question 4
CREATE VIEW vEmployee AS
SELECT Emp.BusinessEntityID, Emp.FirstName, Emp.MiddleName, Emp.LastName, HRe.HireDate
FROM Person.Person as Emp
INNER JOIN HumanResources.Employee as HRe
ON Emp.BusinessEntityID = HRe.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory as HREmpHist
ON HRe.BusinessEntityID = HREmpHist.BusinessEntityID
WHERE EndDate IS NULL;

-- Question 5
CREATE VIEW vTenYear AS
SELECT Emp.BusinessEntityID, Emp.FirstName, Emp.MiddleName, Emp.LastName, HRe.HireDate
FROM Person.Person as Emp
INNER JOIN HumanResources.Employee as HRe
ON Emp.BusinessEntityID = HRe.BusinessEntityID
WHERE HRe.HireDate < '2021-11-14' AND HRe.HireDate > '2011-11-14';


-- Question 6
USE AdventureWorks2019
DECLARE @OldestHire date
SELECT @OldestHire = MIN(HireDate) FROM HumanResources.Employee
PRINT @OldestHire;
GO

-- Question 7
CREATE PROCEDURE spEmployee AS
SELECT Emp.BusinessEntityID, Emp.FirstName, Emp.MiddleName, Emp.LastName, HRe.HireDate
FROM Person.Person as Emp
INNER JOIN HumanResources.Employee as HRe
ON Emp.BusinessEntityID = HRe.BusinessEntityID;

-- Question 8
EXEC spEmployee;

-- Question 9
CREATE PROCEDURE spEmployeeByID @EmpID INT
AS 
SELECT Emp.BusinessEntityID, Emp.FirstName, Emp.MiddleName, Emp.LastName, HRe.HireDate
FROM Person.Person as Emp
INNER JOIN HumanResources.Employee as HRe
ON Emp.BusinessEntityID = HRe.BusinessEntityID
WHERE Emp.BusinessEntityID = @EmpID;

-- Question 10
EXEC spEmployeeByID 135;

-- Question 11
CREATE PROCEDURE spVerifiedEmployeeID @EmpID INT
AS
IF EXISTS (SELECT Emp.BusinessEntityID, Emp.FirstName, Emp.MiddleName, Emp.LastName, HRe.HireDate
FROM Person.Person as Emp
INNER JOIN HumanResources.Employee as HRe
ON Emp.BusinessEntityID = HRe.BusinessEntityID
WHERE Emp.BusinessEntityID = @EmpID)
BEGIN
SELECT Emp.BusinessEntityID, Emp.FirstName, Emp.MiddleName, Emp.LastName, HRe.HireDate
FROM Person.Person as Emp
INNER JOIN HumanResources.Employee as HRe
ON Emp.BusinessEntityID = HRe.BusinessEntityID
WHERE Emp.BusinessEntityID = @EmpID
END
ELSE
PRINT 'Not a valid Employee ID';
