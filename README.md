# SQLTricks
Pivot and UnPivot Data


-[PIVOT] 
	- The PIVOT relational operator converts data from row level to column level. PIVOT rotates a table-valued expression by turning the unique values from one column in the expression into multiple columns in the output. Using PIVOT operator, we can perform aggregate operation where we need them.
	
-[UNPIVOT]
	- UNPIVOT relational operator is reverse process of PIVOT relational operator. UNPIVOT relational operator convert data from column level to row level.
	
- [Usecases]
Read more about this from this research paper here ![Read More](IND1P2.PDF)

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
	
