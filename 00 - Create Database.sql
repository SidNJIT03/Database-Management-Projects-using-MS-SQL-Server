USE [master]
GO

/****** Object:  Database [Spring_2019_BaseBall] Script Date: 8/5/2017 10:13:58 AM ******/
IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'Spring_2019_BaseBall')
DROP DATABASE Spring_2019_BaseBall
GO

/****** Object:  Database [Spring_2019_BaseBall] Script Date: 8/5/2017 10:13:58 AM ******/
CREATE DATABASE Spring_2019_BaseBall
GO
Use [Spring_2019_BaseBall];
GO

/****** Object:  Table [dbo].[AllstarFull]    Script Date: 8/5/2017 2:08:04 PM ******/
IF OBJECT_ID (N'dbo.AllstarFull', N'U') IS NOT NULL
DROP TABLE [dbo].[AllstarFull]
GO

/****** Object:  Table [dbo].[AllstarFull]    Script Date: 8/5/2017 2:08:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AllstarFull](
	[playerID] [varchar](255) NULL,
	[yearID] [int] NULL,
	[gameNum] [int] NULL,
	[gameID] [varchar](255) NULL,
	[teamID] [varchar](255) NULL,
	[lgID] [varchar](255) NULL,
	[GP] [int] NULL,
	[startingPos] [varchar](255) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Appearances]    Script Date: 8/5/2017 2:09:34 PM ******/
IF OBJECT_ID (N'dbo.Appearances', N'U') IS NOT NULL
DROP TABLE [dbo].[Appearances]
GO

