--tao database
CREATE DATABASE QLATM
GO
--xoa database
drop database QLATM

USE QLATM
--TAO CAC BANG
CREATE TABLE MAYATM(MaMay varchar(10)PRIMARY KEY,DiaChi nvarchar(50),SoDuMay int, MaThe varchar(10))
GO
CREATE TABLE THEATM(MaThe varchar(10) PRIMARY KEY,NgayDK date,TenTK nvarchar(30),MaKH varchar(10))
GO
CREATE TABLE CHUCVU(MaCV varchar(10) PRIMARY KEY,TenCV nvarchar(30))
GO

CREATE TABLE NHANVIEN(MaNV varchar(10) PRIMARY KEY,HoTenNV nvarchar(30),DiaChi nvarchar(50),SDT int, MaCV varchar(10),MaMay varchar(10),MaThe varchar(10))
GO
CREATE TABLE KHACHHANG(MaKH varchar(10) PRIMARY KEY, HoTenKH nvarchar(30),DiaChi nvarchar(50),SDT int,CMND int)
GO
--drop cac bang
DROP TABLE MAYATM
DROP TABLE THEATM
DROP TABLE CHUCVU
DROP TABLE NHANVIEN
DROP TABLE KHACHHANG
--TAO CAC RANG BUOC
--RANG BUOC KHOA NGOAI GIUA CHUC VU VA NHAN VIEN
ALTER TABLE NHANVIEN ADD CONSTRAINT fk_NV_CV FOREIGN KEY (MaCV) REFERENCES CHUCVU(MaCV)
ALTER TABLE NHANVIEN ADD CONSTRAINT fk_NV_THEATM FOREIGN KEY (MaThe) REFERENCES THEATM(MaThe)
ALTER TABLE THEATM ADD CONSTRAINT fk_KH_THEATM FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
ALTER TABLE MAYATM ADD CONSTRAINT fk_MAY_THEATM FOREIGN KEY (MaThe) REFERENCES THEATM(MaThe)
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
--*********THEM*********
-- mayatm 
CREATE PROC sp_themMAYATM(@MaMay varchar(10),@DiaChi nvarchar(50),@SoDuMay int, @MaThe varchar(10))
AS INSERT INTO MAYATM(MaMay,DiaChi,SoDuMay,MaThe)
VALUES (@MaMay,@DiaChi,@SoDuMay,@MaThe)
GO
--the atm
CREATE PROC sp_themTHEATM(@MaThe varchar(10),@NgayDK datetime,@TenTK nvarchar(30),@MaKH varchar(10))
AS INSERT INTO THEATM(MaThe,NgayDK,TenTK,MaKH)
VALUES (@MaThe,@NgayDK,@TenTK,@MaKH)
GO
--chuc vu
CREATE PROC sp_themCHUCVU(@MaCV varchar(10) ,@TenCV nvarchar(30))
AS INSERT INTO CHUCVU(MaCV,TenCV)
VALUES (@MaCV,@TenCV)
GO
--nhanvien
CREATE PROC sp_themNHANVIEN(@MaNV varchar(10),@HoTenNV nvarchar(30),@DiaChi nvarchar(50),@SDT int, @MaCV varchar(10),@MaMay varchar(10),@MaThe varchar(10))
AS INSERT INTO NHANVIEN(MaNV,HoTenNV,DiaChi,SDT,MaCV,MaMay,MaThe)
VALUES (@MaNV,@HoTenNV,@DiaChi,@SDT,@MaCV,@MaMay,@MaThe)
GO
--khachhang
CREATE PROC sp_themKHACHHANG(@MaKH varchar(10) , @HoTenKH nvarchar(30),@DiaChi nvarchar(50),@SDT int,@CMND int)
AS INSERT INTO KHACHHANG(MaKH,HoTenKH,DiaChi,SDT,CMND)
VALUES (@MaKH,@HoTenKH,@DiaChi,@SDT,@CMND)
GO

--Thuc thi cac sp
exec sp_themKHACHHANG 'KH1','NguyenT','QUangNam',01201203,221463790 
exec sp_themTHEATM 'T1','12/3/2000','TK1','KH1'
exec sp_themMAYATM 'M1','HCM',2343454,'T1'
exec sp_themCHUCVU 'CV1','QLMAY'
exec sp_themNHANVIEN 'NV1','NguyenB','ETRPhuYen',09876598,'CV1','M1','T1'

exec sp_themKHACHHANG 'KH2','NguyenT','QUangNam',01201203,221463790
exec sp_themTHEATM 'T2','12/3/2000','TK1','KH2'
exec sp_themMAYATM 'M2','HCM',2343454,'T2'
exec sp_themCHUCVU 'CV2','QLMAY'
exec sp_themNHANVIEN 'NV2','NguyenB','ETRPhuYen',09876598,'CV2','M2','T2'

