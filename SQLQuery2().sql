--tao database
CREATE DATABASE QLATM
GO
--xoa database
drop database QLATM

USE QLATM
--TAO CAC BANG
CREATE TABLE MAYATM(MaMay varchar(10)PRIMARY KEY,DiaChi nvarchar(50),SoDuMay int)
GO
CREATE TABLE THEATM(MaThe varchar(10) PRIMARY KEY,HoTenKH nvarchar(30),NgayDK date,MaKH varchar(10))
GO
CREATE TABLE CHUCVU(MaCV varchar(10) PRIMARY KEY,TenCV nvarchar(30))
GO
CREATE TABLE NHANVIEN(MaNV varchar(10) PRIMARY KEY,HoTenNV nvarchar(30),DiaChi nvarchar(50),SDT int, MaCV varchar(10),MaMay varchar(10),MaThe varchar(10))
GO
CREATE TABLE KHACHHANG(MaKH varchar(10) PRIMARY KEY, HoTenKH nvarchar(30),DiaChi nvarchar(50),SDT int,CMND int,MaThe varchar(10))
GO


CREATE TABLE ADMIN 
(
	TAIKHOAN VARCHAR(20),MATKHAU VARCHAR(20),PRIMARY KEY(TAIKHOAN)
)

CREATE PROC sp_LayDSAD
AS
SELECT * FROM ADMIN
GO

CREATE PROC sp_ThemAD
(
	@TAIKHOAN VARCHAR(20),@MATKHAU VARCHAR(20)
)
AS
INSERT INTO ADMIN
(
	TAIKHOAN,MATKHAU  
)
VALUES (@TAIKHOAN,@MATKHAU)
GO

CREATE PROC sp_DangNhap
(
	@TAIKHOAN VARCHAR(20),@MATKHAU VARCHAR(20)
)
AS
SELECT * FROM ADMIN
WHERE TAIKHOAN = @TAIKHOAN AND MATKHAU = @MATKHAU

--drop cac bang
DROP TABLE MAYATM
DROP TABLE THEATM
DROP TABLE CHUCVU
DROP TABLE NHANVIEN
DROP TABLE KHACHHANG
--TAO CAC RANG BUOC

--RANG BUOC KHOA NGOAI GIUA CHUC VU VA NHAN VIEN
--nv vs cv
ALTER TABLE NHANVIEN  ADD CONSTRAINT fk_NV_CV FOREIGN KEY (MaCV) REFERENCES CHUCVU(MaCV)--hop ly

--nv vs the
ALTER TABLE NHANVIEN ADD CONSTRAINT fk_NV_THEATM FOREIGN KEY (MaThe) REFERENCES THEATM(MaThe)
--the vs kh
ALTER TABLE KHACHHANG ADD CONSTRAINT fk_THEATM_KH FOREIGN KEY (MaThe) REFERENCES THEATM(MaThe)
-- may vs the
--ALTER TABLE MAYATM ADD CONSTRAINT fk_MAY_THEATM FOREIGN KEY (MaThe) REFERENCES THEATM(MaThe)
--ALTER TABLE NHANVIEN ADD CONSTRAINT fk_NV_MAYATM FOREIGN KEY (MaMay) REFERENCES MAYATM(MaMay)
--nv vs may
ALTER TABLE NHANVIEN ADD CONSTRAINT fk_NV_MAYATM FOREIGN KEY (MaMay) REFERENCES MAYATM(MaMay)


--XOA RANG BUOC
ALTER TABLE NHANVIEN DROP CONSTRAINT fk_NV_CV
GO 
ALTER TABLE THEATM DROP CONSTRAINT fk_KH_THEATM
GO 
ALTER TABLE MAYATM DROP CONSTRAINT fk_MAY_THEATM
GO 
ALTER TABLE MAYATM DROP CONSTRAINT fk_NV_THEATM
GO 
ALTER TABLE MAYATM DROP CONSTRAINT fk_NV_MAYATM

