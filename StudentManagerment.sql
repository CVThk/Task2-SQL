CREATE DATABASE StudentManagerment
GO

USE StudentManagerment
GO


CREATE TABLE SINHVIEN (
	MSSV CHAR(10) NOT NULL,
	TENSV NVARCHAR(50),
	GIOITINH NVARCHAR(5),
	NGAYSINH DATE,
	NGAYVAOTRUONG DATE,
	LOP CHAR(10),
	KHOA NVARCHAR(50),
	TRANGTHAI NVARCHAR(20),
	BACDAOTAO NVARCHAR(20),
	SDT CHAR(11),
	CMND CHAR(10),
	DIACHI NVARCHAR(50),
	DANTOC NVARCHAR(10),
	TONGIAO NVARCHAR(20),
	CONSTRAINT PK_SINHVIEN PRIMARY KEY(MSSV)
)

CREATE TABLE MONHOC (
	MAMH CHAR(10) NOT NULL,
	TENMH NVARCHAR(50) NOT NULL,
	SOTIET INT,
	TYLEQUATRINH FLOAT,
	TYLETHANHPHAN FLOAT,
	CONSTRAINT PK_MONHOC PRIMARY KEY(MAMH)
)

CREATE TABLE DIEM (
	MSSV CHAR(10) NOT NULL,
	MAMH CHAR(10) NOT NULL,
	DIEMQUATRINH FLOAT,
	DIEMTHANHPHAN FLOAT,
	CONSTRAINT PK_DIEM PRIMARY KEY(MSSV, MAMH),
	CONSTRAINT FK_DIEM_SINHVIEN FOREIGN KEY(MSSV) REFERENCES SINHVIEN(MSSV),
	CONSTRAINT FK_DIEM_MONHOC FOREIGN KEY(MAMH) REFERENCES MONHOC(MAMH)
)

------------------------------------------------- RÀNG BUỘC

-- SINHVIEN
ALTER TABLE SINHVIEN
ADD CONSTRAINT CK_GIOITINH CHECK(GIOITINH = N'Nam' OR GIOITINH = N'Nữ')

CREATE TRIGGER TUOI ON SINHVIEN
FOR INSERT, UPDATE
AS
	IF(SELECT YEAR(GETDATE()) - YEAR(NGAYSINH) FROM inserted) >= 18
		COMMIT TRAN
	ELSE
		BEGIN
			PRINT N'SINH VIÊN PHẢI ĐỦ TỪ 18 TUỔI!'
			ROLLBACK TRAN
		END

ALTER TABLE SINHVIEN
ADD CONSTRAINT CK_BACDAOTAO CHECK(BACDAOTAO = N'Đại học' OR BACDAOTAO = N'Cao đẳng')

ALTER TABLE SINHVIEN
ADD CONSTRAINT UNI_SDT UNIQUE(SDT)

ALTER TABLE SINHVIEN
ADD CONSTRAINT UNI_CMND UNIQUE(CMND)

--MONHOC

ALTER TABLE MONHOC
ADD CONSTRAINT CK_TYLEQUATRINH CHECK(TYLEQUATRINH >= 0 AND TYLEQUATRINH <= 1)
ALTER TABLE MONHOC
ADD CONSTRAINT CK_TYLETHANHPHAN CHECK(TYLETHANHPHAN >= 0 AND TYLETHANHPHAN <= 1)

CREATE TRIGGER TYLE ON MONHOC
FOR INSERT, UPDATE
AS
	IF(SELECT TYLEQUATRINH + TYLETHANHPHAN FROM inserted) = 1
		COMMIT TRAN
	ELSE
		BEGIN
			PRINT N'TỶ LỆ ĐIỂM QUÁ TRÌNH VÀ THÀNH PHẦN PHẢI BẰNG 1!'
			ROLLBACK TRAN
		END
--DIEM
ALTER TABLE DIEM
ADD CONSTRAINT CK_DIEMQUATRINH CHECK(DIEMQUATRINH >= 0 AND DIEMQUATRINH <= 10)
ALTER TABLE DIEM
ADD CONSTRAINT CK_DIEMTHANHPHAN CHECK(DIEMTHANHPHAN >= 0 AND DIEMTHANHPHAN <= 10)

------------------------------------------- INSERT DATA


