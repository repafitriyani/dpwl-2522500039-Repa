
<?php
// Nama Berkas - application/config/routes.php

$route = [];

// Route P2/P3
$route['default_controller'] = 'Katalog_controller';

$route['info/(:any)'] = 'Home/info/$1';
$route['login'] = 'Auth/login';
$route['auth/login'] = 'Auth/login';
$route['auth/logout'] = 'Auth/logout';
$route['admin'] = 'Admin/index';

// Route P4
$route['admin/madmin'] = 'Madmin_controller/index';
$route['admin/madmin/tambah'] = 'Madmin_controller/tambah';
$route['admin/madmin/ubah/(:any)'] = 'Madmin_controller/ubah/$1';
$route['admin/madmin/hapus/(:any)'] = 'Madmin_controller/hapus/$1';

// Route P5
$route['admin/mobil'] = 'Mobil_controller/index';
$route['admin/mobil/tambah'] = 'Mobil_controller/tambah';
$route['admin/mobil/ubah/(:any)'] = 'Mobil_controller/ubah/$1';
$route['admin/mobil/hapus/(:any)'] = 'Mobil_controller/hapus/$1';

// Route P6
$route['katalog'] = 'Katalog_controller/index';
$route['katalog/detail/(:any)'] = 'Katalog_controller/detail/$1';
$route['auth/register'] = 'Auth/register';
$route['auth/login-penyewa'] = 'Auth/loginPenyewa';
$route['auth/logout-penyewa'] = 'Auth/logoutPenyewa';
$route['penyewa/profil'] = 'Penyewa_controller/profil';

// Route P7
$route['transaksi/tambah'] = 'Transaksi_controller/tambah';
$route['transaksi/keranjang'] = 'Transaksi_controller/keranjang';
$route['transaksi/perbarui-periode'] = 'Transaksi_controller/perbaruiPeriode';
$route['transaksi/hapus'] = 'Transaksi_controller/hapus';
$route['transaksi/hapus/(:any)'] = 'Transaksi_controller/hapus/$1';
$route['transaksi/checkout'] = 'Transaksi_controller/checkout';

// Route P8
$route['admin/penyewa'] = 'Penyewa_controller/index';
$route['admin/penyewa/tambah'] = 'Penyewa_controller/tambah';
$route['admin/penyewa/ubah/(:any)'] = 'Penyewa_controller/ubah/$1';
$route['admin/penyewa/hapus/(:any)'] = 'Penyewa_controller/hapus/$1';

// Route P9 - Pembayaran Penyewa
$route['pembayaran'] = 'Pembayaran_controller/index';
$route['pembayaran/upload-bukti'] = 'Pembayaran_controller/uploadBukti';

// Route P9 - Verifikasi Pembayaran Admin
$route['admin/pembayaran'] = 'Pembayaran_controller/verifikasiIndex';
$route['admin/pembayaran/verifikasi'] = 'Pembayaran_controller/verifikasi';

