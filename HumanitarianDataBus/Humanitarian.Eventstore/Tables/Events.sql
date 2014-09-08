CREATE TABLE [dbo].[Events]
(
	[Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY, 
    [EventEnvelopeXml] XML NULL, 
    [EventPropertyXml] XML NULL, 
    [LastModifiedDateTime] DATETIME NULL, 
    [LastModifiedUser] VARCHAR(64) NULL
)

GO

