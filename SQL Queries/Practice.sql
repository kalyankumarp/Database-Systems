use University;
show tables;
select distinct * from student;
select distinct dept_name from student;
select distinct dept_name, tot_cred from student;
select count(dept_name) from student;
select count(distinct dept_name) from student;
select * from student where name = "Kalyan";
select * from student where name = "Kalyan" or name = "Shankar";
select * from student where ID <= 98989;
select * from student where ID <= "98989";
select * from student where ID between 70000 and 98989;
select * from student where ID between 70557 and 98989;
select * from student where ID between "70557" and "98989";
select * from student where name like "S%";
select * from student where name like "S%";
select * from student where name like "%S";
select * from student where name like "w%S";
select * from student where (dept_name = "Comp. Sci.") and (ID = 54321 and name like "W%S");
select * from student where dept_name = "Comp. Sci.";
select * from student order by tot_cred, name;
select * from student order by tot_cred;
select * from student order by tot_cred desc;
select * from student order by tot_cred desc, name desc;
select * from student order by tot_cred desc, name;
insert into student values("90909", "Kumar", "Comp. Sci.", "103");
select * from student;
insert into student (ID, name, dept_name) values ("09000", "KK", "Comp. Sci.");
select * from student;
select * from student where tot_cred is null;
select * from student where tot_cred is not null;
update student set name = "Zhang" where dept_name = "Comp. Sci.";
select * from student;
delete from student where name = "Zhang";
select * from student limit 3; 
select * from student limit 5;
select name as Student_name from student;
select * from instructor;
select min(salary) from instructor;
select min(salary) as Minimum_salary from instructor;
select count(*) from instructor;
select sum(salary) from instructor;
select avg(salary) from instructor;
select * from instructor where name like "%ol%";
select * from instructor where ID like "%45%";
select * from instructor where name like "_a%";
select * from instructor where name like "__a%";
select * from instructor where name like "g_%";
select * from instructor where name like "go__%";
select * from instructor where name like "go______%";
select * from instructor where name not like "%ol%";
select * from instructor where ID not like "%45%";
select * from instructor where name not like "_a%";
select * from instructor where name not like "__a%";
select * from instructor where name not like "g_%";
select * from instructor where name not like "go__%";
select * from instructor where name not like "go______%";
select * from instructor where name in ("srinivasan", "Wu");

select * from student join instructor;
select * from student inner join instructor;

select * from student join instructor on student.dept_name  = instructor.dept_name; 
select * from student inner join instructor on student.dept_name  = instructor.dept_name; 

select * from student left join instructor on student.ID = instructor.ID; 
select * from student right join instructor on instructor.ID  = student.ID;

select * from student FULL OUTER JOIN instructor on instructor.ID  = student.ID;

select * from student union select * from instructor;
select * from student union all select * from instructor;

describe student;

select dept_name, count(name) from instructor group by dept_name;
select dept_name, count(name) as Number from instructor group by dept_name;

select * from teaches;

select instructor.name, student.name from instructor, advisor, student where instructor.ID  = advisor.i_ID and student.ID  = advisor.s_ID;
select instructor.name, count(student.name) as Number from instructor, advisor, student where instructor.ID  = advisor.i_ID and student.ID  = advisor.s_ID
group by instructor.name;
select instructor.name, student.name from instructor, advisor, student where instructor.ID  = advisor.i_ID and student.ID  = advisor.s_ID
group by instructor.name, student.name;
select student.name, instructor.name from instructor, advisor, student where instructor.ID  = advisor.i_ID and student.ID  = advisor.s_ID
group by student.name, instructor.name;


select instructor.name as Instructor_name, count(student.name) as Number from instructor, advisor, student where instructor.ID  = advisor.i_ID and student.ID  = advisor.s_ID
group by instructor.name
having count(student.name) > 1;
select instructor.name as Instructor_name, count(student.name) as Number from instructor, advisor, student where instructor.ID  = advisor.i_ID and student.ID  = advisor.s_ID
group by instructor.name
having Number > 1;

select instructor.name as Instructor_name, count(student.name) as Number from instructor, advisor, student where instructor.ID  = advisor.i_ID and student.ID  = advisor.s_ID
group by instructor.name
having Instructor_name = "Katz";





create database db;
drop database db;

create table instruc(ID varchar(5), name varchar(20), dept_name varchar(20), salary varchar(10));
drop table instruc;

create table instruc as select * from instructor;
select * from instruc;

truncate table instruc;
select * from instruc;
drop table instruc;

create table instruc as select * from instructor;
alter table instruc add age varchar(3);
select * from instruc;

alter table instruc drop column age;
select * from instruc;

describe instruc;
alter table instruc modify column salary varchar(10);
describe instruc;
select * from instruc;

