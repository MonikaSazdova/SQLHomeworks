-- Create multi-statement table value function that for specific Teacher and Course
-- will return list of students (First Name, Last Name) who passed the exam, together with Grade and CreatedDate

DROP FUNCTION IF EXISTS dbo.fn_WhoPassedTheExam
GO

CREATE FUNCTION dbo.fn_WhoPassedTheExam (@TeacherID int, @CourseID int)
RETURNS @output TABLE (FirstName nvarchar(100), LastName nvarchar(100), Grade int, CreatedDate date)
AS 
BEGIN


INSERT INTO @output
SELECT s.FirstName AS FirstName, s.LastName AS LastName, g.Grade AS Grade, g.CreatedDate as CreatedDate
FROM dbo.[Student] s
INNER JOIN dbo.Grade g ON s.ID = g.StudentID
INNER JOIN dbo.Course c ON c.ID = g.CourseID
WHERE g.TeacherID = @TeacherID AND g.CourseID = @CourseID
RETURN
END
GO 

DECLARE @TeacherID int = 1
DECLARE @CourseID int = 1
SELECT * FROM dbo.fn_WhoPassedTheExam (@TeacherID, @CourseID) 