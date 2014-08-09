CREATE TABLE [dbo].[Events]
(
	[Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY, 
    [EventXml] XML NULL, 
    [PropertyXml] XML NULL, 
    [LastModifiedDateTime] DATETIME NULL, 
    [LastModifiedUser] VARCHAR(64) NULL
)

GO

