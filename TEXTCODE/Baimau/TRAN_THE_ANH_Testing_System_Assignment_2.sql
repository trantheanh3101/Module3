DROP DATABASE IF EXISTS TRAN_THE_ANH_Testing_System_Assignment_2;
CREATE DATABASE TRAN_THE_ANH_Testing_System_Assignment_2;
USE TRAN_THE_ANH_Testing_System_Assignment_2;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentID TINYINT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName CHAR(50) UNIQUE KEY
);

DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
	PositionID TINYINT PRIMARY KEY AUTO_INCREMENT,
    PositionName ENUM('Dev','Test','Scrum Master','PM') UNIQUE
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(       
	AccountID SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(100) UNIQUE KEY,
    Username CHAR(50),
    Fullname CHAR(50),
    DepartmentID TINYINT,
    PositionID TINYINT,
    CreateDate DATE,
	FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES Position (PositionID)
);
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    GroupName CHAR(100) UNIQUE,
    CreatorID SMALLINT UNSIGNED,
    CreateDate DATE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
	GroupID TINYINT UNSIGNED,
    AccountID SMALLINT UNSIGNED,
    JoinDate DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID),
    FOREIGN KEY (GroupID) REFERENCES `Group` (GroupID),
    FOREIGN KEY (AccountID) REFERENCES `Account` (AccountID)
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
	TypeID TINYINT PRIMARY KEY AUTO_INCREMENT,
    TypeName CHAR(100)
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion (
	CategoryID SMALLINT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100)
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
	QuestionID TINYINT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(200),
    CategoryID SMALLINT,
    TypeID TINYINT,
    CreatorID SMALLINT UNSIGNED,
    CreateDate DATE,
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID),
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
	AnswerID TINYINT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(200),
    QuestionID TINYINT,
	isCorrect ENUM('0','1'),
    FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
	ExamID TINYINT PRIMARY KEY AUTO_INCREMENT,
    `Code` CHAR(50),
    Title VARCHAR(100),
    CategoryID SMALLINT,
    Duration TINYINT,
    CreatorID SMALLINT UNSIGNED,
    CreateDate DATE,
    FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
	ExamID TINYINT,
    QuestionID TINYINT
);

INSERT INTO Department (DepartmentName)
VALUE  	('sale'),
		('marketing'),
        ('HR'),
        ('TECH');

INSERT INTO Position (PositionName)
VALUE   ('Dev'),
		('Test'),
        ('Scrum Master'),
        ('PM');

INSERT INTO `Account` (Email,Username, FullName, DepartmentID , PositionID,CreateDate)
VALUE   ('Aa1@gmail.com','a','A','1','1','2022-1-1'),
		('Bb1@gmail.com','b','B','3','2','2022-2-1'),
        ('Cc1@gmail.com','c','C','4','4','2022-3-1'),
        ('Dd1@gmail.com','d','D','2','3','2022-4-1');
        
INSERT INTO `Group` (GroupName,CreatorID,CreateDate)
VALUE	('G-SALE','2','2022-4-20'),
		('G-Marketing','3','2022-5-20'),
        ('G-HR','1','2022-6-20'),
        ('G-TECH','4','2022-8-21');

INSERT INTO GroupAccount (GroupID, AccountID , JoinDate)
VALUE 	(2,1,'2022-7-25'),
		(3,2,'2023-8-31'),
        (4,3,'2022-12-12'),
        (1,4,'2022-9-15');

INSERT INTO TypeQuestion (TypeName)
VALUE	('Essay'),
		('Multiple-Choice');

INSERT INTO CategoryQuestion (CategoryName)
VALUE	('Java'),
		('.NET'),
        ('SQL'),
        ('Postman'),
        ('Rudy');
        
INSERT INTO Question (Content, CategoryID, TypeID , CreatorID, CreateDate)
VALUE 	('Java la ngon ngu lap trinh gi ?','1','2','3','2022-12-26'),
		('Rudy la ngon ngu lap trinh gi ?','5','2','1','2022-12-29'),
        ('.NET co kho khong ?','2','1','2','2022-11-20'),
        ('SQL la ngon ngu lap trinh gi ?','4','2','3','2022-12-11');
        
INSERT INTO Answer (Content, QuestionID , isCorrect )
VALUE 	('La ngon ngu truy van cau truc','1','0'),
		('La ngon ngu lap trinh huong doi tuong','1','1'),
        ('La ngon ngu truy van cau truc','4','1');

INSERT INTO Exam (`Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUE	('D1','ĐỀ THI SQL',3,70,1,'2022-11-10'),
		('D2','ĐỀ THI JAVA',1,60,2,'2022-10-15'),
        ('D3','ĐỀ THI .NET',2,80,4,'2022-10-16')
