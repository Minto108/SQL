/*
Inner Joins, Full/Left/Right Outer Joins
*/

--select * from EmployeeDemographics
--Inner Join EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--select * from EmployeeDemographics
--FULL Outer Join EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--select * from EmployeeDemographics
--Left Outer Join EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--select * from EmployeeDemographics
--Right Outer Join EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--where Salary = 100000;

--select JobTitle, AVG(Salary) from EmployeeDemographics
--Inner Join EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--where JobTitle = 'Salesman'
--Group by JobTitle;