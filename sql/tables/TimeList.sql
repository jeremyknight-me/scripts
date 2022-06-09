/* --- CREATE TABLE -------------------- */

IF EXISTS ( SELECT * FROM dbo.sysobjects
            WHERE id = OBJECT_ID(N'[dbo].[TimeList]')
                AND OBJECTPROPERTY(id, N'IsUserTable') = 1 )
   DROP TABLE [dbo].[TimeList];
GO

CREATE TABLE [dbo].[TimeList](
	[Id] [int] NOT NULL,
	[Timestamp] [time](0) NOT NULL,
	[Hour] [tinyint] NOT NULL,
	[MilitaryHour] [tinyint] NOT NULL,
	[Minute] [tinyint] NOT NULL,
	[Second] [tinyint] NOT NULL,
	[AmPm] [char](2) NOT NULL,
	[DisplayTime] [char](11) NOT NULL,
 CONSTRAINT [PK_TimeList] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/* --- LOAD TABLE -------------------- */

SET NOCOUNT ON; -- turn off row inserted messages

DECLARE @time TIME = '12:00:00 AM';
WHILE @time <= '11:59:59 PM'
BEGIN
    DECLARE @militaryHour TINYINT = DATEPART(HOUR, @time);
    DECLARE @hour TINYINT = 
        CASE
            WHEN @militaryHour > 12 THEN @militaryHour - 12
            ELSE @militaryHour
        END;
    DECLARE @minute TINYINT = DATEPART(MINUTE, @time);
    DECLARE @second TINYINT = DATEPART(SECOND, @time);
    DECLARE @amPm CHAR(2) =
        CASE
            WHEN DATEPART(HOUR, @time) >= 12 THEN 'PM'
            ELSE 'AM'
        END;

    DECLARE @charMinute CHAR(2) = RIGHT('00' + CONVERT(VARCHAR, @minute), 2);
    DECLARE @charSecond CHAR(2) = RIGHT('00' + CONVERT(VARCHAR, @second), 2);

    INSERT INTO dbo.TimeList
    (
        [Id],
        [TimeStamp], 
        [Hour], 
        [MilitaryHour], 
        [Minute], 
        [Second], 
        [AmPm],
        [DisplayTime]
    )
    VALUES
    ( 
		CONVERT(int,
			CONVERT(CHAR(2), RIGHT('00' + RTRIM(CAST(SUBSTRING(CONVERT(VARCHAR, @time, 108), 1, 2) AS INT)), 2))
			+ CONVERT(CHAR(2), @charMinute)
			+ CONVERT(CHAR(2), @charSecond)
		), -- Id (hhmmss where hh is military hour)
        CAST(@time AS TIME), -- TimeStamp
        @hour, 
        @militaryHour,
        @minute,
        @second,
        @amPm,
        CASE
            WHEN @hour = 0 THEN '12' 
            ELSE CONVERT(VARCHAR, @hour)
        END + ':' + @charMinute + ':' + @charSecond + ' ' + @amPm -- DisplayTime
    );
    
    IF (@time = '11:59:59 PM')
        BREAK;

    SET @time = DATEADD(second,1,@time);
END

SET NOCOUNT OFF; -- turn messages back on

/* --- CREATE INDEX -------------------- */

CREATE UNIQUE NONCLUSTERED INDEX [IX_TimeList_Timestamp] ON [dbo].[TimeList]
(
	[Timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/* -- Create Additional Indexes based on your use cases
CREATE NONCLUSTERED INDEX [IX_TimeList_MilitaryHour] ON [dbo].[TimeList]
(
	[MilitaryHour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_TimeList_Minute] ON [dbo].[TimeList]
(
	[Minute] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_TimeList_Second] ON [dbo].[TimeList]
(
	[Second] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
*/