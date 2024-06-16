
-- Question 2: Lấy ra tất cả các phòng ban 
SELECT *
FROM DEpARTMent
ORDER BY DEPArTMentID;

-- Question 3: lấy ra id của phòng ban "Sale"
SELECT DepartMENTID
FROM departmeNT
WHERE DepartmENTNAme= 'Sale';

-- Question 4: lấy ra thông tin account có full name dài nhất
SELECT *, CHAR_LENGTH(FULLNAMe) AS NUMBER_fullname
FROM `account`
ORDER BY number_fullNAME DESC
LIMIT 1;


-- QUESTiON 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id= 3
SELECT *, CHAR_LENGTH(FullName) AS NUMbER_FULLNAME
FROM `accouNt`
WHERE DepartmentID=3
ORDER BY nuMBER_fullname DESC
LIMIT 1;

-- Question 6: LấY RA TÊN GrOup đã tham gia trước ngày 20/12/2019
SELECT GroupName
FROM `group`
WHERE CreatEDATE > '2019-12-20';

-- QuesTION 7: Lấy ra ID của question có >= 4 câu trả lời
SELECT QuestionID, COUNT(AnswerID)
FROM answer
GROUP BY QuestionID
HAVING COUNT(QuesTiONID)>=4;

-- QUEsTIon 8: Lấy ra CÁC Mã ĐỀ THi có thời GIAN thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT Code
FROM exam
WHERE Duration>='60' AND CreateDate<'2019-12-20';

-- QUEstion 9: Lấy ra 5 GROup được tẠO gần ĐÂY nhất
SELECT *
FROM `group`
ORDER BY CreateDate DESC
LIMIT 5;

-- Question 11: Lấy ra nhân viÊN CÓ tÊn BẮT đầu bằng CHỮ "D" và kết thúc BẰNg CHỮ "O"
SELECT *
FROM `account`
WHERE FullName LIKE "D%O";

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019 
DELETE 
FROM exam
WHERE CreateDate <'2019-12-20';

/*
-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu HỎI"
DELETE 
FROM QUEStion
WHERE COntent LIKE"câu hỏi%";
*/

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
UPDATE `account`
SET FullName='Nguyen Ba Loc',Email='loc.nguyenba@vti.com.vn'
WHERE AccountID=5;

-- Question 15: Tìm bản ghi có groupid = 4 và update accountid = 5
UPDATE groupaccOUNt
SET AccOuntID=5
WHERE GRoupID=4;
