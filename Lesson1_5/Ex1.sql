DROP DATABASE IF EXISTS `student-management`;
CREATE DATABASE StudentManagement;
USE StudentManagement;

DROP TABLE IF EXISTS Class;
CREATE TABLE Class(
	id INT,
    name_hs VARCHAR(255)
);

DROP TABLE IF EXISTS Teacher;
CREATE TABLE Teacher(
	id INT,
    name VARCHAR(255),
    age INT,
    conntry VARCHAR(255)
);