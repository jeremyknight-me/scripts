IF EXISTS ( SELECT * FROM dbo.sysobjects
            WHERE id = OBJECT_ID(N'[dbo].[MonthDimension]')
                AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
   DROP TABLE [dbo].MonthDimension;
GO

CREATE TABLE [dbo].MonthDimension
( 
    [Id] INT NOT NULL, 
    [MonthName] VARCHAR(10) NOT NULL,
    [CalendarQuarter] TINYINT NOT NULL, 
    CONSTRAINT [PK_MonthDimension] PRIMARY KEY CLUSTERED ( [Id] )
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_MonthDimension_CalendarQuarter] ON [dbo].MonthDimension 
(
	[CalendarQuarter] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
