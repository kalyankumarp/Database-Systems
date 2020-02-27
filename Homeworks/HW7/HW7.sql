use Sales;
select * from customer;
describe customer;

--- task 1
drop procedure if exists prc_cust_add;
delimiter $$
create procedure prc_cust_add (IN FName varchar(15), IN LName varchar(15), IN Initial varchar(1))
begin
	declare M_Id int;
    declare balance decimal(10,2);
	select max(CUS_CODE) into M_Id from customer;
    set balance = 0;
    insert into customer 
    values (M_id + 1, LName, FName, Initial, null, null, balance);
end$$
delimiter ;

call prc_cust_add("Kalyan Kumar", "Paladugula", "P");

select * from customer;

--- Task 3

select * from product;
DROP PROCEDURE if EXISTS prc_new_product;

-- Your code begins here
DELIMITER $$
create procedure prc_new_product(IN VN int(11), IN PC varchar(10), IN descr varchar(35))
begin
  if VN != all(select V_CODE from VENDOR) then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The vendor does not exist';
	else
    insert into PRODUCT values (PC, descr, now(), 0, 0, 1.00, 0, VN);
    select concat('The vendor name is ', VENDOR.V_NAME) as Output from VENDOR where V_CODE = VN;
  end if;
end$$
-- Your code ends here
DELIMITER ;

call prc_new_product(1, "ACME", "Real Product");
delete from PRODUCT where P_CODE = "EGG/TO";
call prc_new_product(24004, "EGG/TO", "Egg Parachute");
select * from VENDOR;

select  routine_name  from information_schema.routines
where routine_schema='Sales' and routine_name='prc_new_product' order by routine_name;

select * from vendor;


--- Task 5

drop function if exists TAX;
delimiter //

create function TAX (S decimal(8,2))
returns decimal(8,2)
deterministic
begin
	declare v decimal(8,2);
    set v = S*0.08;
    return TRUNCATE(v,2);
end//

delimiter ;

select TAX(150.00);

drop table cus_order;
create table cus_order as (select T.CUS_CODE, T.P_CODE, PRODUCT.P_QOH from (select INVOICE.INV_NUMBER, INVOICE.CUS_CODE, LINE.P_CODE, LINE.LINE_UNITS 
from INVOICE, LINE where INVOICE.INV_NUMBER  = LINE.INV_NUMBER) T, PRODUCT where T.P_CODE = PRODUCT.P_CODE);
select * from line;
describe PRODUCT;

--- TASK 6
drop procedure if exists prc_place_order; 
delimiter $$
create procedure prc_place_order(IN CC int, IN PC varchar(10), IN Q int, OUT inv int, OUT line int, OUT total decimal(8,2))
begin
	declare a int;
    declare price decimal(8,2);
    declare p decimal(8,2);
    declare d datetime;
    
    select P_QOH into a from PRODUCT where PRODUCT.P_CODE  = PC;
    select P_PRICE into price from PRODUCT where PRODUCT.P_CODE  = PC;
    if CC != all(select CUS_CODE from CUSTOMER) then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The Customer code does not exist';
    elseif  PC != all(select P_CODE from PRODUCT) then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The Product code does not exist';
    elseif Q > a then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The Quantity is out of range';
    else 
        set p = price * Q;  
        set total = p * 1.08;
        set d = now();
        insert into INVOICE(CUS_CODE, INV_DATE, INV_SUBTOTAL, INV_TAX, INV_TOTAL) values(CC, d, p, p*0.08, total);
        select INV_NUMBER into inv from INVOICE where INV_DATE = d;
        insert into LINE(INV_NUMBER, P_CODE, LINE_UNITS, LINE_PRICE, LINE_TOTAL) values(inv, PC, Q, price, total);
        select LINE_NUMBER into line from LINE order by INV_NUMBER desc limit 1;
    
        
	end if;
end$$    
delimiter ;



-- Your code ends here
DELIMITER ;

call prc_place_order(10012, 'PVC23DRT', 100 ,@T_INV_NUMBER, @T_LINE_NUMBER, @V_INV_TOTAL);

SELECT @T_INV_NUMBER, @T_LINE_NUMBER, @V_INV_TOTAL;
select * from PRODUCT;
describe PRODUCT;

drop table invoice;
--- TASK 7

drop procedure if exists prc_add_to_invoice; 
delimiter $$
create procedure prc_add_to_invoice(IN inv int, IN PC varchar(10), IN Q int)
begin
	declare a int;
    declare price decimal(8,2);
    declare p decimal(8,2);
    declare d datetime;
    
    select P_QOH into a from PRODUCT where PRODUCT.P_CODE  = PC;
    select P_PRICE into price from PRODUCT where PRODUCT.P_CODE  = PC;
    if PC != all(select P_CODE from PRODUCT) then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The Product code does not exist'; 
    elseif Q > a then
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The Quantity is out of range';
    else 
        set p = price * Q;  
        
        insert into LINE(INV_NUMBER, P_CODE, LINE_UNITS, LINE_PRICE, LINE_TOTAL) values(inv, PC, Q, price, p);
    
        
	end if;
end$$    
delimiter ;


call prc_add_to_invoice(1001, 'PVC23DRT', 50);
select * from line;
describe CUSTOMER;

drop table invoice;

--- TASK 8
use Sales;
describe INVOICE;
drop function if exists prc_cus_balance_update;

delimiter $$
create function prc_cus_balance_update(inv int)
returns decimal(10,2)
deterministic
begin
	declare CC int;
    declare total decimal(10,2);
    declare bal decimal(10,2);
    declare rem decimal(10,2);
    declare s varchar(100);
	select CUS_CODE into CC from INVOICE where INVOICE.INV_NUMBER  = inv;
    select INV_TOTAL into total from INVOICE where INVOICE.INV_NUMBER  = inv;
    select CUS_BALANCE into bal from CUSTOMER where CUS_CODE = CC;
    if bal - total < 0 then
		set @m = concat('Insufficient balance: Has ', bal,' needs ',total);
        signal sqlstate '45000'
        SET MESSAGE_TEXT = @m;
	else
		set rem  = bal - total;
		return rem;
    end if;
end$$

delimiter ;
select prc_cus_balance_update(1003);

--- Task 9
drop procedure if exists prc_restock;
delimiter $$

create procedure prc_restock()
begin
	create table t as (select P_CODE, P_MIN - P_QOH as difference, V_CODE from PRODUCT where P_QOH < P_MIN);
    select * from t;
End$$
delimiter ;

--- Task 10 
select * from INVOICE; 
drop procedure if exists prc_expunge_cust;
delimiter $$

create procedure prc_expunge_cust(IN CC int)
begin
	declare inv int;
    delete from LINE where LINE.INV_NUMBER in (select INV_NUMBER from INVOICE where CUS_CODE = CC);
	delete from INVOICE where INVOICE.CUS_CODE  = CC;
    delete from CUSTOMER where CUSTOMER.CUS_CODE = CC;
end$$

delimiter ;