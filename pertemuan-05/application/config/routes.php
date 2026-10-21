
<?php
// Nama Berkas - application/config/routes.php

$route = [];

// Route P2/P3
$route['default_controller'] = 'Home';
$route['info/(:any)'] = 'Home/info/$1';
$route['login'] = 'Auth/login';
$route['auth/login'] = 'Auth/login';
$route['auth/logout'] = 'Auth/logout';
$route['admin'] = 'Admin/index';

// Route P4: CRUD admin
$route['admin/madmin'] = 'Madmin_controller/index';
$route['admin/madmin/tambah'] = 'Madmin_controller/tambah';
$route['admin/madmin/ubah/(:any)'] = 'Madmin_controller/ubah/$1';
$route['admin/madmin/hapus/(:any)'] = 'Madmin_controller/hapus/$1';

// Route P5: CRUD mobil
// Menu mengarah ke Mobil_controller, kemudian method index()
// menampilkan halaman admin/mobil_view.
$route['admin/mobil'] = 'Mobil_controller/index';
$route['admin/mobil/tambah'] = 'Mobil_controller/tambah';
$route['admin/mobil/ubah/(:any)'] = 'Mobil_controller/ubah/$1';
$route['admin/mobil/hapus/(:any)'] = 'Mobil_controller/hapus/$1';
