use University;

select * from takes;
select * from instructor;
select distinct T.name from instructor T, instructor S where T.salary > S.salary and S.dept_name = "Comp. Sci.";
select name from instructor where name like "%Wu%";
select name, course_ID from instructor, teaches where (instructor.ID,dept_name) = (teaches.ID,"Comp. Sci.");
select dept_name, avg(salary) AVG from instructor group by dept_name; 
select dept_name, avg(salary) as AVG from instructor group by dept_name having AVG > 72000;

select course_id from section where semester = "Fall" and year = 2009 
and (course_id in (select course_id from section where semester = "Spring" and year = 2010));

select course_id from section where semester = "Fall" and year = 2009 
and (course_id not in (select course_id from section where semester = "Spring" and year = 2010));

select name from instructor where salary > some(select salary from instructor where dept_name = "Biology");

select name from instructor where salary > some(select salary from instructor where dept_name = "Comp. Sci.");

select name from instructor where salary > any(select salary from instructor where dept_name = "Biology");

select name from instructor where salary > all(select salary from instructor where dept_name = "Biology");

select name from instructor where salary > all(select salary from instructor where dept_name = "Comp. Sci.");

select course_id from section S where semester = "Fall" and year = 2009 and 
exists (select * from section T where semester = "Spring" and year = 2010 and T.course_id = S.course_id);

select course_id from section T 
where  course_id in (select S.course_id from section S where S.course_id = T.course_id and year = 2009);

select T.dept_name, T.AVG from 
(select dept_name, avg(salary) as AVG from instructor group by dept_name) T where AVG > 42000;

select T.dept_name, T.AVG from 
(select dept_name, avg(salary) as AVG from instructor group by dept_name) T where AVG > 42000;

with max_budget(valu) as (select max(budget) from department)
select dept_name from department,max_budget where department.budget = valu;

with total_salary(dept_name,value) as (select dept_name, sum(salary) from instructor group by dept_name),
     total_avg_salary(AVG) as (select avg(value) from total_salary)
select dept_name from total_salary, total_avg_salary where value>AVG;

select dept_name, (select count(*) from instructor where instructor.dept_name = department.dept_name) as num 
from department;

create view v as(select * from instructor);
update v set salary = case when salary > 100000 then salary*1.03
								else salary*1.05
                                end;
use University;
select * from takes order by year;
select * from student;
insert into student values(11111, "Kalyan", "Comp. Sci.", 100);
insert into takes values(11111, "CS-319", 1, "Spring", 2010, "A");
delete from student where name = "Kalyan";
with s(name, year) as (select student.name, takes.year from student, takes where student.ID = takes.ID and takes.year<=2009),
      t(name1, year1) as (select student.name, takes.year from student, takes where (student.ID = takes.ID) and (takes.year > 2009))
select name1 name, year1 year from t left join s  on s.name = t.name1 where s.name is null;


select student.name, takes.year from student, takes where student.ID = takes.ID order by student.name;