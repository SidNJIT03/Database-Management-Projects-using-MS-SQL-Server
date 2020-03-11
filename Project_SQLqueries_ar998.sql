
--- Question 1

	SELECT CONVERT(CHAR(10), MIN(Date_Local),120) AS 'First Date', CONVERT(CHAR(10), MAX(Date_Local),120) AS 'Last Date' 
	FROM Temperature;

--- Question 2

	SELECT tmp.State_Name, MIN(tmp.Average_Temp) AS 'Minimum Temp', MAX(tmp.Average_Temp) AS 'Maximum Temp', AVG(tmp.Average_Temp) AS 'Average Temp' 
	FROM (SELECT a.State_Name, a.State_Code, a.County_Code, a.Site_Number, t.Average_Temp, t.Daily_High_Temp
	   	  FROM Temperature t, AQS_Sites a
		  WHERE a.State_Code = t.State_Code AND a.County_Code = t.County_Code AND a.Site_Number = t.Site_Num) tmp
	GROUP BY tmp.State_Name ORDER BY tmp.State_Name

--- Question 3
	
	SELECT A.State_Name,A.State_Code,A.County_Code,A.Site_Number,MIN(Average_Temp) AS Average_Temp,
	FORMAT(MAX(Date_Local),'yyyy-MM-dd') AS 'DATE_LOCAL'
	FROM AQS_Sites A, Temperature T
	WHERE T.State_Code=A.State_Code AND
	T.County_Code=A.County_Code AND
	T.Site_Num=A.Site_Number
	GROUP BY A.State_Name,A.State_Code,A.County_Code,A.Site_Number, Average_Temp, Date_Local
	HAVING (MIN(Average_Temp) <-39 OR MIN(Average_Temp) > 105)
	ORDER BY State_Name DESC, Average_Temp

--- Question 4

	DELETE FROM Temperature WHERE Average_Temp < -39 OR Average_Temp > 125;
	DELETE FROM Temperature WHERE Average_Temp > 105 AND State_Code IN (30, 29, 37, 26, 18, 38);

--- Question 5

	SELECT tmp.State_Name, tmp.MIN_Temp AS 'Minimum Temp', tmp.MAX_Temp AS 'Maximum Temp', 
		tmp.Average_Temp AS 'Average Temp', RANK() OVER (ORDER BY tmp.Average_Temp DESC) AS State_Rank
	FROM (SELECT a.State_Name, t.State_Code, MIN(t.Average_Temp) AS MIN_Temp, MAX(t.Average_Temp) AS MAX_Temp, 
		  AVG(t.Average_Temp) AS Average_Temp 
		  FROM Temperature t, AQS_Sites a 
		  WHERE a.State_Code = t.State_Code AND	a.County_Code = t.County_Code AND a.Site_Number = t.Site_Num 
		  GROUP BY a.State_Name, t.State_Code) tmp;

--- Question 6

	SELECT DISTINCT State_Name FROM aqs_sites
	WHERE State_Name NOT IN ('Canada','Country Of Mexico','District Of Columbia','Guam','Puerto Rico','Virgin Islands')
	ORDER BY State_Name

--- Question 7

-- Before Indexing

	Go

	DECLARE @StartTime datetime
	DECLARE @EndTime datetime
	SELECT @StartTime = GETDATE() 

	Print 'Before Question 7, the execution of the query started at - ' + (CAST(convert(varchar,getdate(),108) AS nvarchar(30)))

  -- Query of Question #2 

	SELECT tmp.State_Name, MIN(tmp.Average_Temp) AS 'Minimum Temp', MAX(tmp.Average_Temp) AS 'Maximum Temp',
		AVG(tmp.Average_Temp) AS 'Average Temp' 
	FROM (SELECT a.State_Name, a.State_Code, a.County_Code, a.Site_Number, t.Average_Temp, t.Daily_High_Temp
		  FROM Temperature t, AQS_Sites a
		  Where a.State_Code = t.State_Code AND a.County_Code = t.County_Code AND a.Site_Number = t.Site_Num) tmp
	GROUP BY tmp.State_Name ORDER BY tmp.State_Name

	SELECT @EndTime=GETDATE()
	PRINT 'Before Question 7, the execution of the query ended at - ' + (CAST(convert(varchar,getdate(),108) AS nvarchar(30)))

