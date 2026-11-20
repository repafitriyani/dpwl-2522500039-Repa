<?php

// Menyiapkan fungsi untuk mengamankan output.
$e = static function ($value): string {
    return htmlspecialchars(
        (string) $value,
        ENT_QUOTES,
        'UTF-8'
    );
};

// Memanggil template website penyewa.
require __DIR__ . '/../katalog/header.php';
require __DIR__ . '/../katalog/navbar.php';

?>

<!-- Judul Halaman Pembayaran -->
<section class="bg-success py-5">
    <div class="container">
        <div class="row">
            <div class="col-12 text-center">

                <h1 class="h2 text-white mt-3">
                    Pembayaran Penyewaan
                </h1>

                <p class="text-white">
                    Informasi pembayaran dan bukti transfer penyewaan kendaraan.
                </p>

            </div>
        </div>
    </div>
</section>

<!-- Konten Pembayaran -->
<section class="container py-5">

    <div class="row py-3">
        <div class="col-lg-10 m-auto">

            <!-- Notifikasi -->
            <?php if (!empty($flash)) : ?>

                <?php
                $jenisAlert = 'info';

                if ($flash['type'] === 'success') {
                    $jenisAlert = 'success';
                } elseif ($flash['type'] === 'error') {
                    $jenisAlert = 'danger';
                }
                ?>

                <div class="alert alert-<?= $jenisAlert ?>" role="alert">
                    <?= $e($flash['message']) ?>
                </div>

            <?php endif; ?>

            <h2 class="h4 text-success mb-3">
                Informasi Pembayaran
            </h2>

            <p class="text-muted mb-4">
                Berikut merupakan informasi pembayaran dari transaksi
                penyewaan kendaraan yang telah dilakukan.
            </p>

            <?php if (!empty($pembayaran)) : ?>

                <?php foreach ($pembayaran as $bayar) : ?>

                    <?php
                    // Menentukan warna status pembayaran.
                    $status = $bayar['sttus_byr'];
                    $warnaStatus = 'warning';

                    if ($status === 'valid') {
                        $warnaStatus = 'success';
                    } elseif ($status === 'invalid') {
                        $warnaStatus = 'danger';
                    }
                    ?>

                    <div class="card shadow-sm mb-4">

                        <div class="card-body p-4 p-lg-5">

                            <!-- Identitas Pembayaran -->
                            <h3 class="h5 text-success mb-3">
                                <i class="fa fa-credit-card"></i>
                                Kode Pembayaran:
                                <?= $e($bayar['kode_bayar']) ?>
                            </h3>

                            <hr>

                            <!-- Tabel Informasi -->
                            <div class="table-responsive">

                                <table class="table table-bordered align-middle">

                                    <tbody>

                                        <tr>
                                            <th>Kode Pembayaran</th>
                                            <td>
                                                <?= $e($bayar['kode_bayar']) ?>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Kode Penyewaan</th>
                                            <td>
                                                <?= $e($bayar['kode_sewa']) ?>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Tanggal Pembayaran</th>
                                            <td>
                                                <?= $e($bayar['tgl_wkt_byr']) ?>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Nominal Pembayaran</th>
                                            <td>
                                                <strong>
                                                    Rp <?= number_format(
                                                        (float) $bayar['nominal'],
                                                        0,
                                                        ',',
                                                        '.'
                                                    ) ?>
                                                </strong>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Metode Pembayaran</th>
                                            <td>
                                                <?= $e($bayar['mtode_byr']) ?>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Jenis Pembayaran</th>
                                            <td>
                                                <?= $e($bayar['jns_byr']) ?>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Status Pembayaran</th>
                                            <td>
                                                <span class="badge bg-<?= $warnaStatus ?>">
                                                    <?= $e($status) ?>
                                                </span>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Tanggal Mulai Sewa</th>
                                            <td>
                                                <?= $e($bayar['tgl_mulai']) ?>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Tanggal Selesai Sewa</th>
                                            <td>
                                                <?= $e($bayar['tgl_selesai']) ?>
                                            </td>
                                        </tr>

                                        <tr>
                                            <th>Status Penyewaan</th>
                                            <td>
                                                <?= $e($bayar['status_sewa']) ?>
                                            </td>
                                        </tr>

                                    </tbody>

                                </table>

                            </div>

                            <!-- Form Upload Bukti Transfer -->
                            <?php if (
                                $bayar['sttus_byr'] === 'pending' &&
                                $bayar['mtode_byr'] === 'transfer'
                            ) : ?>

                                <hr>

                                <h3 class="h5 text-success mb-3">
                                    <i class="fa fa-upload"></i>
                                    Upload Bukti Transfer
                                </h3>

                                <form
                                    action="<?= $e(site_url('pembayaran/upload-bukti')) ?>"
                                    method="POST"
                                    enctype="multipart/form-data"
                                >

                                    <input
                                        type="hidden"
                                        name="kode_bayar"
                                        value="<?= $e($bayar['kode_bayar']) ?>"
                                    >

                                    <div class="mb-3">

                                        <label
                                            for="ft_byr_<?= $e($bayar['kode_bayar']) ?>"
                                            class="form-label"
                                        >
                                            Pilih Bukti Transfer
                                        </label>

                                        <input
                                            type="file"
                                            name="ft_byr"
                                            id="ft_byr_<?= $e($bayar['kode_bayar']) ?>"
                                            class="form-control"
                                            accept=".jpg,.jpeg,.png,.webp"
                                            required
                                        >

                                        <div class="form-text">
                                            Format JPG, PNG, atau WEBP.
                                            Maksimal 5 MB.
                                        </div>

                                    </div>

                                    <button
                                        type="submit"
                                        class="btn btn-success"
                                    >
                                        <i class="fa fa-upload"></i>
                                        Upload Bukti Pembayaran
                                    </button>

                                </form>

                            <?php endif; ?>

                            <!-- Menampilkan Bukti Pembayaran -->
                            <?php if (!empty($bayar['ft_byr'])) : ?>

                                <hr>

                                <h3 class="h5 text-success mb-3">
                                    <i class="fa fa-image"></i>
                                    Bukti Pembayaran
                                </h3>

                                <img
                                    src="<?= $e(base_url(
                                        'uploads/bayar/' .
                                        rawurlencode(
                                            basename($bayar['ft_byr'])
                                        )
                                    )) ?>"
                                    alt="Bukti Pembayaran"
                                    class="img-fluid rounded border"
                                >

                            <?php endif; ?>

                        </div>
                    </div>

                <?php endforeach; ?>

            <?php else : ?>

                <div class="alert alert-info" role="alert">
                    <i class="fa fa-info-circle"></i>
                    Belum ada data pembayaran.
                </div>

            <?php endif; ?>

        </div>
    </div>

</section>

<?php

// Memanggil footer website penyewa.
require __DIR__ . '/../katalog/footer.php';

?>
