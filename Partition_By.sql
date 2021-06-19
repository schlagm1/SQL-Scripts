--Partition by
--Often compared to Group by
--Group by: reduces number of rows in output by rolling up
--with aggregate functions
--Partition by: divides results in partitions; doesn't reduce
--number of rows in output

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID

--The results from the above query in TotalGender column
--show the total number of each gender next to each name

--Let's compared to Group By

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender)
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary

--To see 3 for females and 6 for males, we need to change 
--the above query again

SELECT Gender,
COUNT(Gender)
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
ON Demo.EmployeeID=Sal.EmployeeID
GROUP BY Gender