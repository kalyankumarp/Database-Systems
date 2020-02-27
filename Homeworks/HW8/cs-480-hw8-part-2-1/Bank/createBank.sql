DROP TABLE IF EXISTS Person;
CREATE TABLE Person
(
 	PID int AUTO_INCREMENT, 
 	Address VARCHAR(180), 
 	FirstName VARCHAR(30), 
 	MiddleInitial CHAR(1), 
 	LastName VARCHAR(30), 
 	PhoneNumber VARCHAR(15), 
 	Email VARCHAR(50), 
 	DOB Date, 
    CreditScore INT,
 	PRIMARY KEY (PID)
);

DROP TABLE IF EXISTS AccountType;
CREATE TABLE AccountType
(
 	TypeID INT,
 	TypeName VARCHAR(20),
 	InterestRate DECIMAL(6,3),
    MinBalance DECIMAL(15,2),
 	PRIMARY KEY (TypeID)
);

DROP TABLE IF EXISTS Account;
CREATE TABLE Account
(
 	AccountID INT,
 	Balance DECIMAL(15,2),
 	TypeID INT,
	PID INT,
 	PRIMARY KEY (AccountID),
 	FOREIGN KEY (TypeID) REFERENCES AccountType (TypeID),
	FOREIGN KEY (PID) REFERENCES Person (PID)
);


DROP TABLE IF EXISTS Transaction;
CREATE TABLE Transaction
(
	TransactionID INT,
 	Amount DECIMAL(15,2),
 	Timestamp TIMESTAMP,
	FromAccount INT,
 	ToAccount INT NOT NULL,
	PRIMARY KEY (TransactionID),
 	FOREIGN KEY (FromAccount) REFERENCES Account (AccountID),
	FOREIGN KEY (ToAccount) REFERENCES Account (AccountID)
);

DROP TABLE IF EXISTS TransactionComment;
CREATE TABLE TransactionComment
(
    TransactionID INT,
    Comment TEXT,
    PRIMARY KEY (TransactionID),
    FOREIGN KEY (TransactionID) REFERENCES Transaction(TransactionID)
);