--tao cac store procedure
--*********MAY ATM*********************************************************
-- mayatm 
CREATE PROC sp_themMAYATM(@MaMay varchar(10),@DiaChi nvarchar(50),@SoDuMay int)
AS INSERT INTO MAYATM(MaMay,DiaChi,SoDuMay)
VALUES (@MaMay,@DiaChi,@SoDuMay)
GO
--xoa mayatm
CREATE PROC sp_xoaMAYATM(@MaMay varchar(10))
AS DELETE FROM MAYATM
WHERE MaMay = @MaMay
GO
--cap nhat may atm
CREATE PROC sp_suaMAYATM(@MaMay varchar(10),@DiaChi nvarchar(50),@SoDuMay int)
AS UPDATE MAYATM 
SET DiaChi=@DiaChi,SoDuMay=@SoDuMay
WHERE MaMay = @MaMay
--lay ds may atm
CREATE PROC sp_LayDSMAYATM
AS SELECT * FROM MAYATM
GO
--tim kiem
create proc sp_timMayATM(@MaMay char(10))
as select * from MAYATM
where MaMay = @MaMay
go



--**************the atm*********************************************************
--them the atm
CREATE PROC sp_themTHEATM(@MaThe varchar(10),@HoTenKH nvarchar(30),@NgayDK date,@MaKH varchar(10))
AS INSERT INTO THEATM(MaThe,HoTenKH,NgayDK,MaKH)
VALUES (@MaThe,@HoTenKH,@NgayDK,@MaKH)
GO
--xoa the atm
CREATE PROC sp_xoaTHEATM(@MaThe varchar(10))
AS DELETE FROM THEATM
WHERE MaThe = @MaThe
GO
--sua the atm
CREATE PROC sp_suaTHEATM(@MaThe varchar(10),@HoTenKH nvarchar(30),@NgayDK date,@MaKH varchar(10))
AS UPDATE THEATM
SET HoTenKH = @HoTenKH,NgayDK=@NgayDK, MaKH=@MaKH
WHERE MaThe = @MaThe
GO
create proc sp_timTheATM(@MaThe char(10))
as select * from THEATM
where MaThe = @MaThe
go
--LAY DS
CREATE PROC sp_LayDSTHEATM
AS SELECT * FROM THEATM
GO

--*********CHUC VU*********************************************************
--THEM chuc vu
CREATE PROC sp_themCHUCVU(@MaCV varchar(10) ,@TenCV nvarchar(30))
AS INSERT INTO CHUCVU(MaCV,TenCV)
VALUES (@MaCV,@TenCV)
GO
--xoa chuc vu
CREATE PROC sp_xoaCHUCVU (@MaCV varchar(10))
AS DELETE FROM CHUCVU 
WHERE MaCV = @MaCV
GO
--cap nhat Chuc vu
CREATE PROC sp_suaCHUCVU(@MaCV varchar(10) ,@TenCV nvarchar(30))
AS UPDATE CHUCVU
SET MaCV=@MaCV,TenCV=@TenCV
WHERE MaCV = @MaCV
GO
--tim kiem sai roi!!!
create proc sp_timChucVu(@MaCV char(10))
as select * from CHUCVU
WHERE MaCV = @MaCV
go
--lay ds chuc vu
CREATE PROC sp_LayDSCHUCVU
AS SELECT * FROM CHUCVU
GO

---*****************NHAN VIEN*********************************************************
--THEM nhanvien
CREATE PROC sp_themNHANVIEN(@MaNV varchar(10),@HoTenNV nvarchar(30),@DiaChi nvarchar(50),@SDT int, @MaCV varchar(10),@MaMay varchar(10),@MaThe varchar(10))
AS INSERT INTO NHANVIEN(MaNV,HoTenNV,DiaChi,SDT,MaCV,MaMay,MaThe)
VALUES (@MaNV,@HoTenNV,@DiaChi,@SDT,@MaCV,@MaMay,@MaThe)
GO
--xoa nhan vien
GO
CREATE PROC sp_xoaNHANVIEN (@MaNV varchar(10))
AS DELETE FROM NHANVIEN
WHERE MaNV = @MaNV
GO
--cap nhat nhan vien
CREATE PROC sp_suaNHANVIEN(@MaNV varchar(10),@HoTenNV nvarchar(30),@DiaChi nvarchar(50),@SDT int, @MaCV varchar(10),@MaMay varchar(10),@MaThe varchar(10))
AS UPDATE NHANVIEN
SET HoTenNV=@HoTenNV,DiaChi=@DiaChi,SDT=@SDT,MaCV=@MaCV,MaMay=@MaMay, MaThe = @MaThe
WHERE MaNV = @MaNV
GO
--tim nv
create proc sp_timNhanVien(@MaNV char(10))
as select * from NHANVIEN
where MaNV = @MaNV
go
--lay ds nhanvien
CREATE PROC sp_LayDSNHANVIEN
AS SELECT * FROM NHANVIEN
GO


