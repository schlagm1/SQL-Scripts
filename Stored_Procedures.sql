--Stored procedures
--A group of SQL that has been created and then stored in that database
--A single stored procedure can be stored over network
--and used be several users despite having different input data
--Reduces network traffic and improves performance
--Modifying stored procedures affects it for all users

CREATE PROCEDURE TEST
AS 
SELECT *
FROM EmployeeDemographics


EXEC TEST


CREATE PROCEDURE Temp_Employee
AS 
CREATE TABLE #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_employee
SELECT JobTitle, Count(JobTitle),
Avg(Age), Avg(Salary)
FROM EmployeeDemographics Emp
JOIN EmployeeSalary Sal
ON Emp.EmployeeID=Sal.EmployeeID
GROUP BY JobTitle

SELECT*
FROM #temp_employee

EXEC Temp_Employee 

--Let's enter Temp_Employee on the left side and change
--the stored procedure






