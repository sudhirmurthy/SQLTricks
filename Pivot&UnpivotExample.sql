/************************************************
Author	: Sudhir Murthy (c) www.sudhirmurthy.com
Desc	: Data Pivoting Techniques in SQL Server.
Date    : June-14-2009.
*************************************************/

--Declare the table variable = @TblOrderDetails

DECLARE @TblOrderDetails TABLE(
	Id				INT NOT NULL PRIMARY KEY, --1
	UniqueOrderKey	UNIQUEIDENTIFIER DEFAULT(NEWSEQUENTIALID()), --2,3
	Employee		NVARCHAR(50) NOT NULL,
	ProductId		INT NOT NULL,
	Sales			DECIMAL(8,3)		
)

/*NOTE:--------------------------------------------------------------------------
1. I've used an integer datatype to build the default index on the PK.
2. Uniqueidentifier type for true uniqueness(useful for replication scenarios)
3. You can use newid() or newsequentialid() for creating a new unique identifier,
   for performance reasons, newsequentialid() is preferred.
---------------------------------------------------------------------------------*/


--Insert Test Data into @TblOrderDetails

INSERT INTO @TblOrderDetails(Id,Employee,ProductId,Sales)
SELECT 1,'Sudhir.Murthy',5,2000
UNION ALL
SELECT 2,'Tom.Hanks',6,3000
UNION ALL
SELECT 3,'Jim.Griffiths',5,1000
UNION ALL
SELECT 4,'Sue.Steely',7,1000
UNION ALL
SELECT 5,'Sudhir.Murthy',8,2000
UNION ALL
SELECT 6,'James.Martin',5,1000
UNION ALL
SELECT 7,'Paul.Smith',5,1000
UNION ALL
SELECT 8,'Sudhir.Murthy',6,1000
UNION ALL
SELECT 9,'Tom.Hanks',7,2000
UNION ALL
SELECT 10,'Sue.Steely',4,2000
UNION ALL
SELECT 11,'Jim.Griffiths',6,2000
UNION ALL
SELECT 12,'James.Martin',7,5000
UNION ALL
SELECT 13,'Paul.Smith',4,4000
UNION ALL
SELECT 14,'Sue.Steely',3,1000
UNION ALL
SELECT 15,'Tom.Hanks',5,1000
UNION ALL
SELECT 16,'Jim.Griffiths',6,1000
UNION ALL
SELECT 17,'Sudhir.Murthy',3,2000
UNION ALL
SELECT 18,'Tom.Hanks',2,5000
UNION ALL
SELECT 19,'Sue.Steely',2,2000
UNION ALL
SELECT 20,'Sudhir.Murthy',7,1000

--Fetch from @TblOrderDetails
SELECT * FROM @TblOrderDetails

SELECT		Employee,
			COUNT(CASE WHEN ProductId=2 THEN ProductId ELSE 0 END) AS Product2,
			COUNT(CASE WHEN ProductId=3 THEN ProductId ELSE 0 END) AS Product3,
			COUNT(CASE WHEN ProductId=4 THEN ProductId ELSE 0 END) AS Product4,
			COUNT(CASE WHEN ProductId=5 THEN ProductId ELSE 0 END) AS Product5,
			COUNT(CASE WHEN ProductId=6 THEN ProductId ELSE 0 END) AS Product6,
			COUNT(CASE WHEN ProductId=7 THEN ProductId ELSE 0 END) AS Product7,
			COUNT(CASE WHEN ProductId=8 THEN ProductId ELSE 0 END) AS Product8  
FROM		@TblOrderDetails
GROUP BY	Employee


/*
 Query to yeild employees vs all products that they sold.
 */	
SELECT	Employee,
		[2] AS Product2,
		[3]	AS Product3,
		[4] AS Product4,
		[5] AS Product5,
		[6] AS Product6,
		[7] AS Product7,
		[8] AS Product8
FROM	@TblOrderDetails
		PIVOT(
			COUNT(ProductId)
			FOR ProductId IN ([2],[3],[4],[5],[6],[7],[8])			
	   )Pvt


/*
Query to yeild the consolidated employees vs products that
they sold.
*/
SELECT  Employee,
        [2] AS Product2,
        [3] AS Product3,
        [4] AS Product4,
        [5] AS Product5,
        [6] AS Product6,
        [7] AS Product7,
        [8] AS Product8       
FROM  (
        SELECT Employee,ProductId FROM @TblOrderDetails
      ) AS Qry
PIVOT (
        COUNT(ProductId)
        FOR ProductId IN ([2],[3],[4],[5],[6],[7],[8])            
      ) Pvt

/*Declare the table variable = @TblEmployeeProducts
Please Note: The table is only designed this way to 
keep the example simple and straightforward. 
In in ideal world, Products will not be repeated this
way to violate Third & BC Normal Forms.
*/
DECLARE @TblEmployeeProducts TABLE(
	Id				INT NOT NULL PRIMARY KEY, --1
	UniqueOrderKey	UNIQUEIDENTIFIER DEFAULT(NEWSEQUENTIALID()), --2,3
	Employee		NVARCHAR(50) NOT NULL,
	Product2		INT NOT NULL,
	Product3		INT NOT NULL,
	Product4		INT NOT NULL,
	Product5		INT NOT NULL,
	Product6		INT NOT NULL,
	Product7		INT NOT NULL,
	Product8		INT NOT NULL
)

--Insert Test Data into @TblEmployeeProducts

INSERT @TblEmployeeProducts(Id,Employee,Product2,Product3,Product4,Product5,Product6,Product7,Product8) 
SELECT 1,'James.Martin',0,0,0,1,0,1,0
UNION  ALL
SELECT 2,'Jim.Griffiths',0,0,0,1,2,0,0
UNION  ALL
SELECT 3,'Paul.Smith',0,0,1,1,0,0,0
UNION  ALL
SELECT 4,'Sudhir.Murthy',0,1,0,1,1,1,0
UNION  ALL
SELECT 5,'Sue.Steely',1,1,1,0,0,1,0
UNION  ALL
SELECT 6,'Tom.Hanks',1,0,0,1,1,1,0

SELECT	Employee,
		Product2 as Prod2,
		Product3 as Prod3,
		Product4 as Prod4,
		Product5 as Prod5,
		Product6 as Prod6,
		Product7 as Prod7,
		Product8 as Prod8
FROM	@TblEmployeeProducts

/*Query to unpivot the Employee and Products to 
rows of Employee, Products and TotalOrders*/

SELECT Employee,ProductId,TotalOrders
FROM (
		SELECT	Employee,
				Product2,
				Product3,
				Product4,
				Product5,
				Product6,
				Product7,
				Product8
		FROM	@TblEmployeeProducts
)Qry
UNPIVOT (
		TotalOrders FOR ProductId IN(Product2,
									 Product3,
									 Product4,
									 Product5,
									 Product6,
									 Product7,
									 Product8)
)AS UnPvt
	
	