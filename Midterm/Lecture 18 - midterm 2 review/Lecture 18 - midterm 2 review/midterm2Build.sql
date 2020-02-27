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


