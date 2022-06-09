SET NOCOUNT ON; -- turn off all the 1 row inserted messages

DECLARE @time DATETIME;
SET @time = CONVERT(VARCHAR,'12:00:00 AM',108);

WHILE @time <= '11:59:59 PM'
BEGIN
	DECLARE @hour TINYINT = DATEPART(HOUR, @time);
    DECLARE @amPm CHAR(2) = 
        CASE
            WHEN DATEPART(HOUR, @time) >= 12 THEN 'PM'
            ELSE 'AM'
        END;

    INSERT INTO [dbo].[HourDimension]
    (
		[Id],
        [TimeStamp],
        [AmPm],
        [DisplayTime]
    )
    VALUES
    ( 
		@hour,
        CAST(@time AS TIME), -- TimeStamp
        @amPm,
        CASE @hour 
            WHEN 0 THEN '12:00:00 ' + @amPm
            ELSE CONVERT(VARCHAR, @hour) + ':00:00 ' + @amPm
        END -- DisplayTime
    );
    
    SELECT @time = DATEADD(hour,1,@time);
END

SET NOCOUNT OFF; -- turn messages back on
