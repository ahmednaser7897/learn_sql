 use first
--مسح بيانات الجدول كله
truncate table table_1


select* from person;
select age from person;
select first_name from person
--ابحث عن المتكرر في هذا العمود و امسح صفه
select distinct first_name from person;

--ابحث عن اجزاء معينه
select first_name from person
where age>12;
-- ابحث عن كلمات معينه عن طريق البحث باجزائها
-- مثلا هنا يتم البحث عن كلمه اخرها d
select * from person
where first_name like '%d' ;
--وهنا يتم البحث عن كلمه اولها a
select * from person
where first_name like 'a%' ;
--وهنا يتم البحث عن كلمه بداخلها s
select * from person
where first_name like '%s%' ;
--لعرض الجدول مرتب ب عنصؤ معين تصاعدي
select *from  person order by id asc ;
--لعرض الجدول مرتب ب عنصؤ معين تنازلي
select *from  person order by first_name desc ;
select *from  person order by first_name asc, age desc ;

-- and & or
select * from person where first_name = 'ahmed' and age =12;
select * from person where first_name = 'ahmed' or age =13;
select * from person 
where (first_name = 'ahmed' and age =12)or age =17 ;

-- تستخدم كلمه in للبحث عن قيم معينه
select *from person where first_name in ('ahmed','naser');

-- between ... and تستخدم للحصول علي قيم محصوره بين قيمتين معينتان
select * from  person where age between 13 and 15;
select * from  person where age not between 13 and 15;
--لتغير اسم عمود ما
select age as person_age from person1




