use Spring_2019_BaseBall
go

if OBJECT_ID('ss3875_Player_History','V') is not null
drop view ss3875_Player_History;
go

---Question 1 create view---
create view ss3875_Player_History as

with 
Player_info(playerid, player_Fullname) as
	(select playerid, namefirst+'('+namegiven+')'+namelast as player_Fullname
		from People),
Appearance_info (playerid,Num_Teams,Num_years,Last_played) as
	(select playerid,count(distinct teamid) as Num_Teams, (max(yearid)- min(yearid) + 1) as Num_years,max(yearid) as Last_played
		from Appearances
		group by playerid ),
Halloffame_info (playerid,HallofFamer) as
	(select playerid,
		(CASE WHEN people.playerid in (select playerid from HallOfFame) THEN 'Hall of Famer'
	        ELSE 'Not Inducted' END) as Hall_Of_Famer
	from people),
Salary_info (playerid,Avg_Salary,Total_Salary) as
	(select people.playerid,format(avg(Salary),'C') as Avg_Salary,format(sum(Salary),'C') as Total_Salary
		from Salaries,people
		where Salaries.playerID=People.playerID
		group by people.playerid),
Collegeplaying_info (playerid,Name_lastcollege,year_lastplay,Num_CollegeYears,Num_colleges) as
	(select a.playerID, max(name_full) as Name_lastcollege,year_lastplay,Num_CollegeYears,Num_colleges
		from schools,collegeplaying,
			(select playerid,max(yearid) as year_lastplay,count(distinct schoolid) as Num_colleges, count(distinct(yearid)) as Num_CollegeYears
				from collegeplaying
				group by playerid ) a
		where CollegePlaying.playerID=a.playerID and
			  CollegePlaying.yearid=year_lastplay and
	          schools.schoolID=CollegePlaying.schoolID
		group by a.playerID,year_lastplay,Num_CollegeYears,Num_colleges),
Batting_info (playerid,Career_HR,Career_BA,Max_BA) as
	(select batting.playerid, sum(HR) as Career_HR, Convert(decimal(5,4), (X*1.0/Y)) as Career_BA,Convert(decimal(5,4),Max_BA) as Max_BA
		from batting, (select playerid, sum(H) as X, sum(AB) as Y, max((H*1.0/AB)) as Max_BA
							from Batting 
							where AB > 0 
							group by playerid)z
		where batting.playerID=z.playerID
		group by batting.playerID,X,Y,Max_BA),
Pitching_info (playerid,Pitcher_Career_Wisn,Pitcher_CareerLosses,Career_Avg_ERA,HighERA,Career_SO,H_SO) as
	(select playerid, sum(W) as Pitcher_Career_Wins, sum(L) as Pitcher_Career_Losses,Convert(decimal(10,4), 
			avg(ERA)) as Career_Avg_ERA, max(ERA) as HighERA, sum(SO) as Career_SO, max(SO) as H_SO 
		from Pitching
		group by playerid),
Awardsplayer_info (playerid,No_Awards) as
	(select playerid,count(awardid) as No_Awards
		from AwardsPlayers
		group by playerid),
Awardsplayershare_info (playerid,No_ShareAwards) as
	(select playerid,count(awardid) as No_ShareAwards
		from AwardsSharePlayers
		group by playerid),
LastTeam_Info (playerid, Last_teamid) as
	(select distinct Appearances.playerid, max(teamid) as Last_teamid
        from Appearances, (select playerid, max(yearid) as A from Appearances group by playerid) B
        where Appearances.playerid= B.playerid and
	          Appearances.yearid = B.A
		group by Appearances.playerid, A)

select distinct Player_info.playerid,
player_Fullname,
HallofFamer,
Avg_Salary,Total_Salary,
Num_Teams,Num_years,
Name_lastcollege,year_lastplay,Num_CollegeYears,Num_colleges,
Career_HR,Career_BA,Max_BA,
Pitcher_Career_Wisn,Pitcher_CareerLosses,Career_Avg_ERA,HighERA,Career_SO,H_SO,
No_Awards,
No_ShareAwards,
Last_played,
Last_teamid

from Player_info 
left join Appearance_info on Player_info.playerid= Appearance_info.playerid
left join Batting_info on Player_info.playerid=Batting_info.playerid
left join Pitching_info on Player_info.playerid=Pitching_info.playerid
left join Collegeplaying_info on Player_info.playerid=Collegeplaying_info.playerid
left join Salary_info on Player_info.playerid=Salary_info.playerid
left join Awardsplayershare_info on Player_info.playerid=Awardsplayershare_info.playerid
left join Awardsplayer_info on Player_info.playerid=Awardsplayer_info.playerid
left join Halloffame_info on Player_info.playerid=Halloffame_info.playerid
left join LastTeam_Info on Player_info.playerid=LastTeam_Info.playerid 
go

---Question 2 retrieve all the data---
select * from ss3875_Player_History

---Question 3 create a role to either access and no access to salaries table---

create role Guest_AccessRole;

---Have access to view---
grant select on ss3875_Player_History to Guest_AccessRole;

---No access to salaries Table
deny select, insert, update, delete on Salaries to Guest_AccessRole;