DROP DATABASE IF EXISTS c0324h1;
CREATE DATABASE c0324h1;
USE c0324h1;

CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    gender BIT(1),
    phone VARCHAR(11),
    dob DATE
);

CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

CREATE TABLE account_student (
    username VARCHAR(100) PRIMARY KEY,
    password VARCHAR(200)
);

CREATE TABLE teachers_teach_classes (
    id_teacher INT,
    id_class INT,
    PRIMARY KEY (id_teacher , id_class),
    FOREIGN KEY (id_class)
        REFERENCES classes (id),
    FOREIGN KEY (id_teacher)
        REFERENCES teachers (id)
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    gender BIT(1),
    phone VARCHAR(11),
    dob DATE,
    id_class INT,
    username VARCHAR(100) UNIQUE,
    FOREIGN KEY (username)
        REFERENCES account_student (username),
    FOREIGN KEY (id_class)
        REFERENCES classes (id)
);

INSERT INTO account_student (username, password) VALUES
     ('student1', 'password1'),
     ('student2', 'password2'),
     ('student3', 'password3'),
     ('student4', 'password4'),
     ('student5', 'password5'),
     ('student6', 'password6'),
     ('student7', 'password7'),
     ('student8', 'password8'),
     ('student9', 'password9'),
     ('student10', 'password10'),
     ('student11', 'password11'),
     ('student12', 'password12'),
     ('student13', 'password13'),
     ('student14', 'password14'),
     ('student15', 'password15');

INSERT INTO classes (name) VALUES
       ('Class 1A'),
       ('Class 1B'),
       ('Class 2A'),
       ('Class 2B'),
       ('Class 3A'),
       ('Class 3B'),
       ('Class 4A'),
       ('Class 4B'),
       ('Class 5A'),
       ('Class 5B');

INSERT INTO teachers (name, gender, phone, dob) VALUES
        ('Nguyen Van A', 0, '0123456789', '1980-01-01'),
        ('Tran Thi B', 1, '0987654321', '1985-02-15'),
        ('Le Van C', 0, '0912345678', '1970-03-25'),
        ('Pham Thi D', 1, '0934567890', '1982-04-10'),
        ('Hoang Van E', 0, '0923456781', '1975-05-20'),
        ('Vo Thi F', 1, '0945678901', '1988-06-30'),
        ('Do Van G', 0, '0956789012', '1981-07-05'),
        ('Bui Thi H', 1, '0967890123', '1983-08-14'),
        ('Ngo Van I', 0, '0978901234', '1978-09-25'),
        ('Dao Thi J', 1, '0989012345', '1987-10-11');

INSERT INTO students (name, gender, phone, dob, id_class, username) VALUES
    ('Nguyen Van K', 0, '0990123456', '2000-01-01', 1, 'student1'),
    ('Nguyen Van Tien', 0, '0990123478', '2000-02-01', 8, 'student2'),
    ('Tran Thi L', 1, '0991234567', '2001-02-02', 2, 'student3'),
    ('Le Van M', 0, '0992345678', '2002-03-03', 3, 'student4'),
    ('Pham Thi N', 1, '0993456789', '2003-04-04', 4, 'student5'),
    ('Hoang Van O', 0, '0994567890', '2004-05-05', 5, 'student6'),
    ('Hoang Van Toan', 0, '0994567889', '2004-08-05', 6, 'student7'),
    ('Vo Thi P', 1, '0995678901', '2005-06-06', 7, 'student8'),
    ('Do Van Q', 0, '0996789012', '2006-07-07', 8, 'student9'),
    ('Bui Thi R', 1, '0997890123', '2007-08-08', 9, 'student10'),
    ('Nguyen Van Toan', 0, '0991123456', '2000-11-01', 1, 'student11'),
    ('Tran Thi V', 1, '0992234567', '2001-12-02', 2, 'student12'),
    ('Le Van Tien', 0, '0993345678', '2002-01-03', 3, 'student13'),
    ('Pham Thi X', 1, '0994456789', '2003-02-04', 4, 'student14'),
    ('Hoang Van Toan', 0, '0995567890', '2004-03-05', 5, 'student15');

INSERT INTO teachers_teach_classes (id_teacher, id_class) VALUES
      (1, 1),
      (1, 2),
      (2, 3),
      (2, 4),
      (3, 5),
      (3, 6),
      (4, 7),
      (4, 8),
      (5, 9),
      (5, 10);
