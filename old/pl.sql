--//1
create database pl_project
use pl_project

-----------------------------------


--//5
create table student
(
	std_id int primary key identity(1,1),
	std_name varchar(50),
	std_pass int not null,
	std_userName varchar(50) unique
);
--exec sp_help student;
-----------------------------------


--//4
create table course
(
	cuo_id int primary key identity(1,1),
	instructor_id int foreign key references instructor (inst_id) on delete cascade on update cascade,
	cou_name varchar(50), 
	room int,
	course_price int,
	parent_course_name varchar(50),
	parent_course_price int,
	start_course_date date,
	cur_date date,
	end_course_date date,
	days_of_course varchar(50),
);
--exec sp_help course;
-----------------------------------


--//3
create table  instructor
(
	inst_id int primary key identity(1,1),
	inst_name varchar(50), 
	inst_pass int not null,
	inst_userName varchar(50) unique
);
--exec sp_help instructor
-----------------------------------------


--//2
create table  adminn
(
	admin_id int primary key identity(1,1),
	admin_name varchar(50), 
	admin_pass int not null,
	admin_userName varchar(50) unique
);
--exec sp_help adminn
----------------------------------------


--//6
create table  std_reg_cou
(
	student_id int foreign key references student (std_id) on delete cascade on update cascade, 
	course_id int foreign key references course (cuo_id) on delete cascade on update cascade,
	cource_grade int,
	constraint s_r_c primary key(student_id,course_id)	 
);
--exec sp_help std_reg_cou
-------------------------------------


--//7

insert into adminn values ('ahmed',123,'admin1');
insert into adminn values ('naser',345,'admin2');
insert into adminn values ('abdelstar',876,'admin3');
insert into adminn values ('bakar',985,'admin4');
select*from adminn;

insert into instructor values ('saif',123,'instructor1');
insert into instructor values ('eldeen',345,'instructor2');
insert into instructor values ('ahmed',876,'instructor3');
insert into instructor values ('saif',985,'instructor4');
select*from instructor;

insert into course values (1,'al',3,3000,'rr',4000,'2020-02-01','2020-03-01','2020-07-05','mon');
insert into course values (3,'it',9,3000,'ff',4000,'2020-01-01','2020-03-01','2020-06-05','mon');
insert into course values (2,'is',7,3000,'df',4000,'2020-02-01','2020-03-01','2020-09-05','mon');
insert into course values (4,'mm',6,3000,'hh',4000,'2020-03-01','2020-03-01','2020-10-05','mon');
select*from course;

insert into student values ('salah',123,'student1');
insert into student values ('eslam',345,'student2');
insert into student values ('hhh',876,'student3');
insert into student values ('eee',985,'student4');
insert into student values ('mnb',985,'student5');
select*from student;

insert into std_reg_cou values (8,3,12);
insert into std_reg_cou values (2,2,12);
insert into std_reg_cou values (1,4,34);
insert into std_reg_cou values (2,3,56);
insert into std_reg_cou values (4,4,56);
insert into std_reg_cou values (8,1,45);
select*from std_reg_cou;
*/
-----------------------------------------------------
