-- ******************************************************
-- Fabrika Analizleri Projesi - Kurulum
-- veritaban�n� olu�turur, t�m tablolar� kurar,
-- �rnek verileri ekler ve analiz sorgular�n� �al��t�r�r.
-- ******************************************************

-- 1. VER�TABANI OLU�TURMA VE KULLANMA
CREATE DATABASE Fabrika_Analizleri;
GO

USE Fabrika_Analizleri;
GO

PRINT 'Fabrika_Analizleri veritaban� ba�ar�yla olu�turuldu ve se�ildi.';
GO

-- 2. TABLOLARI OLU�TURMA
-- 2.1. �retim s�re�leriyle ilgili tablolar
CREATE TABLE Uretim (
    UretimID INT PRIMARY KEY IDENTITY(1,1),
    UrunAdi NVARCHAR(50) NOT NULL,
    UretimTarihi DATE NOT NULL,
    UretilenAdet INT NOT NULL,
    Vardiya NVARCHAR(10) CHECK (Vardiya IN ('Sabah', 'Aksam', 'Gece'))
);

CREATE TABLE KaliteKontrol (
    KaliteKontrolID INT PRIMARY KEY IDENTITY(1,1),
    UretimID INT FOREIGN KEY REFERENCES Uretim(UretimID),
    HataTipi NVARCHAR(50),
    HataAdedi INT NOT NULL,
    KontrolTarihi DATE
);

-- 2.2. Bak�m ve Ar�za y�netimiyle ilgili tablolar
CREATE TABLE Bakim (
    BakimID INT PRIMARY KEY IDENTITY(1,1),
    MakineAdi NVARCHAR(50) NOT NULL,
    BakimTarihi DATE NOT NULL,
    BakimTipi NVARCHAR(50),
    Maliyet DECIMAL(18, 2)
);

CREATE TABLE Ariza (
    ArizaID INT PRIMARY KEY IDENTITY(1,1),
    MakineAdi NVARCHAR(50) NOT NULL,
    ArizaBaslangic DATETIME NOT NULL,
    ArizaBitis DATETIME,
    ArizaNedeni NVARCHAR(100),
    UretimKaybi INT
);

-- 2.3. Personel y�netimiyle ilgili tablo
CREATE TABLE Personel (
    PersonelID INT PRIMARY KEY IDENTITY(1,1),
    AdSoyad NVARCHAR(100) NOT NULL,
    Pozisyon NVARCHAR(50),
    Vardiya NVARCHAR(10),
    PerformansPuani INT
);

-- 2.4. Stok ve Hammadde y�netimiyle ilgili tablolar
CREATE TABLE Hammadde (
    HammaddeID INT PRIMARY KEY IDENTITY(1,1),
    HammaddeAdi NVARCHAR(50) NOT NULL,
    StokMiktari INT NOT NULL,
    Birim NVARCHAR(10)
);

CREATE TABLE UrunHammadde (
    UrunHammaddeID INT PRIMARY KEY IDENTITY(1,1),
    UrunAdi NVARCHAR(50) NOT NULL,
    HammaddeID INT FOREIGN KEY REFERENCES Hammadde(HammaddeID),
    GerekenMiktar INT NOT NULL
);

PRINT 'T�m tablolar ba�ar�yla olu�turuldu.';
GO

-- 3. �RNEK VER�LER� EKLEME
INSERT INTO Uretim (UrunAdi, UretimTarihi, UretilenAdet, Vardiya)
VALUES
('Telefon K�l�f�', '2025-07-28', 1500, 'Sabah'),
('Telefon K�l�f�', '2025-07-28', 1200, 'Aksam'),
('Telefon K�l�f�', '2025-07-29', 1600, 'Sabah'),
('Ekran Koruyucu', '2025-07-28', 800, 'Sabah'),
('Ekran Koruyucu', '2025-07-29', 950, 'Aksam'),
('Telefon K�l�f�', '2025-07-30', 1450, 'Sabah'),
('Ekran Koruyucu', '2025-07-30', 900, 'Aksam'),
('Telefon K�l�f�', '2025-07-31', 1700, 'Sabah'),
('Telefon K�l�f�', '2025-07-31', 1300, 'Aksam');

INSERT INTO KaliteKontrol (UretimID, HataTipi, HataAdedi, KontrolTarihi)
VALUES
(1, 'Boya Hatas�', 30, '2025-07-28'),
(2, '�atlak', 25, '2025-07-28'),
(3, 'Boya Hatas�', 15, '2025-07-29'),
(4, 'Montaj Hatas�', 10, '2025-07-28'),
(5, '�atlak', 8, '2025-07-29'),
(6, '�atlak', 20, '2025-07-30'),
(7, 'Montaj Hatas�', 12, '2025-07-30'),
(8, 'Boya Hatas�', 25, '2025-07-31'),
(9, '�atlak', 18, '2025-07-31');

INSERT INTO Bakim (MakineAdi, BakimTarihi, BakimTipi, Maliyet)
VALUES
('Enjeksiyon Makinesi 1', '2025-07-20', 'Planl�', 500.00),
('Lazer Kesim Makinesi', '2025-07-25', 'Plans�z', 850.50),
('Enjeksiyon Makinesi 1', '2025-07-29', 'Plans�z', 1200.00),
('Lazer Kesim Makinesi', '2025-07-30', 'Planl�', 400.00),
('Enjeksiyon Makinesi 2', '2025-07-27', 'Plans�z', 950.00);

