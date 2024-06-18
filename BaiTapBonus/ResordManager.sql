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
    SoNguoiToiDa VARCHAR(45),
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

