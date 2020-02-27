use bank;

drop trigger if exists balCheckonInsertionTransactions;
drop trigger if exists balCheckonUpdationTransactions; 
drop trigger if exists balCheckonUpdationAccount; 
drop trigger if exists balCheckonUpdationAccount; 

delimiter //
 
create trigger balCheckonInsertionTransactions before insert on Transactions
for each row
begin 
   declare bal decimal(15,2);
   select a.Balance into bal from Account a, Transactions b 
   where (a.AccountID = new.FromAcc_No or a.AccountID = new.ToAcc_No);
   if bal - new.Transaction_Amount < 0 then
	signal sqlstate '45000'
	set message_text = 'The balance goes below zero after the insertion';
   end if;
end//
delimiter ;


delimiter //
 
create trigger balCheckonUpdationTransactions before update on Transactions
for each row
begin 
   declare bal decimal(15,2);
   select a.Balance into bal from Account a, Transactions b 
   where (a.AccountID = new.FromAcc_No or a.AccountID = new.ToAcc_No);
   if bal - new.Transaction_Amount < 0 then
	signal sqlstate '45000'
	set message_text = 'The balance goes below zero after the updation';
   end if;
end//
delimiter ;

delimiter //
 
create trigger balCheckonInsertionAccount before insert on Account
for each row
begin 
   if new.Balance < 0 then
	signal sqlstate '45000'
	set message_text = 'The balance goes below zero after the updation';
   end if;
end//
delimiter ;


delimiter //
 
create trigger balCheckonUpdationAccount before update on Account
for each row
begin 
   if new.Balance < 0 then
	signal sqlstate '45000'
	set message_text = 'The balance goes below zero after the updation';
   end if;
end//
delimiter ;