INSERT INTO Ariza (MakineAdi, ArizaBaslangic, ArizaBitis, ArizaNedeni, UretimKaybi)
VALUES
('Enjeksiyon Makinesi 1', '2025-07-29 10:00:00', '2025-07-29 11:30:00', 'Mekanik Ar�za', 150),
('Lazer Kesim Makinesi', '2025-07-28 15:00:00', '2025-07-28 15:15:00', 'Elektrik Kesintisi', 20),
('Enjeksiyon Makinesi 2', '2025-07-30 08:00:00', '2025-07-30 09:00:00', 'Sens�r Hatas�', 80);

INSERT INTO Personel (AdSoyad, Pozisyon, Vardiya, PerformansPuani)
VALUES
('Ali Y�lmaz', 'Operat�r', 'Sabah', 85),
('Ay�e Kaya', 'Operat�r', 'Aksam', 92),
('Mehmet Demir', 'M�hendis', 'Sabah', 95),
('Fatma �elik', 'Operat�r', 'Gece', 78),
('Deniz Ak�n', 'Operat�r', 'Sabah', 88),
('Can Erol', 'Operat�r', 'Aksam', 90);

INSERT INTO Hammadde (HammaddeAdi, StokMiktari, Birim)
VALUES
('Plastik Gran�l', 1000, 'Kg'),
('S�v� Silikon', 500, 'Litre'),
('Ambalaj Kutusu', 2000, 'Adet');

INSERT INTO UrunHammadde (UrunAdi, HammaddeID, GerekenMiktar)
VALUES
('Telefon K�l�f�', 1, 1),
('Telefon K�l�f�', 3, 1),
('Ekran Koruyucu', 2, 0.5),
('Ekran Koruyucu', 3, 1);

PRINT '�rnek veriler ba�ar�yla eklendi.';
GO

-- 4. ANAL�Z SORGULARI
PRINT 'Analiz sorgular�n�n sonu�lar�:';
GO

-- 4.1. G�nl�k Toplam �retim ve Hata Oranlar�
SELECT
    U.UretimTarihi,
    U.Vardiya,
    SUM(U.UretilenAdet) AS ToplamUretim,
    SUM(ISNULL(KK.HataAdedi, 0)) AS ToplamHata,
    CAST(SUM(ISNULL(KK.HataAdedi, 0)) AS FLOAT) / SUM(U.UretilenAdet) * 100 AS HataOrani
FROM Uretim U
LEFT JOIN KaliteKontrol KK ON U.UretimID = KK.UretimID
GROUP BY U.UretimTarihi, U.Vardiya
ORDER BY U.UretimTarihi, U.Vardiya;
GO

-- 4.2. En �ok Hata Veren �r�n ve Hata Tipi Analizi
SELECT
    U.UrunAdi,
    KK.HataTipi,
    SUM(KK.HataAdedi) AS ToplamHataAdedi
FROM Uretim U
JOIN KaliteKontrol KK ON U.UretimID = KK.UretimID
GROUP BY U.UrunAdi, KK.HataTipi
ORDER BY ToplamHataAdedi DESC;
GO

-- 4.3. Makine Bazl� Bak�m Maliyeti Analizi
SELECT
    MakineAdi,
    COUNT(*) AS BakimSayisi,
    SUM(Maliyet) AS ToplamMaliyet,
    AVG(Maliyet) AS OrtalamaMaliyet
FROM Bakim
GROUP BY MakineAdi
ORDER BY ToplamMaliyet DESC;
GO

-- 4.4. Makine Ar�zalar�n�n �retime Etkisi
SELECT
    MakineAdi,
    COUNT(*) AS ToplamArizaSayisi,
    SUM(DATEDIFF(MINUTE, ArizaBaslangic, ArizaBitis)) AS ToplamArizaSuresi_Dakika,
    SUM(UretimKaybi) AS ToplamUretimKaybi
FROM Ariza
GROUP BY MakineAdi
ORDER BY ToplamUretimKaybi DESC;
GO

-- 4.5. Vardiya ve Personel Performans �li�kisi
SELECT
    P.Vardiya,
    AVG(CAST(P.PerformansPuani AS FLOAT)) AS OrtalamaPerformans,
    SUM(U.UretilenAdet) AS VardiyaToplamUretim,
    SUM(ISNULL(KK.HataAdedi, 0)) AS VardiyaToplamHata
FROM Personel P
JOIN Uretim U ON P.Vardiya = U.Vardiya
LEFT JOIN KaliteKontrol KK ON U.UretimID = KK.UretimID
GROUP BY P.Vardiya
ORDER BY OrtalamaPerformans DESC;
GO

-- 4.6. Stok Durumu ve Hammadde T�ketimi
SELECT
    H.HammaddeAdi,
    H.StokMiktari,
    SUM(ISNULL(UH.GerekenMiktar * U.UretilenAdet, 0)) AS ToplamKullanilanMiktar,
    H.StokMiktari - SUM(ISNULL(UH.GerekenMiktar * U.UretilenAdet, 0)) AS KalanMiktar
FROM Hammadde H
LEFT JOIN UrunHammadde UH ON H.HammaddeID = UH.HammaddeID
LEFT JOIN Uretim U ON UH.UrunAdi = U.UrunAdi
GROUP BY H.HammaddeAdi, H.StokMiktari;
GO