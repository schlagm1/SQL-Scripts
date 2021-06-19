--Case statements let you specify a condition
--and what you want returned when that condition is met

SELECT FirstName, LastName, Age,
CASE
WHEN Age >30 THEN 'Old'
WHEN Age BETWEEN 27 AND 30 THEN 'Young'
ELSE 'Baby'
END AS AgeCategory
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age

--Use case:Giving employees a raise

SELECT FirstName, 
LastName, 
JobTitle, 
Salary,
CASE
WHEN JobTitle='Salesman' THEN Salary+(Salary*0.1)
WHEN JobTitle='Accountant' THEN Salary+(Salary*0.05)
WHEN JobTitle='HR' THEN Salary+(Salary*0.00001)
ELSE Salary+(Salary*.03)
END AS NewSalary
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID=
EmployeeSalary.EmployeeID