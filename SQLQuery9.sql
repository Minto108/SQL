--DROP TABLE IF EXISTS #temp_Employee2
--CREATE TABLE #temp_Employee2 (
--JobTitle varchar(50),
--EmployeesPerJob int,
--AvgAge int,
--AvgSalary int)

--INSERT INTO #temp_Employee2
--SELECT JobTitle, Count(JobTitle), Avg(Age), Avg(Salary)
--from [SQL Tutorial]..EmployeeDemographics emp 
--JOIN [SQL Tutorial]..EmployeeSalary sal ON
--emp.EmployeeID = sal.EmployeeID
--group by JobTitle

--select * from #temp_Employee2

