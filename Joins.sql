--Join lets you join multiple tables into one output
--Inner join
SELECT*
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID

--Full outer join
SELECT*
FROM EmployeeDemographics Demo
FULL OUTER JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID

--Left join
SELECT*
FROM EmployeeDemographics Demo
LEFT JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID

--More join examples
SELECT Demo.EmployeeID, FirstName,
LastName, JobTitle, Salary
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID

--Use case example
SELECT Demo.EmployeeID, FirstName,
LastName, Salary
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID
WHERE FirstName<>'Michael'
ORDER BY Salary DESC

SELECT JobTitle,
AVG(Salary) AS AvgSalary
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID
WHERE JobTitle='Salesman'
GROUP BY JobTitle



