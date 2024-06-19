# 1. Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
    SELECT *
    FROM student stu
    WHERE stu.StudentName LIKE 't%';
# 2. Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
    select *
    from class c
    where MONTH(StartDate) = 12;

# 3. Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
    select *
    from subject s
    where s.Credit >= 3 AND s.Credit <=5;

# 4. Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
    UPDATE student stu
    set ClassId = 2
    where stu.StudentName = 'Hung';
# 5. Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần.
# nếu trùng sắp theo tên tăng dần.
    SELECT stu.StudentName , sub.SubName,m.Mark
    from student stu
    join mark m on stu.StudentId = m.StudentId
    join subject sub on sub.SubId = m.SubId
    order by m.Mark desc,
             stu.StudentName asc ;
