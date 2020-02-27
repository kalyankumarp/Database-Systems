-- Write a function PaySavingsInterest which takes no parameters 
-- and updates all the accounts with type Savings by paying 
-- interest to those accounts.

DELIMITER XX

CREATE FUNCTION PaySavingsInterest()
RETURNS INT
BEGIN
    DECLARE NumSavings INT;

    UPDATE Account, AccountType 
    SET Balance = Balance+Balance*InterestRate*.01
    WHERE Account.TypeID = AccountType.TypeID
    AND AccountType.TypeName = 'Savings';

    SELECT COUNT(*) INTO NumSavings
    FROM Account NATURAL JOIN AccountType
    WHERE AccountType.TypeName = 'Savings';

    RETURN NumSavings;
END;
XX

DELIMITER ;