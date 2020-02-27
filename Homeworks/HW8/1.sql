use bank;
drop function if exists ApplyInterest; 
delimiter //


create function ApplyInterest (acc_no bigint)
returns decimal(15,2)
deterministic
begin
	declare bal decimal(15,2);
    declare interest decimal(4,2);
    select a.Balance, b.InterestRate into bal, interest from  Account a, AccountType b where a.TypeID = b.TypeID and a.AccountID = acc_no;
	update Account 
		set Balance  = bal + bal *(interest/100) where AccountID = acc_no;
	return bal + bal *(interest/100);
end//
 delimiter ;