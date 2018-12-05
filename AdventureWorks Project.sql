USE AdventureWorks2014
GO

DROP PROCEDURE dbo.uspGetAddress

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.uspGetAddress @City nvarchar(30) = NULL, @AddressLine1 nvarchar(60) = NULL
AS
SELECT * 
FROM Person.Address
WHERE City = ISNULL(@City,City)
AND AddressLine1 LIKE '%' + ISNULL(@AddressLine1 ,AddressLine1) + '%'
GO

EXEC dbo.uspGetAddress @City = 'Calgary', @AddressLine1 = 'Ave'


USE AdventureWorks2014
GO

DROP PROCEDURE dbo.uspGetAddressCount

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.uspGetAddressCount @City nvarchar(30), @AddressCount int OUTPUT
AS
SELECT @AddressCount = count(*) 
FROM Person.Address 
WHERE City = @City

DECLARE @AddressCount int
EXEC dbo.uspGetAddressCount @City = 'Calgary', @AddressCount = @AddressCount OUTPUT
SELECT @AddressCount


ALTER PROCEDURE dbo.uspTryCatchTest
AS
BEGIN TRY
    DECLARE @AddressCount int
EXEC dbo.uspGetAddressCount @City = 'Calgary', @AddressCount = @AddressCount OUTPUT
SELECT @AddressCount
END TRY
BEGIN CATCH
    SELECT ERROR_NUMBER() AS ErrorNumber
     ,ERROR_SEVERITY() AS ErrorSeverity
     ,ERROR_STATE() AS ErrorState
     ,ERROR_PROCEDURE() AS ErrorProcedure
     ,ERROR_LINE() AS ErrorLine
     ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH

EXEC dbo.uspTryCatchTest



USE AdventureWorks2014
GO

DROP PROCEDURE dbo.uspGetSalesOrderData

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE dbo.uspGetSalesOrderData @CustomerID int
AS
SELECT A.SalesOrderID, E.BusinessEntityID as "CustomerID", E.FirstName, E.LastName, C.OrderDate, C.ShipDate, A.OrderQty, A.ProductID, A.SpecialOfferID, A.UnitPrice
FROM Sales.SalesOrderDetail A
INNER JOIN Sales.SpecialOfferProduct B ON A.SpecialOfferID = B.SpecialOfferID AND A.ProductID = B.ProductID
INNER JOIN Sales.SalesOrderHeader C ON A.SalesOrderID = C.SalesOrderID
INNER JOIN Sales.Customer D ON C.CustomerID = D.CustomerID
INNER JOIN Person.Person E ON D.PersonID = E.BusinessEntityID
WHERE E.BusinessEntityID = @CustomerID
GO

EXEC dbo.uspGetSalesOrderData @CustomerID = 1045