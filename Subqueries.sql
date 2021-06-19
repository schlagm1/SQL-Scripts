--Subqueries
--AKA Innter queries or nested queries
--Query within a query
--Used to return data used in outer (main) query as a
--condition to specify the data we want retrieved
--Subqueries can be used in SELECT, FROM, WHERE, INSERT,
--UPDATE, DELETE

--Subqueries run inner queries first, then outer queries

--Subquery in Select
SELECT EmployeeID, Salary, 
(SELECT AVG(Salary)FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary

--How to do it with partition by
SELECT EmployeeID, Salary, AVG(Salary)
OVER() AS AllAvgSalary
FROM EmployeeSalary

--Why group by doesn't work
SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary
FROM EmployeeSalary
Group By EmployeeID, Salary
ORDER By 1,2

--Subquery in FROM
--Note: This is similar to CTE, Temp Table... except
--you have to rewrite subquery each time

SELECT a.EmployeeID, AllAvgSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary)
		OVER() AS AllAvgSalary
		FROM EmployeeSalary) a

--Subquery in Where
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
					SELECT EmployeeID
					FROM EmployeeDemographics
					WHERE Age>30)
















