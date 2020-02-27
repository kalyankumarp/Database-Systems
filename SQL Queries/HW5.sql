DROP DATABASE IF EXISTS Industry;

create database Industry;
use Industry;
show tables;
create table Employee(
  Employee_ID int,
  Employee_Fname varchar(50),
  Employee_Lname varchar(50),
  Employee_HireDate varchar(20),
  Employee_Title varchar(50),
  primary key(Employee_ID));
insert into Employee values(2345,"Brian","Oates","2/14/99","DBA");
insert into Employee values(3373,"Franklin","Johnson","3/15/06","Purchasing Agent");
insert into Employee values(4893,"Patricia","Richards","6/11/08","DBA");
insert into Employee values(6234,"Jasmine","Patel","8/10/09","Programmer");
insert into Employee values(8273,"Marco","Bienz","7/28/10","Analyst");
insert into Employee values(9002,"Wade","Gather","5/20/14","Clerk");
insert into Employee values(9283,"Juan","Chavez","7/4/14","Clerk");
insert into Employee values(9382,"Susan","Mathis","8/2/14","Database Programmer");
insert into Employee values(13383,"Raymond","Matthews","3/12/16","Programmer");
select * from Employee order by Employee_ID;

create table Certified(
	Employee_ID int,
    Skill_ID int,
    Employee_HireDate varchar(20));
insert into Certified values(2345,100,"2/14/04");
insert into Certified values(2345,110,"8/9/05");
insert into Certified values(2345,180,"2/14/07");
insert into Certified values(3373,120,"6/20/13");
insert into Certified values(4893,180,"6/11/08");
insert into Certified values(4893,220,"9/20/14");
insert into Certified values(6234,110,"8/10/09");
insert into Certified values(6234,200,"8/10/09");
insert into Certified values(6234,210,"1/29/14");
insert into Certified values(8273,110,"3/8/11");
insert into Certified values(8273,190,"8/19/14");
insert into Certified values(9002,110,"5/16/15");
insert into Certified values(9002,120,"5/16/15");
insert into Certified values(9382,140,"8/2/14");
insert into Certified values(9382,210,"8/2/14");
insert into Certified values(9382,220,"5/1/15");
insert into Certified values(13383,170,"3/12/16");
select * from Certified order by Employee_ID;

create table Skill(
	Skill_ID int,
    Skill_Name varchar(500),
    Skill_Description varchar(1000),
    primary key(Skill_ID));
    
insert into Skill values(100,"Basic Database Management","Create and manage database user accounts");
insert into Skill values(110,"Basic Web Design","Create and maintain HTML and CSS documents");
insert into Skill values(120,"Advanced Spreadsheets","Use of advanced functions, user-defined functions, and macroning");
insert into Skill values(130,"Basic Process Modeling","Create core business process models using standard libraries");
insert into Skill values(140,"Basic Database Design","Create simple data models");
insert into Skill values(150,"Master Database Programming","Create integrated trigger and procedure packages for a distributed environment");
insert into Skill values(160,"Basic Spreadsheets","Create single tab worksheets with basic formulas");
insert into Skill values(170,"Basic C# Programming","Create single-tier data aware modules");
insert into Skill values(180,"Advanced Database Management","Manage Database Server Clusters");
insert into Skill values(190,"Advanced Process Modeling","Evaluate and Redesign cross-functional and external business processes");
insert into Skill values(200,"Advanced C# Programming","Create multi-tier applications using multi-threading");
insert into Skill values(210,"Basic Database Manipulation","Create simple data retrieval and manipulation statements in SQL");
insert into Skill values(220,"Advanced Database Manipulation","Use of advanced data manipulations methods for multi-table inserts, sets operations and correlated subqueries");
select * from Skill order by Skill_ID;

create table PositionRequirements(
	Employee_Title varchar(50),
    Skill_ID int);
    
insert into PositionRequirements values("Clerk",100);
insert into PositionRequirements values("Programmer",110);
insert into PositionRequirements values("Programmer",130);
insert into PositionRequirements values("Programmer",170);
insert into PositionRequirements values("Analyst",120);
insert into PositionRequirements values("Analyst",130);
insert into PositionRequirements values("Analyst",160);
insert into PositionRequirements values("Analyst",140);
insert into PositionRequirements values("Purchasing Agent",160);
insert into PositionRequirements values("Database Programmer",140);
insert into PositionRequirements values("Database Programmer",210);
insert into PositionRequirements values("Database Programmer",100);
insert into PositionRequirements values("Database Programmer",220);
insert into PositionRequirements values("DBA",180);
insert into PositionRequirements values("DBA",150);
select * from PositionRequirements;