--********XOA********
--xoa mayatm
CREATE PROC sp_xoaMAYATM(@MaMay varchar(10))
AS DELETE FROM MAYATM
WHERE MaMay = @MaMay
GO
--xoa the atm
CREATE PROC sp_xoaTHEATM(@MaThe varchar(10))
AS DELETE FROM THEATM
WHERE MaThe = @MaThe
GO
--xoa chuc vu
CREATE PROC sp_xoaCHUCVU (@MaCV varchar(10))
AS DELETE FROM CHUCVU 
WHERE MaCV = @MaCV
GO
--xoa nhan vien
GO
CREATE PROC sp_xoaNHANVIEN (@MaNV varchar(10))
AS DELETE FROM NHANVIEN
WHERE MaNV = @MaNV
GO
--xoa khach hang
CREATE PROC sp_xoaKHACHHANG (@MaKH varchar(10))
AS DELETE FROM KHACHHANG
WHERE MaKH = @MaKH
GO
--DROP PROC XOA
drop proc sp_xoaCHUCVU
drop proc sp_xoaNHANVIEN
drop proc sp_xoaMAYATM
drop proc sp_xoaTHEATM
drop proc sp_xoaKHACHHANG

-- thuc thi xoa
exec sp_xoaNHANVIEN 'NV1'
exec sp_xoaCHUCVU 'CV1'
exec sp_xoaMAYATM 'M1'
exec sp_xoaTHEATM 'T1'
exec sp_xoaKHACHHANG 'KH1'
--sua sp
--cap nhat may atm
CREATE PROC sp_capnhatMAYATM(@MaMay varchar(10),@DiaChi nvarchar(50),@SoDuMay int, @MaThe varchar(10))
AS UPDATE MAYATM 
SET DiaChi=@DiaChi,SoDuMay=@SoDuMay,MaThe=@MaThe
WHERE MaMay = @MaMay
GO
--cap nhat the atm
CREATE PROC sp_capnhatTHEATM(@MaThe varchar(10),@NgayDK date,@TenTK nvarchar(30),@MaKH varchar(10))
AS UPDATE THEATM
SET NgayDK=@NgayDK, TenTK=@TenTK, MaKH=@MaKH
WHERE MaThe = @MaThe
GO
--cap nhat Chuc vu
CREATE PROC sp_capnhatCHUCVU(@MaCV varchar(10) ,@TenCV nvarchar(30))
AS UPDATE CHUCVU
SET MaCV=@MaCV,TenCV=@TenCV
WHERE MaCV = @MaCV
GO
--cap nhat nhan vien
GO
CREATE PROC sp_capnhatNHANVIEN(@MaNV varchar(10),@HoTenNV nvarchar(30),@DiaChi nvarchar(50),@SDT int, @MaCV varchar(10),@MaMay varchar(10),@MaThe varchar(10))
AS UPDATE NHANVIEN
SET HoTenNV=@HoTenNV,DiaChi=@DiaChi,SDT=@SDT,MaCV=@MaCV,MaMay=@MaMay
WHERE MaNV = @MaNV
GO
--cap nhat khach hang
CREATE PROC sp_capnhatKHACHHANG(@MaKH varchar(10) , @HoTenKH nvarchar(30),@DiaChi nvarchar(50),@SDT int,@CMND int)
AS UPDATE KHACHHANG
SET HoTenKH=@HoTenKH,DiaChi=@DiaChi,SDT=@SDT,CMND=@CMND
WHERE MaKH = @MaKH


--Thuc thi cap nhat
exec sp_capnhatKHACHHANG 'KH1','NguyenT','QUangNam',01201203,221463790
exec sp_capnhatCHUCVU 'CV1','QLMAY'
exec  sp_capnhatMAYATM 'M1','HCM',2343454,'T1'
exec sp_capnhatTHEATM 'T1','12/3/2000','TK1','KH1'
exec sp_capnhatNHANVIEN 'NV1','NguyenD','ETRPhuYen',09876598,'CV1','M1','T1'


--ham lay ra
--lay ds may atm
CREATE PROC sp_LayDSMAYATM
AS SELECT * FROM MAYATM
GO
--lay ds the atm
CREATE PROC sp_LayDSTHEATM
AS SELECT * FROM THEATM
GO
--lay ds chuc vu
CREATE PROC sp_LayDSCHUCVU
AS SELECT * FROM CHUCVU
GO
--lay ds nhanvien
CREATE PROC sp_LayDSNHANVIEN
AS SELECT * FROM NHANVIEN
GO
--lay ds khach hang
CREATE PROC sp_LayDSKHACHHANG
AS SELECT * FROM KHACHHANG
GO
--THUC THI LAYDS
exec sp_LayDSNHANVIEN
exec sp_LayDSCHUCVU
exec sp_LayDSKHACHHANG
exec sp_LayDSMAYATM
exec sp_LayDSTHEATM