DROP DATABASE IF EXISTS FuramaResort;
CREATE DATABASE FuramaResort;
USE FuramaResort;

DROP TABLE IF EXISTS LoaiDichVu;
create table LoaiDichVu(
	IDLoaiDichVu INT not null primary key,
    TenLoaiDichVu varchar(45) null
);

drop table if exists KieuThue;
create table KieuThue(
	IDKieuThue varchar(45) not null primary key,
    TenKieuThue varchar(45)
);

drop table if exists LoaiKhach;
create table LoaiKhach(
	IDLoaiKhach int primary key,
    TenLoaiKhach varchar(45)
);

drop table if exists KhachHang;
create table KhachHang(
	IDKhachHang int not null primary key,
    IDLoaiKhach int,
    HoTen varchar(45),
    NgaySinh date,
    SoCMND varchar(45),
    SDT varchar(45),
    Email varchar(45),
    DiaChi varchar(45),
    foreign key (IDLoaiKhach) references LoaiKhach(IDLoaiKhach)
);

DROP TABLE IF EXISTS DichVu;
CREATE TABLE DichVu(
	IDDichVu INT NOT NULL PRIMARY KEY,
    TenDichVu VARCHAR(45),
    DienTich INT,
    SoTang INT,
    SoNguoiToiDa INT,
    ChiPhiThue int,
    IDKieuThue varchar(45),
    IDLoaiDichVu INT,
    TrangThai VARCHAR(45),
    foreign key (IDKieuThue) references KieuThue(IDKieuThue),
    foreign key (IDLoaiDichVu) references LoaiDichVu(IDLoaiDichVu)
);

drop table if exists DichVuDiKem;
create table DichVuDiKem(
	IDDichVuDiKem INT not null primary key,
    TenDichVuDiKem varchar(45),
    Gia int,
    DonVi varchar(50),
    TrangThaiKhaDung varchar(45)
);

drop table if exists TrinhDo;
create table TrinhDo(
	IDTrinhDo int not null primary key,
    TrinhDo varchar(45)
);

drop table if exists ViTri;
create table ViTri(
	IDViTri int not null primary key,
    TenViTri varchar(45)
);

drop table if exists BoPhan;
create table BoPhan(
	IDBoPhan int not null primary key,
    TenBoPhan varchar(45)
);

drop table if exists NhanVien;
create table NhanVien(
	IDNhanVien int not null primary key,
    HoTen varchar(45),
    IDViTri int,
    IDTrinhDo int,
    IDBoPhan int,
    NgaySinh date,
    SoCMND varchar(45),
    Luong varchar(45),
    SDT varchar(45),
    Email varchar(45),
    DiaChi varchar(45),
    foreign key (IDViTri) references ViTri(IDViTri),
    foreign key (IDBoPhan) references BoPhan(IDBoPhan),
    foreign key (IDTrinhDo) references TrinhDo(IDTrinhDo)
);

DROP TABLE IF EXISTS Hop_Dong;
CREATE TABLE Hop_Dong (
	IDHopDong INT NOT NULL PRIMARY KEY,
	IDNhanVien INT,
	IDKhachHang INT,
	IDDichVu INT,
	NgayLamHopDong DATE NULL,
	NgayKetThuc DATE NULL,
	TienDatCoc INT NULL,
    FOREIGN KEY (IDDichVu) REFERENCES DichVu(IDDichVu),
    foreign key (IDKhachHang) references KhachHang(IDKhachHang),
    foreign key (IDNhanVien) references NhanVien(IDNhanVien)
);

drop table if exists HopDongChiTiet;
create table HopDongChiTiet(
	IDHopDongChiTiet int not null primary key,
    IDHopDong int,
    IDDichVuDiKem int,
    SoLuong int not null,
    foreign key (IDDichVuDiKem) references DichVuDiKem(IDDichVuDiKem),
    FOREIGN KEY (IDHopDong) REFERENCES Hop_Dong(IDHopDong)
);

INSERT INTO ViTri (IDViTri, TenViTri) VALUES
  (1, 'Quản Lý'),
  (2, 'Nhân Viên');
-- Chèn dữ liệu vào bảng TrinhDo
INSERT INTO TrinhDo (IDTrinhDo, TrinhDo) VALUES
    (1, 'Trung Cấp'),
    (2, 'Cao Đẳng'),
    (3, 'Đại Học'),
    (4, 'Sau Đại Học');
-- Chèn dữ liệu vào bảng BoPhan
INSERT INTO BoPhan (IDBoPhan, TenBoPhan) VALUES
    (1, 'Sale-Marketing'),
    (2, 'Hành chính'),
    (3, 'Phục vụ'),
    (4, 'Quản lý');