CREATE TABLE [dbo].[Appearances](
	[yearID] [int] NULL,
	[teamID] [varchar](255) NULL,
	[lgID] [varchar](255) NULL,
	[playerID] [varchar](255) NULL,
	[G_all] [int] NULL,
	[GS] [varchar](255) NULL,
	[G_batting] [int] NULL,
	[G_defense] [int] NULL,
	[G_p] [int] NULL,
	[G_c] [int] NULL,
	[G_1b] [int] NULL,
	[G_2b] [int] NULL,
	[G_3b] [int] NULL,
	[G_ss] [int] NULL,
	[G_lf] [int] NULL,
	[G_cf] [int] NULL,
	[G_rf] [int] NULL,
	[G_of] [int] NULL,
	[G_dh] [varchar](255) NULL,
	[G_ph] [varchar](255) NULL,
	[G_pr] [varchar](255) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[AwardsManagers]    Script Date: 8/5/2017 2:10:43 PM ******/
IF OBJECT_ID (N'dbo.AwardsManagers', N'U') IS NOT NULL
DROP TABLE [dbo].[AwardsManagers]
GO

/****** Object:  Table [dbo].[AwardsManagers]    Script Date: 8/5/2017 2:10:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AwardsManagers](
	[playerID] [varchar](255) NULL,
	[awardID] [varchar](255) NULL,
	[yearID] [int] NULL,
	[lgID] [varchar](255) NULL,
	[tie] [varchar](255) NULL,
	[notes] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AwardsPlayers]    Script Date: 8/5/2017 2:11:27 PM ******/
IF OBJECT_ID (N'dbo.AwardsPlayers', N'U') IS NOT NULL
DROP TABLE [dbo].[AwardsPlayers]
GO

/****** Object:  Table [dbo].[AwardsPlayers]    Script Date: 8/5/2017 2:11:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AwardsPlayers](
	[playerID] [varchar](255) NULL,
	[awardID] [varchar](255) NULL,
	[yearID] [int] NULL,
	[lgID] [varchar](255) NULL,
	[tie] [varchar](255) NULL,
	[notes] [varchar](255) NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[AwardsShareManagers]    Script Date: 8/5/2017 2:12:23 PM ******/
IF OBJECT_ID (N'dbo.AwardsShareManagers', N'U') IS NOT NULL
DROP TABLE [dbo].[AwardsShareManagers]
GO

/****** Object:  Table [dbo].[AwardsShareManagers]    Script Date: 8/5/2017 2:12:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AwardsShareManagers](
	[awardID] [varchar](255) NULL,
	[yearID] [int] NULL,
	[lgID] [varchar](255) NULL,
	[playerID] [varchar](255) NULL,
	[pointsWon] [int] NULL,
	[pointsMax] [int] NULL,
	[votesFirst] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AwardsSharePlayers]    Script Date: 8/5/2017 2:14:48 PM ******/
IF OBJECT_ID (N'dbo.AwardsSharePlayers', N'U') IS NOT NULL
DROP TABLE [dbo].[AwardsSharePlayers]
GO

/****** Object:  Table [dbo].[AwardsSharePlayers]    Script Date: 8/5/2017 2:14:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AwardsSharePlayers](
	[awardID] [varchar](255) NULL,
	[yearID] [int] NULL,
	[lgID] [varchar](255) NULL,
	[playerID] [varchar](255) NULL,
	[pointsWon] [int] NULL,
	[pointsMax] [int] NULL,
	[votesFirst] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Batting]    Script Date: 8/5/2017 2:15:24 PM ******/
IF OBJECT_ID (N'dbo.Batting', N'U') IS NOT NULL
DROP TABLE [dbo].[Batting]
GO

/****** Object:  Table [dbo].[Batting]    Script Date: 8/5/2017 2:15:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Batting](
	[playerID] [varchar](255) NULL,
	[yearID] [int] NULL,
	[stint] [int] NULL,
	[teamID] [varchar](255) NULL,
	[lgID] [varchar](255) NULL,
	[G] [int] NULL,
	[AB] [int] NULL,
	[R] [int] NULL,
	[H] [int] NULL,
	[B2] [int] NULL,
	[B3] [int] NULL,
	[HR] [int] NULL,
	[RBI] [int] NULL,
	[SB] [int] NULL,
	[CS] [int] NULL,
	[BB] [int] NULL,
	[SO] [int] NULL,
	[IBB] [varchar](255) NULL,
	[HBP] [varchar](255) NULL,
	[SH] [varchar](255) NULL,
	[SF] [varchar](255) NULL,
	[GIDP] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CollegePlaying]    Script Date: 8/5/2017 2:15:56 PM ******/
IF OBJECT_ID (N'dbo.CollegePlaying', N'U') IS NOT NULL
DROP TABLE [dbo].[CollegePlaying]
GO

/****** Object:  Table [dbo].[CollegePlaying]    Script Date: 8/5/2017 2:15:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CollegePlaying](
	[playerID] [varchar](255) NULL,
	[schoolID] [varchar](255) NULL,
	[yearID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fielding]    Script Date: 8/5/2017 2:16:30 PM ******/
IF OBJECT_ID (N'dbo.Fielding', N'U') IS NOT NULL
DROP TABLE [dbo].[Fielding]
GO

/****** Object:  Table [dbo].[Fielding]    Script Date: 8/5/2017 2:16:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Fielding](
	[playerID] [varchar](255) NULL,
	[yearID] [int] NULL,
	[stint] [int] NULL,
	[teamID] [varchar](255) NULL,
	[lgID] [varchar](255) NULL,
	[POS] [varchar](255) NULL,
	[G] [int] NULL,
	[GS] [varchar](255) NULL,
	[InnOuts] [varchar](255) NULL,
	[PO] [int] NULL,
	[A] [int] NULL,
	[E] [int] NULL,
	[DP] [int] NULL,
	[PB] [varchar](255) NULL,
	[WP] [varchar](255) NULL,
	[SB] [varchar](255) NULL,
	[CS] [varchar](255) NULL,
	[ZR] [varchar](255) NULL
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[HomeGames]    Script Date: 8/5/2017 2:18:09 PM ******/
IF OBJECT_ID (N'dbo.HomeGames', N'U') IS NOT NULL
DROP TABLE [dbo].[HomeGames]
GO

/****** Object:  Table [dbo].[HomeGames]    Script Date: 8/5/2017 2:18:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HomeGames](
	[yearID] [int] NULL,
	[lgid] [varchar](255) NULL,
	[teamID] [varchar](255) NULL,
	[parkID] [varchar](255) NULL,
	[span_first] [varchar](255) NULL,
	[span_last] [varchar](255) NULL,
	[games] [int] NULL,
	[openings] [int] NULL,
	[attendance] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Managers]    Script Date: 8/5/2017 2:18:54 PM ******/
IF OBJECT_ID (N'dbo.Managers', N'U') IS NOT NULL
DROP TABLE [dbo].[Managers]
GO

/****** Object:  Table [dbo].[Managers]    Script Date: 8/5/2017 2:18:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Managers](
	[playerID] [varchar](255) NULL,
	[yearID] [int] NULL,
	[teamID] [varchar](255) NULL,
	[lgID] [varchar](255) NULL,
	[inseason] [int] NULL,
	[G] [int] NULL,
	[W] [int] NULL,
	[L] [int] NULL,
	[rank] [int] NULL,
	[plyrMgr] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[People]    Script Date: 8/5/2017 2:19:25 PM ******/
IF OBJECT_ID (N'dbo.People', N'U') IS NOT NULL
DROP TABLE [dbo].People
GO

/****** Object:  Table [dbo].[People]    Script Date: 8/5/2017 2:19:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].People (
	[playerID] [varchar](255) NULL,
	[birthYear] [int] NULL,
	[birthMonth] [int] NULL,
	[birthDay] [int] NULL,
	[birthCountry] [varchar](255) NULL,
	[birthState] [varchar](255) NULL,
	[birthCity] [varchar](255) NULL,
	[deathYear] [varchar](255) NULL,
	[deathMonth] [varchar](255) NULL,
	[deathDay] [varchar](255) NULL,
	[deathCountry] [varchar](255) NULL,
	[deathState] [varchar](255) NULL,
	[deathCity] [varchar](255) NULL,
	[nameFirst] [varchar](255) NULL,
	[nameLast] [varchar](255) NULL,
	[nameGiven] [varchar](255) NULL,
	[weight] [int] NULL,
	[height] [int] NULL,
	[bats] [varchar](255) NULL,
	[throws] [varchar](255) NULL,
	[debut] [varchar](255) NULL,
	[finalGame] [varchar](255) NULL,
	[retroID] [varchar](255) NULL,
	[bbrefID] [varchar](255) NULL
	) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parks]    Script Date: 8/5/2017 2:21:23 PM ******/
IF OBJECT_ID (N'dbo.Parks', N'U') IS NOT NULL
drop table dbo.parks
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Parks](
	[park_key] [varchar](255) NULL,
	[park_name] [varchar](255) NULL,
	[park_alias] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[state] [varchar](255) NULL,
	[country] [varchar](255) NULL
	) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Pitching]    Script Date: 8/5/2017 2:22:18 PM ******/
