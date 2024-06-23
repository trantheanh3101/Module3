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
SELECT kh.IDKhachHang,kh.HoTen,lk.TenLoaiKhach,hd.IDHopDong,dv.TenDichVu,hd.NgayLamHopDong,hd.NgayKetThuc,
    COALESCE(dv.ChiPhiThue, 0) + COALESCE(sum(hdct.SoLuong * dvd.Gia),0) AS TongTien
#         (dv.ChiPhiThue + hdct.SoLuong * dvd.Gia) as TongTien
FROM KhachHang kh
LEFT JOIN Hop_Dong hd ON kh.IDKhachHang = hd.IDKhachHang
LEFT JOIN DichVu dv ON hd.IDDichVu = dv.IDDichVu
LEFT JOIN LoaiKhach lk ON kh.IDLoaiKhach = lk.IDLoaiKhach
LEFT JOIN HopDongChiTiet hdct ON hd.IDHopDong = hdct.IDHopDong
LEFT JOIN DichVuDiKem dvd ON hdct.IDDichVuDiKem = dvd.IDDichVuDiKem
group by kh.IDKhachHang,hd.IDHopDong
ORDER BY kh.IDKhachHang;


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
group by dv.IDDichVu;

# 8.	Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.
# Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên.
# cach 1:
SELECT DISTINCT HoTen
FROM KhachHang;
#  caách 2:
SELECT HoTen
FROM KhachHang
GROUP BY HoTen;
#  cach 3:

# 9.	Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2021
# thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
SELECT MONTH(NgayLamHopDong) AS Thang,COUNT(DISTINCT IDKhachHang) AS SoLuongKhachHang
FROM Hop_Dong
WHERE YEAR(NgayLamHopDong) = 2021
GROUP BY MONTH(NgayLamHopDong)
ORDER BY Thang;

# 10.	Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng bao nhiêu dịch vụ đi kèm.
#       Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong, ngay_ket_thuc, tien_dat_coc,
#       so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
    select hd.IDHopDong,hd.NgayLamHopDong,hd.NgayKetThuc,hd.TienDatCoc, sum(hdct.SoLuong) as sl_dvdk
    from hop_dong hd
    left join hopdongchitiet hdct on hd.IDHopDong = hdct.IDHopDong
    group by hd.IDHopDong;

# 11.	Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng có ten_loai_khach là “Diamond”
#       và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
select dvdk.IDDichVuDiKem,dvdk.TenDichVuDiKem
from dichvudikem dvdk
left join furamaresort.hopdongchitiet h on dvdk.IDDichVuDiKem = h.IDDichVuDiKem
left join furamaresort.hop_dong hd on hd.IDHopDong = h.IDHopDong
left join furamaresort.khachhang k on k.IDKhachHang = hd.IDKhachHang
left join furamaresort.loaikhach l on l.IDLoaiKhach = k.IDLoaiKhach
where (k.DiaChi like '%Vinh' or k.DiaChi like '%Quảng Ngãi') and l.TenLoaiKhach = 'Diamond';

# 12.	Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), so_dien_thoai (khách hàng),
# ten_dich_vu, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), tien_dat_coc
# của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2020
# nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.
select hd.IDHopDong,n.HoTen as Name_NV,k.HoTen as Name_KH,k.SDT as sdt_kh,d.TenDichVu,sum(h.SoLuong) as sl_dvdk,hd.TienDatCoc
from hop_dong hd
left join furamaresort.nhanvien n on n.IDNhanVien = hd.IDNhanVien
left join furamaresort.khachhang k on k.IDKhachHang = hd.IDKhachHang
left join furamaresort.dichvu d on d.IDDichVu = hd.IDDichVu
left join furamaresort.hopdongchitiet h on hd.IDHopDong = h.IDHopDong
where hd.NgayLamHopDong BETWEEN '2020-10-01' AND '2020-12-31'
  AND d.IDDichVu not in (
     SELECT DISTINCT d.IDDichVu
     from hop_dong hd
         left join furamaresort.dichvu d on d.IDDichVu = hd.IDDichVu
         where hd.NgayLamHopDong BETWEEN '2021-01-01' AND '2021-06-30'
    )
group by hd.IDHopDong;

# 13.	Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.
# (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).

#  -------------- cach 1: sử dụng subquery
    select dvdk.IDDichVuDiKem,dvdk.TenDichVuDiKem,sum(h.SoLuong) as sl_dvdk
    from dichvudikem dvdk
    left join furamaresort.hopdongchitiet h on dvdk.IDDichVuDiKem = h.IDDichVuDiKem
    group by dvdk.IDDichVuDiKem
    having sl_dvdk = (
        select max(sldvdk) from (
            select sum(h2.SoLuong) as sldvdk
            from dichvudikem d
            left join furamaresort.hopdongchitiet h2 on d.IDDichVuDiKem = h2.IDDichVuDiKem
            group by d.IDDichVuDiKem) as maxsldvdk
        );