--SINH VIÊN
SET DATEFORMAT DMY
INSERT INTO SINHVIEN
VALUES ('2037190102', N'Lê Nguyễn Như Băng', N'Nữ', '10/11/2001', '01/09/2019', '10DHTH01',
N'Công nghệ thông tin', N'Đang học', N'Đại học', '0909090909', '231987098', N'Quận 1, HCM', N'Kinh', N'Không');
go
INSERT INTO SINHVIEN
VALUES('2037190007', N'Huỳnh Nhất Duy', N'Nam', '12/09/2001', '11/09/2019', '10DHTH02',
N'Công nghệ thông tin', N'Đang học', N'Đại học', '0909090908', '231987099', N'Quận 4, HCM', N'Kinh', N'Không');
go
INSERT INTO SINHVIEN
VALUES('2029212771', N'Bùi Yến Thơ', N'Nữ', '02/03/2003', '11/10/2021', '12DHAV06',
N'Ngôn ngữ Anh', N'Đang học', N'Đại học', '0368090708', '231333099', N'Quận 2, HCM', N'Kinh', N'Thiên Chúa');
go
INSERT INTO SINHVIEN
VALUES('2029212556', N'Nguyễn Trường Giang', N'Nam', '07/08/2003', '11/09/2021', '12DHAV07',
N'Ngôn ngữ Anh', N'Đang học', N'Đại học', '0365575432', '231987699', N'Quận 12, HCM', N'Hoa', N'Không');
go
INSERT INTO SINHVIEN
VALUES('2001202148', N'Đỗ Huệ Mẫn', N'Nữ', '20/05/2002', '11/09/2020', '11DHTH06',
N'Công nghệ thông tin', N'Đang học', N'Đại học', '0977654321', '165487099', N'Quận 10, HCM', N'Kinh', N'Không');
go
INSERT INTO SINHVIEN
VALUES ('2033210461', N'Nguyễn Ngọc Hiếu', N'Nữ', '02/10/2003', '01/09/2021', '12DHBM05',
N'Công nghệ thông tin', N'Đang học', N'Đại học', '0176323314', '321676545', N'Quận 3, HCM', N'HMông', N'Không');
go
INSERT INTO SINHVIEN
VALUES('2033210637', N'Nguyễn Trung Kha', N'Nam', '01/08/2003', '11/09/2021', '12DHBM05',
N'Công nghệ thông tin', N'Đang học', N'Đại học', '0876993245', '543672287', N'Quận 4, HCM', N'Tày', N'Không');
go
INSERT INTO SINHVIEN
VALUES('2033210918', N'Nguyễn Khánh Lữ', N'Nam', '12/04/2003', '11/10/2021', '12DHBM07',
N'Công nghệ thông tin', N'Đang học', N'Đại học', '0943223142', '764355426', N'Quận 2, HCM', N'Kinh', N'Thiên Chúa');
go
INSERT INTO SINHVIEN
VALUES('2033210438', N'Tất Huy Quyền', N'Nam', '29/08/2003', '11/09/2021', '12DHBM07',
N'Công nghệ thông tin', N'Đang học', N'Đại học', '0364477656', '898554344', N'Quận 12, HCM', N'Hoa', N'Không');
go
INSERT INTO SINHVIEN
VALUES('2033210985', N'Trần Công Danh', N'Nam', '06/07/2003', '11/09/2021', '12DHBM08',
N'Công nghệ thông tin', N'Đang học', N'Đại học', '0965784323', '167658768', N'Quận 10, HCM', N'Kinh', N'Không');
go

--MÔN HỌC
INSERT INTO MONHOC
VALUES ('NMLT',N'Nhập môn lập trình', 45, 0.3, 0.7);
GO
INSERT INTO MONHOC
VALUES ('KTLT',N'Kỹ thuật lập trình', 30, 0.3, 0.7);
GO
INSERT INTO MONHOC
VALUES ('THKTLT',N'Thực hành kỹ thuật lập trình', 60, 0.3, 0.7);
GO
INSERT INTO MONHOC
VALUES ('THNMLT',N'Thực hành nhập môn lập trình', 60, 0.3, 0.7);
GO
INSERT INTO MONHOC
VALUES ('CTDLGT',N'Cấu trúc dữ liệu và giải thuật', 45, 0.3, 0.7);
GO
INSERT INTO MONHOC
VALUES ('THCTDLGT',N'Thực hành cấu trúc dữ liệu và giải thuật', 60, 0.3, 0.7);
GO
INSERT INTO MONHOC
VALUES ('AV1',N'Anh văn 1', 45, 0.5, 0.5);
GO
INSERT INTO MONHOC
VALUES ('AV2',N'Anh văn 2', 45, 0.5, 0.5);
GO
INSERT INTO MONHOC
VALUES ('AV3',N'Anh văn 3', 45, 0.5, 0.5);
GO
INSERT INTO MONHOC
VALUES ('DHUD',N'Đồ họa ứng dụng', 45, 0.3, 0.7);
GO

