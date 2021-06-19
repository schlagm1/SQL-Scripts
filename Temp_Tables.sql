--Temp Tables
--You can hit off a temp table multiple times,
--which you cannot do with a CTE or subquery

CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int)

INSERT INTO #temp_Employee VALUES (
1001, 'HR', 45000
)

--Use a select statement to insert large data into table
INSERT INTO #temp_Employee
SELECT*
FROM EmployeeSalary

SELECT*
FROM #temp_Employee

--Use case for temp table:
--If a table had many large number of rows,
--doing a complex query with large data would take a long
--time to hit off of it
--Instead, you can insert data into temp table and hit off
--of that to increase speed

--Example 2: How Alex would actually use it
--Drop Table if exists is imperative to rerun temp table 
--query 

DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2 (
JobTitle varchar(50), 
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #Temp_Employee2
SELECT JobTitle, Count(JobTitle),
Avg(Age), Avg(Salary)
FROM EmployeeDemographics Emp
JOIN EmployeeSalary Sal
ON Emp.EmployeeID=Sal.EmployeeID
GROUP BY JobTitle

SELECT*
FROM #Temp_Employee2

--We can now run further calculations on the temp table
--values without having to redo the joins and aggregate
--functions
--This cuts down on run time

 