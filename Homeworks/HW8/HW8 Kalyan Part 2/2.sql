use bank;

drop function if exists PaySavingsInterest;
delimiter //

create function PaySavingsInterest ()
returns varchar(20)
deterministic
begin
    declare interest decimal(4,2);
    declare type smallint;
    declare msg varchar(20);
    select a.TypeID, a.InterestRate into type, interest from AccountType a where a.TypeName = "Savings"; 
	update Account 
		set Balance  =  Balance + Balance *(interest/100) where AccountID.TypeId = type;
	set msg  = "Balances of Savings Accounts are updated";
	return msg;
end//
 delimiter ;