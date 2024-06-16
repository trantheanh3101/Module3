DROP DATABASE IF EXISTS TTA_Testing_System_Assignment_5;
CREATE DATABASE TTA_Testing_System_Assignment_5;
USE TTA_Testing_System_Assignment_5;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
    DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    DepartmentName VARCHAR(30) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
    PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
);


DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
    AccountID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(50) NOT NULL UNIQUE KEY,
    Username VARCHAR(50) NOT NULL UNIQUE KEY ,
    FullName VARCHAR(50) NOT NULL,
    DepartmentID TINYINT UNSIGNED NOT NULL,
    PositionID TINYINT UNSIGNED NOT NULL,
	CreateDate DATETIME DEFAULT NOW(),
	FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
);

-- Age TINYINT UNSIGNED CHECK (Age>=18 AND Age <=40)
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
    GroupID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    GroupName VARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID TINYINT UNSIGNED,     -- IdNgườiTạoRaGroup: cùng kiểu với AccountID vì nó sẽ liên kết với nhau,
    CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
    GroupID TINYINT UNSIGNED NOT NULL,
    AccountID TINYINT UNSIGNED NOT NULL,
    JoinDate DATETIME DEFAULT NOW(),
    PRIMARY KEY(GroupID, AccountID),
    FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName 	ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
		CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
		QuestionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Content NVARCHAR(100) NOT NULL,
		CategoryID TINYINT UNSIGNED NOT NULL,
		TypeID TINYINT UNSIGNED NOT NULL,
		CreatorID TINYINT UNSIGNED NOT NULL,
		CreateDate DATETIME DEFAULT NOW(),
		FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
		FOREIGN KEY(TypeID) REFERENCES TypeQuestion(TypeID),
		FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountId)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
		AnswerID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Content NVARCHAR(100) NOT NULL,
		QuestionID TINYINT UNSIGNED NOT NULL,
		isCorrect BIT DEFAULT 1,
		FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
		ExamID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		`Code` CHAR(10) NOT NULL, -- cân nhắc UNIQUE KEY
		Title NVARCHAR(50) NOT NULL,
		CategoryID TINYINT UNSIGNED NOT NULL,
		Duration TINYINT UNSIGNED NOT NULL,
		CreatorID TINYINT UNSIGNED NOT NULL,
		CreateDate DATETIME DEFAULT NOW(),
		FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
		FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountId)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
		ExamID TINYINT UNSIGNED NOT NULL,
		QuestionID TINYINT UNSIGNED NOT NULL,
        PRIMARY KEY (ExamID,QuestionID),
		FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
        FOREIGN KEY(ExamID) REFERENCES Exam(ExamID)
);


/*	INSERT	INSERT	INSERT	INSERT	INSERT */

INSERT INTO Department(DepartmentName)
VALUES
		(N'Marketing' ),
		(N'Sale' ),
		(N'Bảo vệ' ),
		(N'Nhân sự' ),
		(N'Kỹ thuật' ),
		(N'Tài chính' ),
		(N'Phó giám đốc'),
		(N'Giám đốc' ),
		(N'Thư kí' ),
		(N'No person' ),
		(N'Bán hàng' ),
		(N'Department 1' ),
		(N'Department 2' ),
		(N'Department 3' ),
		(N'Department 4' ),
		(N'Department 5' ),
		(N'Department 6' ),
		(N'Department 7' );
        
 
-- Thêm dữ liệu cho bảng Position
INSERT INTO `Position`(PositionName) VALUE ('Dev'); 
INSERT INTO `Position`(PositionName) VALUE ('Test'); 
INSERT INTO `Position`(PositionName) VALUE ('Scrum Master'); 
INSERT INTO `Position`(PositionName) VALUE ('PM'); 
/*
INSERT INTO `Position`(PositionName) VALUE ('QA'); 
INSERT INTO `Position`(PositionName) VALUE ('BA'); 
INSERT INTO `Position`(PositionName) VALUE ('PM'); 
INSERT INTO `Position`(PositionName) VALUE ('CEO'); 
INSERT INTO `Position`(PositionName) VALUE ('CTO'); 
INSERT INTO `Position`(PositionName) VALUE ('Produc Owner'); 
*/