-- This query gives the execution time in milliseconds before indexing

	PRINT 'The execution time in milliseconds before Indexing: ' +(CAST(convert(varchar,DATEDIFF(millisecond,@StartTime,@EndTime),108) AS nvarchar(30)))
 
-- Checking if the Average_Temp_Index exists before and creating it

	Go
	BEGIN
	IF EXISTS (SELECT *  FROM SYS.INDEXES 
			 WHERE name in (N'Average_Temp_Index') AND object_id = OBJECT_ID('dbo.Temperature'))
	BEGIN
		DROP INDEX Average_Temp_Index ON Temperature
	END
	END

-- Creating index for Average_Temp column in Temperature table
	
	Go
	Create Index Average_Temp_Index ON Temperature (Average_Temp)

-- Checking if the Daily_High_Temp_Index exists before and creating it

	Go
	BEGIN
	IF EXISTS (SELECT *  FROM SYS.INDEXES 
			 WHERE name in (N'Daily_High_Temp_Index') AND object_id = OBJECT_ID('dbo.Temperature'))
	BEGIN
		DROP INDEX Daily_High_Temp_Index ON Temperature
	END
	END

-- Creating index for Daily_High_Temp column in Temperature table

	Go
	Create Index Daily_High_Temp_Index ON Temperature (Daily_High_Temp)

-- Checking if the Date_Local_Index exists before and creating it

	Go
	BEGIN
	IF EXISTS (SELECT *  FROM SYS.INDEXES 
			 WHERE name in (N'Date_Local_Index') AND object_id = OBJECT_ID('dbo.Temperature'))
	BEGIN
		DROP INDEX Date_Local_Index ON Temperature
	END
	END

-- Creating index for Date_Local column in Temperature table
	
	Go
	Create Index Date_Local_Index ON Temperature (Date_Local)

-- Checking if the State_County_Site_Code_Temp_Index exists before and creating it

	Go
	BEGIN
	IF EXISTS (SELECT *  FROM SYS.INDEXES 
			 WHERE name in (N'State_County_Site_Code_Temp_Index') AND object_id = OBJECT_ID('dbo.Temperature'))
	BEGIN
		DROP INDEX State_County_Site_Code_Temp_Index ON Temperature
	END
	END

-- Creating Indexes on County_Code, State_Code, Site_Num in Temperature table
	
	Go
	Create Index State_County_Site_Code_Temp_Index ON Temperature (State_Code, County_Code, Site_Num) 
 
-- Checking if the State_County_Site_Code_AQS_Index exists before and creating it
	
	Go
	BEGIN
	IF EXISTS (SELECT *  FROM SYS.INDEXES 
			 WHERE name in (N'State_County_Site_Code_AQS_Index') AND object_id = OBJECT_ID('dbo.aqs_sites'))
	BEGIN
		DROP INDEX State_County_Site_Code_AQS_Index ON aqs_sites
	END
	END

-- Creating Indexes on County_Code, State_Code, Site_Num in aqs_sites table
	
	Go
	Create Index State_County_Site_Code_AQS_Index ON aqs_sites (State_Code,county_code, Site_Number)
 
-- After Indexing is done
	
	Go
	DECLARE @StartTimeAfterIndex datetime
	DECLARE @EndTimeAfterIndex datetime
	SELECT @StartTimeAfterIndex = GETDATE() 

	Print 'After Question 7, the execution of the query started at - ' + (CAST(CONVERT(VARCHAR, GETDATE(),108) AS NVARCHAR(30)))

-- Query of Question 2

	SELECT tmp.State_Name, MIN(tmp.Average_Temp) AS 'Minimum Temp', MAX(tmp.Average_Temp) AS 'Maximum Temp',
		AVG(tmp.Average_Temp) AS 'Average Temp' 
	FROM (SELECT a.State_Name, a.State_Code, a.County_Code, a.Site_Number, t.Average_Temp, t.Daily_High_Temp
		FROM Temperature t, AQS_Sites a
		Where a.State_Code = t.State_Code AND a.County_Code = t.County_Code AND a.Site_Number = t.Site_Num) tmp
	GROUP BY tmp.State_Name ORDER BY tmp.State_Name

	SELECT @EndTimeAfterIndex=GETDATE()
	PRINT 'After Question 7, the execution of the query ended at - ' + (CAST(CONVERT(VARCHAR, GETDATE(),108) AS NVARCHAR(30)))

