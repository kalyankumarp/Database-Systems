-- prevent a withdrawal if the withdrawal exceeds the balance associated with account?

use bank;
drop trigger if exists balCheckonWithdrawal; 

delimiter //
 
create trigger balCheckonWithdrawal before insert on Transactions
for each row
begin 
   declare bal decimal(15,2);
   select a.Balance into bal from Account a, Transactions b 
   where a.AccountID = b.AccountID and b.Transaction_Id = new.Transaction_Id;
   if bal - new.Transaction_Amount < 0 then
	signal sqlstate '45000'
	set message_text = 'The balance goes below zero after the insertion';
   end if;
end//
delimiter ;