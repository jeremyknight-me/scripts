IF EXISTS ( SELECT * FROM dbo.sysobjects
            WHERE id = OBJECT_ID(N'[dbo].[DateDimension]')
                AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
   DROP TABLE [dbo].[DateDimension];
GO

CREATE TABLE [dbo].[DateDimension]
( 
    [Id] INT NOT NULL, 
    [DateStamp] DATE NOT NULL, 
    [DateName] CHAR(11) NOT NULL, 
    [DateNameUS] CHAR(11) NOT NULL,   --US Date Format: MM/DD/YYYY
    [DateNameEU] CHAR(11) NOT NULL,   --European Union Date Format: DD/MM/YYYY
    [DayOfWeek] TINYINT NOT NULL, 
    [DayNameOfWeek] VARCHAR(10) NOT NULL, 
    [DayOfMonth] TINYINT NOT NULL, 
    [DayOfYear] SMALLINT NOT NULL, 
    [IsWeekday] BIT NOT NULL, 
    [WeekOfYear] TINYINT NOT NULL, 
    [MonthName] VARCHAR(10) NOT NULL, 
    [MonthOfYear] TINYINT NOT NULL, 
    [IsLastDayOfMonth] BIT NOT NULL, 
    [CalendarQuarter] TINYINT NOT NULL, 
    [CalendarYear] SMALLINT NOT NULL, 
    [CalendarYearMonth] CHAR(7) NOT NULL, 
    [CalendarYearQtr] CHAR(6) NOT NULL, 
    [FiscalMonthOfYear] TINYINT NOT NULL, 
    [FiscalQuarter] TINYINT NOT NULL, 
    [FiscalYear] SMALLINT NOT NULL, 
    [FiscalYearMonth] CHAR(7) NOT NULL, 
    [FiscalYearQtr] CHAR(6) NOT NULL, 
    CONSTRAINT [PK_DateDimension] PRIMARY KEY CLUSTERED ( [Id] )
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_DateDimension_DateStamp] ON [dbo].[DateDimension] 
(
	[DateStamp] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/* NOTE: Add additional indexes per your use cases
CREATE NONCLUSTERED INDEX [IX_DateDimension_DayOfWeek] ON [dbo].[DateDimension] 
(
	[DayOfWeek] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_DateDimension_MonthOfYear] ON [dbo].[DateDimension] 
(
	[MonthOfYear] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_DateDimension_CalendarQuarter] ON [dbo].[DateDimension] 
(
	[CalendarQuarter] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
*/