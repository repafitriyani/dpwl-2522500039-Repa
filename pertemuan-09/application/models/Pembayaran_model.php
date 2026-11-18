<?php

class Pembayaran_model
{
    private mysqli $db;

    public function __construct()
    {
        global $db;
        $this->db = $db;
    }

    // Mengambil seluruh pembayaran milik penyewa yang sedang login.
    public function getPembayaranPenyewa(string $userPlg): array
    {
        $stmt = $this->db->prepare(
            "SELECT
                b.kode_bayar,
                b.tgl_wkt_byr,
                b.ft_byr,
                b.mtode_byr,
                b.jns_byr,
                b.nominal,
                b.sttus_byr,
                b.tgl_wkt_ver,
                b.kode_sewa,
                s.tgl_mulai,
                s.tgl_selesai,
                s.status_sewa
            FROM t_bayar b
            INNER JOIN t_sewa s
                ON s.kode_sewa = b.kode_sewa
            WHERE s.user_plg = ?
            ORDER BY b.tgl_wkt_byr DESC"
        );

        if (!$stmt) {
            throw new RuntimeException(
                'Data pembayaran gagal disiapkan.'
            );
        }

        $stmt->bind_param('s', $userPlg);

        if (!$stmt->execute()) {
            $stmt->close();

            throw new RuntimeException(
                'Data pembayaran gagal diambil.'
            );
        }

        $hasil = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
        $stmt->close();

        return $hasil;
    }

    // Memastikan pembayaran benar-benar milik penyewa.
    public function getPembayaranByKode(
        string $kodeBayar,
        string $userPlg
    ): ?array {
        $stmt = $this->db->prepare(
            "SELECT
                b.kode_bayar,
                b.ft_byr,
                b.nominal,
                b.sttus_byr,
                b.mtode_byr,
                b.jns_byr,
                b.kode_sewa,
                s.status_sewa
            FROM t_bayar b
            INNER JOIN t_sewa s
                ON s.kode_sewa = b.kode_sewa
            WHERE b.kode_bayar = ?
                AND s.user_plg = ?
            LIMIT 1"
        );

        if (!$stmt) {
            throw new RuntimeException(
                'Pencarian pembayaran gagal disiapkan.'
            );
        }

        $stmt->bind_param('ss', $kodeBayar, $userPlg);

        if (!$stmt->execute()) {
            $stmt->close();

            throw new RuntimeException(
                'Pencarian pembayaran gagal dijalankan.'
            );
        }

        $hasil = $stmt->get_result()->fetch_assoc();
        $stmt->close();

        return $hasil ?: null;
    }

    // Menyimpan nama file bukti transfer.
    public function simpanBukti(
        string $kodeBayar,
        string $userPlg,
        string $namaFile
    ): bool {
        $stmt = $this->db->prepare(
            "UPDATE t_bayar b
            INNER JOIN t_sewa s
                ON s.kode_sewa = b.kode_sewa
            SET b.ft_byr = ?
            WHERE b.kode_bayar = ?
                AND s.user_plg = ?
                AND b.mtode_byr = 'transfer'
                AND b.sttus_byr = 'pending'"
        );

        if (!$stmt) {
            throw new RuntimeException(
                'Penyimpanan bukti pembayaran gagal disiapkan.'
            );
        }

        $stmt->bind_param(
            'sss',
            $namaFile,
            $kodeBayar,
            $userPlg
        );

        if (!$stmt->execute()) {
            $stmt->close();

            throw new RuntimeException(
                'Bukti pembayaran gagal disimpan.'
            );
        }

        $berhasil = $stmt->affected_rows === 1;
        $stmt->close();

        return $berhasil;
    }

    // Mengambil pembayaran transfer yang perlu diperiksa admin.
    public function getDaftarVerifikasi(): array
    {
        $stmt = $this->db->prepare(
            "SELECT
                b.kode_bayar,
                b.tgl_wkt_byr,
                b.ft_byr,
                b.mtode_byr,
                b.jns_byr,
                b.nominal,
                b.sttus_byr,
                b.kode_sewa,
                s.user_plg,
                s.tgl_mulai,
                s.tgl_selesai,
                p.nm_lngkp
            FROM t_bayar b
            INNER JOIN t_sewa s
                ON s.kode_sewa = b.kode_sewa
            INNER JOIN t_penyewa p
                ON p.user_plg = s.user_plg
            WHERE b.sttus_byr = 'pending'
                AND b.mtode_byr = 'transfer'
                AND b.ft_byr IS NOT NULL
                AND b.ft_byr <> ''
                AND s.status_sewa = 'diajukan'
            ORDER BY b.tgl_wkt_byr ASC"
        );

        if (!$stmt) {
            throw new RuntimeException(
                'Daftar verifikasi gagal disiapkan.'
            );
        }

        if (!$stmt->execute()) {
            $stmt->close();

            throw new RuntimeException(
                'Daftar verifikasi gagal diambil.'
            );
        }

        $hasil = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
        $stmt->close();

        return $hasil;
    }

