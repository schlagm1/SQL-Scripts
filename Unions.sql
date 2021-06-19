--Unions are similar to joins in that
--you combine two tables to get one output

--They are different in that joins combine
--two tables based on a common column,
--whereas unions let you select all data from both tables
--and put into one table where all data is in each column

--The output in the following example works well 
--because the columns in both tables are the same

SELECT *
FROM EmployeeDemographics
UNION
SELECT*
FROM WareHouseEmployeeDemographics


--By default, unions remove duplicates
--You have to use union all if you want duplicates

SELECT *
FROM EmployeeDemographics
UNION ALL
SELECT*
FROM WareHouseEmployeeDemographics
ORDER BY EmployeeID

--The following is an example of a union that you should not do
--The union still works because column numbers and
--data types are the same

SELECT EmployeeID, FirstName, Age
FROM EmployeeDemographics
UNION
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
