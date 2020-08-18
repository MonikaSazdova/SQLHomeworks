-- Homework 3

-- 1/ Calculate the count of all grades in the system
SELECT COUNT(*) FROM Grade GO
-- 2/ Calculate the count of all grades per Teacher in the system
SELECT COUNT(*) FROM Grade GROUP BY TeacherID GO
-- 3/ Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
SELECT COUNT(*) FROM Grade WHERE StudentID < 100 GROUP BY TeacherID GO
-- 4/ Find the Maximal Grade, and the Average Grade per Student on all grades in the system
SELECT MAX(Grade) AS MaxGrade FROM dbo.[Grade] GROUP BY StudentID GO
SELECT AVG(Grade) AS MaxGrade FROM dbo.[Grade] GROUP BY StudentID GO
-- 5/ Calculate the count of all grades per Teacher in the system and filter only grade count grater then 200
SELECT COUNT(*) AS GradeCount FROM dbo.[Grade] GROUP BY TeacherID HAVING COUNT(*) > 200 GO
-- 6/ Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100) and filter teachers with more then 50 Grade count
SELECT COUNT(*) AS GradeCount FROM dbo.[Grade] WHERE StudentID < 100 GROUP BY TeacherID HAVING COUNT(*) > 50 GO
-- 7/ Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system Filter only records where Maximal Grade is equal to Average Grade
SELECT COUNT(*) GradeCount, MAX(Grade) AS MaxGrade, AVG(Grade) AS AvgGrade
FROM dbo.[Grade] 
GROUP BY StudentID 
HAVING MAX(Grade) = AVG(Grade)
GO
-- 8/ List Student First Name and Last Name next to the other details from previous query
SELECT COUNT(*) GradeCount, MAX(Grade) AS MaxGrade, AVG(Grade) AS AvgGrade FROM dbo.[Grade] g
INNER JOIN dbo.Student s ON g.StudentID = s.FirstName + s.LastName 
GROUP BY StudentID 
HAVING MAX(Grade) = AVG(Grade)
GO
-- ERROR Conversion failed when converting the nvarchar value 'BogdanAtanasov' to data type int.

-- 9/ Create new view (vv_StudentGrades) that will List all Student Ids and count of Grades per student
CREATE VIEW vv_StudentGrades
AS 
SELECT COUNT(*) GradeCount FROM dbo.[Grade] GROUP BY StudentID
GO

SELECT * FROM vv_StudentGrades
GO
-- ERROR Conversion failed when converting the nvarchar value 'BogdanAtanasov' to data type int.

-- 10/ Change the view to show Student First and Lat Names instead of StudentID
ALTER VIEW vv_StudentGrades 
AS 
SELECT s.FirstName as StudentFirstName, s.LastName as StudentLastName FROM dbo.[Grade] g
INNER JOIN dbo.Student s ON g.StudentID = s.FirstName + s.LastName
GO

SELECT * FROM vv_StudentGrades
GO
-- Same ERROR with BogdanAtanasov

-- 11/ List all rows view ordered by biggest Grade Count
-- SELECT * FROM vv_StudentGrades ORDER BY MAX(GradeCount????)

-- 12/ Create new view (vv_StudentGradeDetails) that will List all Students (FirstName and LastName) and COunt the courses he passed through the exam (Ispit)

CREATE VIEW vv_StudentGradeDetails 
AS
SELECT s.FirstName as StudentFirstName, s.LastName as StudentLastName FROM dbo.[Student] s
GO 

SELECT * FROM vv_StudentGradeDetails 
-- count the courses he passed through the exam ?!

