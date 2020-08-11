USE [master]
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'SEDCHome')
	ALTER DATABASE [SEDCHome] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [Master]
GO
DROP DATABASE IF EXISTS [SEDCHome]
GO
CREATE DATABASE [SEDCHome]
GO
USE [SEDCHome]
GO

DROP TABLE IF EXISTS [dbo].[GradeDetails];
DROP TABLE IF EXISTS [dbo].[Grade];
DROP TABLE IF EXISTS [dbo].[AchievementType];
DROP TABLE IF EXISTS [dbo].[Course];
DROP TABLE IF EXISTS [dbo].[Student];
DROP TABLE IF EXISTS [dbo].[Teacher];
GO

CREATE TABLE [dbo].[Teacher]
(
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[AcademicRank] [nvarchar](50) NOT NULL,
	[HireDate] [date] NOT NULL,
	CONSTRAINT [PK_Teacher] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)
)
GO

CREATE TABLE [dbo].[Student]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[EnrolledDate] [date] NOT NULL,
	[Gender] [char](1) NOT NULL,
	[NationalIDNumber] [nvarchar](50) NOT NULL,
	[StudentCardNumber] [nvarchar](50) NOT NULL,
	CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)
)
GO

CREATE TABLE [dbo].[Course]
(
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Credit] [tinyint] NOT NULL,
	[AcademicYear] [tinyint] NOT NULL,
	[Semester] [tinyint] NOT NULL,
	CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)
)
GO

CREATE TABLE [dbo].[AchievementType]
(
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[ParticipationRate] [tinyint] NOT NULL,
	CONSTRAINT [PK_AchievementType] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)
)
GO

CREATE TABLE [dbo].[Grade]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StudentID] [int] NOT NULL,
	[CourseID] [smallint] NOT NULL,
	[TeacherID] [smallint] NOT NULL,
	[Grade] [tinyint] NOT NULL,
	[Comment] [nvarchar](100) NULL,
	[CreatedDate] [datetime] NOT NULL,
	CONSTRAINT [PK_Grade] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)
)
GO

CREATE TABLE [dbo].[GradeDetails]
(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GradeID] [int] NOT NULL,
	[AchievementTypeID] [tinyint] NOT NULL,
	[AchievementPoints] [tinyint] NOT NULL,
	[AchievementMaxPoints] [tinyint] NOT NULL,
	[AchievementDate] [datetime] NOT NULL,
	CONSTRAINT [PK_GradeDetails] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)
)
GO

-- Homework requirements
SELECT * FROM Student WHERE FirstName  = 'Antonio'
SELECT * FROM Student WHERE DateOfBirth > '01.01.1999'
SELECT * FROM Student WHERE Gender = 'M'
SELECT * FROM Student WHERE LastName LIKE 'T%'
SELECT * FROM Student WHERE EnrolledDate BETWEEN '19980101'AND '19980131'

-- Not sure if it does not work or if there are no students that have those requirements
SELECT * FROM Student WHERE EnrolledDate BETWEEN '19980101' AND '19980131' AND LastName LIKE 'J%'

SELECT * FROM Student WHERE FirstName  = 'Antonio' ORDER BY FirstName ASC
SELECT * FROM Student ORDER BY FirstName ASC
SELECT * FROM Student WHERE Gender = 'M' ORDER BY EnrolledDate DESC


--Duplicates
--with duplicates
SELECT FirstName FROM Teacher UNION ALL SELECT FirstName FROM Student 
--without duplicates
SELECT FirstName FROM Teacher UNION SELECT FirstName FROM Student 
--common
SELECT FirstName FROM Teacher INTERSECT SELECT FirstName FROM Student 


--Default 
ALTER TABLE GradeDetails 
ADD CONSTRAINT DF_Grade_Value
DEFAULT 100 FOR AchievementMaxPoints
GO

-- Check
ALTER TABLE [dbo].[GradeDetails] WITH CHECK
ADD CONSTRAINT CHK_Grade_Value
CHECK (AchievementPoints >= AchievementMaxPoints);
GO

--Unique
ALTER TABLE [dbo].[AchievementType] WITH CHECK
ADD CONSTRAINT UC_Name UNIQUE (Name)
GO

--Create Foreign Key constraints from diagram or with scripts 

-- Requirement 6/6