-- Thêm dữ liệu cho bảng Account
INSERT INTO Account(Email								, Username				, FullName					, DepartmentID		, PositionID, CreateDate)
VALUE 				('lamchiki@gmail.com'				, 'lamchiki'			,'Lam Chi Ky'				,   '5'				,   '1'		,'2020-03-05'),
					('phamtrungkien@gmail.com'			, 'phamtrungkien'		,'Pham Trung Kien'			,   '1'				,   '2'		,'2020-03-05'),
                    ('hongochiep@gmail.com'				, 'hongochiep'			,'Ho Ngoc Hiep'				,   '2'				,   '3'		,'2020-03-07'),
                    ('nguyentrongthai@gmail.com'		, 'nguyentrongthai'		,'Nguyen Trong Thai'		,   '2'				,   '4'		,'2020-03-08'),
                    ('nguyenductien@gmail.com'			, 'nguyenductien'		,'Nguyen Duc Tien'			,   '4'				,   '4'		,'2020-03-10'),
                    ('buianhtuan@gmail.com'				, 'buianhtuan'			,'Bui Anh Tuan'				,   '6'				,   '3'		,'2020-04-05'),
                    ('nguyenxuanhau@gmail.com'			, 'nguyenxuanhau'		,'Nguyen Xuan Hau'			,   '7'				,   '2'		,'2020-04-05'),
                    ('trantheanh@gmail.com'				, 'trantheanh'			,'Tran The Anh'				,   '8'				,   '1'		,'2020-04-07'),
                    ('nguyenhoangthanh@gmail.com'		, 'nguyenhoangthanh'	,'Nguyen Hoang Thanh'		,   '9'				,   '2'		,'2020-04-07'),
                    ('ngotritrong@gmail.com'			, 'ngotritrong'			,'Ngo Tri Trong'			,   '10'			,   '2'		,'2020-04-07'),
                    ('maivanthuong@gmail.com'			, 'maivanthuong'		,'Mai Van Thuong'			,   '12'			,   '2'		,'2020-04-07'),
                    ('hoangvancuong@gmail.com'			, 'hoangvancuong'		,'Hoang Van Cuong'			,   '13'			,   '2'		,'2020-04-07'),
                    ('havietkhanh@gmail.com'			, 'havietkhanh'			,'Ha Viet Khanh'			,   '14'			,   '2'		,'2020-04-07'),
                    ('nguyentruongan@gmail.com'			, 'nguyentruongan'		,'Nguyen Truong An'			,   '15'			,   '2'		,'2020-04-07'),
                    ('nguyenthingocthu@gmail.com'		, 'nguyenthingocthu'	,'Nguyen Thi Ngoc Thu'		,   '16'			,   '2'		,'2020-04-07'),
                    ('nguyenthihongtuoi@gmail.com'		, 'nguyenthihongtuoi'	,'Nguyen Thi Hong Tuoi'		,   '17'			,   '2'		,'2020-04-07'),
                    ('vtiaccademy@gmail.com'			, 'vtiaccademy'			,'Vi Ti Ai'					,   '10'			,   '1'		,'2020-04-09'),
                    ('v1@gmail.com'						, 'v1'					,'V1'						,   '10'			,   '2'		,'2020-05-09'),
                    ('a1@gmail.com'						, 'a1'					,'A1'						,   '10'			,   '3'		,'2020-06-09'),
                    ('b1@gmail.com'						, 'b1'					,'B1'						,   '1'				,   '2'		,'2020-09-09'),
                    ('c1@gmail.com'						, 'c1'					,'C1'						,   '1'				,   '1'		,'2020-10-09');

-- Thêm dữ liệu cho bảng Group
INSERT INTO `Group`	(  GroupName			, CreatorID		, CreateDate)
VALUE 				(N'Testing System'		,   '5'			,'2019-03-05'),
					(N'Developement'		,   '1'			,'2020-03-07'),
                    (N'VTI Sale 01'			,   '2'			,'2020-03-09'),
                    (N'VTI Sale 02a'			,   '3'			,'2020-03-10'),
                    (N'VTI Sale 02b'			,   '4'			,'2020-03-28'),
                    (N'VTI Creator'			,   '6'			,'2020-04-06'),
                    (N'VTI Marketing 01'	,   '7'			,'2020-04-07'),
                    (N'Management'			,   '8'			,'2020-04-08'),
                    (N'Chat with love'		,   '9'			,'2020-04-09'),
                    (N'Vi Ti Ai'			,   '10'		,'2020-04-10');