#      ------ cach 2: Views -------
CREATE OR REPLACE VIEW views_sl_dvdk as
    select dvdk.*,sum(h.SoLuong) as sl_dvdk
    from dichvudikem dvdk
    left join furamaresort.hopdongchitiet h on dvdk.IDDichVuDiKem = h.IDDichVuDiKem
    group by dvdk.IDDichVuDiKem;
select v.IDDichVuDiKem,v.TenDichVuDiKem,v.sl_dvdk
from views_sl_dvdk v
where sl_dvdk = (select max(sl_dvdk) from views_sl_dvdk);

#    ------ cach 3: CTE --------
    with cte as
    (
        select dvdk.*,sum(h.SoLuong) as sl_dvdk
        from dichvudikem dvdk
        left join furamaresort.hopdongchitiet h on dvdk.IDDichVuDiKem = h.IDDichVuDiKem
        group by dvdk.IDDichVuDiKem
    )
    select cte.IDDichVuDiKem,cte.TenDichVuDiKem,cte.sl_dvdk
    from cte
    where sl_dvdk =(select max(sl_dvdk) from cte);


# 14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất.
# Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem, so_lan_su_dung
# (được tính dựa trên việc count các ma_dich_vu_di_kem).
    select hd.IDHopDong,l.TenLoaiDichVu,dvdk.TenDichVuDiKem,COUNT(h.SoLuong) as slsd
    from dichvudikem dvdk
    left join furamaresort.hopdongchitiet h on dvdk.IDDichVuDiKem = h.IDDichVuDiKem
    left join furamaresort.hop_dong hd on hd.IDHopDong = h.IDHopDong
    left join furamaresort.dichvu d on d.IDDichVu = hd.IDDichVu
    left join furamaresort.loaidichvu l on l.IDLoaiDichVu = d.IDLoaiDichVu
    group by dvdk.TenDichVuDiKem
    having slsd = 1;

# 15.	Hiển thi thông tin của tất cả nhân viên bao gồm
#        ma_nhan_vien, ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai, dia_chi
#        mới chỉ lập được tối đa 3 hợp đồng từ năm 2020 đến 2021.
    select nv.IDNhanVien,nv.HoTen,t.TrinhDo,b.TenBoPhan,nv.SDT,nv.DiaChi
    from nhanvien nv
    left join furamaresort.trinhdo t on t.IDTrinhDo = nv.IDTrinhDo
    left join furamaresort.bophan b on b.IDBoPhan = nv.IDBoPhan
    left join furamaresort.hop_dong hd on nv.IDNhanVien = hd.IDNhanVien
    left join furamaresort.hopdongchitiet h on hd.IDHopDong = h.IDHopDong
    where hd.NgayLamHopDong BETWEEN '2020-01-01' AND '2021-12-31'
    group by nv.IDNhanVien
    having count(hd.IDHopDong) <= 3
    order by nv.IDNhanVien;

# 16.	Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021.
SELECT nv.IDNhanVien,nv.HoTen
# delete
FROM NhanVien nv
WHERE nv.IDNhanVien NOT IN (
        SELECT DISTINCT hd.IDNhanVien
        FROM Hop_Dong hd
        WHERE hd.NgayLamHopDong BETWEEN '2019-01-01' AND '2021-12-31'
    );

# 17.	Cập nhật thông tin những khách hàng có ten_loai_khach từ Platinum lên Diamond,
# chỉ cập nhật những khách hàng đã từng đặt phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.
#      cach 1: view
DROP VIEW IF EXISTS khachhang_update;
CREATE VIEW KhachHang_Update AS
    SELECT kh.IDKhachHang,kh.HoTen,lk.TenLoaiKhach,hd.IDHopDong,dv.TenDichVu,hd.NgayLamHopDong,hd.NgayKetThuc,
           COALESCE(dv.ChiPhiThue, 0) + COALESCE(sum(hdct.SoLuong * dvd.Gia),0) AS TongTien
    FROM KhachHang kh
        LEFT JOIN Hop_Dong hd ON kh.IDKhachHang = hd.IDKhachHang
        LEFT JOIN DichVu dv ON hd.IDDichVu = dv.IDDichVu
        LEFT JOIN LoaiKhach lk ON kh.IDLoaiKhach = lk.IDLoaiKhach
        LEFT JOIN HopDongChiTiet hdct ON hd.IDHopDong = hdct.IDHopDong
        LEFT JOIN DichVuDiKem dvd ON hdct.IDDichVuDiKem = dvd.IDDichVuDiKem
    WHERE lk.TenLoaiKhach = 'Platinium' AND YEAR(hd.NgayLamHopDong) = 2021
    group by kh.IDKhachHang,hd.IDHopDong
    HAVING TongTien > 10000000;

SELECT *
FROM khachhang as kh
join KhachHang_Update AS ku ON kh.IDKhachHang = ku.IDKhachHang
where kh.IDLoaiKhach = 2;

UPDATE KhachHang AS kh
    JOIN KhachHang_Update AS ku ON kh.IDKhachHang = ku.IDKhachHang
