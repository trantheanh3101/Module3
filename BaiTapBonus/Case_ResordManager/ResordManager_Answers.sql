# 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu
# là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
SELECT * FROM NhanVien
WHERE (HoTen LIKE 'H%' OR HoTen LIKE 'T%' OR HoTen LIKE 'K%') AND CHAR_LENGTH(HoTen) <= 15;

# 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi
#       và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select * from khachhang kh
where (kh.DiaChi LIKE '%Đà Nẵng' OR kh.DiaChi LIKE '%Quảng Trị')
    AND (TIMESTAMPDIFF(YEAR, NgaySinh, CURDATE()) BETWEEN 18 AND 50);

# 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần.
#       Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng.
#       Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
    select kh.IDKhachHang, kh.HoTen,count(hd.IDHopDong) as sl_hd,l.TenLoaiKhach
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

SELECT KH.IDKhachHang,KH.HoTen,LK.TenLoaiKhach,
    HD.IDHopDong,DV.TenDichVu,HD.NgayLamHopDong,HD.NgayKetThuc,
    (DV.ChiPhiThue + SUM(HDC.SoLuong * DVK.Gia)) AS TongTien
FROM KhachHang KH
LEFT JOIN LoaiKhach LK ON KH.IDLoaiKhach = LK.IDLoaiKhach
LEFT JOIN Hop_Dong HD ON KH.IDKhachHang = HD.IDKhachHang
LEFT JOIN DichVu DV ON HD.IDDichVu = DV.IDDichVu
LEFT JOIN HopDongChiTiet HDC ON HD.IDHopDong = HDC.IDHopDong
LEFT JOIN DichVuDiKem DVK ON HDC.IDDichVuDiKem = DVK.IDDichVuDiKem
GROUP BY
    KH.IDKhachHang,
    HD.IDHopDong
ORDER BY
    KH.IDKhachHang;

SELECT
    kh.IDKhachHang,
    kh.HoTen,
    lk.TenLoaiKhach,
    hd.IDHopDong,
    dv.TenDichVu,
    hd.NgayLamHopDong,
    hd.NgayKetThuc,
    COALESCE(dv.ChiPhiThue, 0) + COALESCE(hdct.SoLuong, 0) * COALESCE(dvd.Gia, 0) AS TongTien
FROM
    KhachHang kh
        LEFT JOIN Hop_Dong hd ON kh.IDKhachHang = hd.IDKhachHang
        LEFT JOIN DichVu dv ON hd.IDDichVu = dv.IDDichVu
        LEFT JOIN LoaiKhach lk ON kh.IDLoaiKhach = lk.IDLoaiKhach
        LEFT JOIN HopDongChiTiet hdct ON hd.IDHopDong = hdct.IDHopDong
        LEFT JOIN DichVuDiKem dvd ON hdct.IDDichVuDiKem = dvd.IDDichVuDiKem
GROUP BY kh.IDKhachHang,hd.IDHopDong
ORDER BY
    kh.IDKhachHang;


# 6.	Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, ten_loai_dich_vu của tất cả
# các loại dịch vụ chưa từng được khách hàng thực hiện đặt từ quý 1 của năm 2024 (Quý 1 là tháng 1, 2, 3).
select dv.IDDichVu,dv.TenDichVu,dv.DienTich,dv.ChiPhiThue,ldv.TenLoaiDichVu
from dichvu dv
join loaidichvu ldv on dv.IDLoaiDichVu = ldv.IDLoaiDichVu
join hop_dong hd on dv.IDDichVu = hd.IDDichVu
where MONTH(hd.NgayLamHopDong) not between 1 and 3
group by dv.IDDichVu;

# 7.	Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da, chi_phi_thue, ten_loai_dich_vu
# của tất cả các loại dịch vụ đã từng được khách hàng đặt phòng trong năm 2020
# nhưng chưa từng được khách hàng đặt phòng trong năm 2021.
SELECT dv.IDDichVu,dv.TenDichVu,dv.DienTich,dv.SoNguoiToiDa,dv.ChiPhiThue,ldv.TenLoaiDichVu
FROM DichVu dv
JOIN LoaiDichVu ldv ON dv.IDLoaiDichVu = ldv.IDLoaiDichVu
JOIN Hop_Dong hd ON dv.IDDichVu = hd.IDDichVu
WHERE YEAR(hd.NgayLamHopDong) = 2020
  AND dv.IDDichVu NOT IN (
    SELECT DISTINCT dv.IDDichVu
    FROM DichVu dv
    JOIN Hop_Dong hd ON dv.IDDichVu = hd.IDDichVu
    WHERE YEAR(hd.NgayLamHopDong) = 2021
)
group by dv.IDDichVu