--Điểm
INSERT INTO DIEM
VALUES ('2037190102', 'NMLT', 7, 8);
GO
INSERT INTO DIEM
VALUES ('2037190102', 'THNMLT', 9, 8);
GO
INSERT INTO DIEM
VALUES ('2037190102', 'AV1', 7, 9);
GO
INSERT INTO DIEM
VALUES ('2037190102', 'DHUD', 7.5, 9);
GO
INSERT INTO DIEM
VALUES ('2037190007', 'NMLT', 7, 8);
GO
INSERT INTO DIEM
VALUES ('2037190007', 'KTLT', 8, 8);
GO
INSERT INTO DIEM
VALUES ('2029212771', 'AV1', 9, 9);
GO
INSERT INTO DIEM
VALUES ('2029212771', 'AV2', 10, 9.5);
GO
INSERT INTO DIEM
VALUES ('2029212556', 'AV1', 8.5, 9);
GO
INSERT INTO DIEM
VALUES ('2001202148', 'CTDLGT', 8.5, 8);
GO
INSERT INTO DIEM
VALUES ('2001202148', 'THCTDLGT', 10, 10);
GO
INSERT INTO DIEM
VALUES ('2033210461', 'CTDLGT', 8, 8);
GO
INSERT INTO DIEM
VALUES ('2033210461', 'THCTDLGT', 9, 10);
GO
INSERT INTO DIEM
VALUES ('2033210637', 'CTDLGT', 8, 8.5);
GO
INSERT INTO DIEM
VALUES ('2033210637', 'THCTDLGT', 9.5, 9);
GO
INSERT INTO DIEM
VALUES ('2033210918', 'CTDLGT', 8, 8);
GO
INSERT INTO DIEM
VALUES ('2033210918', 'THCTDLGT', 9.5, 9.5);
GO
INSERT INTO DIEM
VALUES ('2033210438', 'CTDLGT', 3, 4);
GO
INSERT INTO DIEM
VALUES ('2033210438', 'THCTDLGT', 9.5, 9.5);
GO
INSERT INTO DIEM
VALUES ('2033210985', 'CTDLGT', 8, 8);
GO
INSERT INTO DIEM
VALUES ('2033210985', 'THCTDLGT', 9.5, 9.5);
GO

-- Tạo view bangDiem
CREATE VIEW bangDiem
AS
	SELECT SINHVIEN.MSSV, MONHOC.MAMH, MONHOC.TENMH, MONHOC.SOTIET, MONHOC.TYLEQUATRINH, MONHOC.TYLETHANHPHAN, DIEMQUATRINH, DIEMTHANHPHAN
	FROM SINHVIEN, DIEM, MONHOC
	WHERE SINHVIEN.MSSV = DIEM.MSSV AND DIEM.MAMH = MONHOC.MAMH

-- Xem danh sách sinh viên.
SELECT * FROM SINHVIEN
-- Xem số môn học sinh viên đăng ký.
SELECT DISTINCT MONHOC.TENMH
FROM DIEM, MONHOC
WHERE DIEM.MAMH = MONHOC.MAMH
-- Xem điểm môn học của sinh viên.
SELECT SINHVIEN.MSSV, TENSV, MONHOC.TENMH, DIEMQUATRINH, DIEMTHANHPHAN
FROM SINHVIEN, DIEM, MONHOC
WHERE DIEM.MSSV = SINHVIEN.MSSV AND DIEM.MAMH = MONHOC.MAMH
-- Xem kết quả trượt đỗ của sinh viên.
SELECT SINHVIEN.MSSV, TENSV, MONHOC.TENMH, DIEMQUATRINH, DIEMTHANHPHAN, DIEMQUATRINH * TYLEQUATRINH + DIEMTHANHPHAN * TYLETHANHPHAN AS N'DIEM TB', N'Đỗ' AS 'KET QUA'
FROM SINHVIEN, DIEM, MONHOC
WHERE DIEM.MSSV = SINHVIEN.MSSV AND DIEM.MAMH = MONHOC.MAMH AND DIEMQUATRINH * TYLEQUATRINH + DIEMTHANHPHAN * TYLETHANHPHAN >= 4
UNION
SELECT SINHVIEN.MSSV, TENSV, MONHOC.TENMH, DIEMQUATRINH, DIEMTHANHPHAN, DIEMQUATRINH * TYLEQUATRINH + DIEMTHANHPHAN * TYLETHANHPHAN AS N'DIEM TB', N'Rớt' AS 'KET QUA'
FROM SINHVIEN, DIEM, MONHOC
WHERE DIEM.MSSV = SINHVIEN.MSSV AND DIEM.MAMH = MONHOC.MAMH AND DIEMQUATRINH * TYLEQUATRINH + DIEMTHANHPHAN * TYLETHANHPHAN < 4



-- Nhập điểm cho sinh viên.
--UPDATE DIEM
--SET DIEMQUATRINH = 9
--WHERE MSSV = '2033210438' AND MAMH = 'CTDLGT'




--UPDATE bangDiem
--SET DIEMQUATRINH = 10
--WHERE MSSV = '2033210637' AND MAMH = 'CTDLGT'


--UPDATE DIEM
--SET DIEMQUATRINH = 9, DIEMTHANHPHAN = 8.5
--WHERE MSSV = '2033210637' AND MAMH = 'CTDLGT'