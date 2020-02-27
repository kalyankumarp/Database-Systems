-- Write one or more triggers to guarantee that the balance 
-- of the accounts table never goes below 0, 
-- throwing an exception if a change to the table 
-- would result in a balance containing a negative value.

CREATE TRIGGER ON Account BEFORE UPDATE
FOR EACH ROW
BEGIN
    IF NEW.Balance < 0  THEN
        SIGNAL STATE '45000'
        SET MESSAGE_TEXT = 'Negative Balance not allowed';
    END IF;
END;


CREATE TRIGGER ON Account BEFORE INSERT
FOR EACH ROW
BEGIN
    IF NEW.Balance < 0  THEN
        SIGNAL STATE '45000'
        SET MESSAGE_TEXT = 'Negative Balance not allowed';
    END IF;
END;

    UPDATE Account 
    SET Balance = Balance - NEW.Amount
    WHERE NEW.FromAccount = AccountID;
    
    UPDATE Account 
    SET Balance = Balance + NEW.Amount
    WHERE NEW.ToAccount = AccountID;
    

END



INSERT INTO Transactions(Amount, FromAccount, ToAccount) VALUES (100, @a, @b)

CREATE TRIGGER ON Transactions BEFORE INSERT
FOR EACH ROW
BEGIN
    UPDATE Account 
    SET Balance = Balance - NEW.Amount
    WHERE NEW.FromAccount = AccountID;
    
    UPDATE Account 
    SET Balance = Balance + NEW.Amount
    WHERE NEW.ToAccount = AccountID;
    

END

    TransactionID INT,
 	Amount DECIMAL(15,2),
 	Timestamp TIMESTAMP,
	FromAccount INT,
 	ToAccount INT NOT NULL,

