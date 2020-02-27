-- Write a transaction which initiates a transfer of funds 
-- between the account with ID stored in 
-- variable @a and the account with the ID stored in variable @b,
-- having @a pay @b the amount stored in the variable @amount. 

START TRANSACTION

INSERT INTO Transactions(TransactionID, Amount, Timestamp, FromAccount, ToAccount) 
VALUES (1, @amount, NOW(), @a, @b)

UPDATE Account 
SET Balance = Balance - NEW.Amount
WHERE NEW.FromAccount = AccountID;
    
UPDATE Account 
SET Balance = Balance + NEW.Amount
WHERE NEW.ToAccount = AccountID;

COMMIT