----***********KHACH HANG*********************************************************
--themkhachhang
CREATE PROC sp_themKHACHHANG(@MaKH varchar(10) , @HoTenKH nvarchar(30),@DiaChi nvarchar(50),@SDT int,@CMND int,@MaThe varchar(10))
AS INSERT INTO KHACHHANG(MaKH,HoTenKH,DiaChi,SDT,CMND,MaThe)
VALUES (@MaKH,@HoTenKH,@DiaChi,@SDT,@CMND,@MaThe)
GO
--xoa khach hang
CREATE PROC sp_xoaKHACHHANG (@MaKH varchar(10))
AS DELETE FROM KHACHHANG
WHERE MaKH = @MaKH
GO
--cap nhat khach hang
CREATE PROC sp_capnhatKHACHHANG(@MaKH varchar(10) , @HoTenKH nvarchar(30),@DiaChi nvarchar(50),@SDT int,@CMND int,@MaThe varchar)
AS UPDATE KHACHHANG
SET HoTenKH=@HoTenKH,DiaChi=@DiaChi,SDT=@SDT,CMND=@CMND,MaThe =@MaThe
WHERE MaKH = @MaKH
--tim kh
create proc sp_timNhanVien(@MaKH char(10))
as select * from KHACHHANG
where MaKH = @MaKH
go
--lay ds khach hang
CREATE PROC sp_LayDSKHACHHANG
AS SELECT * FROM KHACHHANG
GO


--Thuc thi cac THEM  
exec sp_ThemAD 'admin','123456'
exec sp_themTHEATM '172111542','Phan Van Tung','12/3/2000','KH1'
exec sp_themTHEATM 'THe1','Phan Van Tung','12/3/2000','KH1'
exec sp_themKHACHHANG 'KH1','Phan Van Tung','Thu Duc-TPHCM',0964169032,123123123,'172111542'
exec sp_themMAYATM 'M1','HCM',2343454
exec sp_themCHUCVU 'CV1','QLMAY'
exec sp_themNHANVIEN 'NV1','Nguyen Chi Tan','Quan Thu Duc',09876598,'CV1','M1','172111542'


exec sp_ThemAD 'admin1','123456'
exec sp_themTHEATM '172111545','Ngo Huu The','12/3/2000','KH2'
exec sp_themKHACHHANG 'KH3','Ngo Huu The','Thu Duc-TPHCM',093623123,019019910,'THe1'
exec sp_themMAYATM 'M2','DaNang',2343454
exec sp_themCHUCVU 'CV2','Sua Chua'
exec sp_themNHANVIEN 'NV2','Tran Dang Khoa','Quan 9',0932138,'CV2','M2','12351312'

-- thuc thi xoa
exec sp_xoaNHANVIEN 'NV1'
exec sp_xoaCHUCVU 'CV1'
exec sp_xoaMAYATM 'M1'
exec sp_xoaTHEATM 'T1'
exec sp_xoaKHACHHANG 'KH1'
--Thuc thi cap nhat
exec sp_capnhatKHACHHANG 'KH1','Phan Van Tung','Bac Giang',01201203,221463790
exec sp_capnhatCHUCVU 'CV1','QLMAY'
exec  sp_capnhatMAYATM 'M1','HCM',2343454
exec sp_capnhatTHEATM 'T1','12/3/2000','TK1','KH1'
exec sp_capnhatNHANVIEN 'NV1','Ngo Huu The','Phu Yen',09876598,'CV1','M1','T1'
exec sp_capnhatNHANVIEN 'NV2','Tran Dang Khoa','Quan 9',0932138,'CV2','M2','12351312'


--THUC THI LAYDS
exec sp_LayDSNHANVIEN
exec sp_LayDSCHUCVU
exec sp_LayDSKHACHHANG
exec sp_LayDSMAYATM
exec sp_LayDSTHEATM