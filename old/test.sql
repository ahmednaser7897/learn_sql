use pl_project
select * from student join std_reg_cou on std_reg_cou.student_id=student.std_id join course 
on std_reg_cou.course_id= course.cuo_id where course.instructor_id=1;

select cource_grade from std_reg_cou join course on course.cuo_id=std_reg_cou.course_id 
join student on student.std_id=std_reg_cou.student_id where std_reg_cou.course_id=3 and std_reg_cou.student_id=8
 
update std_reg_cou set cource_grade=2  where std_reg_cou.course_id=4 and std_reg_cou.student_id=4
(select cource_grade from std_reg_cou join course on course.cuo_id=std_reg_cou.course_id 
join student on student.std_id=std_reg_cou.student_id 
where std_reg_cou.course_id=4 and std_reg_cou.student_id=1);

select inst_id from instructor where inst_userName='instructor1'
select * from admin