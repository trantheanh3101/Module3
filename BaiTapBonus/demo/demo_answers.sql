-- 1. Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào.
select stu.id,stu.name,c.name as name_class
from students stu
join classes c
on stu.id_class = c.id;
-- 2. Lấy ra thông tin các học viên, và cho biết các học viên đang theo học lớp nào, lớp đó giảng viên nào dạy
SELECT students.id AS student_id,students.name AS student_name,classes.name AS class_name,teachers.name AS teacher_name
FROM students
JOIN classes ON students.id_class = classes.id
JOIN teachers_teach_classes ON classes.id = teachers_teach_classes.id_class
JOIN teachers ON teachers_teach_classes.id_teacher = teachers.id;
-- 3. Lấy ra thông tin các học viên đang theo học tại các lớp kể cả các học viên không theo học lớp nào.
select * from students ;
-- 4. Lấy thông tin của các học viên tên ‘Tien’ và ‘Toan’. (dữ liệu tự insert để thỏa mãn)
select * from students
where name like '%Tien%' or name like '%Toan%';
-- 5. Lấy ra số lượng học viên của từng lớp.
select c.id as id_class,c.name as name_class,COUNT(stu.id) as count_student
from classes c 
join students stu
on c.id = stu.id_class
group by c.id;
-- 6. Lấy ra danh sách học viên và sắp xếp tên theo alphabet.
select * from students order by name