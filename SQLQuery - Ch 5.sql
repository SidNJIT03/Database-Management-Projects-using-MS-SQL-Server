
-- Question 1
 
	SELECT playerID, [Full Name], [Career Batting Average], RANK() OVER (ORDER BY [Career Batting Average] DESC) AS BA_rank       
	FROM ar998_Player_History    
	WHERE [Career Batting Average] < 0.40 
	ORDER BY BA_rank

-- Question 2

	SELECT playerID, [Full Name], [Career Batting Average], DENSE_RANK() OVER (ORDER BY [Career Batting Average] DESC) AS BA_rank       
	FROM ar998_Player_History    
	WHERE [Career Batting Average] < 0.40 
	ORDER BY BA_rank

-- Question 3

	SELECT playerID, [Full Name], [Last Played], [Career Batting Average], 
	RANK() OVER (PARTITION BY [Last Played] ORDER BY [Career Batting Average] DESC) AS BA_rank       
	FROM ar998_Player_History    
	WHERE [Career Batting Average] > 0.00 AND [Career Batting Average] < 0.40
	ORDER BY [Last Played] DESC

-- Question 4

	SELECT playerID, [Full Name], [Last Played], [Career Batting Average],
	NTILE(4) OVER (PARTITION BY [Last Played] ORDER BY [Career Batting Average] DESC) AS Ntile	
	FROM ar998_Player_History
	WHERE [Career Batting Average] > 0.00 AND [Career Batting Average] < 0.40
	ORDER BY [Last Played] DESC

-- Question 5

	SELECT A.teamID, A.yearID, Avg_Salary, 
	AVG(Avg_Salary) OVER
	(PARTITION BY A.teamID ORDER BY A.teamID, A.yearID ROWS between 3 PRECEDING and 1 FOLLOWING) as Windowed_Salary
	FROM Salaries,
	(SELECT teamID, yearID, AVG(salary) AS Avg_Salary
	FROM Salaries
	GROUP BY teamID, yearID) A
	WHERE Salaries.teamID = A.teamID 
	and Salaries.yearID = A.yearID
	GROUP BY A.teamID, A.yearID, Avg_Salary
	ORDER BY teamID, yearID

-- Question 6

	SELECT A.teamID, People.playerid, (nameGiven + ' (' + nameFirst + ') ' + nameLast) AS [Full Name], [Total Hits], [Total At Bats], [Batting Avg],
	RANK() OVER (PARTITION BY A.teamID ORDER BY [Batting Avg] DESC) AS Team_Batting_rank,
	RANK() OVER (ORDER BY [Batting Avg] DESC) AS All_Batting_rank  
	FROM People,
	(SELECT playerID, teamID, SUM(H) AS [Total Hits], SUM(AB) AS [Total At Bats], (CONVERT(DECIMAL(5,4),SUM(H)*1.0/SUM(AB))) AS [Batting Avg]
	 FROM Batting
	 GROUP BY teamID, playerID
	 HAVING SUM(AB)>0 and SUM(H)>=150) A
	WHERE People.playerID = A.playerID
	ORDER BY A.teamID, Team_Batting_rank
