USE [BaseBall_Summer_2018]

-- League Table creation
	IF OBJECT_ID (N'dbo.league', N'U') IS NOT NULL
	DROP TABLE [dbo].[league];       
	GO

	CREATE TABLE [dbo].[league](
	[lgID] [varchar](255) NOT NULL,
	[lgName] [varchar](255) NULL,
	PRIMARY KEY (lgID));
	GO

--Insert data into league table

	insert into league values('AA',null)
	insert into league values('AL',null)
	insert into league values('ML',null)
	insert into league values('NL',null)
	insert into league values('UA',null)
	insert into league values('NA',null)
	insert into league values('FL',null)
	insert into league values('PL',null)

	SELECT * FROM league

-- 1. TeamsFranchises (NOT NULLS) -> Before creating PK & FK, we should make sure keep PK & FK columns as not null

	ALTER TABLE [dbo].[TeamsFranchises] ALTER COLUMN franchID VARCHAR(255) NOT NULL

-- 1. TeamsFranchises (PRIMARY KEYS) -> franchID is the PK here which would be used as FK in Teams table

	ALTER TABLE [dbo].[TeamsFranchises]
	ADD PRIMARY KEY CLUSTERED ([franchID]);

-- 2. Teams (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null
	ALTER TABLE [dbo].[Teams] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Teams] ALTER COLUMN yearID INT NOT NULL
	ALTER TABLE [dbo].[Teams] ALTER COLUMN teamID VARCHAR(255) NOT NULL

-- 2. Teams (PRIMARY KEYS)

	ALTER TABLE [dbo].[Teams]
	ADD PRIMARY KEY CLUSTERED ([lgID], [yearID], [teamID])

-- 2. Teams (FOREIGN KEY)

	ALTER TABLE [dbo].[Teams]  WITH CHECK ADD FOREIGN KEY([lgID])
	REFERENCES [dbo].[league] ([lgID])

	ALTER TABLE [dbo].[Teams]  WITH CHECK ADD FOREIGN KEY([franchID])
	REFERENCES [dbo].[TeamsFranchises] ([franchID])

-- 3. People (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[People]
	ALTER COLUMN [playerID] VARCHAR(255) Not Null

-- 3. People (PRIMARY KEYS) -> playerID is the only unique key in Peoples table

	ALTER TABLE [dbo].[People]
	ADD PRIMARY KEY CLUSTERED (playerID)

-- 4. AllstarFull (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[AllstarFull] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[AllstarFull] ALTER COLUMN yearID INT NOT NULL
	ALTER TABLE [dbo].[AllstarFull] ALTER COLUMN teamID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[AllstarFull] ALTER COLUMN playerID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[AllstarFull] ALTER COLUMN gameID VARCHAR(255) NOT NULL

-- 4. AllstarFull (PRIMARY KEY)

	ALTER TABLE [dbo].[AllstarFull]
	ADD PRIMARY KEY CLUSTERED ([yearID], [lgID], [teamID], [playerID], [gameID]); 	

-- 4. AllstarFull (FOREIGN KEY)

	ALTER TABLE [dbo].[AllstarFull]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[AllstarFull]  WITH CHECK ADD FOREIGN KEY([lgID], [yearID], [teamID])
	REFERENCES [dbo].[Teams] ([lgID], [yearID], [teamID])

-- 5. CollegePlaying (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[CollegePlaying] ALTER COLUMN schoolID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[CollegePlaying] ALTER COLUMN playerID VARCHAR(255) NOT NULL

-- 5. CollegePlaying (FOREIGN KEY)

	ALTER TABLE [dbo].[CollegePlaying]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])

-- Had to record the bad data from CollegePlaying table by comparing schoolID records from Schools table
-- This ensured eliminiation of (Issue 5: The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "FK__CollegePl__schoo__5772F790". The conflict occurred in database "BaseBall_Summer_2018", table "dbo.Schools", column 'schoolID'). error

	DELETE FROM CollegePlaying WHERE schoolID not in(
	SELECT DISTINCT schoolID FROM Schools)
	
	ALTER TABLE [dbo].[CollegePlaying]  WITH CHECK ADD FOREIGN KEY([schoolID])
	REFERENCES [dbo].[Schools] ([schoolID])

-- 6. Schools (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[Schools] ALTER COLUMN schoolID VARCHAR(255) NOT NULL

-- 6. Schools (PRIMARY KEY)

	ALTER TABLE [dbo].[Schools]
	ADD PRIMARY KEY CLUSTERED ([schoolID]);

-- 7. Batting (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[Batting] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Batting] ALTER COLUMN yearID INT NOT NULL
	ALTER TABLE [dbo].[Batting] ALTER COLUMN teamID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Batting] ALTER COLUMN playerID VARCHAR(255) NOT NULL
	
-- 7. Batting (FOREIGN KEY)

	ALTER TABLE [dbo].[Batting]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[Batting]  WITH CHECK ADD FOREIGN KEY([lgID], [yearID], [teamID])
	REFERENCES [dbo].[Teams] ([lgID], [yearID], [teamID])

-- 8. Appearances (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[Appearances] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Appearances] ALTER COLUMN yearID INT NOT NULL
	ALTER TABLE [dbo].[Appearances] ALTER COLUMN teamID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Appearances] ALTER COLUMN playerID VARCHAR(255) NOT NULL

