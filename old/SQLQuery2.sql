create database myFirstDatabase
use myFirstDatabase
create table student (
	student_id INT  ,
	student_name varchar(50)  default 'undefiend' ,
	major varchar(10)unique,
	primary key(student_id)
);
--drop table student;
-- delet a table
--drop table student3011;
-- add a colum
--alter table student add gpa decimal(3,2);
--drop colum
--alter table student drop column gpa;
-- insert into student values(17,'eprahim','oi');
--insert into student(student_id,student_name) values(14,'mohamed');

insert into student values(5,'me','lk');
select* from student;

update student 
set major ='changed'
where major='lk';

update student
set major ='changed2'
where student_id=2;

update student
set student_name='we'
where student_name= 'ahmed' or student_name= 'me';

update student
set student_name= 'ahmed' , student_id= '10'
where student_name='adel' ;

update student
set student_name= 'ahmed' ;

delete from student
where major='it';

delete from student
where major='changed' or student_id=10;

delete from student;
select* from student;


  
