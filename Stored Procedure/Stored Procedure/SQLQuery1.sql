select * from EMPLOYEE1

--TO CREATE Stored Procedure Without Parameter
create Procedure sp_GetEmployee				--OR CREATE PROC
As
BEGIN
	select ID,Name,Department from Employee1
END

--TO EXECUTE
sp_GetEmployee
EXECUTE sp_GetEmployee
EXEC sp_GetEmployeeByDepartment

--To View the text of a Stored Procedure
sp_helptext sp_GetEmployee

--TO CREATE Stored Procedure With Parameter
create Procedure sp_GetEmployeeByDepartment
@DepartmentName nvarchar(50)
As
BEGIN
	select ID,Name,Department from Employee1 where Department =@DepartmentName
END

--TO EXECUTE
sp_GetEmployeeByDepartment 'IT'

-- To change the body of a stored procedure Use Alter procedure to change the body
ALTER PROCEDURE sp_GetEmployeeByDepartment
AS
BEGIN
  SELECT ID, Name, Department FROM Employee1 ORDER BY ID
END

-- To change the procedure name from spGetEmployee Use sp_rename system defined stored procedure
EXEC sp_rename 'sp_GetEmployeeByDepartment', 'sp_GetEmployeeByDepartment1'

sp_GetEmployeeByDepartment1

--Input parameters
create Procedure spAddTwoNumbers
@Num1 int,
@Num2 int
As
BEGIN
	DECLARE @Result INT
	SET @Result = @Num1 + @Num2
	PRINT 'RESULT IS: '+ CAST(@Result AS VARCHAR)
END

EXECUTE spAddTwoNumbers 10, 20
--or
EXECUTE spAddTwoNumbers @Num1=10, @Num2=20

--Output Parameter
CREATE PROCEDURE spSubTwoNumbers
  @No1 INT,
  @No2 INT,
  @Result INT OUTPUT
AS
BEGIN
  SET @Result = @No1 - @No2
END

DECLARE @Result INT
EXECUTE spSubTwoNumbers 20, 10, @Result OUT
PRINT @Result

--Stored Procedure with Default Values
CREATE PROCEDURE spMulNumber(@No1 INT= 10, @No2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = @No1 * @No2
  PRINT 'The MUL of the 2 Numbers is: '+ CAST(@Result AS VARCHAR)
END

EXEC spMulNumber 5,5
EXEC spMulNumber @No1=10, @No2=5
EXEC spMulNumber @No1=DEFAULT, @No2=5
EXEC spMulNumber @No2=5

--Some System Stored procedures
sp_help spMulNumber
sp_helptext spMulNumber
sp_depends spMulNumber

--Return Value 
CREATE PROCEDURE spGetTotalCountOfEmployee1
AS
BEGIN
  RETURN (SELECT COUNT(ID) FROM Employee1)
END

DECLARE @EmployeeTotal INT
EXECUTE @EmployeeTotal = spGetTotalCountOfEmployee1
PRINT @EmployeeTotal

-- Function without with encryption option and return value
CREATE FUNCTION fn_GetEmployeeDetailsById
(
  @ID INT
)
RETURNS TABLE
AS
RETURN (SELECT ID,Name FROM Employee1 WHERE ID = @ID)

sp_helptext fn_GetEmployeeDetailsById

-- function With Encryption option
ALTER FUNCTION fn_GetEmployeeDetailsById
(
  @ID INT
)
RETURNS TABLE
WITH Encryption
AS
RETURN (SELECT ID,Name FROM Employee1 WHERE ID = @ID)

sp_helptext fn_GetEmployeeDetailsById						--The text for object 'fn_GetEmployeeDetailsById' is encrypted.

-- Function with SCHEMABINDING option
ALTER FUNCTION fn_GetEmployeeDetailsById
(
  @ID INT
)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN (SELECT ID,Name FROM dbo.Employee1 WHERE ID = @ID)

DROP TABLE Employee1		--Cannot DROP TABLE 'Employee1' because it is being referenced by object 'fn_GetEmployeeDetailsById'.

--Deterministic Functions
SELECT COUNT(*) FROM Employee1
SELECT SQUARE(3)

--Non-Deterministic Functions
SELECT GetDate()
SELECT Current_Timestamp
SELECT Rand(1)
SELECT Rand()
