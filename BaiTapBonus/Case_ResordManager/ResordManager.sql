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
    Gia INT null
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
    ChiPhiThue VARCHAR(45),
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
    DonVi int,
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
	TongTien INT NULL,
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

INSERT INTO LoaiDichVu (IDLoaiDichVu, TenLoaiDichVu) VALUES
    (1, 'Phòng Deluxe'),
    (2, 'Biệt thự ven biển'),
    (3, 'Căn hộ cao cấp'),
    (4, 'Phòng Suite'),
    (5, 'Phòng gia đình'),
    (6, 'Phòng tiêu chuẩn'),
    (7, 'Căn hộ Studio'),
    (8, 'Chung cư cao cấp'),
    (9, 'Villa'),
    (10, 'Bungalow');

INSERT INTO KieuThue (IDKieuThue, Gia) VALUES
    ('Theo ngày', 500000),
    ('Theo tuần', 3000000),
    ('Theo tháng', 12000000),
    ('Theo giờ', 100000),
    ('Theo đêm', 700000),
    ('Theo lần', 200000),
    ('Theo khách', 1500000),
    ('Theo phòng', 2500000),
    ('Theo căn hộ', 4500000),
    ('Theo Villa', 6000000);

INSERT INTO LoaiKhach (IDLoaiKhach, TenLoaiKhach) VALUES
    (1, 'Khách du lịch'),
    (2, 'Khách nội địa'),
    (3, 'Khách nước ngoài'),
    (4, 'Khách công tác'),
    (5, 'Khách VIP'),
    (6, 'Khách thường'),
    (7, 'Khách đoàn'),
    (8, 'Khách gia đình'),
    (9, 'Khách trẻ'),
    (10, 'Khách cao cấp');

INSERT INTO KhachHang (IDKhachHang, IDLoaiKhach, HoTen, NgaySinh, SoCMND, SDT, Email, DiaChi) VALUES
    (1, 1, 'Nguyễn Văn A', '1990-05-15', '123456789', '0987654321', 'nguyenvana@example.com', 'Hà Nội'),
    (2, 2, 'Phạm Thị B', '1985-08-20', '987654321', '0123456789', 'phamthib@example.com', 'Hồ Chí Minh'),
    (3, 3, 'Trần Văn C', '1978-12-10', '654321789', '0909090909', 'tranvanc@example.com', 'Đà Nẵng'),
    (4, 4, 'Lê Thị D', '1995-04-25', '456789123', '0999888777', 'lethid@example.com', 'Nha Trang'),
    (5, 5, 'Hoàng Văn E', '1980-10-01', '987654321', '0888777666', 'hoangvane@example.com', 'Vũng Tàu'),
    (6, 6, 'Mai Thị F', '1992-03-08', '123456789', '0777666555', 'maithif@example.com', 'Quảng Ninh'),
    (7, 7, 'Nguyễn Văn G', '1976-07-18', '567891234', '0666555444', 'nguyenvang@example.com', 'Hải Phòng'),
    (8, 8, 'Trần Thị H', '1987-06-21', '987123654', '0555444333', 'tranthih@example.com', 'Phú Quốc'),
    (9, 9, 'Lê Văn I', '1998-09-30', '654789123', '0444333222', 'levani@example.com', 'Đà Lạt'),
    (10, 10, 'Phạm Văn K', '1993-11-05', '789456123', '0333222111', 'phamvank@example.com', 'Hội An');

