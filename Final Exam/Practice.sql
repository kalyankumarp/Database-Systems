--- Variables

set @a = "Kalyan";

select @a into @b;

select @b;

--- This does not work
--- select @a = @c;
--- select @c;

--- Rollback

set autocommit = off;

start transaction;
set @a = "Kalyan";

select @a into @b;

select @b;
rollback;
commit;
--- Rollback only works with databases not variables

--- update join

CREATE DATABASE IF NOT EXISTS empdb;
 
USE empdb;
 
-- create tables
CREATE TABLE merits (
    performance INT(11) NOT NULL,
    percentage FLOAT NOT NULL,
    PRIMARY KEY (performance)
);
 
CREATE TABLE employees (
    emp_id INT(11) NOT NULL AUTO_INCREMENT,
    emp_name VARCHAR(255) NOT NULL,
    performance INT(11) DEFAULT NULL,
    salary FLOAT DEFAULT NULL,
    PRIMARY KEY (emp_id),
    CONSTRAINT fk_performance FOREIGN KEY (performance)
        REFERENCES merits (performance)
);
-- insert data for merits table
INSERT INTO merits(performance,percentage)
VALUES(1,0),
      (2,0.01),
      (3,0.03),
      (4,0.05),
      (5,0.08);
-- insert data for employees table
INSERT INTO employees(emp_name,performance,salary)      
VALUES('Mary Doe', 1, 50000),
      ('Cindy Smith', 3, 65000),
      ('Sue Greenspan', 4, 75000),
      ('Grace Dell', 5, 125000),
      ('Nancy Johnson', 3, 85000),
      ('John Doe', 2, 45000),
      ('Lily Bush', 3, 55000);

--- update inner join
UPDATE employees
        INNER JOIN
    merits ON employees.performance = merits.performance 
SET 
    salary = salary + salary * percentage;
    
UPDATE employees
        INNER JOIN
    merits ON employees.performance = merits.performance 
SET 
    employees.performance = employees.performance +1;
    
select * from employees;

--- update left join

INSERT INTO employees(emp_name,performance,salary)
VALUES('Jack William',NULL,43000),
      ('Ricky Bond',NULL,52000);

select * from employees
        LEFT JOIN
    merits ON employees.performance = merits.performance;
    
UPDATE employees
        LEFT JOIN
    merits ON employees.performance = merits.performance 
SET 
    salary = salary + salary * 0.015
WHERE
    merits.percentage IS NULL;
    
select * from employees;

--- delete join

--- delete inner join

DROP TABLE IF EXISTS t1, t2;
 
CREATE TABLE t1 (
    id INT PRIMARY KEY AUTO_INCREMENT
);
 
CREATE TABLE t2 (
    id VARCHAR(20) PRIMARY KEY,
    ref INT NOT NULL
);
 
INSERT INTO t1 VALUES (1),(2),(3);
 
INSERT INTO t2(id,ref) VALUES('A',1),('B',2),('C',3);

select * from t2;
	
DELETE t1,t2 FROM t1
        INNER JOIN
    t2 ON t2.ref = t1.id 
WHERE
    t1.id = 1;

select * from t1;

--- delete left join

INSERT INTO t1 VALUES (4);
select * from t1;
DELETE t1 
FROM t1
        LEFT JOIN
    t2 ON t2.ref = t1.id 
WHERE
    t2.ref IS NULL;
    
select * from t1;

--- WHere tuple comparision
use university;

select * from instructor;

select * from instructor where (ID, dept_name) = (15151, "Music");

select * from instructor, teaches where (instructor.ID, dept_name) = (teaches.ID, "Music");

--- subqueries in select clause
use university;
select dept_name, (select count(*) from instructor where instructor.dept_name  = department.dept_name) num 
from department; 

drop database if exists Olympics;
create database Olympics;
use Olympics;

drop table if exists TimedRun;
drop table if exists Participants;
drop table if exists Athletes;
drop table if exists Events;


create table Events
	(EventID		int,
	 EventName		varchar(15),
	 EventArena		int,
     ScoringType	varchar(7),
	 primary key (EventID)
	);
create table Athletes
	(AthleteID		int, 
	 AthleteFName	varchar(30), 
	 AthleteLName	varchar(30),
     Country		varchar(20),
	 primary key (AthleteID)
	);
create table Participants
	(AthleteID		int, 
	 EventID		int, 
	 Medal			varchar(6),
	 primary key (AthleteID,EventID),
	 foreign key (AthleteID) references Athletes(AthleteID)
		on delete cascade,
	 foreign key (EventID) references Events(EventID)
		on delete cascade
    );
create table TimedRun
	(AthleteID			int, 
	 EventID			int, 
	 runTime			time, 
	 RunNumber			int,
	 primary key (AthleteID,EventID,RunNumber),
	 foreign key (AthleteID) references Athletes(AthleteID)
		on delete cascade,
	 foreign key (EventID) references Events(EventID)
		on delete cascade
	);

INSERT INTO Athletes VALUES
(111,'Jane','Artielo','Belgium'),
(241,'Flash','Gordan','USA'),
(367,'Rosie','Beestinger','China'),
(440,'George','Lucas','USA'),
(501,'Viktor','Krum','Russia'),
(715,'Emily','Sweeney','Brazil');

INSERT INTO Events VALUES
(1,'Slalom',1,'Time'),
(2,'Long Jump',1,'Score'),
(3,'Luge',4,'Time'),
(4,'Figure Skating',3,'Score'),
(5,'Curling',2,'Points');


INSERT INTO Participants VALUES
(111,4,NULL),
(241,4,'Bronze'),
(111,2,'Gold'),
(440,5,'Silver'),
(501,1,NULL);

INSERT INTO TimedRun VALUES
(501,1,'1:01',1),
(501,3,'1:32',1),
(367,1,'1:15',1),
(241,3,'1:52',1),
(241,3,NULL,2),
(241,3,'1:41',3);


with g (Country, Medal, C) as (select Athletes.Country, Participants.Medal, count(Participants.Medal) c 
from Athletes, Participants 
where Athletes.AthleteID = Participants.AthleteID group by Athletes.Country, Participants.Medal)

select distinct Country, (select count(*) from g where g.Medal = "Gold" and g.Country = Athletes.Country) G, 
(select count(*) from g where g.Medal = "Silver" and g.Country = Athletes.Country) S, 
(select count(*) from g where g.Medal = "Bronze" and g.Country = Athletes.Country) B from Athletes; 