    // Memproses penerimaan atau penolakan pembayaran oleh admin.
    public function verifikasi(
        string $kodeBayar,
        string $status
    ): bool {
        if (!in_array($status, ['valid', 'invalid'], true)) {
            throw new InvalidArgumentException(
                'Status verifikasi tidak valid.'
            );
        }

        $this->db->begin_transaction();

        try {
            // Mengunci dan mengambil data pembayaran serta penyewaan.
            $stmt = $this->db->prepare(
                "SELECT
                    b.kode_sewa,
                    b.sttus_byr,
                    b.mtode_byr,
                    b.ft_byr,
                    s.status_sewa
                FROM t_bayar b
                INNER JOIN t_sewa s
                    ON s.kode_sewa = b.kode_sewa
                WHERE b.kode_bayar = ?
                LIMIT 1
                FOR UPDATE"
            );

            if (!$stmt) {
                throw new RuntimeException(
                    'Pemeriksaan pembayaran gagal disiapkan.'
                );
            }

            $stmt->bind_param('s', $kodeBayar);

            if (!$stmt->execute()) {
                $stmt->close();

                throw new RuntimeException(
                    'Pemeriksaan pembayaran gagal dijalankan.'
                );
            }

            $data = $stmt->get_result()->fetch_assoc();
            $stmt->close();

            // Memastikan pembayaran memenuhi syarat verifikasi.
            if (
                $data === null ||
                $data['sttus_byr'] !== 'pending' ||
                $data['status_sewa'] !== 'diajukan' ||
                $data['mtode_byr'] !== 'transfer' ||
                empty($data['ft_byr'])
            ) {
                throw new RuntimeException(
                    'Pembayaran tidak ditemukan, belum memiliki bukti transfer, atau sudah diverifikasi.'
                );
            }

            // Mengubah status pembayaran.
            $stmt = $this->db->prepare(
                "UPDATE t_bayar
                SET
                    sttus_byr = ?,
                    tgl_wkt_ver = NOW()
                WHERE kode_bayar = ?
                    AND sttus_byr = 'pending'"
            );

            if (!$stmt) {
                throw new RuntimeException(
                    'Perubahan status pembayaran gagal disiapkan.'
                );
            }

            $stmt->bind_param('ss', $status, $kodeBayar);

            if (!$stmt->execute()) {
                $stmt->close();

                throw new RuntimeException(
                    'Status pembayaran gagal diperbarui.'
                );
            }

            $berhasil = $stmt->affected_rows === 1;
            $stmt->close();

            if (!$berhasil) {
                throw new RuntimeException(
                    'Status pembayaran tidak berhasil diubah.'
                );
            }

            // Mengubah status penyewaan sesuai hasil verifikasi.
            $statusSewa = $status === 'valid'
                ? 'disetujui'
                : 'ditolak';

            $kodeSewa = (string) $data['kode_sewa'];

            $stmt = $this->db->prepare(
                "UPDATE t_sewa
                SET status_sewa = ?
                WHERE kode_sewa = ?
                    AND status_sewa = 'diajukan'"
            );

            if (!$stmt) {
                throw new RuntimeException(
                    'Perubahan status penyewaan gagal disiapkan.'
                );
            }

            $stmt->bind_param('ss', $statusSewa, $kodeSewa);

            if (!$stmt->execute()) {
                $stmt->close();

                throw new RuntimeException(
                    'Status penyewaan gagal diperbarui.'
                );
            }

            $berhasil = $stmt->affected_rows === 1;
            $stmt->close();

            if (!$berhasil) {
                throw new RuntimeException(
                    'Status penyewaan tidak berhasil diubah.'
                );
            }

            // Menyimpan seluruh perubahan ke database.
            $this->db->commit();

            return true;

        } catch (Throwable $e) {
            // Membatalkan perubahan jika terjadi kesalahan.
            $this->db->rollback();
            throw $e;
        }
    }
}