-- This query gives the execution time in milliseconds afer indexing
	
	PRINT 'The execution time in milliseconds after Indexing: ' +
		(CAST(CONVERT(VARCHAR,DATEDIFF(MILLISECOND, @StartTimeAfterIndex,@EndTimeAfterIndex),108) AS nvarchar(30)))

--- Question 8

	GO
	WITH 
     StateRank AS
		   (SELECT A.State_Name, AVG(Average_temp) AS [State Avg Temp], 
				   RANK() OVER (ORDER BY AVG(Average_temp) DESC) AS State_Rank
			FROM Temperature T, aqs_sites A
			WHERE T.State_Code = A.State_Code and T.County_Code = A.County_Code and T.Site_Num = A.Site_Number
				  and State_Name not in ('Canada','Country Of Mexico','District Of Columbia','Guam','Puerto Rico','Virgin Islands')
			GROUP BY A.State_Name),

	 CityRank AS
		   (SELECT A.State_Name, A.City_Name, AVG(Average_temp) AS [Average_Temp],
				   RANK() OVER (PARTITION BY A.State_Name ORDER BY AVG(Average_temp) DESC) AS State_City_Rank
			FROM Temperature T, aqs_sites A
			WHERE T.State_Code = A.State_Code and T.County_Code = A.County_Code and T.Site_Num = A.Site_Number
			GROUP BY A.State_Name, A.City_Name)

	SELECT  StateRank.State_Rank, CityRank.State_Name,  CityRank.State_City_Rank, CityRank.City_Name, CityRank.[Average_Temp]    
	FROM  StateRank, CityRank
	WHERE StateRank.State_Name = CityRank.State_Name and State_Rank <= 15
	ORDER BY StateRank.State_Rank ASC

--- Question 9

	GO
	WITH 
     StateRank AS
				(SELECT A.State_Name, AVG(Average_temp) as [State Avg Temp], 
				        RANK() OVER (ORDER BY  avg(Average_temp) DESC) AS State_Rank
				 FROM Temperature T, aqs_sites A
				 WHERE T.State_Code = A.State_Code and T.County_Code = A.County_Code and T.Site_Num = A.Site_Number
				      and State_Name not in ('Canada','Country Of Mexico','District Of Columbia','Guam','Puerto Rico','Virgin Islands')
				GROUP BY A.State_Name),

	 CityRank AS
				(SELECT A.State_Name, A.City_Name, AVG(Average_temp) as [Average_Temp],
						RANK() over (PARTITION BY A.State_Name ORDER BY avg(Average_temp) DESC) AS State_City_Rank
				 FROM Temperature T, aqs_sites A
				 WHERE T.State_Code = A.State_Code and T.County_Code = A.County_Code and T.Site_Num = A.Site_Number
					and City_Name <> 'Not in a City' 
				GROUP BY A.State_Name, A.City_Name)

	SELECT  StateRank.State_Rank, CityRank.State_Name,  CityRank.State_City_Rank, CityRank.City_Name, CityRank.[Average_Temp]      
	FROM  StateRank, CityRank
	WHERE StateRank.State_Name = CityRank.State_Name and State_Rank <= 15 
	ORDER BY StateRank.State_Rank ASC

--- Question 10

	Go

	WITH StateRank AS
				(SELECT State_Name, Avg(Average_Temp) as State_Average,
						RANK() OVER (ORDER BY Avg(Average_Temp) desc) as State_Rank
				 FROM Temperature T, aqs_sites A
				 WHERE T.State_Code = A.State_Code and T.County_Code = A.County_Code and T.Site_Num = A.Site_Number
				       and State_Name not in ('Canada','Country Of Mexico','District Of Columbia','Guam','Puerto Rico','Virgin Islands')
				 GROUP BY State_Name),

     CityRank AS
			   (SELECT A.State_Name, City_Name, Avg(Average_Temp) AS Average_Temp,
			           RANK() OVER (PARTITION BY A.State_Name ORDER BY Avg(Average_Temp) DESC) AS State_City_Rank
			    FROM Temperature T, aqs_sites A
				WHERE T.State_Code = A.State_Code and T.County_Code = A.County_Code and T.Site_Num = A.Site_Number
				      and  City_Name <> 'Not in a City'  
				GROUP BY A.State_Name, City_Name)


	SELECT State_Rank, StateRank.State_Name, State_City_Rank, CityRank.City_Name, CityRank.Average_Temp  
	FROM   StateRank, CityRank
	WHERE  StateRank.State_Name = CityRank.State_Name and CityRank.State_City_Rank < =2  and State_Rank <= 15     
	ORDER BY StateRank.State_Rank ASC

