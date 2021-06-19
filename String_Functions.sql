--String Functions
--First, create table to demonstrate these examples
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

--Using Trim, LTRIM, RTRIM
--Trim removes blank spaces
SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

--Removes spaces on the left side
SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

--Removes spaces on the right side
SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors

--Using replace
SELECT LastName, 
REPLACE(LastName, '- Fired','') 
AS LastNameFixed
FROM EmployeeErrors

--Using substring
--Specify place you want to start and how many
--characters you want to go out
SELECT SUBSTRING(FirstName, 1, 3)
FROM EmployeeErrors

--Fuzzy match use case for substring
SELECT Err.FirstName,
SUBSTRING(Err.FirstName,1,3), 
Dem.FirstName,
SUBSTRING(Dem.FirstName,1,3)
FROM EmployeeErrors Err
JOIN EmployeeDemographics Dem
ON SUBSTRING(Err.FirstName, 1,3)=
SUBSTRING(Dem.FirstName, 1,3)

--UPPER & LOWER
--Takes all characters and converts
--them to either upper or lower
SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors