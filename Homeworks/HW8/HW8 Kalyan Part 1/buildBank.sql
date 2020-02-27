drop database if exists Bank;
create database Bank;
use Bank;

create table Customers(
	ID int auto_increment, 
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
    primary key(ID));

create table Accounts(
	Acc_No int auto_increment,
    Acc_Type varchar(10) not null,
    Amount float not null,
    interest decimal(4,2) not null,
    check (Amount >= 0 and interest >= 0), 
    primary key(Acc_No));
  
create table Transfers (
	Transfer_Id int auto_increment, 
    Transfer_Type varchar(10) not null, 
    Transfer_TimeStamp TIMESTAMP not null, 
    Transfer_Amount float not null, 
    Transfer_Description varchar(100),
    FromAcc_No int, 
    ToAcc_No int,
	foreign key (FromAcc_no) references Accounts (Acc_No) on delete cascade,
    foreign key (ToAcc_No) references Accounts (Acc_No) on delete cascade,
    check (Transfer_Amount >= 0),
    primary key (Transfer_Id));
    
create table Transactions(
	Transaction_Id int auto_increment, 
    Transaction_Type varchar(10) not null, 
    Acc_No int, 
    Transaction_Amount float not null, 
    Transaction_TimeStamp timestamp not null, 
    Transaction_Description varchar(100),
    foreign key (Acc_no) references Accounts (Acc_No) on delete cascade,
    check (Transaction_Amount >= 0),
    primary key (Transaction_Id));
    
create table HasAccount(
	ID int,
    Acc_No int,
    foreign key (ID) references Customers (ID) on delete cascade,
    foreign key (Acc_No) references Accounts (Acc_No) on delete cascade,
    primary key(ID, Acc_No));
    

	
    
    
insert into Customers 
 values (6, "Kalyan Kumar", "Paladugula", null, "1997-01-24", 3125328656, "kalyanpaladugula@gmail.com", 100, 710, "S Loomis", "Chicago", 60607);
insert into Accounts values (4, "SB", 100, 2);
insert into HasAccount values (6,4);

select * from HasAccount;

delete from Customers where ID = 6;
select * from HasAccount;