INSERT INTO DichVu (IDDichVu, TenDichVu, DienTich, SoTang, SoNguoiToiDa, ChiPhiThue, IDKieuThue, IDLoaiDichVu, TrangThai) VALUES
    (1, 'Biệt thự biển', 500, 2, 10, '12000000 đồng', 'Theo tháng', 2, 'Đang hoạt động'),
    (2, 'Phòng Deluxe', 50, 1, 2, '2500000 đồng', 'Theo ngày', 1, 'Đang hoạt động'),
    (3, 'Căn hộ cao cấp', 100, 5, 6, '4500000 đồng', 'Theo lần', 3, 'Đang hoạt động'),
    (4, 'Phòng Suite', 70, 3, 4, '3000000 đồng', 'Theo tuần', 4, 'Đang hoạt động'),
    (5, 'Phòng gia đình', 80, 2, 5, '3500000 đồng', 'Theo đêm', 5, 'Đang hoạt động'),
    (6, 'Chung cư cao cấp', 120, 10, 8, '5000000 đồng', 'Theo giờ', 8, 'Đang hoạt động'),
    (7, 'Căn hộ Studio', 60, 4, 3, '2800000 đồng', 'Theo đêm', 7, 'Đang hoạt động'),
    (8, 'Villa', 150, 1, 12, '6000000 đồng', 'Theo ngày', 9, 'Đang hoạt động'),
    (9, 'Bungalow', 40, 1, 2, '2000000 đồng', 'Theo đêm', 10, 'Đang hoạt động'),
    (10, 'Phòng tiêu chuẩn', 45, 1, 2, '2200000 đồng', 'Theo lần', 6, 'Đang hoạt động');

INSERT INTO DichVuDiKem (IDDichVuDiKem, TenDichVuDiKem, Gia, DonVi, TrangThaiKhaDung) VALUES
    (1, 'Bể bơi riêng', 5000000, 1, 'Có sẵn'),
    (2, 'Bữa sáng', 150000, 1, 'Có sẵn'),
    (3, 'Xe đưa đón sân bay', 1000000, 1, 'Có sẵn'),
    (4, 'Spa', 800000, 1, 'Có sẵn'),
    (5, 'Dịch vụ phòng', 200000, 1, 'Có sẵn'),
    (6, 'Thiết bị vui chơi gia đình', 300000, 1, 'Có sẵn'),
    (7, 'Tour du lịch', 500000, 1, 'Có sẵn'),
    (8, 'Dịch vụ giặt là', 100000, 1, 'Có sẵn'),
    (9, 'Bể Jacuzzi', 700000, 1, 'Có sẵn'),
    (10, 'Dịch vụ cho thú cưng', 200000, 1, 'Có sẵn');

INSERT INTO TrinhDo (IDTrinhDo, TrinhDo) VALUES
    (1, 'Đại học'),
    (2, 'Cao đẳng'),
    (3, 'Trung cấp'),
    (4, 'Sơ cấp'),
    (5, 'Chứng chỉ'),
    (6, 'Khác'),
    (7, 'Thạc sĩ'),
    (8, 'Tiến sĩ'),
    (9, 'Thạc sĩ cao cấp'),
    (10, 'Chuyên gia'),
    (11, 'Kiến trúc sư'),
    (12, 'Kỹ sư');

INSERT INTO ViTri (IDViTri, TenViTri) VALUES
    (1, 'Lãnh đạo'),
    (2, 'Nhân viên văn phòng'),
    (3, 'Kỹ thuật viên'),
    (4, 'Quản lý dự án'),
    (5, 'Chuyên viên kinh doanh'),
    (6, 'Nhân viên lễ tân'),
    (7, 'Quản lý nhân sự'),
    (8, 'Kế toán viên'),
    (9, 'Kỹ sư phần mềm'),
    (10, 'Bảo vệ');

INSERT INTO BoPhan (IDBoPhan, TenBoPhan) VALUES
    (1, 'Ban điều hành'),
    (2, 'Phòng kinh doanh'),
    (3, 'Phòng nhân sự'),
    (4, 'Phòng kỹ thuật'),
    (5, 'Phòng dịch vụ khách hàng'),
    (6, 'Phòng tài chính'),
    (7, 'Phòng marketing'),
    (8, 'Phòng hành chính'),
    (9, 'Phòng IT'),
    (10, 'Ban bảo vệ');

