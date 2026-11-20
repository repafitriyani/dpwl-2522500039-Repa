# pertemuan-10

1. Pada tahap pertama, dilakukan penambahan fungsi untuk mengambil daftar transaksi penyewaan yang masih memiliki sisa pembayaran. Data tersebut diambil dari database, kemudian sistem menghitung total biaya penyewaan dan jumlah pembayaran yang sudah dilakukan oleh penyewa.

       Setelah itu, sistem menghitung sisa pembayaran yang masih harus dilunasi. Dengan adanya fungsi ini, admin dapat mengetahui transaksi mana saja yang masih memiliki kewajiban pembayaran dan perlu diproses lebih lanjut.



2. Pada tahap kedua, dilakukan pengembangan fungsi untuk menampilkan detail transaksi penyewaan. Informasi yang ditampilkan meliputi identitas penyewa, data kendaraan yang disewa, tanggal penyewaan, total biaya transaksi, serta riwayat pembayaran sebelumnya.

    Fitur ini dibuat agar admin dapat melihat informasi transaksi secara lebih lengkap sebelum melakukan proses pelunasan. Dengan begitu, admin dapat memastikan bahwa data penyewaan dan pembayaran sudah sesuai.

3. Pada tahap ketiga, dilakukan pembuatan fungsi untuk menghasilkan kode pembayaran pelunasan secara otomatis. Kode pembayaran ini digunakan sebagai identitas setiap transaksi agar pembayaran yang dilakukan dapat dibedakan dan tidak tertukar dengan transaksi lainnya.

    Format kode pembayaran yang digunakan adalah PAY/YYYYMMDD/NN, yaitu terdiri dari kode pembayaran, tanggal transaksi, dan nomor urut pembayaran.

    Dengan adanya kode pembayaran otomatis, pencatatan transaksi pelunasan menjadi lebih teratur dan mudah diperiksa kembali.


4. Pada tahap keempat, dilakukan pembuatan fungsi untuk menyimpan data pembayaran pelunasan ke dalam database. Pada proses ini, sistem menghitung sisa kewajiban pembayaran yang harus dibayarkan oleh penyewa.

     Pembayaran pelunasan dapat dilakukan melalui dua metode, yaitu tunai dan transfer. Jika penyewa menggunakan metode transfer, maka admin perlu melampirkan bukti transfer sebagai dokumentasi pembayaran.

     Setelah pembayaran berhasil disimpan, sistem akan memperbarui status transaksi penyewaan menjadi lunas apabila seluruh kewajiban pembayaran sudah terpenuhi.


5. Pada tahap kelima, dilakukan pengembangan controller dan halaman admin untuk menghubungkan fungsi-fungsi yang sudah dibuat pada model dengan tampilan aplikasi.

      Controller bertugas mengatur proses pengambilan data, menampilkan detail transaksi, serta menjalankan proses penyimpanan pelunasan. Sementara itu, view digunakan untuk menampilkan daftar transaksi, informasi detail pembayaran, dan formulir pencatatan pelunasan.

      Dengan adanya pengembangan ini, admin dapat mengelola proses pelunasan secara langsung melalui halaman administrator tanpa harus mengakses database secara manual.