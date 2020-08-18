-- 1/ Declare scalar variable for storing FirstName values
		-- Assign value 'Antonio' to the FirstName variable
		-- Find all Students having FirstName same as variable

		DECLARE @StudentFirstName NVARCHAR(100)
		SET @StudentFirstName = 'Antonio'
		SELECT * FROM Student WHERE FirstName = @StudentFirstName
		GO


-- 2/ Declare table variable that will contain StudentId, StudentName and DateOfBirth
		-- Fill the table variable with all female students

		DECLARE @FemaleStudents TABLE(StudentID int not null, FirstName nvarchar(100) null, DateOfBirth date);
		INSERT INTO @FemaleStudents 
		SELECT ID, FirstName, DateOfBirth FROM Student WHERE Gender = 'F'

		SELECT * FROM @FemaleStudents 
		GO


-- 3/ Declare temp table that will contain LastName and EnrolledDate columns
		-- Fill the temp table with all Male students having First Name starting with 'A'
		CREATE TABLE #StudentInformation
		(LastName nvarchar(100) null, EnrolledDate date);
		INSERT INTO #StudentInformation (LastName, EnrolledDate)
		SELECT LastName, EnrolledDate FROM dbo.Student WHERE Gender = 'M' AND FirstName LIKE 'A%'   
		
		-- Retrive the students from the table which last name is with 7 characters
		SELECT * FROM #StudentInformation WHERE LEN(LastName) = 7
		GO


-- 4/ Find all teachers whose FirstName length is less than 5 and the first 3 characters of their FirstName and LastName are the same
		SELECT * FROM dbo.Teacher WHERE LEN(FIrstName) <= 5 AND LEFT(FirstName, 3) = LEFT(LastName, 3)


-- 5/ Declare scalar function (fn_FormatStudentName) for retrieving the Student description for specific StudentID in the following format:
		-- StudentCardNumber without "sc-"
		-- "-"
		-- First character of student FirstName
		-- "."
		-- Student LastName

		CREATE FUNCTION dbo.fn_FormatStudent (@StudentID int)
		RETURNS NVARCHAR(100)
		AS 
		BEGIN 

		DECLARE @Output NVARCHAR(200)
		SELECT @Output = REPLACE(StudentCardNumber,'sc-',' ') + '-' + LEFT(FirstName, 1) + '.' + LastName
		FROM Student WHERE ID = @StudentID 
		RETURN @Output
		END 
		GO

		SELECT *,dbo.fn_FormatStudent(ID) AS FunctionOutput FROM Student