-- Assuming IDViTri, IDTrinhDo, and IDBoPhan refer to existing IDs in ViTri, TrinhDo, and BoPhan tables
INSERT INTO NhanVien (IDNhanVien, HoTen, IDViTri, IDTrinhDo, IDBoPhan, NgaySinh, SoCMND, Luong, SDT, Email, DiaChi) VALUES
    (1, 'Nguyễn Văn An', 2, 1, 2, '1990-05-15', '123456789', '15000000 đồng', '0987654321', 'nguyenvanan@example.com', 'Hà Nội'),
    (2, 'Trần Thị Bình', 6, 2, 3, '1985-08-20', '987654321', '12000000 đồng', '0123456789', 'tranthibinh@example.com', 'Hồ Chí Minh'),
    (3, 'Phạm Văn Cường', 3, 3, 4, '1978-12-10', '654321789', '9000000 đồng', '0909090909', 'phamvancuong@example.com', 'Đà Nẵng'),
    (4, 'Hoàng Thị Dung', 7, 4, 5, '1995-04-25', '456789123', '8000000 đồng', '0999888777', 'hoangthidung@example.com', 'Nha Trang'),
    (5, 'Lê Văn Đức', 4, 5, 6, '1980-10-01', '987654321', '10000000 đồng', '0888777666', 'levanduc@example.com', 'Vũng Tàu'),
    (6, 'Mai Thị Eo', 8, 6, 7, '1992-03-08', '123456789', '11000000 đồng', '0777666555', 'maithieo@example.com', 'Quảng Ninh'),
    (7, 'Nguyễn Văn Phúc', 1, 7, 8, '1976-07-18', '567891234', '16000000 đồng', '0666555444', 'nguyenvanphuc@example.com', 'Hải Phòng'),
    (8, 'Trần Thị Hương', 5, 8, 9, '1987-06-21', '987123654', '13000000 đồng', '0555444333', 'tranthihuong@example.com', 'Phú Quốc'),
    (9, 'Lê Văn Giang', 10, 9, 10, '1998-09-30', '654789123', '9500000 đồng', '0444333222', 'levangiang@example.com', 'Đà Lạt'),
    (10, 'Phạm Văn Khánh', 9, 10, 1, '1993-11-05', '789456123', '14000000 đồng', '0333222111', 'phamvankhanh@example.com', 'Hội An');

-- Assuming IDNhanVien and IDKhachHang refer to existing IDs in NhanVien and KhachHang tables, and IDDichVu refers to existing IDs in DichVu table
INSERT INTO Hop_Dong (IDHopDong, IDNhanVien, IDKhachHang, IDDichVu, NgayLamHopDong, NgayKetThuc, TienDatCoc, TongTien) VALUES
    (1, 1, 1, 2, '2024-01-01', '2024-01-15', 5000000, 25000000),
    (2, 2, 2, 3, '2024-02-05', '2024-02-20', 3000000, 18000000),
    (3, 3, 3, 4, '2024-03-10', '2024-03-25', 4000000, 24000000),
    (4, 4, 4, 5, '2024-04-15', '2024-04-30', 3500000, 21000000),
    (5, 5, 5, 6, '2024-05-20', '2024-06-04', 6000000, 36000000),
    (6, 6, 6, 7, '2024-06-25', '2024-07-10', 7000000, 42000000),
    (7, 7, 7, 8, '2024-07-30', '2024-08-14', 4500000, 27000000),
    (8, 8, 8, 9, '2024-08-15', '2024-08-30', 3000000, 18000000),
    (9, 9, 9, 10, '2024-09-01', '2024-09-16', 2000000, 12000000),
    (10, 10, 10, 1, '2024-10-05', '2024-10-20', 4000000, 24000000);

-- Assuming IDHopDong and IDDichVuDiKem refer to existing IDs in Hop_Dong and DichVuDiKem tables
INSERT INTO HopDongChiTiet (IDHopDongChiTiet, IDHopDong, IDDichVuDiKem, SoLuong) VALUES
    (1, 1, 1, 1),
    (2, 2, 2, 2),
    (3, 3, 3, 3),
    (4, 4, 4, 4),
    (5, 5, 5, 5),
    (6, 6, 6, 6),
    (7, 7, 7, 7),
    (8, 8, 8, 8),
    (9, 9, 9, 9),
    (10, 10, 10, 10);







