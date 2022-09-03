--Bài 1: Để quản lý Thực tập nghề nghiệp của sinh viên, người ta xây dựng một cơ sở dữ liệu có tên là ThucTap
--gồm các sơ đồ quan hệ sau:

--Khoa(makhoa char(10), tenkhoa char(30), dienthoai char(10))
--GiangVien(magv int, hotengv char(30), luong decimal(5,2), makhoa char(10))
--SinhVien(masv int, hotensv char(30), makhoa char(10), namsinh int, quequan char(30))
--DeTai(madt char(10), tendt char(30), kinhphi int, NoiThucTap char(30))
--HuongDan(masv int, madt char(10), magv int, ketqua decimal(5,2))


CREATE DATABASE ThucTap;
USE ThucTap;
CREATE TABLE TBLKhoa
(Makhoa char(10)primary key,
 Tenkhoa char(30),
 Dienthoai char(10));
CREATE TABLE TBLGiangVien(
Magv int primary key,
Hotengv char(30),
Luong decimal(5,2),
Makhoa char(10) references TBLKhoa);
CREATE TABLE TBLSinhVien(
Masv int primary key,
Hotensv char(40),
Makhoa char(10)foreign key references TBLKhoa,
Namsinh int,
Quequan char(30));
CREATE TABLE TBLDeTai(
Madt char(10)primary key,
Tendt char(30),
Kinhphi int,
Noithuctap char(30));
CREATE TABLE TBLHuongDan(
Masv int primary key,
Madt char(10)foreign key references TBLDeTai,
Magv int foreign key references TBLGiangVien,
KetQua decimal(5,2));
INSERT INTO TBLKhoa VALUES
('Geo','Dia ly va QLTN',3855413),
('Math','Toan',3855411),
('Bio','Cong nghe Sinh hoc',3855412);
INSERT INTO TBLGiangVien VALUES
(11,'Thanh Binh',700,'Geo'),    
(12,'Thu Huong',500,'Math'),
(13,'Chu Vinh',650,'Geo'),
(14,'Le Thi Ly',500,'Bio'),
(15,'Tran Son',900,'Math');
INSERT INTO TBLSinhVien VALUES
(1,'Le Van Son','Bio',1990,'Nghe An'),
(2,'Nguyen Thi Mai','Geo',1990,'Thanh Hoa'),
(3,'Bui Xuan Duc','Math',1992,'Ha Noi'),
(4,'Nguyen Van Tung','Bio',null,'Ha Tinh'),
(5,'Le Khanh Linh','Bio',1989,'Ha Nam'),
(6,'Tran Khac Trong','Geo',1991,'Thanh Hoa'),
(7,'Le Thi Van','Math',null,'null'),
(8,'Hoang Van Duc','Bio',1992,'Nghe An');
INSERT INTO TBLDeTai VALUES
('Dt01','GIS',100,'Nghe An'),
('Dt02','ARC GIS',500,'Nam Dinh'),
('Dt03','Spatial DB',100, 'Ha Tinh'),
('Dt04','MAP',300,'Quang Binh' );
INSERT INTO TBLHuongDan VALUES
(1,'Dt01',13,8),
(2,'Dt03',14,0),
(3,'Dt03',12,10),
(5,'Dt04',14,7),
(6,'Dt01',13,Null),
(7,'Dt04',11,10),
(8,'Dt03',15,6);

--1. Đưa ra thông tin gồm mã số, họ tênvà tên khoa của tất cả các giảng viên
SELECT Magv, Hotengv, Tenkhoa
FROM TBLGiangVien, TBLKhoa
WHERE TBLGiangVien.Makhoa = TBLKhoa.Makhoa
--2. Đưa ra thông tin gồm mã số, họ tênvà tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’
SELECT Magv, Hotengv, Tenkhoa
FROM TBLGiangVien, TBLKhoa
WHERE TBLGiangVien.Makhoa = TBLKhoa.Makhoa AND Tenkhoa = 'DIA LY va QLTN'
--3. Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
SELECT COUNT(*) AS 'SOLUONG'
FROM TBLKhoa, TBLSinhVien
WHERE TBLKhoa.Makhoa = TBLSinhVien.Makhoa AND Tenkhoa = 'CONG NGHE SINH HOC'
--4. Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’
SELECT Masv, Hotensv, YEAR(GETDATE()) - Namsinh AS 'TUOI'
FROM TBLKhoa, TBLSinhVien
WHERE TBLKhoa.Makhoa = TBLSinhVien.Makhoa AND Tenkhoa = N'TOAN'
--5. Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
SELECT COUNT(*) AS 'SOLUONG'
FROM TBLKhoa, TBLGiangVien
WHERE TBLKhoa.Makhoa = TBLGiangVien.Makhoa AND Tenkhoa = 'CONG NGHE SINH HOC'
--6. Cho biết thông tin về sinh viên không tham gia thực tập
SELECT *
FROM TBLSinhVien
WHERE Masv NOT IN (SELECT TBLSinhVien.Masv
					FROM TBLSinhVien, TBLHuongDan
					WHERE TBLSinhVien.Masv = TBLHuongDan.Masv)
