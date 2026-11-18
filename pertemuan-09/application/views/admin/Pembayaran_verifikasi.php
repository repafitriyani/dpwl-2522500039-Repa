<?php
require APPPATH . '/views/templates/header.php';
require APPPATH . '/views/templates/sidebar.php';

$pembayaran = $pembayaran ?? [];
$flash = $flash ?? null;

$flashClass = (($flash['type'] ?? '') === 'success')
    ? 'alert-success'
    : 'alert-danger';
?>

<!-- Content Wrapper -->
<div class="content-wrapper">

    <section class="content-header">
        <h1>
            Verifikasi Pembayaran
            <small>Manajemen pembayaran penyewa</small>
        </h1>

        <ol class="breadcrumb">
            <li>
                <a href="<?= htmlspecialchars(site_url('admin'), ENT_QUOTES, 'UTF-8') ?>">
                    <i class="fa fa-dashboard"></i> Dashboard
                </a>
            </li>
            <li class="active">Verifikasi Pembayaran</li>
        </ol>
    </section>

    <section class="content">

        <!-- Pesan notifikasi -->
        <?php if (is_array($flash) && !empty($flash['message'])): ?>
            <div class="alert <?= $flashClass ?> alert-dismissible">
                <button type="button" class="close"
                    data-dismiss="alert" aria-hidden="true">&times;</button>

                <i class="fa <?= (($flash['type'] ?? '') === 'success')
                    ? 'fa-check'
                    : 'fa-warning' ?>"></i>

                <?= htmlspecialchars(
                    $flash['message'],
                    ENT_QUOTES,
                    'UTF-8'
                ) ?>
            </div>
        <?php endif; ?>

        <!-- Daftar pembayaran -->
        <div class="box">

            <div class="box-header">
                <h3 class="box-title">
                    Daftar Pembayaran Menunggu Verifikasi
                </h3>
            </div>

            <div class="box-body">
                <div class="table-responsive">

                    <table class="table table-bordered table-striped js-data-table">

                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Kode Pembayaran</th>
                                <th>Nama Penyewa</th>
                                <th>Tanggal Sewa</th>
                                <th>Jenis Pembayaran</th>
                                <th>Nominal</th>
                                <th>Bukti Transfer</th>
                                <th>Status</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>

                        <tbody>

                            <?php if (empty($pembayaran)): ?>

                                <tr>
                                    <td colspan="9" class="text-center">
                                        Belum ada pembayaran yang menunggu verifikasi.
                                    </td>
                                </tr>

                            <?php else: ?>

                                <?php foreach ($pembayaran as $i => $row): ?>

                                    <tr>

                                        <td><?= (int) $i + 1 ?></td>

                                        <td>
                                            <?= htmlspecialchars(
                                                $row['kode_bayar'] ?? '',
                                                ENT_QUOTES,
                                                'UTF-8'
                                            ) ?>
                                        </td>

                                        <td>
                                            <?= htmlspecialchars(
                                                $row['nm_lngkp'] ?? '',
                                                ENT_QUOTES,
                                                'UTF-8'
                                            ) ?>
                                        </td>

                                        <td>
                                            <?= htmlspecialchars(
                                                (string) ($row['tgl_mulai'] ?? '-'),
                                                ENT_QUOTES,
                                                'UTF-8'
                                            ) ?>

                                            s/d

                                            <?= htmlspecialchars(
                                                (string) ($row['tgl_selesai'] ?? '-'),
                                                ENT_QUOTES,
                                                'UTF-8'
                                            ) ?>
                                        </td>

                                        <td>
                                            <?= htmlspecialchars(
                                                $row['jns_byr'] ?? '-',
                                                ENT_QUOTES,
                                                'UTF-8'
                                            ) ?>
                                        </td>

                                        <td>
                                            Rp <?= number_format(
                                                (float) ($row['nominal'] ?? 0),
                                                0,
                                                ',',
                                                '.'
                                            ) ?>
                                        </td>

                                        <td>
                                            <?php if (!empty($row['ft_byr'])): ?>

                                                <a
                                                    href="<?= htmlspecialchars(
                                                        base_url(
                                                            'uploads/bayar/' .
                                                            rawurlencode($row['ft_byr'])
                                                        ),
                                                        ENT_QUOTES,
                                                        'UTF-8'
                                                    ) ?>"
                                                    target="_blank"
                                                    rel="noopener noreferrer"
                                                    class="btn btn-info btn-xs">

                                                    <i class="fa fa-image"></i>
                                                    Lihat Bukti
                                                </a>

                                            <?php else: ?>

                                                <span class="text-danger">
                                                    Belum ada bukti
                                                </span>

                                            <?php endif; ?>
                                        </td>

                                        <td>
                                            <span class="label label-warning">
                                                <?= htmlspecialchars(
                                                    $row['sttus_byr'] ?? 'pending',
                                                    ENT_QUOTES,
                                                    'UTF-8'
                                                ) ?>
                                            </span>
                                        </td>

                                        <td>

                                            <?php if (
                                                !empty($row['ft_byr']) &&
                                                ($row['sttus_byr'] ?? '') === 'pending'
                                            ): ?>

                                                <!-- Tombol Valid -->
                                                <form
                                                    action="<?= htmlspecialchars(
                                                        site_url('admin/pembayaran/verifikasi'),
                                                        ENT_QUOTES,
                                                        'UTF-8'
                                                    ) ?>"
                                                    method="POST"
                                                    style="display:inline-block;"
                                                    onsubmit="return confirm('Yakin ingin menyatakan pembayaran ini VALID?');">

                                                    <input
                                                        type="hidden"
                                                        name="kode_bayar"
                                                        value="<?= htmlspecialchars(
                                                            $row['kode_bayar'],
                                                            ENT_QUOTES,
                                                            'UTF-8'
                                                        ) ?>">

                                                    <input
                                                        type="hidden"
                                                        name="status"
                                                        value="valid">

                                                    <button
                                                        type="submit"
                                                        class="btn btn-success btn-xs">

                                                        <i class="fa fa-check"></i>
                                                        Valid
                                                    </button>

                                                </form>

                                                <!-- Tombol Invalid -->
                                                <form
                                                    action="<?= htmlspecialchars(
                                                        site_url('admin/pembayaran/verifikasi'),
                                                        ENT_QUOTES,
                                                        'UTF-8'
                                                    ) ?>"
                                                    method="POST"
                                                    style="display:inline-block;"
                                                    onsubmit="return confirm('Yakin ingin menyatakan pembayaran ini INVALID?');">

                                                    <input
                                                        type="hidden"
                                                        name="kode_bayar"
                                                        value="<?= htmlspecialchars(
                                                            $row['kode_bayar'],
                                                            ENT_QUOTES,
                                                            'UTF-8'
                                                        ) ?>">

                                                    <input
                                                        type="hidden"
                                                        name="status"
                                                        value="invalid">

                                                    <button
                                                        type="submit"
                                                        class="btn btn-danger btn-xs">

                                                        <i class="fa fa-times"></i>
                                                        Invalid
                                                    </button>

                                                </form>

                                            <?php else: ?>

                                                <span class="text-muted">
                                                    Menunggu bukti transfer
                                                </span>

                                            <?php endif; ?>

                                        </td>

                                    </tr>

                                <?php endforeach; ?>

                            <?php endif; ?>

                        </tbody>

                    </table>

                </div>
            </div>

        </div>

    </section>

</div>

<?php
require APPPATH . '/views/templates/footer.php';
?>