--- Question 11
	
	Select City_Name, DATEPART(month, Date_Local) as Month, count(*) as '# of Records', Avg(Average_Temp) as Average_Temp
	From Temperature T, aqs_sites A
	Where A.State_code = T.State_code and
          A.County_code = T.County_code and
          A.Site_number = T.Site_num and
          City_Name in ('Mission','Tucson','Pinellas Park')
	Group by City_Name, DATEPART(month, Date_local)
	Order by City_Name

--- Question 12
	
	With D as
     (Select distinct A.City_Name, T.average_temp, 
	         CUME_DIST() Over (Partition by a.City_Name Order by t.Average_Temp) as Temp_Cume_Dist
      from Temperature T, aqs_sites A
      where A.state_code = T.state_code and
            A.county_code = T.county_code and
            A.site_number = T.site_num and
            city_name in ('Mission','Tucson','Pinellas Park') and
			A.State_Name in ('Florida', 'Texas', 'Arizona'))
	Select D.City_name, D.Average_Temp, TEMP_CUME_DIST 
	from D
	where TEMP_CUME_DIST < 0.60 and TEMP_CUME_DIST > 0.40
	
--- Question 13

	Select distinct City_Name, Percentile_Disc(0.4) Within Group (Order By Average_Temp) Over (Partition By City_Name) as '40 Percentile Temp',
                Percentile_Disc(0.6) Within Group (Order By Average_Temp) Over (Partition By City_Name) as '60 Percentile Temp'
	from aqs_sites A, Temperature T
	where City_Name in ('Pinellas Park', 'Mission', 'Tucson') and
          A.County_Code = T.County_Code and
		  A.State_Code = T.State_Code and
		  A.Site_Number = T.Site_Num
	order by City_Name

--- Question 14

	With D as
     (Select a.City_Name, t.Average_Temp, 
			NTILE(10) Over (Partition by a.City_Name Order by t.Average_Temp) as Percentile
			From Temperature t, AQS_Sites a
			Where a.State_Code = t.State_Code and 
	   			  a.County_Code = t.County_Code and
				  a.Site_Number = t.Site_Num and
				  a.City_Name IN ('Pinellas Park', 'Mission', 'Tucson') and
				  a.State_Name IN ('Florida', 'Texas', 'Arizona'))
	Select D.City_Name, D.Percentile, MIN(D.Average_Temp) as MIN_Temp, MAX(D.Average_Temp) as MAX_Temp 
	from D
	group by D.City_Name, D.Percentile

-- Question 15

	SELECT A.City_Name, A.Average_Temp,
	FORMAT(PERCENT_RANK() OVER (PARTITION BY A.City_Name ORDER BY A.Average_Temp), 'P') AS 'Percentage'
	FROM (SELECT DISTINCT AQ.City_Name, CAST(T.Average_Temp AS INT) AS Average_Temp
			FROM Temperature T, AQS_Sites AQ
			WHERE AQ.State_Code = T.State_Code AND 
			   	  AQ.County_Code = T.County_Code AND
				  AQ.Site_Number = T.Site_Num AND
				  AQ.City_Name IN ('Pinellas Park', 'Mission', 'Tucson') and
				  AQ.State_Name IN ('Florida', 'Texas', 'Arizona')) A

-- Question 16

	SELECT A.City_Name, A.[Day of the Year], 
	AVG(A.Average_Temp) OVER (PARTITION BY A.City_Name ORDER BY A.[Day of the Year] ROWS BETWEEN 3 PRECEDING AND 1 FOLLOWING) AS Rolling_Avg_Temp
	FROM (SELECT DISTINCT AQ.City_Name, DATEPART(DY, T.Date_Local) AS 'Day of the Year', AVG(t.Average_Temp) AS Average_Temp
			FROM Temperature T, AQS_Sites AQ
			WHERE AQ.State_Code = T.State_Code AND 
			   	  AQ.County_Code = T.County_Code AND
				  AQ.Site_Number = T.Site_Num AND
				  AQ.City_Name IN ('Pinellas Park', 'Mission', 'Tucson') and
				  AQ.State_Name IN ('Florida', 'Texas', 'Arizona')	
			GROUP BY AQ.City_Name, DATEPART(DY,T.Date_Local)) A