-- Thêm dữ liệu cho bảng GroupAccount
INSERT INTO GroupAccount	(  GroupID	, AccountID	, JoinDate	 )
VALUE 						(	2		,    1		,'2019-03-05'),
							(	2		,    2		,'2020-03-07'),
							(	2		,    3		,'2020-03-09'),
							(	2		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	6		,    6		,'2020-04-06'),
							(	7		,    7		,'2020-04-07'),
							(	8		,    8		,'2020-04-08'),
							(	9		,    9		,'2020-04-09'),
							(	1		,    10		,'2020-04-10'),
							(	1		,    5		,'2020-04-10'),
							(	1		,    2		,'2020-04-10'),
							(	10		,    3		,'2020-04-10');


-- Thêm dữ liệu cho bảng TypeQuestion
INSERT INTO TypeQuestion(TypeName) VALUE ('Essay'); 
INSERT INTO TypeQuestion(TypeName) VALUE ('Multiple-Choice'); 


-- Thêm dữ liệu cho CategoryQuestion
INSERT INTO CategoryQuestion(CategoryName) VALUE ('Java'); 
INSERT INTO CategoryQuestion(CategoryName) VALUE ('ASP.NET'); 
INSERT INTO CategoryQuestion(CategoryName) VALUE ('ADO.NET'); 
INSERT INTO CategoryQuestion(CategoryName) VALUE ('SQL'); 
INSERT INTO CategoryQuestion(CategoryName) VALUE ('Postman'); 
INSERT INTO CategoryQuestion(CategoryName) VALUE ('Ruby'); 
INSERT INTO CategoryQuestion(CategoryName) VALUE ('Python'); 
INSERT INTO CategoryQuestion(CategoryName) VALUE ('C++'); 
INSERT INTO CategoryQuestion(CategoryName) VALUE ('C Sharp'); 
INSERT INTO CategoryQuestion(CategoryName) VALUE ('PHP'); 

-- Thêm bảng Question
INSERT INTO Question	(Content			, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUE 					(N'Câu hỏi về Java'	,	1		,   '1'			,   '1'		,'2020-04-05'),
						(N'Câu Hỏi về PHP'	,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về C#'		,	9		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Ruby'		,	6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Postman'	,	5		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về ADO.NET'	,	3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về ASP.NET'	,	2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về C++'		,	8		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về SQL'		,	4		,   '2'			,   '9'		,'2020-04-07'),
                        (N'PHP la j'		,	10		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về Python'	,	7		,   '1'			,   '10'	,'2020-04-07');

-- Thêm bảng Answers
INSERT INTO Answer	(  Content		, QuestionID	, isCorrect	)
VALUE 				(N'Trả lời 01'	,   1			,	0		),
					(N'Trả lời 02'	,   1			,	1		),
                    (N'Trả lời 03'	,   1			,	0		),
                    (N'Trả lời 04'	,   1			,	1		),
                    (N'Trả lời 05'	,   2			,	1		),
                    (N'Trả lời 06'	,   3			,	1		),
                    (N'Trả lời 07'	,   4			,	0		),
                    (N'Trả lời 08'	,   8			,	0		),
                    (N'Trả lời 09'	,   9			,	1		),
                    (N'Trả lời 10'	,   10			,	1		);
	
-- Thêm bảng Exam
INSERT INTO Exam	(Code			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUE 				('VTIQ001'		, N'Đề thi C#'			,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi PHP'			,	10			,	60		,   '1'			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi C++'			,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'Đề thi Java'		,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi Ruby'		,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'Đề thi Postman'		,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'Đề thi SQL'			,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'Đề thi Python'		,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'Đề thi ADO.NET'		,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'Đề thi ASP.NET'		,	7			,	90		,   '10'		,'2020-04-08');

INSERT INTO ExamQuestion(ExamID , QuestionID )
VALUES      ( 1 , 5 ),
			( 2 , 10 ),
			( 3 , 4 ),
			( 4 , 3 ),
			( 5 , 7 ),
			( 6 , 10 ),
			( 7 , 2 ),
			( 8 , 10 ),
			( 9 , 9 ),
			( 10 , 8 );
                    