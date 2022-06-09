IF EXISTS ( SELECT * FROM dbo.sysobjects
            WHERE id = OBJECT_ID(N'[dbo].[HourDimension]')
                AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
   DROP TABLE [dbo].[HourDimension];
GO

CREATE TABLE [dbo].[HourDimension]
(
    [Id] INT NOT NULL,
    [TimeStamp] TIME(0) NOT NULL,
    [AmPm] CHAR(2) NOT NULL,
    [DisplayTime] CHAR(11) NOT NULL,
    CONSTRAINT [PK_HourDimension] PRIMARY KEY CLUSTERED ( [Id] )
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_HourDimension_TimeStamp] ON [dbo].[HourDimension] 
(
	[TimeStamp] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
