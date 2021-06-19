--Aliasing: Temporarily changing table or column name
--Helps with readability of script

SELECT FirstName Fname
FROM EmployeeDemographics

SELECT FirstName + ' '+LastName AS FullName
FROM EmployeeDemographics

--Often used with aggregate functions
SELECT AVG(Age) AS AvgAge
FROM EmployeeDemographics

--Aliasing table names
SELECT Demo.EmployeeID, Sal.Salary
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID

--Example joining three tables
SELECT Demo.EmployeeID,
Demo.FirstName, Demo.LastName, 
Sal.JobTitle, Ware.Age
FROM EmployeeDemographics Demo
LEFT JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID
LEFT JOIN WareHouseEmployeeDemographics Ware
ON Demo.EmployeeID=Ware.EmployeeID