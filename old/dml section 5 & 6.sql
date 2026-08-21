--dml section 6
create database  company;
	--استخدم الداتا بيز بعد انشائها لانه قد يكون يستخدم داتا بيز اخري
use company;

create table department
(
	name varchar(50) not null,
	id int primary key identity (1,1)
);

create table student
(
	id int primary key,
	name varchar(50) not null,
	student_level int not null,
	dept_id int foreign key references department (id)
);

------------------------------------
--لا نضع ال اي دي لاني حددته بان يزيد تلقائيا
insert into department values ('is');
insert into department values ('cs');
insert into department values ('al');
insert into department values ('dl');

--لادخال قيم معينه في صف معين
insert into student (id,name,student_level,dept_id) values(5,'aa',4,1);
insert into student (id,name,student_level,dept_id) values(6,'bb',2,3);
insert into student (id,name,student_level,dept_id) values(7,'cc',1,8);
--لا يمكن تحقيق الخطوه القادمه لانه في قيمه الفورن كي في جدوله الاصلي لا يوجد قيمه عشرين
--insert into student (id,name,student_level,dept_id) values(1,'ahmed',4,20);
----------------------------------
--لعرض جميع بيانات صفوف (البيانات الداخليه)الجدول
select* from department;
select* from student;
------------------------------------
-- لتعديل عمود كامل
update  department
set name ='swe'; 
select* from department;

--لتعديل قيمه معينه في صف معين
update  department
set name ='it' where id=3;
select* from department;
------------------------------------
--لمسح بيانات المدخله كلها
delete from  department;
--لمسح صف معين
delete from department
where id =5;
select* from department;
------------------------------------
--لمسح بيانات المدخله كلها
truncate table student;
select* from student;
------------------------------------



--dml section 6
--لعرض جميع بيانات صفوف (البيانات الداخليه)الجدول
select* from department;
select* from student;
---------------------------------------
--ابحث عن صفوف  معينه
select * from student 
where student_level=4;
----------------------------------------
--ابحث عن عمود معين
select name from student
select id from student
select name,dept_id from student;
----------------------------------------
--يرجع قيم عمود معين ولا يرجع المتكرر اكثر من مره اي انه اذا يوجد كذا قيمه 2 يرجع 2 مره واحده فقط
select distinct student_level from student;
--------------------------------------------
-- and & or & not
select* from student
where student_level=4 and dept_id =1;

select* from student
where student_level=4 or dept_id =8;

select* from student
where not student_level=4 and not dept_id =8;
--------------------------------------------- 
--لعرض الجدول مرتب ب عنصر معين تصاعدي
select * from student order by name;
--لعرض الجدول مرتب ب عنصر معين تنازلي
select * from student order by name desc;

select * from student order by name, dept_id;
----------------------------------------------
--لتغير اسم عمود ما
select name as std_name from student;
--------------------------------------------
--Sub queries
select name,id,student_level from student
where dept_id in
(
select id from department 
where name='swe'
);
--------------------------------------------
-- between ... and تستخدم للحصول علي قيم محصوره بين قيمتين معينتان
select * from  student where id between 3 and 6;
select * from  student where id not between 3 and 6;
------------------------------------------------ 
-- ابحث عن كلمات معينه عن طريق البحث باجزائها
-- مثلا هنا يتم البحث عن كلمه اخرها d
select * from student
where name like '%o' ;
--وهنا يتم البحث عن كلمه اولها a
select * from student
where name like 'a%' ;
--وهنا يتم البحث عن كلمه بداخلها s
select * from student
where name like '%d%' ;
---------------------------------------------