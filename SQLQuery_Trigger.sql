
-- Dropping Total_Salary and Average_Salary columns in People table

	ALTER TABLE People
	DROP COLUMN ar998_Total_Salary;

	ALTER TABLE People
	DROP COLUMN ar998_Average_Salary;

-- Adding Total_Salary and Average_Salary columns in People table

	ALTER TABLE People
	ADD ar998_Total_Salary money;	

	ALTER TABLE People
	ADD ar998_Average_Salary money;

-- Calculation of Total_Salary and Average_Salary columns in People table

	UPDATE People
	SET ar998_Total_Salary = Sum_Salary
	FROM People,
	 (SELECT playerID, SUM(salary) AS Sum_Salary
	  FROM Salaries
	  GROUP BY playerID) A
	WHERE People.playerID = A.playerID

	UPDATE People
	SET ar998_Average_Salary = Avg_Salary
	FROM People,
	 (SELECT playerID, AVG(salary) AS Avg_Salary
	  FROM Salaries
	  GROUP BY playerID) B
	WHERE People.playerID = B.playerID

-- Dropping Trigger
	IF EXISTS (
    SELECT *
    FROM sys.objects
    WHERE [type] = 'TR' AND [name] = 'Salary_Trigger'
    )
	DROP TRIGGER Salary_Trigger
	GO
-- Creating Trigger in Salaries Table

	CREATE TRIGGER Salary_Trigger
	ON Salaries AFTER INSERT, UPDATE, DELETE
	AS

	BEGIN

-- Updating Total_Salary & Average_Salary of People Table

	IF EXISTS (SELECT * FROM Inserted) AND EXISTS (SELECT * FROM Deleted)
	
	-- Total Salary Update
	BEGIN 
	UPDATE People
	SET ar998_Total_Salary = (ar998_Total_Salary + Inserted.salary - Deleted.salary)
	FROM Inserted, Deleted
	WHERE People.playerID = Inserted.playerID AND People.playerID = Deleted.playerID
	END 

	-- Average Salary Update
	BEGIN
	UPDATE People
	SET ar998_Average_Salary = A.Average_Salary
	FROM 
	(SELECT Salaries.playerID, AVG(Salaries.salary) AS Average_Salary
	 FROM Salaries, inserted, deleted
	 WHERE Salaries.playerID = inserted.playerID AND Salaries.playerID = deleted.playerID
	 GROUP BY Salaries.playerID) A
	 WHERE A.playerID = People.playerID
	END

-- Inserting Total_Salary & Average_Salary in People Table

	IF EXISTS (SELECT * FROM Inserted) AND NOT EXISTS (SELECT * FROM Deleted)
	
    -- Total Salary Insert	
	BEGIN 
	UPDATE People
	SET ar998_Total_Salary = (ar998_Total_Salary + Inserted.salary)
	FROM Inserted
	WHERE People.playerID = Inserted.playerID  
	END

	-- Average salary Insert
	BEGIN
	UPDATE People
	SET ar998_Average_Salary = A.Average_Salary
	FROM 
	(SELECT Salaries.playerID, AVG(Salaries.salary) AS Average_Salary
	 FROM Salaries, inserted
	 WHERE Salaries.playerID = inserted.playerID
	 GROUP BY Salaries.playerID) A
	 WHERE A.playerID = People.playerID
	END

-- Deleting Total_Salary & Average_Salary from People Table

	IF NOT EXISTS (SELECT * FROM Inserted) AND EXISTS (SELECT * FROM Deleted)

	-- Total Salary Delete	
	BEGIN
	UPDATE People
	SET ar998_Total_Salary = (ar998_Total_Salary - Deleted.salary)
	FROM Deleted
	WHERE People.playerID = Deleted.playerID 
	END 

	-- Average Salary Delete	
	BEGIN
	UPDATE People
	SET ar998_Average_Salary = A.Average_Salary
	FROM 
	(SELECT Salaries.playerID, AVG(Salaries.salary) AS Average_Salary
	 FROM Salaries, deleted
	 WHERE Salaries.playerID = deleted.playerID
	 GROUP BY Salaries.playerID) A
	 WHERE A.playerID = People.playerID
	END

	END

-- Testing The insert trigger
	
	-- For Total_Salary & Average_Salary

	BEGIN TRANSACTION

	SELECT * FROM Salaries WHERE playerID = 'barkele01'

	INSERT INTO Salaries VALUES ('1985', 'ATL', 'NL', 'barkele01', '500', NULL, NULL)

	SELECT * FROM Salaries WHERE playerID = 'barkele01'

	SELECT SUM(salary), AVG(salary) 
	FROM Salaries
	WHERE playerID = 'barkele01'

	SELECT * FROM People WHERE playerID = 'barkele01'

	ROLLBACK
	
-- Testing The update trigger
	
	-- For Total_Salary & Average_Salary

	BEGIN TRANSACTION

	SELECT * FROM Salaries WHERE playerID = 'barkele01'

	UPDATE Salaries 
	SET salary = '1000' 
	WHERE  yearID = '1985' AND  teamID = 'ATL' AND lgID = 'NL' AND playerID = 'barkele01' AND salary = '500.00'

	SELECT * FROM Salaries WHERE playerID = 'barkele01'

	SELECT SUM(salary), AVG(salary) 
	FROM Salaries
	WHERE playerID = 'barkele01'

	SELECT * FROM People WHERE playerID = 'barkele01'

	ROLLBACK

-- Testing The delete trigger
	
	-- For Total_Salary & Average_Salary

	BEGIN TRANSACTION

	SELECT * FROM Salaries WHERE playerID = 'barkele01'

	DELETE FROM Salaries 
	WHERE yearID = '1985' AND  teamID = 'ATL' AND lgID = 'NL' AND playerID = 'barkele01' AND salary = '1000'
	
	SELECT SUM(salary), AVG(salary) 
	FROM Salaries
	WHERE playerID = 'barkele01'

	SELECT * FROM People WHERE playerID = 'barkele01'

	ROLLBACK

	COMMIT