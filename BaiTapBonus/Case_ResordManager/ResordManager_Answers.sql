# 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu
# là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
SELECT * FROM NhanVien
WHERE (HoTen LIKE 'H%' OR HoTen LIKE 'T%' OR HoTen LIKE 'K%') AND CHAR_LENGTH(HoTen) <= 15;

# 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi
#       và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select * from khachhang kh
where (kh.DiaChi = 'Đà Nẵng' OR kh.DiaChi = 'Quảng Trị')
    AND (TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) BETWEEN 18 AND 50);

# 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần.
#       Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
#       Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
    select kh.*,count(hd.IDHopDong) as sl_hd,l.TenLoaiKhach
    from khachhang kh
    inner join furamaresort.hop_dong hd on kh.IDKhachHang = hd.IDKhachHang
    inner join furamaresort.loaikhach l on kh.IDLoaiKhach = l.IDLoaiKhach
    where TenLoaiKhach = 'Diamond'
    group by hd.IDKhachHang
#     having l.TenLoaiKhach = 'Diamond'
    order by sl_hd asc;

# 5.	Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien
# (Với TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia,
# với SoLuong và Giá là từ bảng DichVuDiKem) cho tất cả các Khách hàng đã từng đặt phỏng.
# (Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).

SELECT
    KH.IDKhachHang,
    KH.HoTen,
    LK.TenLoaiKhach,
    HD.IDHopDong,
    DV.TenDichVu,
    HD.NgayLamHopDong,
    HD.NgayKetThuc,
    (HD.TongTien + COALESCE(SUM(HDCT.SoLuong * DDK.Gia), 0)) AS TongTien
FROM
    KhachHang KH
        LEFT JOIN Hop_Dong HD ON KH.IDKhachHang = HD.IDKhachHang
        LEFT JOIN LoaiKhach LK ON KH.IDLoaiKhach = LK.IDLoaiKhach
        LEFT JOIN DichVu DV ON HD.IDDichVu = DV.IDDichVu
        LEFT JOIN HopDongChiTiet HDCT ON HD.IDHopDong = HDCT.IDHopDong
        LEFT JOIN DichVuDiKem DDK ON HDCT.IDDichVuDiKem = DDK.IDDichVuDiKem
GROUP BY
    KH.IDKhachHang, HD.IDHopDong
ORDER BY
    KH.IDKhachHang, HD.IDHopDong;