IF OBJECT_ID (N'dbo.Pitching', N'U') IS NOT NULL
DROP TABLE [dbo].[Pitching]
GO

/****** Object:  Table [dbo].[Pitching]    Script Date: 8/5/2017 2:22:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pitching](
	[playerID] [varchar](255) NULL,
	[yearID] [int] NULL,
	[stint] [int] NULL,
	[teamID] [varchar](255) NULL,
	[lgID] [varchar](255) NULL,
	[W] [int] NULL,
	[L] [int] NULL,
	[G] [int] NULL,
	[GS] [int] NULL,
	[CG] [int] NULL,
	[SHO] [int] NULL,
	[SV] [int] NULL,
	[IPouts] [int] NULL,
	[H] [int] NULL,
	[ER] [int] NULL,
	[HR] [int] NULL,
	[BB] [int] NULL,
	[SO] [int] NULL,
	[BAOpp] [varchar](255) NULL,
	[ERA] [float] NULL,
	[IBB] [varchar](255) NULL,
	[WP] [varchar](255) NULL,
	[HBP] [varchar](255) NULL,
	[BK] [int] NULL,
	[BFP] [varchar](255) NULL,
	[GF] [varchar](255) NULL,
	[R] [int] NULL,
	[SH] [varchar](255) NULL,
	[SF] [varchar](255) NULL,
	[GIDP] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salaries]    Script Date: 8/5/2017 2:22:47 PM ******/
