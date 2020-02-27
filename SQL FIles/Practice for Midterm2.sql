use University;
select title from course where (dept_name = "Comp. Sci.") and credits = 3;

select * from advisor;
select * from student, advisor, instructor where student.ID = advisor.s_ID and instructor.ID = advisor.i_ID;
select distinct student.ID from student, advisor, instructor where student.ID = advisor.s_ID and instructor.ID = advisor.i_ID and instructor.name = "Einstein";

select * from student join takes using(ID);

select * from instructor;
select max(salary) from instructor;