SET kh.IDLoaiKhach = 1      -- ID của loại Diamond
WHERE kh.IDLoaiKhach = 2; -- ID của loại Platinum

#  cach2 : sub
UPDATE KhachHang AS kh
JOIN (
    SELECT kh.IDKhachHang,kh.HoTen,lk.TenLoaiKhach,hd.IDHopDong,dv.TenDichVu,hd.NgayLamHopDong,hd.NgayKetThuc,
    COALESCE(dv.ChiPhiThue, 0) + COALESCE(sum(hdct.SoLuong * dvd.Gia),0) AS TongTien
    FROM KhachHang kh
    LEFT JOIN Hop_Dong hd ON kh.IDKhachHang = hd.IDKhachHang
    LEFT JOIN DichVu dv ON hd.IDDichVu = dv.IDDichVu
    LEFT JOIN LoaiKhach lk ON kh.IDLoaiKhach = lk.IDLoaiKhach
    LEFT JOIN HopDongChiTiet hdct ON hd.IDHopDong = hdct.IDHopDong
    LEFT JOIN DichVuDiKem dvd ON hdct.IDDichVuDiKem = dvd.IDDichVuDiKem
    WHERE lk.TenLoaiKhach = 'Platinium' AND YEAR(hd.NgayLamHopDong) = 2021
    group by kh.IDKhachHang,hd.IDHopDong
    HAVING TongTien > 10000000) AS ku ON kh.IDKhachHang = ku.IDKhachHang
SET kh.IDLoaiKhach = 1      -- ID của loại Diamond
WHERE kh.IDLoaiKhach = 2; -- ID của loại Platinum


# 18.	Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).
SELECT DISTINCT *
FROM KhachHang AS kh
JOIN Hop_Dong AS hd ON kh.IDKhachHang = hd.IDKhachHang
WHERE YEAR(hd.NgayLamHopDong) < 2021;

#
# 19.	Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.
#
# 20.	Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống,
# thông tin hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.

#  	----------------------- SQL NÂNG CAO -------------------
# 21.	Tạo khung nhìn có tên là v_nhan_vien để lấy được thông tin của tất cả các nhân viên có địa chỉ là “Hải Châu”
#       và đã từng lập hợp đồng cho một hoặc nhiều khách hàng bất kì với ngày lập hợp đồng là “12/12/2019”.

# 22.	Thông qua khung nhìn v_nhan_vien thực hiện cập nhật địa chỉ thành “Liên Chiểu”
# đối với tất cả các nhân viên được nhìn thấy bởi khung nhìn này.

# 23.	Tạo Stored Procedure sp_xoa_khach_hang dùng để xóa thông tin của một khách hàng nào đó với
#       ma_khach_hang được truyền vào như là 1 tham số của sp_xoa_khach_hang.

# 24.	Tạo Stored Procedure sp_them_moi_hop_dong dùng để thêm mới vào bảng hop_dong với yêu cầu
#       sp_them_moi_hop_dong phải thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung,
#       với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.

# 25.	Tạo Trigger có tên tr_xoa_hop_dong khi xóa bản ghi trong bảng hop_dong
#       thì hiển thị tổng số lượng bản ghi còn lại có trong bảng hop_dong ra giao diện console của database.
        # Lưu ý: Đối với MySQL thì sử dụng SIGNAL hoặc ghi log thay cho việc ghi ở console.

# 26.	Tạo Trigger có tên tr_cap_nhat_hop_dong khi cập nhật ngày kết thúc hợp đồng,
#       cần kiểm tra xem thời gian cập nhật có phù hợp hay không, với quy tắc sau:
#           Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày.
#           Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu dữ liệu không hợp lệ
#           thì in ra thông báo “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database.
#           Lưu ý: Đối với MySQL thì sử dụng SIGNAL hoặc ghi log thay cho việc ghi ở console.

# 27.	Tạo Function thực hiện yêu cầu sau:
# a.	Tạo Function func_dem_dich_vu: Đếm các dịch vụ đã được sử dụng với tổng tiền là > 2.000.000 VNĐ.
# b.	Tạo Function func_tinh_thoi_gian_hop_dong: Tính khoảng thời gian dài nhất tính từ lúc bắt đầu làm hợp đồng
#       đến lúc kết thúc hợp đồng mà khách hàng đã thực hiện thuê dịch vụ
#       (lưu ý chỉ xét các khoảng thời gian dựa vào từng lần làm hợp đồng thuê dịch vụ, không xét trên toàn bộ các lần làm hợp đồng).
#       Mã của khách hàng được truyền vào như là 1 tham số của function này.

# 28.	Tạo Stored Procedure sp_xoa_dich_vu_va_hd_room để tìm các dịch vụ được thuê bởi khách hàng
#       với loại dịch vụ là “Room” từ đầu năm 2015 đến hết năm 2019
#       để xóa thông tin của các dịch vụ đó (tức là xóa các bảng ghi trong bảng dich_vu)
#       và xóa những hop_dong sử dụng dịch vụ liên quan (tức là phải xóa những bản gi trong bảng hop_dong)
#       và những bản liên quan khác.