IF OBJECT_ID (N'dbo.Salaries', N'U') IS NOT NULL
DROP TABLE [dbo].[Salaries]
GO

/****** Object:  Table [dbo].[Salaries]    Script Date: 8/5/2017 2:22:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Salaries](
	[yearID] [int] NULL,
	[teamID] [varchar](255) NULL,
	[lgID] [varchar](255) NULL,
	[playerID] [varchar](255) NULL,
	[salary] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schools]    Script Date: 8/5/2017 2:23:34 PM ******/
IF OBJECT_ID (N'dbo.Schools', N'U') IS NOT NULL
DROP TABLE [dbo].[Schools]
GO

/****** Object:  Table [dbo].[Schools]    Script Date: 8/5/2017 2:23:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Schools](
	[schoolID] [varchar](255) NULL,
	[name_full] [varchar](255) NULL,
	[city] [varchar](255) NULL,
	[state] [varchar](255) NULL,
	[country] [varchar](255) NULL
	) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teams]    Script Date: 8/5/2017 2:24:15 PM ******/
IF OBJECT_ID (N'dbo.Teams', N'U') IS NOT NULL
DROP TABLE [dbo].[Teams]
GO

/****** Object:  Table [dbo].[Teams]    Script Date: 8/5/2017 2:24:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Teams](
	[yearID] [int] NULL,
	[lgID] [varchar](255) NULL,
	[teamID] [varchar](255) NULL,
	[franchID] [varchar](255) NULL,
	[divID] [varchar](255) NULL,
	[Team_Rank] [int] NULL,
	[G] [int] NULL,
	[Ghome] [varchar](255) NULL,
	[W] [int] NULL,
	[L] [int] NULL,
	[DivWin] [varchar](255) NULL,
	[WCWin] [varchar](255) NULL,
	[LgWin] [varchar](255) NULL,
	[WSWin] [varchar](255) NULL,
	[R] [int] NULL,
	[AB] [int] NULL,
	[H] [int] NULL,
	[B2] [int] NULL,
	[B3] [int] NULL,
	[HR] [int] NULL,
	[BB] [int] NULL,
	[SO] [int] NULL,
	[SB] [int] NULL,
	[CS] [varchar](255) NULL,
	[HBP] [varchar](255) NULL,
	[SF] [varchar](255) NULL,
	[RA] [int] NULL,
	[ER] [int] NULL,
	[ERA] [float] NULL,
	[CG] [int] NULL,
	[SHO] [int] NULL,
	[SV] [int] NULL,
	[IPouts] [int] NULL,
	[HA] [int] NULL,
	[HRA] [int] NULL,
	[BBA] [int] NULL,
	[SOA] [int] NULL,
	[E] [int] NULL,
	[DP] [varchar](255) NULL,
	[FP] [float] NULL,
	[name] [varchar](255) NULL,
	[park] [varchar](255) NULL,
	[attendance] [varchar](255) NULL,
	[BPF] [int] NULL,
	[PPF] [int] NULL,
	[teamIDBR] [varchar](255) NULL,
	[teamIDlahman45] [varchar](255) NULL,
	[teamIDretro] [varchar](255) NULL
	) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamsFranchises]    Script Date: 8/5/2017 2:25:43 PM ******/
IF OBJECT_ID (N'dbo.TeamsFranchises', N'U') IS NOT NULL
DROP TABLE [dbo].[TeamsFranchises]
GO

/****** Object:  Table [dbo].[TeamsFranchises]    Script Date: 8/5/2017 2:25:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TeamsFranchises](
	[franchID] [varchar](255) NULL,
	[franchName] [varchar](255) NULL,
	[active] [varchar](255) NULL,
	[NAassoc] [varchar](255) NULL
	) ON [PRIMARY]
GO