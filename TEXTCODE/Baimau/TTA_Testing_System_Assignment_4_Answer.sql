-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT t1.AccountID,t1.Username,t1.FullName,t1.DepartmentID,t2.DepartmentName
FROM `account` AS t1 
INNER JOIN department AS t2
ON t1.DepartmentID = t2.DepartmentID
ORDER BY AccountID;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `account` AS t1 
INNER JOIN department AS t2
ON t1.DepartmentID = t2.DepartmentID
WHERE CreateDate > '2020-04-05';

-- Question 3: Viết lệnh để lấy ra tất cả các developer 
SELECT *
FROM `account` AS t1 
INNER JOIN position AS t3
ON t1.PositionID = t3.PositionID
WHERE t1.positionID=1;

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT *, COUNT(t1.DepartmentID) AS `Number`
FROM `account` AS t1 
INNER JOIN department AS t2
ON t1.DepartmentID = t2.DepartmentID
GROUP BY DepartmentName
HAVING `Number`>'3';

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
-- Cách 1: không tối ưu 
SELECT* ,COUNT(t4.QuestionID) AS SLCH
FROM question AS t3
INNER JOIN examquestion AS t4
ON t3.QuestionID=t4.QuestionID 
GROUP BY t4.QuestionID
ORDER BY SLCH DESC
LIMIT 1;

-- Cách 2:
WITH cau5 AS
(
	SELECT t4.ExamID,t3.QuestionID,t3.Content,t3.CategoryID,t3.TypeID,t3.CreatorID,t3.CreateDate,COUNT(t4.QuestionID) AS SLCH
FROM question AS t3
INNER JOIN examquestion AS t4
ON t3.QuestionID=t4.QuestionID 
GROUP BY t4.QuestionID
)
SELECT *
FROM `cau5`
WHERE SLCH = (SELECT MAX(SLCH) FROM `cau5`);

-- Cách 3: lệnh lồng nhau
SELECT *, COUNT(q.QuestionID) AS SLCH 
FROM question q
INNER JOIN examquestion eq
ON q.QuestionID=eq.QuestionID
GROUP BY q.QuestionID
HAVING SLCH = (
				SELECT MAX(SLCH) 
				FROM ( 
					SELECT * , COUNT(eq.QuestionID) AS SLCH 
					FROM examquestion eq
					GROUP BY eq.QuestionID 
					 ) AS tablett
				);

-- Question 6: Thông kê mỗi Category Question được sử dụng trong bao nhiêu Question ???
SELECT t5.CategoryID, t6.CategoryName, count(t5.CategoryID) AS SL_CAUHOI
FROM question t5
INNER JOIN categoryquestion t6 
ON t5.CategoryID = t6.CategoryID
GROUP BY t5.CategoryID;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT *, COUNT(t7.QuestionID) AS SL_EXAM
FROM question t7
LEFT JOIN examquestion t8
ON t7.QuestionID=t8.QuestionID
GROUP BY t7.QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
-- Cách 1: 
WITH Cau8 AS
(
	SELECT t9.QuestionID,t9.Content,t9.CategoryID,t9.TypeID,t9.CreatorID,t9.CreateDate, COUNT(t9.QuestionID) AS SL_Answer
	FROM question t9 
    INNER JOIN answer t10 
    ON t9.QuestionID=t10.QuestionID
    GROUP BY t9.QuestionID
)
SELECT *
FROM Cau8
WHERE SL_Answer=(SELECT MAX(SL_Answer) FROM Cau8);

-- Cách 2:
SELECT q.QuestionID,q.Content, COUNT(q.QuestionID) AS SLCTT
FROM question q
INNER JOIN answer a
ON q.QuestionID=a.QuestionID
GROUP BY q.QuestionID 
HAVING SLCTT= ( 
				SELECT MAX(SLCTT) 
						FROM (
							SELECT *, COUNT(QuestionID) AS SLCTT
							FROM answer
							GROUP BY QuestionID 
							) AS tablectt
			);
