-- Xóa cơ sở dữ liệu nếu tồn tại và tạo mới
DROP DATABASE IF EXISTS QuanLyDonHang;
CREATE DATABASE QuanLyDonHang;
USE QuanLyDonHang;

-- Tạo bảng Customer
DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer(
    cID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cName VARCHAR(50) NOT NULL,
    cAge INT NOT NULL
);

-- Tạo bảng Product
DROP TABLE IF EXISTS Product;
CREATE TABLE Product(
    pID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pName VARCHAR(50) NOT NULL,
    pPrice DECIMAL(10, 2) NOT NULL
);

-- Tạo bảng Order
DROP TABLE IF EXISTS `Order`;
CREATE TABLE `Order`(
    oID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cID INT NOT NULL,
    oDate DATETIME NOT NULL,
    oTotalPrice DECIMAL(10, 2),
    FOREIGN KEY (cID) REFERENCES Customer(cID)
);

-- Tạo bảng OrderDetail
DROP TABLE IF EXISTS OrderDetail;
CREATE TABLE OrderDetail(
    oID INT NOT NULL,
    pID INT NOT NULL,
    odQTY INT NOT NULL,
    PRIMARY KEY (oID, pID),
    FOREIGN KEY (oID) REFERENCES `Order`(oID),
    FOREIGN KEY (pID) REFERENCES Product(pID)
);

-- Thêm dữ liệu vào bảng Customer
INSERT INTO Customer (cName, cAge) VALUES
    ('Alice', 30),
    ('Bob', 25),
    ('Charlie', 35);

-- Thêm dữ liệu vào bảng Product
INSERT INTO Product (pName, pPrice) VALUES
    ('Product A', 10.00),
    ('Product B', 20.00),
    ('Product C', 30.00);

-- Thêm dữ liệu vào bảng Order
INSERT INTO `Order` (cID, oDate, oTotalPrice) VALUES
    (1, '2024-01-01', 40.00),
    (2, '2024-01-02', 150.00),
    (3, '2024-01-03', 110.00);

-- Thêm dữ liệu vào bảng OrderDetail
INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
    (1, 1, 2),
    (1, 2, 1),
    (2, 3, 5),
    (3, 2, 3),
    (3, 3, 1);