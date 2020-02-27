-- Write a function ApplyInterest which takes an 
-- account number as a parameter and 
-- adds to the balance the current balance 
-- multiplied by the interest rate of that account.  

DELIMITER YOYO

CREATE FUNCTION ApplyInterest(AcctNumber INT)
RETURNS DECIMAL(15,2)
BEGIN
    DECLARE NewBalance DECIMAL(15,2);
    
    SELECT Balance+Balance*InterestRate INTO NewBalance
    FROM Account, AccountType 
    WHERE Account.TypeID = AccountType.TypeID
    AND AccountID = AcctNumber;
    
    RETURN NewBalance;
END;
YOYO

DELIMITER ;
