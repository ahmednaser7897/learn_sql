--ddl section 4
--لاعاده استخدام داتا بيز موجوده من قبل 
use myFirstDatabase;
--------------------------------------------
--استخدام الايدنتتي كونسترينت لوضع ارقام تذايديه بمقدهر محددلعنصر ما
create table student
(
	student_ID int identity(1,1) primary key,
	student_Fname nvarchar(10),
	student_Minit nvarchar(10),
	student_lname nvarchar(10),
	student_Bdate datetime,
	age int
)
-----------------------------------------------
--استخدام يونيك كونسترينت لعدم تكرار قيمه ما لعنصر محدد
alter table student add maill nvarchar(50) unique ;
----------------------------------------------
--لعرض معلومات الجدول
 exec sp_help student;
 ---------------------------------------------
create table class
(
	class_ID int identity(1,1) primary key,
	class_name nvarchar(50),
--استخدام ديفولت كونسترينت لاعطاء قيمه مبدائيه تلقائيا للعنصر عند عدم ادخال قيمه
	class_floor nvarchar(50) default 'unnknow',
)

exec sp_help class;
 
create table teacher
(
	teacher_ssn int identity(1,1) primary key,
	teacher_Fname nvarchar(10),
	teacher_Minit nvarchar(10),
	teacher_lname nvarchar(10),
)

alter table student add class_ID int;
-----------------------------------------------
--طريقه اضافه الكونسترينت فورين كي بعد انشاء الجدول
alter table student add constraint st_fk foreign key (class_ID) references class(class_ID)
on delete set null on update cascade;

exec sp_help student;
 ------------------------------------------------
create table teacher_class
(
--طريقه اضافه الكونسترينت فورين كي اثناء انشاء الجدول
	id int foreign key references class (class_ID) on delete cascade on update cascade,
	ssn int foreign key  references teacher (teacher_ssn)on delete cascade on update cascade,
	no_sup int,
--طريقه عمل برايماري كي مزدوج
	constraint tt_pk primary key (id,ssn)
)

exec sp_help teacher_class;
------------------------------------------------
create table teacher_tell
(
	ssn int foreign key  references teacher (teacher_ssn)on delete cascade on update cascade,
	tell int ,
	constraint tell_pk primary key (tell,ssn)
)

exec sp_help teacher_tell;
--------------------------------------------------
--طريقه مسح كونسترينت عن طريق اسمه
alter table student drop constraint UQ__student__11D4A22989C8553E;
exec sp_help student;
--------------------------------------------------
