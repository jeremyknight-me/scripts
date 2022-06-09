SET NOCOUNT ON; -- turn off all the 1 row inserted messages

DECLARE @time DATETIME;
DECLARE @hour CHAR(2);
DECLARE @minute CHAR(2);
DECLARE @second CHAR(2);
DECLARE @amPm CHAR(2);

SET @time = CONVERT(VARCHAR,'12:00:00 AM',108);

WHILE @time <= '11:59:59 PM'
BEGIN

    SET @hour = 
        CASE
            WHEN DATEPART(HOUR, @time) > 12 THEN DATEPART(HOUR, @time) - 12
            ELSE DATEPART(HOUR, @time)
        END;
    SET @hour = RIGHT('00' + RTRIM(@hour), 2);
    
    SET @minute = RIGHT('00' + RTRIM(CAST(DATEPART(MINUTE, @time) AS CHAR(2))), 2);
    
    SET @second = RIGHT('00' + RTRIM(CAST(DATEPART(SECOND, @time) AS CHAR(2))), 2);
    
    SET @amPm = 
        CASE
            WHEN DATEPART(HOUR, @time) >= 12 THEN 'PM'
            ELSE 'AM'
        END;

    INSERT INTO [dbo].[TimeDimension]
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
		--Convert(int,CAST(YEAR(@dateCounter) AS CHAR(4)) 
  --      + RIGHT('00' + RTRIM(CAST(DATEPART(mm, @dateCounter) AS CHAR(2))), 2)), 
		CONVERT(int,
			CONVERT(CHAR(2), RIGHT('00' + RTRIM(CAST(SUBSTRING(CONVERT(VARCHAR, @time, 108), 1, 2) AS INT)), 2))
			+ CONVERT(CHAR(2), RIGHT('00' + RTRIM(@minute), 2))
			+ CONVERT(CHAR(2), RIGHT('00' + RTRIM(@second), 2))
		),
        CAST(@time AS TIME), -- TimeStamp
        @hour, 
        CAST(SUBSTRING(CONVERT(VARCHAR, @time, 108), 1, 2) AS INT), -- MilitaryHour
        @minute,
        @second,
        @amPm,
        CASE
            WHEN @hour = '00' THEN '12' + ':' + @minute + ':' + @second + ' ' + @amPm
            ELSE @hour + ':' + @minute + ':' + @second + ' ' + @amPm
        END -- DisplayTime
    );
    
    SELECT @time = DATEADD(second,1,@time);
END

SET NOCOUNT OFF; -- turn the annoying messages back on
