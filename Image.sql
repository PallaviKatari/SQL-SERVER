use dml;
--Insert Images into SQL Server
CREATE TABLE SaveFiles
(
    FileID INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(50) NOT NULL,
    Files VARBINARY(MAX) NOT NULL
)

INSERT INTO [dbo].[SaveFiles] (Name, Files)
SELECT 'Home Page 1', 
	BulkColumn FROM OPENROWSET(BULK N'E:\G2Pallavi\G2\oip.jfif', SINGLE_BLOB) image;

	select * from SaveFiles