SET autocommit = OFF;

start transaction;


update Account set Balance= Balance - @amount where AccountID = @a;
update Account set Balance= Balance + @amount where AccountID = @b;

commit;


