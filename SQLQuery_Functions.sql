
--- FUNCTIONS

-- Question 1 

	CREATE FUNCTION FullName (@playerID VARCHAR(255))
	RETURNS VARCHAR (255)
	AS
	BEGIN 
	DECLARE @fullname VARCHAR (255)
	SET @fullname = (SELECT (nameGiven + ' (' + nameFirst + ') ' + nameLast) AS [Full Name]
				FROM People
				WHERE People.playerID = @playerID)
	RETURN @fullname
	END


	SELECT A.teamID, People.playerid, [dbo].[FullName](People.playerID) AS [Full Name], [Total Hits], [Total At Bats], [Batting Avg],
	RANK() OVER (PARTITION BY A.teamID ORDER BY [Batting Avg] DESC) AS Team_Batting_rank,
	RANK() OVER (ORDER BY [Batting Avg] DESC) AS All_Batting_rank  
	FROM People,
	(SELECT playerID, teamID, SUM(H) AS [Total Hits], SUM(AB) AS [Total At Bats], (CONVERT(DECIMAL(5,4),SUM(H)*1.0/SUM(AB))) AS [Batting Avg]
	 FROM Batting
	 GROUP BY teamID, playerID
	 HAVING SUM(AB)>0 and SUM(H)>=150) A
	WHERE People.playerID = A.playerID
	ORDER BY A.teamID, Team_Batting_rank