-- Write a procedure GetAccountInfo which takes a Customer ID 
-- as a parameter and during execution selects a 
-- table containing the 
-- account number, balance, and account type of 
-- each of the accounts owned by the customer.

DELIMITER ZZZ

CREATE PROCEDURE GetAccountInfo(IN CustID INT)
BEGIN
    SELECT AccountID AS AccountNumber, Balance, TypeName
    FROM Person NATURAL JOIN Account NATURAL JOIN AccountType
    WHERE PID = CustID;
END;
ZZZ

DELIMITER ;