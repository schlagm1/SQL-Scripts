--CTE (Common Table Expression)
--Sometimes called WITH queries
--Named temporary result set used to manipulate
--complex subquery data
--Only exists within the scope of the statement we write
--Once we cancel out of this query, it's like it never existed
--Acts similarly to a subquery

WITH CTE_Employee AS
(SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) AvgSalary
FROM EmployeeDemographics Emp
JOIN EmployeeSalary Sal
ON Emp.EmployeeID=Sal.EmployeeID
WHERE Salary>'45000'
)
SELECT FirstName, AvgSalary
FROM CTE_Employee

--Note: CTE is not stored anywhere
--Note: You have to put your SELECT statement 
--directly after the CTE