-- Chèn dữ liệu vào bảng NhanVien
INSERT INTO NhanVien (IDNhanVien, HoTen, IDViTri, IDTrinhDo, IDBoPhan, NgaySinh, SoCMND, Luong, SDT, Email, DiaChi) VALUES
    (1, 'Nguyễn Văn An', 1, 3, 1, '1970-11-07', '456231786', '10000000', '0901234121', 'annguyen@gmail.com', '295 Nguyễn Tất Thành, Đà Nẵng'),
    (2, 'Lê Văn Bình', 1, 2, 2, '1997-04-09', '654231234', '7000000', '0934212314', 'binhlv@gmail.com', '22 Yên Bái, Đà Nẵng'),
    (3, 'Hồ Thị Yến', 1, 3, 2, '1995-12-12', '999231723', '14000000', '0412352315', 'thiyen@gmail.com', 'K234/11 Điện Biên Phủ, Gia Lai'),
    (4, 'Võ Công Toản', 1, 4, 4, '1980-04-04', '123231365', '17000000', '0374443232', 'toan0404@gmail.com', '77 Hoàng Diệu, Quảng Trị'),
    (5, 'Nguyễn Bỉnh Phát', 2, 1, 1, '1999-12-09', '454363232', '6000000', '0902341231', 'phatphat@gmail.com', '43 Yên Bái, Đà Nẵng'),
    (6, 'Khúc Nguyễn An Nghi', 2, 2, 3, '2000-11-08', '964542311', '7000000', '0978653213', 'annghi20@gmail.com', '294 Nguyễn Tất Thành, Đà Nẵng'),
    (7, 'Nguyễn Hữu Hà', 2, 3, 2, '1993-01-01', '534323231', '8000000', '0941234553', 'nhh0101@gmail.com', '4 Nguyễn Chí Thanh, Huế'),
    (8, 'Nguyễn Hà Đông', 2, 4, 4, '1989-09-03', '234414123', '9000000', '0642123111', 'donghanguyen@gmail.com', '111 Hùng Vương, Hà Nội'),
    (9, 'Tòng Hoang', 2, 4, 4, '1982-09-03', '256781231', '6000000', '0245144444', 'hoangtong@gmail.com', '213 Hàm Nghi, Đà Nẵng'),
    (10, 'Nguyễn Công Đạo', 2, 3, 2, '1994-01-08', '755434343', '8000000', '0988767111', 'nguyencongdao12@gmail.com', '6 Hoà Khánh, Đồng Nai');
INSERT INTO LoaiKhach (IDLoaiKhach, TenLoaiKhach) VALUES
    (1, 'Diamond'),
    (2, 'Platinium'),
    (3, 'Gold'),
    (4, 'Silver'),
    (5, 'Member');
-- Chèn dữ liệu vào bảng LoaiDichVu
INSERT INTO LoaiDichVu (IDLoaiDichVu, TenLoaiDichVu) VALUES
    (1, 'Villa'),
    (2, 'House'),
    (3, 'Room');
-- Chèn dữ liệu vào bảng KieuThue
INSERT INTO KieuThue (IDKieuThue, TenKieuThue) VALUES
    ('1','year'), -- year
    ('2', 'month'), -- month
    ('3', 'day'), -- day
    ('4', 'hour'); -- hour

-- Chèn dữ liệu vào bảng KhachHang
INSERT INTO KhachHang (IDKhachHang, IDLoaiKhach, HoTen, NgaySinh, SoCMND, SDT, Email, DiaChi) VALUES
    (1, 5, 'Nguyễn Thị Hào', '1970-11-07', '643431213', '0945423362', 'thihao07@gmail.com', '23 Nguyễn Hoàng, Đà Nẵng'),
    (2, 3, 'Phạm Xuân Diệu', '1992-08-08', '865342123', '0954333333', 'xuandieu92@gmail.com', 'K77/22 Thái Phiên, Quảng Trị'),
    (3, 1, 'Trương Đình Nghệ', '1990-02-27', '488645199', '0373213122', 'nghenhan2702@gmail.com', 'K323/12 Ông Ích Khiêm, Vinh'),
    (4, 1, 'Dương Văn Quan', '1981-07-08', '543432111', '0490039241', 'duongquan@gmail.com', 'K453/12 Lê Lợi, Đà Nẵng'),
    (5, 4, 'Hoàng Trần Nhi Nhi', '1995-12-09', '795453345', '0312345678', 'nhinhi123@gmail.com', '224 Lý Thái Tổ, Gia Lai'),
    (6, 4, 'Tôn Nữ Mộc Châu', '2005-12-06', '732434215', '0988888844', 'tonnuchau@gmail.com', '37 Yên Thế, Đà Nẵng'),
    (7, 1, 'Nguyễn Mỹ Kim', '1984-04-08', '856453123', '0912345698', 'kimcuong84@gmail.com', 'K123/45 Lê Lợi, Hồ Chí Minh'),
    (8, 3, 'Nguyễn Thị Hào', '1999-04-08', '965656433', '0763212345', 'haohao99@gmail.com', '55 Nguyễn Văn Linh, Kon Tum'),
    (9, 1, 'Trần Đại Danh', '1994-07-01', '432341235', '0643343433', 'danhhai99@gmail.com', '24 Lý Thường Kiệt, Quảng Ngãi'),
    (10, 2, 'Nguyễn Tâm Đắc', '1989-07-01', '344343432', '0987654321', 'dactam@gmail.com', '22 Ngô Quyền, Đà Nẵng');

