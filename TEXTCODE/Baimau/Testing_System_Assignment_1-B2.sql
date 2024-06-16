DROP DATABASE IF EXISTS Testing_System_Assignment_1;
CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50) UNIQUE KEY
);

DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
	PositionID INT PRIMARY KEY AUTO_INCREMENT,
    PositionName ENUM('Dev','Test','Scrum Master','PM') UNIQUE KEY
);

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(       
	AccountID INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(250) UNIQUE KEY,
    Username VARCHAR(100),
    Fullname VARCHAR(100),
    DepartmentID VARCHAR(100),
    PositionID VARCHAR(100),
    CreateDate DATE
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID INT PRIMARY KEY AUTO_INCREMENT,
    GroupName VARCHAR(100) UNIQUE KEY,
    CreatorID INT,
    CreateDate DATE
);

DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
	GroupID INT,
    AccountID VARCHAR(100),
    JoinDate DATE
);

DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
	TypeID INT PRIMARY KEY AUTO_INCREMENT,
    TypeName VARCHAR(100)
);

DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion (
	CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100)
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
	QuestionID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(100),
    CategoryID INT,
    TypeID INT,
    CreatorID INT,
    CreateDate DATE
);

DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
	AnswerID INT PRIMARY KEY AUTO_INCREMENT,
    Content VARCHAR(100),
    QuestionID INT,
	isCorrect ENUM('0','1')
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
	ExamID INT PRIMARY KEY AUTO_INCREMENT,
    `Code` VARCHAR(50),
    Title VARCHAR(100),
    CategoryID INT,
    Duration INT,
    CreatorID INT,
    CreateDate DATE
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
	ExamID INT,
    QuestionID INT
);

INSERT INTO Department (DepartmentName)
VALUE  ('sale'),
		('marketing'),
        ('HR'),
        ('TECH');

INSERT INTO Position (PositionName)
VALUE  ('Dev'),
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