-- 8. Appearances (FOREIGN KEY)

	ALTER TABLE [dbo].[Appearances]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[Appearances]  WITH CHECK ADD FOREIGN KEY([lgID], [yearID], [teamID])
	REFERENCES [dbo].[Teams] ([lgID], [yearID], [teamID])

-- 9. Salaries (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[Salaries] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Salaries] ALTER COLUMN yearID INT NOT NULL
	ALTER TABLE [dbo].[Salaries] ALTER COLUMN teamID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Salaries] ALTER COLUMN playerID VARCHAR(255) NOT NULL

-- 9. Salaries (FOREIGN KEY)

-- Had to record the bad data from Salaries table by comparing playerID records from People table
-- This ensured eliminiation of (Issue 6: The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "FK__Salaries__player__62E4AA3C". The conflict occurred in database "BaseBall_Summer_2018", table "dbo.People", column 'playerID'). error

	DELETE FROM Salaries WHERE playerID NOT IN(
	SELECT DISTINCT playerID FROM People)

	ALTER TABLE [dbo].[Salaries]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[Salaries]  WITH CHECK ADD FOREIGN KEY([lgID], [yearID], [teamID])
	REFERENCES [dbo].[Teams] ([lgID], [yearID], [teamID])

-- 10. Managers (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[Managers] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Managers] ALTER COLUMN yearID INT NOT NULL
	ALTER TABLE [dbo].[Managers] ALTER COLUMN teamID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Managers] ALTER COLUMN playerID VARCHAR(255) NOT NULL

-- 10. Managers (FOREIGN KEY)

	ALTER TABLE [dbo].[Managers]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[Managers]  WITH CHECK ADD FOREIGN KEY([lgID], [yearID], [teamID])
	REFERENCES [dbo].[Teams] ([lgID], [yearID], [teamID])

