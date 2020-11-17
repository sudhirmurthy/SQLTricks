# SQLTricks
Pivot and UnPivot Data

/************************************************
Author	 : Sudhir Murthy (c) www.sudhirmurthy.blogspot.com
Desc	   : Data Pivoting Techniques in SQL Server.
Date    : June-14-2009.
*************************************************/

- [Declare the table variable = @TblOrderDetails]

DECLARE @TblOrderDetails TABLE(
	Id				INT NOT NULL PRIMARY KEY, --1
	UniqueOrderKey	UNIQUEIDENTIFIER DEFAULT(NEWSEQUENTIALID()), --2,3
	Employee		NVARCHAR(50) NOT NULL,
	ProductId		INT NOT NULL,
	Sales			DECIMAL(8,3)		
)

- [NOTE:]
  - 1. I've used an integer datatype to build the default index on the PK.
  - 2. Uniqueidentifier type for true uniqueness(useful for replication scenarios)
  - 3. You can use newid() or newsequentialid() for creating a new unique identifiers.
   For performance reasons, newsequentialid() is preferred.

Please refer to the Pivot&UnpivotExample.sql file for more details
	
