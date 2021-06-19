--Having clause
--Syntax: Goes after GROUP BY but before ORDER BY
--First, let's view a count of each job title

SELECT JobTitle, COUNT(JobTitle) AS CountJobTitle
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
GROUP BY JobTitle

--Now let's look at all the jobs that have more than one person
--in each job
--Because we cannot use aggregate function in the where 
--statement, we need to use the HAVING clause


SELECT JobTitle, COUNT(JobTitle) AS CountJobTitle
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle)>1

--Second example:
SELECT JobTitle, AVG(Salary) AS AvgSalary
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID=EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary)>45000
ORDER BY AVG(Salary)