--7. Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
SELECT TBLKhoa.Makhoa, Tenkhoa, COUNT(*) AS 'SLGV'
FROM TBLKhoa, TBLGiangVien
WHERE TBLKhoa.Makhoa = TBLGiangVien.Makhoa
GROUP BY TBLKhoa.Makhoa, TBLKhoa.Tenkhoa
--8. Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
SELECT Dienthoai
FROM TBLKhoa, TBLSinhVien
WHERE TBLKhoa.Makhoa = TBLSinhVien.Makhoa AND Hotensv = 'Le van son'
--9. Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
SELECT TBLDeTai.Madt, TBLDeTai.Tendt
FROM TBLDeTai, TBLGiangVien, TBLHuongDan
WHERE TBLDeTai.Madt = TBLHuongDan.Madt AND TBLHuongDan.Magv = TBLGiangVien.Magv AND Hotengv = 'Tran son'
--10.Cho biết tên đề tài không có sinh viên nào thực tập
SELECT Tendt
FROM TBLDeTai
WHERE Madt NOT IN (SELECT TBLDeTai.Madt
					FROM TBLHuongDan, TBLDeTai
					WHERE TBLDeTai.Madt = TBLHuongDan.Madt)
--11.Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
SELECT TBLGiangVien.Magv, TBLGiangVien.Hotengv, TBLKhoa.Tenkhoa
FROM TBLGiangVien, TBLHuongDan, TBLKhoa
WHERE TBLGiangVien.Makhoa = TBLKhoa.Makhoa AND TBLGiangVien.Magv = TBLHuongDan.Magv
GROUP BY TBLGiangVien.Magv, TBLGiangVien.Hotengv, TBLKhoa.Tenkhoa
HAVING COUNT(*) >= 3
--12.Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
SELECT Madt, Tendt
FROM TBLDeTai
WHERE Kinhphi >= (SELECT MAX(Kinhphi) FROM TBLDeTai)
--13. Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
SELECT TBLDeTai.Madt, Tendt
FROM TBLDeTai, TBLHuongDan
WHERE TBLDeTai.Madt = TBLHuongDan.Madt
GROUP BY TBLDeTai.Madt, Tendt
HAVING COUNT(*) > 2
--14.Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIA LY va QLTN’
SELECT TBLSinhVien.Masv, Hotensv, TBLHuongDan.KetQua
FROM TBLSinhVien, TBLKhoa, TBLHuongDan
WHERE TBLSinhVien.Makhoa = TBLKhoa.Makhoa AND TBLSinhVien.Masv = TBLHuongDan.Masv AND TBLKhoa.Tenkhoa = 'DIA LY va QLTN'
--15.Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
SELECT Tenkhoa, COUNT(*) AS 'SLSV'
FROM TBLKhoa
GROUP BY Tenkhoa
--16.Cho biết thông tin về các sinh viên thực tập tại quê nhà
SELECT TBLSinhVien.*
FROM TBLSinhVien, TBLHuongDan, TBLDeTai
WHERE TBLSinhVien.Masv = TBLHuongDan.Masv AND TBLDeTai.Madt = TBLHuongDan.Madt
	AND TBLSinhVien.Quequan = TBLDeTai.Noithuctap
--17.Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
SELECT TBLSinhVien.*
FROM TBLSinhVien, TBLHuongDan
WHERE TBLSinhVien.Masv = TBLHuongDan.Masv AND TBLHuongDan.KetQua IS NULL
--18.Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
SELECT TBLSinhVien.Masv, Hotensv
FROM TBLSinhVien, TBLHuongDan
WHERE TBLSinhVien.Masv = TBLHuongDan.Masv AND TBLHuongDan.KetQua = 0