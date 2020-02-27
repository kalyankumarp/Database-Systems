-- Produce a summary of account interactions for a particular account/user"

use bank;

drop procedure if exists Summary;

delimiter //

create procedure Summary (in FN varchar(20), in LN varchar(20), in MN varchar(20), out sum decimal(15,2), out avg decimal(15,2))

begin
	select sum(c.Balance), avg(c.Balance) into sum, avg 
    from Customers a, HasAccount b, Account c, Transactions d
    where a.PID = b.PID and b.AccountID = c.AccountID and c.AccountID  = d.AccountID 
    and (a.FName  = FN) and (a.LName = LN) and (a.MName = MN);
end//

delimiter ;