-- Question 9: Thống kê số lượng account trong mỗi group
SELECT t12.GroupID, COUNT(t12.GroupID) AS TV_Group
FROM `account` t11
INNER JOIN groupaccount t12
ON t11.AccountID=t12.AccountID
GROUP BY t12.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
-- Cách 1:
WITH Cau10 AS
(
SELECT t14.PositionName, COUNT(t14.PositionID) AS Chucvu_NV
FROM `account` t13 
INNER JOIN position t14
ON t13.PositionID=t14.PositionID
GROUP BY t14.PositionID
)
SELECT *
FROM Cau10
WHERE Chucvu_NV = (SELECT MIN(Chucvu_NV) FROM Cau10);

-- Cách 2: 
SELECT p.PositionID,p.PositionName,COUNT(p.PositionID) AS SL_NGUOI
FROM `account` a
INNER JOIN position p
ON a.PositionID=p.PositionID
GROUP BY a.PositionID
HAVING SL_NGUOI = (
					SELECT MIN(SL_NGUOI) FROM (
												SELECT * , COUNT(PositionID) AS SL_NGUOI
												FROM `account`
												GROUP BY PositionID
												) AS tablett
					);
                    
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT dep.DepartmentID,dep.DepartmentName, pos.PositionName, count(pos.PositionName) 
FROM `account` acc
INNER JOIN department dep  		ON acc.DepartmentID = dep.DepartmentID
INNER JOIN position pos  		ON acc.PositionID = pos.PositionID
GROUP BY dep.DepartmentID, pos.PositionID;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT Q.QuestionID, Q.Content, A.FullName AS Nguoitaocauhoi, TQ.TypeName AS loaicauhoi, ANS.Content 
FROM question Q
INNER JOIN categoryquestion CQ 	ON Q.CategoryID = CQ.CategoryID
INNER JOIN typequestion TQ 		ON Q.TypeID = TQ.TypeID
INNER JOIN account A 			ON A.AccountID = Q.CreatorID
INNER JOIN Answer ANS 			ON Q.QuestionID = ANS.QuestionID
ORDER BY Q.QuestionID;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT tq1.TypeID,tq1.TypeName ,COUNT(q1.TypeID) AS SL_loaich
FROM question q1
INNER JOIN typequestion tq1
ON q1.TypeID=tq1.TypeID 
GROUP BY q1.TypeID ;

-- Question 14:Lấy ra group không có account nào
SELECT * 
FROM `group` g
LEFT JOIN groupaccount ga 
ON g.GroupID = ga.GroupID
WHERE ga.AccountID IS NULL;

-- Question 15: Lấy ra group không có account nào
SELECT *
FROM groupaccount ga
RIGHT JOIN `group` g
ON ga.GroupID=g.GroupID
WHERE ga.AccountID IS NULL;

-- Question 16: Lấy ra question không có answer nào
SELECT *
FROM question Q
LEFT JOIN answer A
ON Q.QuestionID=A.AnswerID 
WHERE A.AnswerID IS NULL;

-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
SELECT A.FullName 
FROM `Account` A
JOIN GroupAccount GA 
ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT A.FullName 
FROM `Account` A
JOIN GroupAccount GA 
ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT A.FullName
FROM `Account` A
INNER JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 1
UNION
SELECT A.FullName
FROM `Account` A
INNER JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;

-- Question 18:
-- a) Lấy các group có lớn hơn 2 thành viên
SELECT *, COUNT(g.GroupID) AS t1
FROM `Group` g
INNER JOIN groupaccount ga
ON g.GroupID=ga.GroupID
GROUP BY ga.GroupID
HAVING t1>2;

-- b) Lấy các group có nhỏ hơn 5 thành viên
SELECT *, COUNT(g.GroupID) AS t2
FROM `Group` g
INNER JOIN groupaccount ga
ON g.GroupID=ga.GroupID
GROUP BY ga.GroupID
HAVING t2 < 5;

-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT *, COUNT(g.GroupID) AS t1
FROM `Group` g
INNER JOIN groupaccount ga
ON g.GroupID=ga.GroupID
GROUP BY ga.GroupID
HAVING t1 > 2
UNION
SELECT *, COUNT(g.GroupID) AS t2
FROM `Group` g
INNER JOIN groupaccount ga
ON g.GroupID=ga.GroupID
GROUP BY ga.GroupID
HAVING t2 BETWEEN 3 AND 5


