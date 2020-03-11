
-- Add ar998_Date_Last_Update and ar998_Total_Games_Played to People table

	ALTER TABLE People 
	ADD ar998_Date_Last_Update DATE DEFAULT NULL,
		ar998_Total_Games_Played INT DEFAULT NULL

-- Declare Variables

	GO
	
	DECLARE		@today DATE
	SET			@today = convert(DATE, getdate())

	DECLARE		@ar998_Total_Games_Played INT,
				@PlayerID VARCHAR(50)

	DECLARE updatecursor CURSOR STATIC FOR
        SELECT Appearances.playerID, SUM (G_all) AS ar998_Total_Games_Played
        FROM People, Appearances
		WHERE People.playerID = Appearances.playerid and 
	   (ar998_Date_Last_Update <> @today or ar998_Date_Last_Update is Null)
		GROUP BY Appearances.playerID

-- Open Cursor

    OPEN updatecursor

	Select @@CURSOR_ROWS as 'Number of Cursor Rows After Declare'

    FETCH NEXT FROM updatecursor INTO @PLayerid, @ar998_Total_Games_Played
    WHILE @@fetch_status = 0 

    BEGIN

	UPDATE People 
	SET ar998_Date_Last_Update = @today
	WHERE @PlayerID = playerID

	UPDATE People
	SET ar998_Total_Games_Played = @ar998_Total_Games_Played
	WHERE @PlayerID = playerID
			
	FETCH NEXT FROM updatecursor INTO @PLayerid, @ar998_Total_Games_Played
	END

	CLOSE updatecursor
	DEALLOCATE updatecursor