DECLARE @DelimitedString VARCHAR(100) = 'A,B,CD,E,FGH,KL,MNOP,QRSTU,V,W,XYZ';

-- Prior to SQL Server 2016, this is what typical T-SQL would look like:
DECLARE @Items VARCHAR(100) = @DelimitedString;
DECLARE @Item VARCHAR(50);
DECLARE @Pos INT;
DECLARE @Loop BIT;
SELECT @Loop = CASE WHEN LEN(@Items) > 0 THEN 1 ELSE 0 END;
DECLARE @Values TABLE ( Item VARCHAR(50), Position INT, [Loop] BIT);

WHILE (SELECT @Loop) = 1
BEGIN
    SELECT @Pos = CHARINDEX(',', @Items, 1)
    IF @Pos > 0
    BEGIN
        SELECT @Item = SUBSTRING(@Items, 1, @Pos - 1);
        SELECT @Items = SUBSTRING(@Items, @Pos + 1, LEN(@Items) - @Pos);
    END
    ELSE
    BEGIN
        SELECT @Item = @Items;
        SELECT @Loop = 0;
    END

	INSERT INTO @Values (Item, Position, [Loop]) VALUES (@Item, @Pos, @Loop);
END

SELECT * FROM @Values;

-- After SQL Server 2016:
SELECT * FROM STRING_SPLIT(@DelimitedString, ',');
