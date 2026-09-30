# pertemuan-02
## 1. Tujuan Praktikum
Jawaban : Tujuan dari praktikum P2 ini adalah untuk memahami dasar penggunaan konsep MVC dalam pembuatan aplikasi web menggunakan PHP. Pada praktikum ini juga dipelajari bagaimana cara kerja routing, front controller, controller, view, helper URL, serta alur request dan response pada aplikasi.

## 2.Struktur Direktory
Jawaban : 
```
dpwl-2522500039/
│
├── application/
│   ├── config/
│   │   ├── config.php
│   │   └── routes.php
│   │
│   ├── controllers/
│   │   └── Home.php
│   │
│   ├── helpers/
│   │   └── url_helper.php
│   │
│   └── views/
│       └── home/
│           ├── index.php
│           └── info.php
│
├── assets/
│   └── css/
│       └── app.css
│
├── Dokumentasi/
│
├── system/
│   └── core/
│       ├── Controller.php
│       └── router.php
│
└── index.php
```

## 3. Front Controller
Jawaban : index.php berfungsi sebagai front controller, yaitu sebagai pintu masuk utama aplikasi. Jadi, ketika pengguna membuka sebuah URL, request tersebut akan masuk terlebih dahulu ke index.php.

Setelah itu, index.php akan menjalankan Router untuk mengecek URL yang dimasukkan dan menentukan Controller serta method yang sesuai. Dengan cara ini, request aplikasi menjadi lebih teratur karena diproses melalui satu pintu masuk.

## 4. Routing dan Pemetaan URL
Jawaban : 

| URL/Route | Controller | Method | Parameter | View | 
|---|---|---|---|---| 
| / | Home | index | - | home/index.php | 
| home/index | Home | index | - | home/index.php | 
| home/info/mvc | Home | info | mvc | home/info.php | 
| info/routing | Home | info | routing | home/info.php | 
|atm/saldo |Home |info | saldo | home/info.php |

Penjelasan :

Jadi, ketika URL tersebut dibuka, Router akan mencocokkan URL dengan route yang tersedia. Setelah cocok, request akan diarahkan ke Controller Home, kemudian menjalankan method info() dengan parameter atm/saldo. Setelah itu Controller akan menampilkan saldo home/info.php

## 5. Base URL dan Helper
Jawaban : 

base_url() dan site_url() digunakan untuk mempermudah pemanggilan URL dalam aplikasi.

base_url() digunakan untuk memanggil file atau asset yang ada di dalam aplikasi, seperti CSS, JavaScript, dan gambar.

Contohnya untuk memanggil file CSS:

<link rel="stylesheet" href="<?= base_url('assets/css/app.css') ?>">

Sedangkan site_url() digunakan untuk membuat URL yang mengarah ke route atau halaman tertentu dalam aplikasi

Contohnya : 
`<a href="<?= site_url('home/index') ?>">Home</a>`

## 6. Alur Request-Response
1. Alur eksekusi aktual P2: 
Browser → index.php → Router → Controller → View → Response.

Penjelasannya, ketika pengguna membuka URL melalui browser, request akan masuk ke index.php. Kemudian Router mengecek URL tersebut dan menentukan Controller serta method yang akan dijalankan.

2. Posisi Model dalam arsitektur MVC lengkap: 
Browser → index.php → Router → Controller → Model → basis data/data → Model → Controller → View → 
Response.

Penjelasan setiap tahapnya:

Browser
Proses dimulai ketika pengguna memasukkan atau mengakses sebuah URL melalui browser. Misalnya pengguna membuka halaman home/index. Browser akan mengirimkan request ke aplikasi.
index.php
Request yang masuk pertama kali diterima oleh index.php. File ini berfungsi sebagai front controller, yaitu sebagai pintu masuk utama aplikasi. Jadi, request tidak langsung menuju Controller, tetapi diproses terlebih dahulu melalui index.php.

Router
Setelah masuk ke index.php, request diteruskan ke Router. Router bertugas membaca URL yang diminta dan mencocokkannya dengan route yang sudah dibuat di routes.php.

Misalnya terdapat route:

$route['home/info/(:any)'] = 'home/info/$1';

Jika pengguna membuka:

home/info/mvc

maka Router akan mengenali bahwa URL tersebut diarahkan ke Controller Home, method info(), dengan parameter mvc.

Controller
Setelah Router menemukan route yang sesuai, request diteruskan ke Controller. Controller berfungsi sebagai pengatur proses aplikasi.

