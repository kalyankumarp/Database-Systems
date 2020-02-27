drop database if exists bank;
create database bank;
use bank;

create table Customers(
	PID int auto_increment, 
    FName varchar(20) not null,
    LName varchar(20) not null, 
    MName varchar(20), 
    DOB date, 
    Phone_Number bigint(10) not null, 
    Email varchar(50), 
    Credit_Score int(10), 
    AptNo int(10) not null, 
    Street varchar(20) not null, 
    City varchar(20) not null, 
    Zipcode int(6)  not null,
    primary key(PID));


  
create table AccountType (
	TypeID smallint auto_increment, 
    TypeName varchar(10) not null, 
    interest decimal(4,2) not null,
    primary key (TypeID));
 
 create table Account(
	AccountID bigint auto_increment,
	Balance decimal(15,2) not null,
    TypeID smallint,
    check (Balance >= 0),
    foreign key (TypeID) references AccountType(TypeID),
    primary key(AccountID));
    
create table Transactions(
	Transaction_Id int auto_increment, 
    FromAcc_No bigint,
    ToAcc_No bigint,
    Transaction_Amount decimal(15,2) not null, 
    Transaction_TimeStamp timestamp not null, 
    Transaction_Description varchar(100),
    foreign key (FromAcc_No) references Account (AccountID) on delete cascade,
    foreign key (ToAcc_No) references Account (AccountID) on delete cascade,
    check (Transaction_Amount >= 0),
    primary key (Transaction_Id));
    
create table HasAccount(
	PID int,
    AccountID bigint,
    foreign key (PID) references Customers (PID) on delete cascade,
    foreign key (AccountID) references Account (AccountID) on delete cascade,
    primary key(PID, AccountID));
    

	
    
    

