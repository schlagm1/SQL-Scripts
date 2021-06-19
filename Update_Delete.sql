--Updating/Deleting data
--Inserting: creates new row
--Updating: alters existing rows
--Deleting: removes certain rows

UPDATE EmployeeDemographics
SET Age=31, Gender='Female'
WHERE FirstName='Holly' AND LastName='Flax'

DELETE
FROM EmployeeDemographics
WHERE EmployeeID=1005