Contohnya:

Home.php

kemudian menjalankan method:

info()

Controller bertugas menerima request, menjalankan proses yang diperlukan, dan jika membutuhkan data maka Controller akan meminta data tersebut kepada Model.

Model
Pada tahap ini Model digunakan untuk mengatur data. Model menjadi bagian yang berhubungan dengan sumber data, misalnya database.

Contohnya, jika pengguna ingin melihat informasi saldo ATM, Controller dapat meminta data saldo kepada Model. Model kemudian melakukan proses pengambilan data dari database.

Jadi, Controller tidak langsung mengakses database, tetapi meminta bantuan Model. Hal ini membuat pembagian tugas dalam MVC menjadi lebih jelas.

Basis data/data
Setelah menerima permintaan dari Model, data akan diambil dari database atau sumber data lainnya. Misalnya pada aplikasi ATM, data yang diambil dapat berupa nomor rekening, nama nasabah, saldo, atau data transaksi.
Model → Controller
Setelah data berhasil didapatkan, Model mengembalikan data tersebut kepada Controller. Controller kemudian menerima dan mengolah data sesuai kebutuhan halaman yang akan ditampilkan.

View
Setelah Controller mendapatkan data, data tersebut dikirimkan ke View. View bertugas mengatur tampilan yang akan dilihat oleh pengguna.

Misalnya View menampilkan:

Informasi Saldo
Nomor Rekening : 12345
Saldo          : Rp1.000.000

Jadi, View lebih fokus pada tampilan, sedangkan proses pengolahan datanya dilakukan oleh Controller dan Model.

Response
Setelah View selesai membuat tampilan, hasilnya dikirim kembali ke browser sebagai response. Browser kemudian menampilkan halaman tersebut kepada pengguna.
Penerapan pada P2

Pada P2, alur yang digunakan sebenarnya belum sampai ke Model dan database. Alur yang berjalan pada P2 masih:

Browser → index.php → Router → Controller → View → Response

Contohnya ketika membuka:

home/info/mvc

Request masuk ke index.php, kemudian Router mencocokkan route tersebut dan mengarahkannya ke Home.php. Selanjutnya method info() dijalankan dan memanggil View home/info.php. View tersebut kemudian ditampilkan kembali ke browser.

## 7. Hasil Pengujian dan Debugging 
Catat skenario pengujian valid dan tidak valid beserta hasilnya. Jika ditemukan kesalahan selama 
implementasi, dokumentasikan sekurang-kurangnya satu proses debugging yang memuat: 

Jawaban : Pada saat aplikasi dijalankan, halaman Fondasi MVC DPWL sudah berhasil tampil. Ini menunjukkan bahwa alur front controller → Router → Controller → View sudah berjalan. Namun, masih muncul warning pada router.php baris 56.

Error tersebut adalah:

preg_match(): Compilation failed: missing closing parenthesis

Artinya, terdapat kesalahan pada pola route atau regex, yaitu kurang tanda kurung tutup ). Contohnya:

$route['info/(:any'] = 'home/info/$1';

Seharusnya ditulis:

$route['info/(:any)'] = 'home/info/$1';

Jadi, penyebab errornya adalah penulisan route yang kurang tepat. Setelah tanda kurung diperbaiki, Router dapat membaca route dengan benar dan custom route bisa diuji kembali.

## 8. Bukti Tangkapan Layar 

### Gambar 1. Hasil Pengujian Halaman Utama  
![Gambar 1 - Halaman Utama](dokumentasi/gambar1.png)  
 
### Gambar 2. Hasil Pengujian Custom Route  
![Gambar 2 - Custom Route](dokumentasi/gambar2.png) 

## 9. Kesimpulan dari Screenshoot

Jawaban :

Pada saat pengujian aplikasi P2, halaman utama berhasil ditampilkan dan menunjukkan bahwa request sudah melewati front controller, Router, Controller, dan View. Namun, pada bagian atas halaman masih muncul warning dari fungsi preg_match() pada file system/core/router.php baris 56. Warning tersebut menunjukkan bahwa terdapat kesalahan pada pola regex yang digunakan Router, yaitu adanya tanda kurung buka yang belum memiliki tanda kurung penutup. Kesalahan ini kemungkinan berasal dari penulisan route pada routes.php, seperti (:any yang seharusnya ditulis (:any). Setelah penulisan route diperbaiki, Router dapat mencocokkan URL dengan pola route yang benar sehingga custom route dan parameter dapat diuji kembali.