-- 11. AwardsManagers (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[AwardsManagers] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[AwardsManagers] ALTER COLUMN playerID VARCHAR(255) NOT NULL

-- 11. AwardsManagers (FOREIGN KEY)

	ALTER TABLE [dbo].[AwardsManagers]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[AwardsManagers]  WITH CHECK ADD FOREIGN KEY([lgID])
	REFERENCES [dbo].[league] ([lgID])

-- 12. AwardsPlayers (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[AwardsPlayers] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[AwardsPlayers] ALTER COLUMN playerID VARCHAR(255) NOT NULL

-- 12. AwardsPlayers (FOREIGN KEY)

	ALTER TABLE [dbo].[AwardsPlayers]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[AwardsPlayers]  WITH CHECK ADD FOREIGN KEY([lgID])
	REFERENCES [dbo].[league] ([lgID])

-- 13. AwardsSharePlayers (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[AwardsSharePlayers] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[AwardsSharePlayers] ALTER COLUMN playerID VARCHAR(255) NOT NULL

-- 13. AwardsSharePlayers (FOREIGN KEY)

	ALTER TABLE [dbo].[AwardsSharePlayers]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[AwardsSharePlayers]  WITH CHECK ADD FOREIGN KEY([lgID])
	REFERENCES [dbo].[league] ([lgID])

-- 14. AwardsShareManagers (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[AwardsShareManagers] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[AwardsShareManagers] ALTER COLUMN playerID VARCHAR(255) NOT NULL

-- 14. AwardsShareManagers (FOREIGN KEY)

	ALTER TABLE [dbo].[AwardsShareManagers]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[AwardsShareManagers]  WITH CHECK ADD FOREIGN KEY([lgID])
	REFERENCES [dbo].[league] ([lgID])

-- 15. Pitching (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[Pitching] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Pitching] ALTER COLUMN playerID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Pitching] ALTER COLUMN yearID INT NOT NULL
	ALTER TABLE [dbo].[Pitching] ALTER COLUMN teamID VARCHAR(255) NOT NULL

-- 15. Pitching (FOREIGN KEY)

	ALTER TABLE [dbo].[Pitching]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[Pitching]  WITH CHECK ADD FOREIGN KEY([lgID], [yearID], [teamID])
	REFERENCES [dbo].[Teams] ([lgID], [yearID], [teamID])

-- 16. Fielding (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[Fielding] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Fielding] ALTER COLUMN playerID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Fielding] ALTER COLUMN yearID INT NOT NULL
	ALTER TABLE [dbo].[Fielding] ALTER COLUMN teamID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[Fielding] ALTER COLUMN stint INT NOT NULL
	ALTER TABLE [dbo].[Fielding] ALTER COLUMN POS VARCHAR(255) NOT NULL

-- 16. Fielding (FOREIGN KEY)

	ALTER TABLE [dbo].[Fielding]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
	ALTER TABLE [dbo].[Fielding]  WITH CHECK ADD FOREIGN KEY([lgID], [yearID], [teamID])
	REFERENCES [dbo].[Teams] ([lgID], [yearID], [teamID])

-- 17. FieldingOF (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[FieldingOF] ALTER COLUMN playerID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[FieldingOF] ALTER COLUMN yearID INT NOT NULL

-- 17. FieldingOF (FOREIGN KEY)

	ALTER TABLE [dbo].[FieldingOF]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])
	
-- 18. HomeGames (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null

	ALTER TABLE [dbo].[HomeGames] ALTER COLUMN lgID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[HomeGames] ALTER COLUMN teamID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[HomeGames] ALTER COLUMN parkID VARCHAR(255) NOT NULL
	ALTER TABLE [dbo].[HomeGames] ALTER COLUMN yearID INT NOT NULL

-- 18. HomeGames (FOREIGN KEY)

	ALTER TABLE [dbo].[HomeGames]  WITH CHECK ADD FOREIGN KEY([parkID])
	REFERENCES [dbo].[Parks] ([park_key])

	ALTER TABLE [dbo].[HomeGames]  WITH CHECK ADD FOREIGN KEY([lgID], [yearID], [teamID])
	REFERENCES [dbo].[Teams] ([lgID], [yearID], [teamID])

-- 19. Parks (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null
 
	ALTER TABLE [dbo].[Parks] ALTER COLUMN park_key VARCHAR(255) NOT NULL

-- 19. Parks (PRIMARY KEY)

	ALTER TABLE [dbo].[Parks]
	ADD PRIMARY KEY CLUSTERED (park_key)

-- 20. HallOfFame (NOT NULLS) -> Before creating PK & FK, we should make sure to keep PK & FK columns as not null
	ALTER TABLE [dbo].[HallOfFame] alter column playerID varchar(255) NOT NULL
	ALTER TABLE [dbo].[HallOfFame] alter column yearID int NOT NULL
	ALTER TABLE [dbo].[HallOfFame] alter column votes int NOT NULL

-- 20. HallOfFame (PRIMARY KEY)

	ALTER TABLE [dbo].[HallOfFame]
	ADD PRIMARY KEY CLUSTERED ([playerID],
	[yearID],
	[votedBy]);

-- 20. HallOfFame (FOREIGN KEY)

	ALTER TABLE [dbo].[HallOfFame]  WITH CHECK ADD FOREIGN KEY([playerID])
	REFERENCES [dbo].[People] ([playerID])