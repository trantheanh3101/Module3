# 2.	Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu
# là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
SELECT * FROM NhanVien
WHERE (HoTen LIKE 'H%' OR HoTen LIKE 'T%' OR HoTen LIKE 'K%') AND CHAR_LENGTH(HoTen) <= 15;