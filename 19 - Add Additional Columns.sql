Use Spring_2019_BaseBall
go

IF NOT EXISTS(
    SELECT *
    FROM sys.columns 
    WHERE Name      = N'401K Contributions'
      AND Object_ID = Object_ID(N'SALARIES'))
BEGIN
      ALTER TABLE salaries ADD [401K Contributions] Money NULL
END
go

 IF NOT EXISTS(
    SELECT *
    FROM sys.columns 
    WHERE Name      = N'401K Team Contributions'
      AND Object_ID = Object_ID(N'SALARIES'))
BEGIN
      ALTER TABLE salaries ADD [401K Team Contributions] Money NULL
END
go

IF NOT EXISTS(
    SELECT *
    FROM sys.columns 
    WHERE Name      = N'Total_HR'
      AND Object_ID = Object_ID(N'PEOPLE'))
BEGIN
      ALTER TABLE PEOPLE ADD Total_HR INT NULL
END
go
IF NOT EXISTS(
    SELECT *
    FROM sys.columns 
    WHERE Name      = N'High_BA'
      AND Object_ID = Object_ID(N'PEOPLE'))
BEGIN
      ALTER TABLE PEOPLE ADD High_BA FLOAT NULL
END
go

IF NOT EXISTS(
    SELECT *
    FROM sys.columns 
    WHERE Name      = N'Total_401K'
      AND Object_ID = Object_ID(N'PEOPLE'))
BEGIN
      ALTER TABLE PEOPLE ADD Total_401K money NULL
END
go