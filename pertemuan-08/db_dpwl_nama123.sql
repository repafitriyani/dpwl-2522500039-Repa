-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 05, 2026 at 08:06 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_dpwl_nama123`
--

-- --------------------------------------------------------

--
-- Table structure for table `t_admin`
--

CREATE TABLE `t_admin` (
  `username` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` char(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status_akun` enum('aktif','nonaktif') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'nonaktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `t_admin`
--

INSERT INTO `t_admin` (`username`, `password`, `status_akun`) VALUES
('admin', '$2y$10$KAeM1j.05vb6eHernfo0T.vVPtnN6SWCrqHuwidS80t5VDcIDFaXK', 'aktif'),
('repa', '$2y$12$Wv13yj3OgJ2DSNATE.wZneJu7VslfLytq9BBUFLxivP1ReM.hhiHC', 'aktif');

-- --------------------------------------------------------

--
-- Table structure for table `t_bayar`
--

CREATE TABLE `t_bayar` (
  `kode_bayar` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tgl_wkt_byr` datetime NOT NULL,
  `ft_byr` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `mtode_byr` enum('tunai','transfer') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `jns_byr` enum('dp','pelunasan') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `nominal` mediumint NOT NULL,
  `sttus_byr` enum('pending','valid','invalid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tgl_wkt_ver` datetime DEFAULT NULL,
  `kode_sewa` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `t_bayar`
--

INSERT INTO `t_bayar` (`kode_bayar`, `tgl_wkt_byr`, `ft_byr`, `mtode_byr`, `jns_byr`, `nominal`, `sttus_byr`, `tgl_wkt_ver`, `kode_sewa`) VALUES
('PAY/20260702/01', '2026-07-02 13:56:47', NULL, 'tunai', 'dp', 270000, 'valid', '2026-07-02 13:56:47', 'INV/20260702/01'),
('PAY/20260702/02', '2026-07-02 20:49:08', NULL, 'tunai', 'dp', 560000, 'valid', '2026-07-02 20:49:08', 'INV/20260702/02'),
('PAY/20260702/03', '2026-07-02 21:29:08', NULL, 'tunai', 'pelunasan', 840000, 'valid', '2026-07-02 21:29:08', 'INV/20260702/02'),
('PAY/20260703/01', '2026-07-03 15:23:58', NULL, 'tunai', 'pelunasan', 630000, 'valid', '2026-07-03 15:23:58', 'INV/20260702/01'),
('PAY/20260704/01', '2026-07-04 09:38:33', 'ft_byr_1783132725_6a487235b75a0.jpeg', 'transfer', 'dp', 250000, 'valid', '2026-07-04 09:40:39', 'INV/20260704/01'),
('PAY/20260704/02', '2026-07-04 09:46:48', NULL, 'tunai', 'pelunasan', 110000, 'valid', '2026-07-04 09:46:48', 'INV/20260704/01'),
('PAY/20260704/03', '2026-07-04 14:20:54', 'ft_byr_1783150294_6a48b6d69576d.jpeg', 'transfer', 'dp', 150000, 'pending', NULL, 'INV/20260704/02'),
('PAY/20260705/01', '2026-07-05 00:10:21', 'ft_byr_1783185669_6a494105c0eee.jpeg', 'transfer', 'dp', 150000, 'pending', NULL, 'INV/20260705/01'),
('PAY/20260705/02', '2026-07-05 00:57:55', 'ft_byr_1783187883_6a4949abd1077.jpeg', 'transfer', 'dp', 150000, 'valid', '2026-07-05 01:03:04', 'INV/20260705/02'),
('PAY/20260706/01', '2026-07-06 14:09:35', NULL, 'tunai', 'pelunasan', 500000, 'valid', '2026-07-06 14:09:35', 'INV/20260703/01'),
('PAY/20261104/01', '2026-11-04 14:17:47', NULL, 'transfer', 'dp', 105000, 'pending', NULL, 'INV/20261104/01');

-- --------------------------------------------------------

--
-- Table structure for table `t_denda`
--

CREATE TABLE `t_denda` (
  `kode_denda` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `telat_jam` tinyint(1) NOT NULL,
  `tarif_per_jam` mediumint NOT NULL,
  `kode_kembali` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `t_denda`
--

INSERT INTO `t_denda` (`kode_denda`, `telat_jam`, `tarif_per_jam`, `kode_kembali`) VALUES
('FINE/20260703/1', 1, 50000, 'RET/20260703/01'),
('FINE/20260703/2', 3, 50000, 'RET/20260703/02'),
('FINE/20260703/3', 2, 25000, 'RET/20260702/01'),
('FINE/20260704/1', 3, 0, 'RET/20260704/01');

-- --------------------------------------------------------

--
-- Table structure for table `t_kembali`
--

CREATE TABLE `t_kembali` (
  `kode_kembali` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tgl_wkt_blk` datetime NOT NULL,
  `stts_blk` enum('normal','terlambat') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'normal',
  `ket_blk` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `kode_bayar` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `t_kembali`
--

INSERT INTO `t_kembali` (`kode_kembali`, `tgl_wkt_blk`, `stts_blk`, `ket_blk`, `kode_bayar`) VALUES
('RET/20260702/01', '2026-07-02 21:30:00', 'terlambat', 'rese', 'PAY/20260702/03'),
('RET/20260703/01', '2026-07-03 15:47:00', 'terlambat', 'mobil sedikit kotor', 'PAY/20260703/01'),
('RET/20260703/02', '2026-07-03 23:11:00', 'terlambat', 'telat 3 jam', 'PAY/20260703/02'),
('RET/20260704/01', '2026-07-04 09:46:00', 'terlambat', 'bensin tidak diisi full', 'PAY/20260704/02'),
('RET/20260706/01', '2026-07-06 14:10:00', 'normal', '', 'PAY/20260706/01');

-- --------------------------------------------------------

--
-- Table structure for table `t_mobil`
--

CREATE TABLE `t_mobil` (
  `no_plat` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nm_mobil` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nkursi` tinyint(1) NOT NULL,
  `nbagasi` tinyint(1) NOT NULL,
  `jns_mobil` enum('SUV','MPV','City Car') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `transmisi` enum('AT','MT') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `thn_buat` year NOT NULL,
  `ft_depan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `ft_blkg` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `ft_interior` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `hrg_hari` mediumint NOT NULL,
  `cttn_unit` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status_unit` enum('tersedia','disewa','tidaktersedia') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'tersedia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `t_mobil`
--

INSERT INTO `t_mobil` (`no_plat`, `nm_mobil`, `nkursi`, `nbagasi`, `jns_mobil`, `transmisi`, `thn_buat`, `ft_depan`, `ft_blkg`, `ft_interior`, `hrg_hari`, `cttn_unit`, `status_unit`) VALUES
('B 1173 HFF', 'Toyota Kijang Innova Reborn 2.4 G Diesel', 7, 2, 'MPV', 'AT', 2025, 'ft_depan_20261028101755_683a9a1e11020e0a.jpg', 'ft_blkg_20261028101755_af14b9d7cf6f7aec.jpg', 'ft_interior_20261028101756_2844494dfc71c69e.webp', 700000, 'Toyota Kijang Innova Reborn 2.4 G Diesel tahun 2025 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('B 1583 RKE', 'Honda Brio 1.2 RS CVT CKD', 5, 2, 'City Car', 'AT', 2023, 'ft_depan_20261028102113_bdc82c959249b055.webp', 'ft_blkg_20261028102113_9f756806b1e6ae9e.webp', 'ft_interior_20261028102113_b56a9a1619b6d26c.jpg', 400000, 'Honda Brio 1.2 RS CVT CKD tahun 2023 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('B 4 LIP', 'Toyota Kijang Innova Reborn 2.4 V Diesel', 7, 2, 'MPV', 'AT', 2020, 'ft_depan_20261028104552_0c1157141a02dc37.webp', 'ft_blkg_20261028104552_b606181c0dc3f9a2.webp', 'ft_interior_20261028104552_2fab78a82b538bb5.jpg', 650000, 'Toyota Kijang Innova Reborn 2.4 V Diesel tahun 2020 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1020 AC', 'Honda Brio 1.2 RS CVT', 5, 2, 'City Car', 'AT', 2021, 'ft_depan_20261028104754_ffe7a4ae9c771188.jpg', 'ft_blkg_20261028104754_22fd7ff11cfcd6b8.jpg', 'ft_interior_20261028104754_4a80b0072751f11a.jpg', 370000, 'Honda Brio 1.2 RS CVT tahun 2021 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1058 AN', 'Toyota Kijang Innova Reborn 2.0 G', 7, 2, 'MPV', 'AT', 2020, 'ft_depan_20261028104946_2076b15d631260e2.jpg', 'ft_blkg_20261028104946_daccb90e1e5d2d17.jpg', 'ft_interior_20261028104946_e16952a24c2b2f58.jpg', 550000, 'Toyota Kijang Innova Reborn 2.0 G tahun 2020 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1060 LZQ', 'Toyota Kijang Innova Reborn 2.4 G Diesel', 7, 2, 'MPV', 'AT', 2025, 'ft_depan_20261028105035_c08f076025e6e12f.jpg', 'ft_blkg_20261028105035_b62fe2869f4e4b91.jpg', 'ft_interior_20261028105035_3deca980fb2c5d47.webp', 700000, 'Toyota Kijang Innova Reborn 2.4 G Diesel tahun 2025 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1070 VKT', 'Toyota Kijang Innova Reborn 2.4 G Diesel', 7, 2, 'MPV', 'AT', 2025, 'ft_depan_20261028105115_06670ad23bca37d2.jpg', 'ft_blkg_20261028105115_b6f1199408b0bc99.jpg', 'ft_interior_20261028105115_200fb81fe3b930b7.webp', 700000, 'Toyota Kijang Innova Reborn 2.4 G Diesel tahun 2025 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1078 AU', 'Toyota Kijang Innova Reborn 2.4 G Diesel', 7, 2, 'MPV', 'AT', 2023, 'ft_depan_20261028105159_e5a39276dfbe2693.jpg', 'ft_blkg_20261028105159_8d983233c87bf9f3.jpg', 'ft_interior_20261028105159_fed3c77aaafa0511.webp', 680000, 'Toyota Kijang Innova Reborn 2.4 G Diesel tahun 2023 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1142 PJ', 'Toyota Kijang Innova Reborn 2.0 V', 7, 2, 'MPV', 'AT', 2021, 'ft_depan_20261028105306_7fccf6a0806ce1fb.webp', 'ft_blkg_20261028105306_97bc58c996a680b0.webp', 'ft_interior_20261028105306_f12d5cff38879df6.jpg', 600000, 'Toyota Kijang Innova Reborn 2.0 V tahun 2021 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1169 TE', 'Honda Brio 1.2 RS CVT', 5, 2, 'City Car', 'AT', 2025, 'ft_depan_20261028105346_bba74fb05f0ddfc7.jpg', 'ft_blkg_20261028105346_4b8c5111973d95c9.jpg', 'ft_interior_20261028105346_4f0e58127e7506b5.jpg', 450000, 'Honda Brio 1.2 RS CVT tahun 2025 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1194 AB', 'Honda BR-V 1.5 CVT (All New Honda BR-V)', 7, 2, 'SUV', 'AT', 2022, 'ft_depan_20261021142735_34ccf033de0c6ce7.webp', 'ft_blkg_20261021142735_2c99ff74aee31ba2.webp', 'ft_interior_20261021142735_dbac5351e198b4cb.webp', 500000, 'Honda BR-V 1.5 CVT tahun 2022 merupakan kendaraan kategori SUV Crossover berkapasitas 7 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.5 liter. Kendaraan ini menawarkan kabin yang luas, posisi berkendara yang nyaman, serta ground clearance yang tinggi sehingga cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1362 QG', 'Toyota Kijang Innova Reborn 2.0 V', 7, 2, 'MPV', 'AT', 2022, 'ft_depan_20261028110619_a2ca4e2f8227d339.webp', 'ft_blkg_20261028110619_2fc73db86259b0f1.webp', 'ft_interior_20261028110620_56e4ed6a92607a02.jpg', 620000, 'Toyota Kijang Innova Reborn 2.0 V tahun 2022 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1460 AD', 'Honda Brio 1.2 Satya E CVT', 5, 2, 'City Car', 'AT', 2023, 'ft_depan_20261021143027_4afb2b5be30b4e12.webp', 'ft_blkg_20261021143027_0710d3507e478268.webp', 'ft_interior_20261021143027_34dd10802b52c634.webp', 380000, 'Honda Brio 1.2 Satya E CVT tahun 2023 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1467 AV', 'Toyota Kijang Innova Reborn 2.0 G', 7, 2, 'MPV', 'AT', 2020, 'ft_depan_20261028111111_33fb1816fb8e1e4e.jpg', 'ft_blkg_20261028111111_5ad2ca3c5a50cf4e.jpg', 'ft_interior_20261028111111_fba411d0ee07cd7c.jpg', 550000, 'Toyota Kijang Innova Reborn 2.0 G tahun 2020 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1470 AA', 'Toyota Kijang Innova Reborn 2.0 G', 7, 2, 'MPV', 'AT', 2022, 'ft_depan_20261028111153_835fde414a244274.jpg', 'ft_blkg_20261028111153_fc82cf0b2d0010c2.jpg', 'ft_interior_20261028111153_be373ad74142c250.jpg', 580000, 'Toyota Kijang Innova Reborn 2.0 G tahun 2022 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1570 AC', 'Honda Brio 1.2 RS CVT', 5, 2, 'City Car', 'AT', 2024, 'ft_depan_20261028112043_f340571620b6e55d.jpg', 'ft_blkg_20261028112043_9afccc5bb40fb77b.jpg', 'ft_interior_20261028112043_1bab79c24f20f33f.jpg', 420000, 'Honda Brio 1.2 RS CVT tahun 2024 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1639 AA', 'Honda Brio 1.2 Satya E CVT', 5, 2, 'City Car', 'AT', 2020, 'ft_depan_20261028112643_603bd8b6e07720fb.jpg', 'ft_blkg_20261028112643_3bf3a5675556ab27.jpg', 'ft_interior_20261028112643_1324737a31acafd9.jpg', 350000, 'Honda Brio 1.2 Satya E CVT tahun 2020 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1663 PJ', 'Honda Brio 1.2 E MT', 5, 2, 'City Car', 'MT', 2020, 'ft_depan_20261028113515_39a52be5817c5006.webp', 'ft_blkg_20261028113515_df4073d02f02e130.webp', 'ft_interior_20261028113515_7e00f59701a8d33c.webp', 300000, 'Honda Brio 1.2 E MT tahun 2020 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi manual dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1721 PI', 'Toyota Kijang Innova Reborn 2.0 G', 7, 2, 'MPV', 'AT', 2020, 'ft_depan_20261028113557_965121e10fb6e363.jpg', 'ft_blkg_20261028113557_f680f960637f92f4.jpg', 'ft_interior_20261028113557_06a946e006ce2554.jpg', 550000, 'Toyota Kijang Innova Reborn 2.0 G tahun 2020 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1744 NZM', 'Toyota Kijang Innova Reborn 2.4 V Diesel', 7, 2, 'MPV', 'AT', 2025, 'ft_depan_20261028113736_3795483055c9ea68.webp', 'ft_blkg_20261028113736_2ff4133c8aad0679.webp', 'ft_interior_20261028113736_26b072e9531e0b9f.webp', 750000, 'Toyota Kijang Innova Reborn 2.4 V Diesel tahun 2025 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1752 AA', 'Honda Brio 1.2 E CVT', 5, 2, 'City Car', 'AT', 2020, 'ft_depan_20261028114141_493ffd489aef19af.webp', 'ft_blkg_20261028114141_09b5bb4e207f602a.webp', 'ft_interior_20261028114141_449fdb5d3086fb7a.webp', 360000, 'Honda Brio 1.2 E CVT tahun 2020 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1755 AA', 'Honda Brio 1.2 Satya S CVT', 5, 2, 'City Car', 'AT', 2020, 'ft_depan_20261028115000_33fb679cd033ba8b.webp', 'ft_blkg_20261028115000_8c59b806100b5567.webp', 'ft_interior_20261028115000_26527e4862233985.webp', 340000, 'Honda Brio 1.2 Satya S CVT tahun 2020 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1759 PJ', 'Toyota Kijang Innova 2.0 V', 7, 2, 'MPV', 'AT', 2021, 'ft_depan_20261021143334_5b8b3b6f52660a5f.jpg', 'ft_blkg_20261021143334_a3f4364ac1c29aa0.jpg', 'ft_interior_20261021143334_5e453f0ffb404824.jpg', 600000, 'Toyota Kijang Innova 2.0 V A/T TGN tahun 2021 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1760 QF', 'Toyota Kijang Innova Reborn 2.0 V', 7, 2, 'MPV', 'AT', 2025, 'ft_depan_20261028115929_a2a4a18f1127a463.jpg', 'ft_blkg_20261028115929_188bbfa3bc34a8fe.jpg', 'ft_interior_20261028115929_8365e0772e211595.jpg', 650000, 'Toyota Kijang Innova Reborn 2.0 V tahun 2025 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1798 AB', 'Honda Brio 1.2 RS MT', 5, 2, 'City Car', 'MT', 2023, 'ft_depan_20261028120251_555f33fd088f71fd.webp', 'ft_blkg_20261028120251_413b47ecd353d035.webp', 'ft_interior_20261028120251_9601c730d31c76e9.webp', 350000, 'Honda Brio 1.2 RS MT tahun 2023 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi manual dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1847 PJ', 'Toyota Avanza Facelift', 7, 2, 'MPV', 'AT', 2021, 'ft_depan_20261021143607_4d4dd5cb71a5c832.webp', 'ft_blkg_20261021143607_5d5b06d17b4f7704.jpg', 'ft_interior_20261021143607_083997e7ce404bc2.jpg', 500000, 'Toyota Avanza Facelift merupakan kendaraan kategori MPV dengan kapasitas 7 penumpang yang dirancang untuk memberikan kenyamanan dan efisiensi dalam berbagai kebutuhan perjalanan. Kendaraan ini memiliki kabin yang luas, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1888 XY', 'Honda Brio 1.2 E MT', 5, 2, 'City Car', 'MT', 2022, 'ft_depan_20261028120525_95bf303c59596442.webp', 'ft_blkg_20261028120525_fa3a5978c1e72850.webp', 'ft_interior_20261028120525_85dc7c4c539a44b1.webp', 330000, 'Honda Brio 1.2 E MT tahun 2022 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi manual dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1895 PI', 'Toyota Kijang Innova Reborn 2.0 V', 7, 2, 'MPV', 'AT', 2020, 'ft_depan_20261028120645_50074ab20715f9e9.webp', 'ft_blkg_20261028120645_1d58a25408f00983.webp', 'ft_interior_20261028120645_3071543a9b2d1ce2.webp', 580000, 'Toyota Kijang Innova Reborn 2.0 V tahun 2020 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 1911 AB', 'Honda Brio Satya 1.2 E CVT CKD', 5, 2, 'City Car', 'AT', 2023, 'ft_depan_20261021143833_c701d4344353f93c.jpg', 'ft_blkg_20261021143834_ef663d724b9fdba1.jpg', 'ft_interior_20261021143834_5c150e3d70242ad2.jpg', 400000, 'Honda Brio Satya 1.2 E CVT CKD tahun 2023 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1926 AP', 'Honda Brio 1.2 RS CVT', 5, 2, 'City Car', 'AT', 2022, 'ft_depan_20261028120738_a8b24f828102ec52.jpg', 'ft_blkg_20261028120738_f3439e57f125b58e.jpg', 'ft_interior_20261028120738_7ba6cf5b0f3a97f1.jpg', 380000, 'Honda Brio 1.2 RS CVT tahun 2022 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 1999 ZZ', 'Honda Brio 1.2 RS CVT', 5, 2, 'City Car', 'AT', 2024, 'ft_depan_20261028120836_e0b57e896445811d.jpg', 'ft_blkg_20261028120836_918cf5983b41f467.jpg', 'ft_interior_20261028120836_3a378aa8181c362d.jpg', 420000, 'Honda Brio 1.2 RS CVT tahun 2024 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 2000 AA', 'Toyota Kijang Innova Reborn 2.0 V', 7, 2, 'MPV', 'AT', 2022, 'ft_depan_20261028120916_225d50578aab2625.jpg', 'ft_blkg_20261028120916_f92e455b62813b00.jpg', 'ft_interior_20261028120916_8fa876448fa1742e.jpg', 620000, 'Toyota Kijang Innova Reborn 2.0 V tahun 2022 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 2067 TS', 'Mitsubishi Pajero Sport', 7, 2, 'SUV', 'MT', 1996, 'ft_depan_20261021134221_cf567eefcba2f3ea.webp', 'ft_blkg_20261021134221_2b21e5b72f32c712.webp', 'ft_interior_20261021134221_7a9d9abd03ad067a.webp', 900, '-', 'tersedia'),
('BN 2111 BB', 'Toyota Kijang Innova Reborn 2.4 V Diesel', 7, 2, 'MPV', 'AT', 2023, 'ft_depan_20261028121018_67cf675e126921d1.jpg', 'ft_blkg_20261028121018_cb1ca4b3806633a2.jpg', 'ft_interior_20261028121018_00c7ba75c80a8f62.webp', 720000, 'Toyota Kijang Innova Reborn 2.4 V Diesel tahun 2023 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 2222 CC', 'Honda Brio 1.2 Satya S MT', 5, 2, 'City Car', 'MT', 2021, 'ft_depan_20261028121438_3690fc602109fe51.jpg', 'ft_blkg_20261028121438_2d20874af9f38184.jpg', 'ft_interior_20261028121438_f9b356ecbe513d3f.webp', 310000, 'Honda Brio 1.2 Satya S MT tahun 2021 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi manual dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 2285 BRH', 'Toyota Kijang Innova Reborn 2.4 V Diesel', 7, 2, 'MPV', 'AT', 2026, 'ft_depan_20261028121521_7e17cefe72ba2f51.webp', 'ft_blkg_20261028121521_688906ec6ac023ad.webp', 'ft_interior_20261028121521_71dfabd09bbb2090.webp', 800000, 'Toyota Kijang Innova Reborn 2.4 V Diesel tahun 2026 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 2333 DD', 'Honda Brio 1.2 Satya E CVT', 5, 2, 'City Car', 'AT', 2025, 'ft_depan_20261028121617_00fea2c00bc7ace1.jpg', 'ft_blkg_20261028121617_a493ede52168ffe6.jpg', 'ft_interior_20261028121617_646d7d054fd76ec8.jpg', 400000, 'Honda Brio 1.2 Satya E CVT tahun 2025 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 2444 EE', 'Toyota Kijang Innova Reborn 2.0 G', 7, 2, 'MPV', 'AT', 2024, 'ft_depan_20261028122035_88cafee205b4cff6.jpg', 'ft_blkg_20261028122035_c22113cfda26089e.jpg', 'ft_interior_20261028122035_257978bcf28cee0f.jpg', 600000, 'Toyota Kijang Innova Reborn 2.0 G tahun 2024 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin bensin 2.0 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 2555 FF', 'Honda Brio 1.2 RS CVT', 5, 2, 'City Car', 'AT', 2022, 'ft_depan_20261028122125_82bcb2dc1038b69e.jpg', 'ft_blkg_20261028122125_336231b0a040690d.jpg', 'ft_interior_20261028122125_6bf88b261670fcad.jpg', 380000, 'Honda Brio 1.2 RS CVT tahun 2022 merupakan kendaraan kategori City Car dengan kapasitas 5 penumpang yang dilengkapi transmisi otomatis CVT dan mesin bensin 1.2 liter. Kendaraan ini memiliki desain kompak, konsumsi bahan bakar yang efisien, serta cocok digunakan untuk kebutuhan transportasi harian maupun perjalanan dalam kota.', 'tersedia'),
('BN 2625 SQQ', 'Toyota Kijang Innova Reborn 2.4 V Diesel', 7, 2, 'MPV', 'AT', 2025, 'ft_depan_20261028122218_98aa144fd4e03dd3.webp', 'ft_blkg_20261028122218_8948c05004bb3ce4.webp', 'ft_interior_20261028122218_af34c7f9438b5d81.webp', 750000, 'Toyota Kijang Innova Reborn 2.4 V Diesel tahun 2025 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 2666 GG', 'Toyota Kijang Innova Reborn 2.4 G Diesel', 7, 2, 'MPV', 'AT', 2021, 'ft_depan_20261028122316_97873e2a25a0c50e.jpg', 'ft_blkg_20261028122316_661eebdaa06fd388.jpg', 'ft_interior_20261028122316_970aeb8e4bd61d8d.webp', 600000, 'Toyota Kijang Innova Reborn 2.4 G Diesel tahun 2021 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 2736 PKU', 'Toyota Kijang Innova Reborn 2.4 V Diesel', 7, 2, 'MPV', 'AT', 2025, 'ft_depan_20261028122418_a17e1713c95ad3bf.webp', 'ft_blkg_20261028122418_fdc605b25a23c29c.webp', 'ft_interior_20261028122418_d06d2a7aa804abfc.jpg', 750000, 'Toyota Kijang Innova Reborn 2.4 V Diesel tahun 2025 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia'),
('BN 2786 VQT', 'Toyota Kijang Innova Reborn 2.4 V Diesel', 7, 2, 'MPV', 'AT', 2026, 'ft_depan_20261028122507_23c03705f7d64bb7.webp', 'ft_blkg_20261028122507_7b5d982ad1070ba2.webp', 'ft_interior_20261028122507_84aff51b6ba67867.webp', 800000, 'Toyota Kijang Innova Reborn 2.4 V Diesel tahun 2026 merupakan kendaraan kategori MPV berkapasitas 7 penumpang yang dilengkapi transmisi otomatis dan mesin diesel 2.4 liter. Kendaraan ini menawarkan kabin yang luas, kenyamanan berkendara yang baik, serta cocok digunakan untuk perjalanan keluarga, wisata, maupun perjalanan dinas.', 'tersedia');

-- --------------------------------------------------------

--
-- Table structure for table `t_penyewa`
--

CREATE TABLE `t_penyewa` (
  `user_plg` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `sandi` char(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nik` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nm_lngkp` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `no_hp` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `almt_lngkp` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `ft_ktp` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `ft_sim_a` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `t_penyewa`
--

INSERT INTO `t_penyewa` (`user_plg`, `sandi`, `nik`, `nm_lngkp`, `no_hp`, `almt_lngkp`, `ft_ktp`, `ft_sim_a`) VALUES
('aisyah', '$2y$10$jBHIse2MUp2R5CRlorg08ufjRkHLzFVcjnDhD.GRc2YBLz1agDqeW', '1971922019928288', 'Aisyah Nurul Putri', '087766761234', 'Jl. Raden Said Abdullah Kota Sungailiat', NULL, NULL),
('andi', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM2', '1971030303030003', 'Andi Prasetyo', '082156789012', 'Jl. Merdeka RT 003 RW 003 Kel. Bukit Intan Kec. Bukit Intan Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL),
('budi', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMN', '1971010101010001', 'Budi Santoso', '081234567890', 'Jl. Depati Hamzah RT 001 RW 001 Kel. Air Itam Kec. Bukit Intan Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL),
('dewi', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM3', '1971040404040004', 'Dewi Lestari', '082267890123', 'Jl. Ahmad Yani RT 004 RW 004 Kel. Gabek Kec. Gabek Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL),
('eko', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM4', '1971050505050005', 'Eko Widodo', '085378901234', 'Jl. Sudirman RT 005 RW 005 Kel. Girimaya Kec. Girimaya Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL),
('gema', '$2y$10$yLYgFo9VhVu0L/g2pvvO5ujSpT0tO2dt28URyVD5MAVz8LYe2R9gq', '1971041210910012', 'Gema Saputra', '08126672888', 'Jl. Sriwijaya RT 004 RW 002 Kel. Asam Kec. Rangkui Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', 'ft_ktp_1782316776_6a3bfee8711f0.jpg', 'ft_sim_a_1782316776_6a3bfee871739.jpg'),
('irhamdani', '$2y$10$zc96yRwpTlsfvig7zA9nReftZAn1NFIi7o.WymyAfhIv1I8rVErc.', '1971012009940001', 'Irhamdani', '081378772655', 'Jl. Depati Hamzah RT 009 RW 003 Kel. Air Itam Kec. Bukit Intan Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', 'ft_ktp_1782632700_6a40d0fc4ee6c.webp', NULL),
('joko', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM8', '1971090909090009', 'Joko Susilo', '085812345678', 'Jl. Veteran RT 009 RW 009 Kel. Pasar Padi Kec. Taman Sari Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL),
('lintang', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM9', '1971101010100010', 'Lintang Pradipta', '085923456789', 'Jl. Bangka RT 010 RW 010 Kel. Selindung Kec. Gerunggang Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL),
('maya', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM7', '1971080808080008', 'Maya Sari', '085701234567', 'Jl. Imam Bonjol RT 008 RW 008 Kel. Opas Indah Kec. Gerunggang Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL),
('princess2233', '$2y$10$ZE/HpvQ9rY/WruzX1aiNSOBqIThDnzt5S24LN1STvebjzx.6DAlB.', '1233445566778899', 'Repa Fitriyani', '085925526647', 'Desa Cambai', NULL, NULL),
('ratna', '$2y$10$NfvB6cLtk4ho9zvHGRw2VOQHiCvyhThcmzMkdgVUiTOU6qNO1b4du', '1012929292929292', 'Ratna Dewi', '08191919', 'Jl. Belinyu Bangka', NULL, NULL),
('rini', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM5', '1971060606060006', 'Rini Wulandari', '085489012345', 'Jl. Pahlawan RT 006 RW 006 Kel. Kampung Melayu Kec. Rangkui Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL),
('siti', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM1', '1971020202020002', 'Siti Aminah', '081345678901', 'Jl. Sriwijaya RT 002 RW 002 Kel. Asam Kec. Rangkui Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL),
('tono', '$2y$10$abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLM6', '1971070707070007', 'Tono Supriyadi', '085690123456', 'Jl. Diponegoro RT 007 RW 007 Kel. Ketapang Kec. Rangkui Kota Pangkalpinang Provinsi Kepulauan Bangka Belitung', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `t_pilih`
--

CREATE TABLE `t_pilih` (
  `kode_sewa` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `no_plat` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hrg_sewa` mediumint NOT NULL,
  `n_hari` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `t_pilih`
--

INSERT INTO `t_pilih` (`kode_sewa`, `no_plat`, `hrg_sewa`, `n_hari`) VALUES
('INV/20260702/01', 'B 1583 RKE', 400000, 1),
('INV/20260702/01', 'BN 1460 AD', 500000, 1),
('INV/20260702/02', 'B 1173 HFF', 700000, 2),
('INV/20260703/01', 'BN 1194 AB', 500000, 1),
('INV/20260704/01', 'BN 1752 AA', 360000, 1),
('INV/20260704/02', 'BN 1194 AB', 500000, 1),
('INV/20260705/01', 'BN 1194 AB', 500000, 1),
('INV/20260705/02', 'BN 1194 AB', 500000, 1),
('INV/20260712/01', 'B 1583 RKE', 400000, 1),
('INV/20260712/02', 'B 4 LIP', 650000, 1),
('INV/20261104/01', 'BN 1798 AB', 350000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `t_sewa`
--

CREATE TABLE `t_sewa` (
  `kode_sewa` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tgl_mulai` date NOT NULL,
  `tgl_selesai` date NOT NULL,
  `wkt_ambil` time NOT NULL,
  `status_sewa` enum('diajukan','disetujui','ditolak','aktif','selesai','batal','keranjang') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci DEFAULT 'keranjang',
  `user_plg` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `t_sewa`
--

INSERT INTO `t_sewa` (`kode_sewa`, `tgl_mulai`, `tgl_selesai`, `wkt_ambil`, `status_sewa`, `user_plg`) VALUES
('INV/20260702/01', '2026-07-02', '2026-07-03', '14:07:00', 'selesai', 'gema'),
('INV/20260702/02', '2026-07-04', '2026-07-06', '21:15:00', 'selesai', 'irhamdani'),
('INV/20260703/01', '2026-07-03', '2026-07-04', '14:10:00', 'selesai', 'gema'),
('INV/20260704/01', '2026-07-04', '2026-07-05', '10:00:00', 'selesai', 'gema'),
('INV/20260704/02', '2026-07-04', '2026-07-05', '13:57:20', 'diajukan', 'ratna'),
('INV/20260705/01', '2026-07-05', '2026-07-06', '00:01:32', 'batal', 'aisyah'),
('INV/20260705/02', '2026-07-05', '2026-07-06', '00:57:48', 'disetujui', 'aisyah'),
('INV/20260712/01', '2026-07-12', '2026-07-13', '08:00:00', 'batal', 'aisyah'),
('INV/20260712/02', '2026-07-12', '2026-07-13', '08:00:00', 'batal', 'andi'),
('INV/20261104/01', '2026-11-04', '2026-11-05', '07:17:26', 'diajukan', 'princess2233');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `t_admin`
--
ALTER TABLE `t_admin`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `t_bayar`
--
ALTER TABLE `t_bayar`
  ADD PRIMARY KEY (`kode_bayar`);

--
-- Indexes for table `t_denda`
--
ALTER TABLE `t_denda`
  ADD PRIMARY KEY (`kode_denda`);

--
-- Indexes for table `t_kembali`
--
ALTER TABLE `t_kembali`
  ADD PRIMARY KEY (`kode_kembali`);

--
-- Indexes for table `t_mobil`
--
ALTER TABLE `t_mobil`
  ADD PRIMARY KEY (`no_plat`);

--
-- Indexes for table `t_penyewa`
--
ALTER TABLE `t_penyewa`
  ADD PRIMARY KEY (`user_plg`);

--
-- Indexes for table `t_pilih`
--
ALTER TABLE `t_pilih`
  ADD PRIMARY KEY (`kode_sewa`,`no_plat`);

--
-- Indexes for table `t_sewa`
--
ALTER TABLE `t_sewa`
  ADD PRIMARY KEY (`kode_sewa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
