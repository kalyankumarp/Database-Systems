use bank;

drop procedure if exists GetAccountInfo;

delimiter //

create procedure GetAccountInfo (in CID int)

begin
	select c.AccountID, c.Balance, d.TypeName 
    from Customers a, HasAccount b, Account c, AccountType d
    where a.PID = b.PID and b.AccountID = c.AccountID and c.TypeID  = d.TypeID and a.PID = CID;
end//

delimiter ;