USE [master]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[Build_db_Library_Management_System]
AS
BEGIN

	/******************************************************
	 * The following prevents any errors from occuring
	 * if the database or tables already exist.
	 * This code will close all active connections to the 
	 * database and then drop it
	 ******************************************************/

	IF EXISTS(select * from sys.databases where name='db_Library_Management_System')
	BEGIN
		DECLARE @SQL varchar(max)
		SELECT @SQL = COALESCE(@SQL,'') + 'Kill ' + Convert(varchar, SPId) + ';'
		FROM MASTER.sys.sysprocesses
		WHERE DBId = DB_ID(N'db_Library_Management_System') AND SPId <> @@SPId
		EXEC(@SQL)
		DROP DATABASE [db_Library_Management_System]
	END

	CREATE DATABASE db_Library_Management_System

END
GO

EXECUTE dbo.Build_db_Library_Management_System

USE [db_Library_Management_System]

	/******************************************************
	 * If our tables already exist, drop and recreate them
	 ******************************************************/

	IF EXISTS (select * from sys.objects where name = 'tbl_Library_Branch')
		DROP TABLE tbl_Library_Branch, tbl_Book_Copies, tbl_Publisher, tbl_Book_Loans, tbl_Books, tbl_Borrower, tbl_Book_Authors;

	/******************************************************
	 * Build our database tables and define ther schema
	 ******************************************************/

	CREATE TABLE tbl_Library_Branch (
		BranchID INT PRIMARY KEY NOT NULL,
		BranchName VARCHAR(50) NOT NULL,
		Address VARCHAR(50) NOT NULL
	);
		CREATE TABLE tbl_Publisher (
		PublisherName VARCHAR(50) PRIMARY KEY NOT NULL,
		Address VARCHAR(50) NOT NULL,
		Phone VARCHAR(50) NOT NULL
	);
		CREATE TABLE tbl_Borrower (
		CardNo INT PRIMARY KEY NOT NULL,
		Name VARCHAR(50) NOT NULL,
		Address VARCHAR(50) NOT NULL,
		Phone VARCHAR(50) NOT NULL
	);
		CREATE TABLE tbl_Books(
		BookID INT PRIMARY KEY NOT NULL,
		Title VARCHAR(50) NOT NULL,
		PublisherName VARCHAR(50) NOT NULL CONSTRAINT fk_PublisherName_Books FOREIGN KEY REFERENCES tbl_Publisher(PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
	);
	CREATE TABLE tbl_Book_Copies (
		BookID INT NOT NULL CONSTRAINT fk_BookID_BookCopies FOREIGN KEY REFERENCES tbl_Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL CONSTRAINT fk_BranchID_BookCopies FOREIGN KEY REFERENCES tbl_Library_Branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		Number_Of_Copies INT NOT NULL
	);
	CREATE TABLE tbl_Book_Loans (
		BookID INT NOT NULL CONSTRAINT fk_BookID_BookLoans FOREIGN KEY REFERENCES tbl_Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL CONSTRAINT fk_BranchID_BookLoans FOREIGN KEY REFERENCES tbl_Library_Branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		CardNo INT NOT NULL CONSTRAINT fk_CardNo_BookLoans FOREIGN KEY REFERENCES tbl_Borrower(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
		DateOut DATE NOT NULL,
		DateDue DATE NOT NULL
	);
	CREATE TABLE tbl_Book_Authors (
		BookID INT NOT NULL CONSTRAINT fk_BookID_BookAuthors FOREIGN KEY REFERENCES tbl_Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		AuthorName VARCHAR(50) NOT NULL
	);

	/******************************************************
	 * Now that the tables are built, we populate them
	 ******************************************************/

	INSERT INTO tbl_Library_Branch
		(BranchID, BranchName, Address)
		VALUES 
		(1, 'Sharpstown','500 Library Lane'),
		(2, 'Central','1200 Library Street'),
		(3, 'Weston','123 Boogie Alley'),
		(4, 'Norwalk','6900 Fort Worth Ave'),
		(5, 'Jax','1430 Main Street')
	;
	SELECT * FROM tbl_Library_Branch;

	INSERT INTO tbl_Publisher
		(PublisherName, Address, Phone)
		VALUES 
		('Penguin Publishing','400 Publishing Street','992-456-8495'),
		('Double Day','666 King Lane','345-323-5534'),
		('Publishing Inc','193 Pub Ave','234-643-3734')
	;
	SELECT * FROM tbl_Publisher;

	INSERT INTO tbl_Borrower
		(CardNo, Name, Address, Phone)
		VALUES 
		(12398074,'Dave Lewis','645 Boring Ave','567-345-3423'),
		(54336457,'Jessica Hayes','392 Trinx Street','245-569-5422'),
		(34573345,'Winston Bishop','2039 Xerath Ave','659-865-9856'),
		(34563356,'Charlie Day','23553 Circle Lane','547-853-5555'),
		(13241345,'Rob Mac','2304 Whyme Street','958-586-5874'),
		(85955795,'Dennis Reynolds','1238 Thisisboring Circle','445-858-5541'),
		(56788955,'Dee Reynolds','85444 Wednesday Road','456-789-1234'),
		(09890890,'Mark Martin','1235 Street Road','659-859-6665'),
		(54678939,'Pria Delray','034885 Milk Way','965-845-2222'),
		(37956797,'Mary Moore','6906 Free Street','456-982-9824')
	;
	SELECT * FROM tbl_Borrower;

	INSERT INTO tbl_Books
		(BookID, Title, PublisherName)
		VALUES 
		(1,'The Lost Tribe','Penguin Publishing'),
		(2, 'The Shining','Double Day'),
		(3, 'IT','Double Day'),
		(4, 'Harry Potter','Publishing Inc'),
		(5, 'How to Code','Penguin Publishing'),
		(6, 'Code ID','Publishing Inc'),
		(7, 'World of Warcraft Tutorial','Penguin Publishing'),
		(8, 'League of Legends Tutorial','Double Day'),
		(9, 'Riot Games Guide','Publishing Inc'),
		(10, 'Hatchet','Double Day'),
		(11, 'Misery','Penguin Publishing'),
		(12, 'C# for Dummies','Penguin Publishing'),
		(13, 'C# Advanced Guide','Penguin Publishing'),
		(14, 'SQL Server for Dummies','Double Day'),
		(15, 'How to Cook','Double Day'),
		(16, 'Cookbook Guide','Publishing Inc'),
		(17, 'Computer Basics Learning','Publishing Inc'),
		(18, 'Tech Academy Novel','Publishing Inc'),
		(19, 'Express Train','Double Day'),
		(20, 'Android Development Step 1','Penguin Publishing')
	;
	SELECT * FROM tbl_Books;

	INSERT INTO tbl_Book_Copies
		(BookID, BranchID, Number_Of_Copies)
		VALUES 
		(1,1,20),
		(2,2,25),
		(3,2,14),
		(4,1,22),
		(5,1,24),
		(6,1,13),
		(7,1,11),
		(13,1,3),
		(14,1,6),
		(15,1,23),
		(12,1,8),
		(11,1,9),
		(10,1,5),
		(4,2,7),
		(5,2,3),
		(6,2,6),
		(7,2,5),
		(13,2,6),
		(16,2,6),
		(17,2,45),
		(18,2,33),
		(19,2,36),
		(20,2,37),
		(14,3,3),
		(15,3,7),
		(16,3,9),
		(17,3,7),
		(13,3,4),
		(11,3,6),
		(9,3,57),
		(8,3,57),
		(7,3,4),
		(6,3,5),
		(4,4,8),
		(5,4,8),
		(6,4,22),
		(7,4,15),
		(13,4,8),
		(14,4,15),
		(15,4,14),
		(12,4,13),
		(18,4,12),
		(10,4,12),
		(1,5,11),
		(2,5,10),
		(3,5,10),
		(6,5,9),
		(7,5,22),
		(8,5,33),
		(9,5,5),
		(12,5,7),
		(11,5,9),
		(20,5,5)
	;
	SELECT * FROM tbl_Book_Copies;

	INSERT INTO tbl_Book_Loans
		(BookID, BranchID, CardNo, DateOut, DateDue)
		VALUES 
		(1,1,85955795,'20170907','20181224'),
		(2,1,85955795,'20170907','20181224'),
		(3,1,85955795,'20170907','20181224'),
		(4,1,85955795,'20170907','20181224'),
		(5,1,85955795,'20170907','20181224'),
		(7,1,85955795,'20170907','20181224'),
		(9,1,85955795,'20170907','20181224'),
		(1,2,54678939,'20170709','20181224'),
		(2,2,54678939,'20170709','20170822'),
		(3,2,54678939,'20170709','20170822'),
		(4,2,54678939,'20170709','20170822'),
		(5,2,54678939,'20170709','20170822'),
		(6,2,54678939,'20170709','20170822'),
		(7,2,54678939,'20170709','20170822'),
		(8,2,54678939,'20170709','20170822'),
		(11,1,12398074,'20170907','20170907'),
		(12,1,12398074,'20170907','20181224'),
		(13,2,12398074,'20170907','20181224'),
		(14,3,12398074,'20170907','20181224'),
		(15,4,12398074,'20170907','20181224'),
		(17,5,12398074,'20170907','20181224'),
		(19,1,12398074,'20170907','20181224'),
		(1,2,12398074,'20170709','20181224'),
		(2,1,12398074,'20170709','20170822'),
		(3,2,12398074,'20170709','20181224'),
		(4,2,12398074,'20170709','20181224'),
		(5,5,54336457,'20170709','20181224'),
		(6,5,54336457,'20170709','20170822'),
		(7,3,54336457,'20170709','20181224'),
		(8,1,54336457,'20170709','20170822'),
		(1,1,54336457,'20170907','20170907'),
		(2,2,54336457,'20170907','20170907'),
		(3,2,34573345,'20170907','20170907'),
		(14,1,34573345,'20170907','20170907'),
		(5,1,34573345,'20170907','20170907'),
		(7,2,34573345,'20170907','20170907'),
		(9,1,34573345,'20170907','20170907'),
		(1,2,34573345,'20170709','20170822'),
		(12,1,34573345,'20170709','20170822'),
		(3,1,34573345,'20170709','20181224'),
		(14,1,34573345,'20170709','20170822'),
		(5,2,34573345,'20170709','20181224'),
		(6,1,34573345,'20170709','20170822'),
		(7,3,34563356,'20170709','20170822'),
		(8,2,34563356,'20170709','20170822'),
		(1,1,34563356,'20170907','20181224'),
		(2,1,34563356,'20170907','20181224'),
		(3,3,34563356,'20170907','20181224'),
		(4,4,34563356,'20170907','20170907'),
		(5,5,34563356,'20170907','20170907'),
		(7,1,34563356,'20170907','20181224'),
		(19,1,34563356,'20170907','20181224'),
		(11,5,34563356,'20170709','20170822'),
		(20,1,34563356,'20170709','20170822'),
		(3,4,34563356,'20170709','20170822'),
		(4,1,13241345,'20170709','20170822'),
		(5,2,13241345,'20170709','20170822'),
		(6,1,13241345,'20170709','20170822'),
		(7,3,13241345,'20170709','20170822'),
		(8,1,13241345,'20170709','20170822'),
		(11,2,13241345,'20170907','20170907'),
		(12,4,13241345,'20170907','20170907'),
		(13,1,13241345,'20170907','20181224'),
		(4,1,13241345,'20170907','20181224'),
		(5,3,13241345,'20170907','20181224'),
		(7,2,13241345,'20170907','20181224'),
		(9,5,13241345,'20170907','20181224'),
		(1,1,56788955,'20170709','20170822'),
		(2,3,56788955,'20170709','20170822'),
		(3,3,56788955,'20170709','20170822'),
		(4,1,56788955,'20170709','20170822'),
		(5,3,56788955,'20170709','20170822'),
		(6,3,56788955,'20170709','20170822'),
		(7,2,56788955,'20170709','20170822'),
		(18,1,56788955,'20170709','20170822'),
		(1,1,56788955,'20170907','20170907'),
		(2,2,56788955,'20170907','20170907'),
		(3,1,56788955,'20170907','20170907'),
		(4,3,56788955,'20170907','20170907'),
		(5,5,56788955,'20170907','20181224'),
		(17,5,56788955,'20170907','20181224'),
		(19,1,56788955,'20170907','20170907'),
		(1,1,56788955,'20170709','20170822'),
		(20,5,56788955,'20170709','20170822'),
		(3,5,56788955,'20170709','20170822'),
		(4,1,56788955,'20170709','20170822'),
		(5,2,56788955,'20170709','20170822'),
		(6,3,09890890,'20170709','20170822'),
		(7,4,09890890,'20170709','20181204'),
		(18,1,09890890,'20170709','20181204'),
		(11,4,09890890,'20170907','20181224'),
		(12,1,09890890,'20170907','20170907'),
		(3,4,09890890,'20170907','20181224'),
		(4,1,09890890,'20170907','20181204'),
		(5,4,09890890,'20170907','20170907'),
		(17,2,09890890,'20170907','20170907'),
		(19,2,09890890,'20170907','20181204'),
		(1,4,09890890,'20170709','20170822'),
		(20,3,09890890,'20170709','20181224'),
		(13,4,09890890,'20170709','20170822'),
		(4,2,37956797,'20170709','20181224'),
		(15,1,37956797,'20170709','20181224'),
		(16,5,37956797,'20170709','20170822'),
		(17,5,37956797,'20170709','20181224'),
		(8,1,37956797,'20170709','20181204')
	;
	SELECT * FROM tbl_Book_Loans;

	INSERT INTO tbl_Book_Authors
		(BookID, AuthorName)
		VALUES 
		(1,'Mark Hamlin'),
		(2,'Stephen King'),
		(3,'Stephen King'),
		(4,'Mike Myers'),
		(5,'Michael Scott'),
		(6,'Pam Beesley'),
		(7,'Jim Halpert'),
		(8,'Ryan Howard'),
		(9,'Karen Fillapelli'),
		(10,'Stanley Hudson'),
		(11,'Kevin Malone'),
		(12,'Angela Martin'),
		(13,'Pam Beesley'),
		(14,'Jim Halpert'),
		(15,'Ryan Howard'),
		(16,'Karen Fillapelli'),
		(17,'Stanley Hudson'),
		(18,'Kevin Malone'),
		(19,'Angela Martin'),
		(20,'Angela Martin')
	;
	SELECT * FROM tbl_Book_Authors;
	
USE [db_Library_Management_System]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE dbo.uspGetLostTribeCopySharpstown
	AS
		SELECT B.Title,  A.Number_Of_Copies, C.BranchName
		FROM tbl_Book_Copies A
		INNER JOIN tbl_Books B ON A.BookID = B.BookID
		INNER JOIN tbl_Library_Branch C ON A.BranchID = C.BranchID
		WHERE C.BranchName = 'Sharpstown' and B.Title = 'The Lost Tribe'
	GO
	EXEC dbo.uspGetLostTribeCopySharpstown

USE [db_Library_Management_System]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE dbo.uspGetLostTribeCopyCount
	AS
		SELECT C.BranchName, B.Title,  A.Number_Of_Copies
		FROM tbl_Book_Copies A
		INNER JOIN tbl_Books B ON A.BookID = B.BookID
		INNER JOIN tbl_Library_Branch C ON A.BranchID = C.BranchID
		WHERE B.Title = 'The Lost Tribe'
	GO
	EXEC dbo.uspGetLostTribeCopyCount

USE [db_Library_Management_System]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE dbo.uspGetBorrowerNoBooks
	AS
		SELECT A.*
		FROM tbl_Borrower A
		WHERE A.CardNo NOT IN (SELECT A.CardNo 
		FROM tbl_Book_Loans A 
		INNER JOIN tbl_Borrower B ON A.CardNo = B.CardNo
		WHERE A.DateDue > GETDATE())
	GO
	EXEC dbo.uspGetBorrowerNoBooks

USE [db_Library_Management_System]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE dbo.uspGetSharpstownDueDate
	AS
		SELECT C.Title, D.Name, D.Address
		FROM tbl_Library_Branch A
		INNER JOIN tbl_Book_Loans B ON A.BranchID = B.BranchID
		INNER JOIN tbl_Books C ON B.BookID = C.BookID
		INNER JOIN tbl_Borrower D ON B.CardNo = D.CardNo
		WHERE A.BranchName = 'Sharpstown' AND B.DateDue = GETDATE()
	GO
	EXEC dbo.uspGetSharpstownDueDate

USE [db_Library_Management_System]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE dbo.uspGetBranchBookTotalLoaned
	AS
		SELECT A.BranchName, COUNT(B.BookID) as "Current_Books_Loaned"
		FROM tbl_Library_Branch A
		INNER JOIN tbl_Book_Loans B ON A.BranchID = B.BranchID
		GROUP BY A.BranchName
	GO
	EXEC dbo.uspGetBranchBookTotalLoaned

USE [db_Library_Management_System]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE dbo.uspGetPersonBookLoanedGreater5
	AS
		SELECT A.Name, A.Address, B.Total_Checked_Out
		FROM tbl_Borrower A
		INNER JOIN (SELECT A.CardNo, COUNT(A.CardNo) as "Total_Checked_Out"
		FROM tbl_Book_Loans A
		GROUP BY A.CardNo
		HAVING COUNT(A.CardNo) > 5) B ON A.CardNo = B.CardNo	
	GO
	EXEC dbo.uspGetPersonBookLoanedGreater5

USE [db_Library_Management_System]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE dbo.uspGetStephenKingBooks
	AS
		SELECT B.Title, C.Number_Of_Copies
		FROM tbl_Book_Authors A
		INNER JOIN tbl_Books B ON A.BookID = B.BookID
		INNER JOIN tbl_Book_Copies C ON A.BookID = C.BookID
		INNER JOIN tbl_Library_Branch D ON C.BranchID = D.BranchID
		WHERE A.AuthorName = 'Stephen King' AND D.BranchName = 'Central'
	GO
	EXEC dbo.uspGetStephenKingBooks