-- Chèn dữ liệu vào bảng DichVu
INSERT INTO DichVu (IDDichVu, TenDichVu, DienTich, SoTang, SoNguoiToiDa, ChiPhiThue, IDKieuThue, IDLoaiDichVu, TrangThai) VALUES
    (1, 'Villa Beach Front', 25000, 4, 10, 10000000, '3', 1, 'vip'),
    (2, 'House Princess 01', 14000, 3, 7, 5000000, '2', 2, 'vip'),
    (3, 'Room Twin 01', 5000, NULL, 2, 1000000, '4', 3, 'normal'),
    (4, 'Villa No Beach Front', 22000, 3, 8, 9000000, '3', 1, 'normal'),
    (5, 'House Princess 02', 10000, 2, 5, 4000000, '3', 2, 'normal'),
    (6, 'Room Twin 02', 3000, NULL, 2, 900000, '4', 3, 'normal');

-- Chèn dữ liệu vào bảng DichVuDiKem
INSERT INTO DichVuDiKem (IDDichVuDiKem, TenDichVuDiKem, Gia, DonVi, TrangThaiKhaDung) VALUES
    (1, 'Karaoke', 10000, 'giờ', 'tiện nghi, hiện tại'),
    (2, 'Thuê xe máy', 10000, 'chiếc', 'hỏng 1 xe'),
    (3, 'Thuê xe đạp', 20000, 'chiếc', 'tốt'),
    (4, 'Buffet buổi sáng', 15000, 'suất', 'đầy đủ đồ ăn, tráng miệng'),
    (5, 'Buffet buổi trưa', 90000, 'suất', 'đầy đủ đồ ăn, tráng miệng'),
    (6, 'Buffet buổi tối', 16000, 'suất', 'đầy đủ đồ ăn, tráng miệng');

INSERT INTO Hop_Dong (IDHopDong, IDNhanVien, IDKhachHang, IDDichVu, NgayLamHopDong, NgayKetThuc, TienDatCoc) VALUES
    (1, 3, 1, 3, '2020-12-08', '2020-12-08', 0),
    (2, 7, 3, 1, '2020-07-14', '2020-07-21', 200000),
    (3, 3, 4, 2, '2021-03-15', '2021-03-17', 50000),
    (4, 7, 5, 5, '2021-01-14', '2021-01-18', 100000),
    (5, 7, 2, 6, '2021-07-14', '2021-07-15', 0),
    (6, 7, 7, 6, '2021-06-01', '2021-06-03', 0),
    (7, 7, 4, 4, '2021-09-02', '2021-09-05', 100000),
    (8, 3, 4, 1, '2021-06-17', '2021-06-18', 150000),
    (9, 3, 4, 3, '2020-11-19', '2020-11-19', 0),
    (10, 10, 3, 5, '2021-04-12', '2021-04-14', 0),
    (11, 2, 2, 1, '2021-04-25', '2021-04-25', 0),
    (12, 7, 10, 1, '2021-05-25', '2021-05-27', 0);

INSERT INTO HopDongChiTiet (IDHopDongChiTiet, IDHopDong, IDDichVuDiKem, SoLuong)
VALUES
    (1, 2, 4, 5),
    (2, 2, 5, 8),
    (3, 2, 6, 15),
    (4, 3, 1, 1),
    (5, 3, 2, 11),
    (6, 1, 3, 1),
    (7, 1, 2, 2),
    (8, 12, 2, 2);










