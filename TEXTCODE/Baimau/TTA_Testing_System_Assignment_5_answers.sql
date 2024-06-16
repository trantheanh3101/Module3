-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
-- Lấy danh sách nhân viên thuộc phòng ban Sale
				SELECT *
				FROM `account` a
				INNER JOIN department d
				ON a.DepartmentID=d.DepartmentID
				WHERE d.DepartmentName='Sale';

-- Sử dụng View
				CREATE OR REPLACE VIEW nv_sale AS
					SELECT A.*,D.DepartmentName  -- không thể dùng select * bởi vì trùng lặp cột DepartmentID
					FROM `account` a
					INNER JOIN department d
					ON a.DepartmentID=d.DepartmentID
					WHERE d.DepartmentName='Sale';
				SELECT *
				FROM nv_sale
				WHERE DepartmentName='Sale';	
	
-- Sử dụng CTE :
				CREATE OR REPLACE VIEW nv_sale_cte AS
					WITH NV_SALE1 AS
					(
						SELECT a.*,d.DepartmentName
						FROM `account` a
						INNER JOIN department d
						ON a.DepartmentID=d.DepartmentID
					)
					SELECT *
					FROM NV_SALE1
					WHERE DepartmentName='Sale';

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
-- Sử dụng CTE : cách 1:
					DROP VIEW IF EXISTS cau3_CTE;
					CREATE VIEW cau3_CTE AS
						WITH gr_acc AS
						(
							SELECT A.*,ga.GroupID, COUNT(a.AccountID) AS slacc
							FROM `account` a
							INNER JOIN groupaccount ga
							ON a.AccountID=ga.AccountID
							GROUP BY ga.GroupID
						)
						SELECT *
						FROM gr_acc
						WHERE slacc = (SELECT MAX(slacc) FROM gr_acc);
					SELECT * FROM cau3_CTE;

-- Cách 2: SỬ DỤNG SUBQUARY
					DROP VIEW IF EXISTS cau3_sub;
					CREATE VIEW cau3_sub AS
						SELECT a.*, COUNT(a.AccountID) AS slacc
						FROM `account` a
						INNER JOIN groupaccount ga
						ON a.AccountID=ga.AccountID
						GROUP BY ga.GroupID
						HAVING slacc = (
										SELECT MAX(sl)  FROM (
															SELECT *,COUNT(AccountID) AS sl
															FROM groupaccount
															GROUP BY GroupID
															) AS table_alass
										);
					SELECT * FROM cau3_sub;


-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
					DROP VIEW IF EXISTS sl_kitu;
					CREATE VIEW sl_kitu AS
							SELECT *
							FROM question 
							WHERE length(Content)>16;
					-- XÓA : DELETE FROM sl_kitu


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
-- Cách 1: sử dụng subquery
					DROP VIEW IF EXISTS cauview4;
					CREATE VIEW cauview4 AS
						SELECT a.*, COUNT(a.AccountID) AS slnv_everydep
						FROM `account` a
						INNER JOIN department d 
						ON a.DepartmentID=d.DepartmentID 
						GROUP BY a.DepartmentID
						HAVING slnv_everydep = (
												SELECT MAX(slnv) FROM (
												SELECT *, COUNT(DepartmentID) AS slnv
												FROM `account`
												GROUP BY DepartmentID
																	) AS tablealnv
												);
					SELECT * FROM cauview4;
                    
-- Cách 2: sử dụng CTE :
					DROP VIEW IF EXISTS cauview4_2;
					CREATE VIEW cauview4_2 AS
						WITH CAU4_2 AS
						(
							SELECT a.*, COUNT(a.AccountID) AS slnv_everydep
							FROM `account` a
							INNER JOIN department d
							ON a.DepartmentID=d.DepartmentID 
							GROUP BY d.DepartmentID
						)
						SELECT *
						FROM CAU4_2
						WHERE slnv_everydep = ( SELECT MAX(slnv_everydep) FROM CAU4_2);
					SELECT * FROM cauview4_2;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
						DROP VIEW IF EXISTS table_Nguyen;
						CREATE VIEW table_Nguyen AS
							SELECT a.FullName,q.QuestionID,q.Content,q.CreatorID
							FROM `account` a
							INNER JOIN question q
							ON a.AccountID=q.CreatorID
							WHERE a.FullName LIKE 'Nguyen %';
						SELECT * 
						FROM table_Nguyen