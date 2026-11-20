<?php

require_once APPPATH . 'models/Pembayaran_model.php';
require_once APPPATH . 'helpers/auth_helper.php';

class Pembayaran_controller extends Controller
{
    private Pembayaran_model $pembayaranModel;

    public function __construct()
    {
        $this->pembayaranModel = new Pembayaran_model();
    }

    // Menampilkan halaman pembayaran milik penyewa.
    public function index(): void
    {
        $userPlg = $this->wajibLoginPenyewa();
        $this->wajibMetode('GET');

        try {
            $pembayaran = $this->pembayaranModel
                ->getPembayaranPenyewa($userPlg);

            $flash = $_SESSION['flash_pembayaran'] ?? null;
            unset($_SESSION['flash_pembayaran']);

            $this->view('transaksi/pembayaran', [
                'pembayaran' => $pembayaran,
                'flash' => $flash
            ]);
        } catch (Throwable $e) {
            error_log('Tampilan pembayaran gagal: ' . $e->getMessage());

            http_response_code(500);
            exit('Halaman pembayaran belum dapat ditampilkan. Silakan coba kembali.');
        }
    }

    // Memproses upload bukti pembayaran oleh penyewa.
    public function uploadBukti(): void
    {
        $userPlg = $this->wajibLoginPenyewa();
        $this->wajibMetode('POST');

        $kodeBayar = trim((string) ($_POST['kode_bayar'] ?? ''));

        if ($kodeBayar === '') {
            $this->redirectDenganPesan('error', 'Kode pembayaran wajib diisi.');
        }

        $tujuanFile = null;

        try {
            $dataBayar = $this->pembayaranModel
                ->getPembayaranByKode($kodeBayar, $userPlg);

            if ($dataBayar === null) {
                $this->redirectDenganPesan('error', 'Data pembayaran tidak ditemukan.');
            }

            if (
                ($dataBayar['sttus_byr'] ?? '') !== 'pending' ||
                ($dataBayar['mtode_byr'] ?? '') !== 'transfer'
            ) {
                $this->redirectDenganPesan(
                    'error',
                    'Pembayaran ini tidak dapat diunggah kembali.'
                );
            }

            $hasilUpload = $this->simpanFileBukti('ft_byr');

            if (!$hasilUpload['success']) {
                $this->redirectDenganPesan('error', $hasilUpload['error']);
            }

            $namaFile = $hasilUpload['filename'];
            $tujuanFile = FCPATH . 'uploads/bayar/' . $namaFile;

            $berhasil = $this->pembayaranModel->simpanBukti(
                $kodeBayar,
                $userPlg,
                $namaFile
            );

            if (!$berhasil) {
                $this->hapusBuktiBaru($namaFile);
                $this->redirectDenganPesan(
                    'error',
                    'Bukti transfer belum berhasil disimpan.'
                );
            }

            $this->redirectDenganPesan(
                'success',
                'Bukti transfer berhasil diunggah dan menunggu verifikasi admin.'
            );
        } catch (Throwable $e) {
            error_log('Upload bukti pembayaran gagal: ' . $e->getMessage());

            if ($tujuanFile !== null && is_file($tujuanFile)) {
                unlink($tujuanFile);
            }

            $this->redirectDenganPesan(
                'error',
                'Bukti pembayaran belum berhasil diproses. Silakan coba kembali.'
            );
        }
    }

    // Menampilkan daftar pembayaran yang perlu diverifikasi admin.
    public function verifikasiIndex(): void
    {
        require_admin_login();
        $this->wajibMetode('GET');

        try {
            $pembayaran = $this->pembayaranModel->getDaftarVerifikasi();

            $flash = $_SESSION['flash_pembayaran_admin'] ?? null;
            unset($_SESSION['flash_pembayaran_admin']);

            $this->view('admin/pembayaran_verifikasi', [
                'pembayaran' => $pembayaran,
                'flash' => $flash
            ]);
        } catch (Throwable $e) {
            error_log('Daftar verifikasi pembayaran gagal: ' . $e->getMessage());

            http_response_code(500);
            exit('Daftar pembayaran belum dapat ditampilkan.');
        }
    }

    // Memproses keputusan admin terhadap pembayaran.
    public function verifikasi(): void
    {
        require_admin_login();
        $this->wajibMetode('POST');

        $kodeBayar = trim((string) ($_POST['kode_bayar'] ?? ''));
        $status = trim((string) ($_POST['status'] ?? ''));

        if ($kodeBayar === '') {
            $this->redirectAdminDenganPesan('error', 'Kode pembayaran wajib diisi.');
        }

        if (!in_array($status, ['valid', 'invalid'], true)) {
            $this->redirectAdminDenganPesan('error', 'Status verifikasi tidak valid.');
        }

        try {
            $berhasil = $this->pembayaranModel->verifikasi($kodeBayar, $status);

            if (!$berhasil) {
                $this->redirectAdminDenganPesan(
                    'error',
                    'Pembayaran gagal diverifikasi atau sudah diproses sebelumnya.'
                );
            }

            $pesan = $status === 'valid'
                ? 'Pembayaran berhasil dinyatakan valid.'
                : 'Pembayaran berhasil dinyatakan tidak valid.';

            $this->redirectAdminDenganPesan('success', $pesan);
        } catch (Throwable $e) {
            error_log('Verifikasi pembayaran gagal: ' . $e->getMessage());

            $this->redirectAdminDenganPesan(
                'error',
                'Proses verifikasi gagal. Silakan coba kembali.'
            );
        }
    }

    // P10: Menampilkan daftar transaksi yang masih memiliki kewajiban pelunasan.
    public function pelunasanIndex(): void
    {
        require_admin_login();
        $this->wajibMetode('GET');

        try {
            $daftarPelunasan = $this->pembayaranModel->getDaftarPelunasan();

            $flash = $_SESSION['flash_pembayaran_admin'] ?? null;
            unset($_SESSION['flash_pembayaran_admin']);

            $this->view('admin/pelunasan', [
                'username' => $_SESSION['admin_username'] ?? '',
                'daftarPelunasan' => $daftarPelunasan,
                'flash' => $flash
            ]);
        } catch (Throwable $e) {
            error_log('Daftar pelunasan gagal ditampilkan: ' . $e->getMessage());

            http_response_code(500);
            exit('Daftar transaksi pelunasan belum dapat ditampilkan. Silakan coba kembali.');
        }
    }

    // P10: Menampilkan detail transaksi, riwayat pembayaran, dan sisa kewajiban.
    public function pelunasanDetail(string $kodeSewa = ''): void
    {
        require_admin_login();
        $this->wajibMetode('GET');

        $kodeSewa = trim(str_replace('~', '/', $kodeSewa));

        if ($kodeSewa === '') {
            http_response_code(400);
            exit('Kode transaksi sewa wajib tersedia.');
        }

        try {
            $detailPelunasan = $this->pembayaranModel
                ->getDetailPelunasan($kodeSewa);

            if ($detailPelunasan === null) {
                http_response_code(404);
                exit('Transaksi sewa tidak ditemukan.');
            }

            $flash = $_SESSION['flash_pembayaran_admin'] ?? null;
            unset($_SESSION['flash_pembayaran_admin']);

            $this->view('admin/pelunasan_detail', [
                'username' => $_SESSION['admin_username'] ?? '',
                'detailPelunasan' => $detailPelunasan,
                'flash' => $flash
            ]);
        } catch (Throwable $e) {
            error_log('Detail pelunasan gagal ditampilkan: ' . $e->getMessage());

            http_response_code(500);
            exit('Detail transaksi pelunasan belum dapat ditampilkan. Silakan coba kembali.');
        }
    }

    /**
     * P10: Mencatat pelunasan yang diterima langsung oleh admin.
     * Tunai tidak memerlukan unggahan bukti.
     * Transfer menggunakan bukti yang diunggah admin.
     * Model menghitung sisa kewajiban dan menyimpan pembayaran secara transaksional.
     */
    public function prosesPelunasan(string $kodeSewa = ''): void
    {
        require_admin_login();
        $this->wajibMetode('POST');

        $kodeSewa = trim(str_replace('~', '/', $kodeSewa));
        $metodeBayar = trim((string) ($_POST['mtode_byr'] ?? ''));

        if ($kodeSewa === '') {
            http_response_code(400);
            exit('Kode transaksi sewa wajib tersedia.');
        }

        $tujuan = 'admin/pembayaran/pelunasan/' . str_replace('/', '~', $kodeSewa);

        if (!in_array($metodeBayar, ['tunai', 'transfer'], true)) {
            $this->redirectAdminDenganPesan(
                'error',
                'Metode pembayaran harus tunai atau transfer.',
                $tujuan
            );
        }

        $namaFileBukti = null;

        if ($metodeBayar === 'transfer') {
            $hasilUpload = $this->simpanFileBukti('ft_byr');

            if (!$hasilUpload['success']) {
                $this->redirectAdminDenganPesan(
                    'error',
                    $hasilUpload['error'],
                    $tujuan
                );
            }

            $namaFileBukti = $hasilUpload['filename'];
        }

        try {
            // Pemanggilan simpanPelunasan hanya dilakukan satu kali di dalam method.
            $kodeBayar = $this->pembayaranModel->simpanPelunasan(
                $kodeSewa,
                $metodeBayar,
                $namaFileBukti
            );

            $this->redirectAdminDenganPesan(
                'success',
                'Pelunasan berhasil dicatat dengan kode pembayaran ' . $kodeBayar
                    . '. Status pembayaran: valid; status transaksi: lunas.',
                $tujuan
            );
        } catch (InvalidArgumentException $e) {
            if ($namaFileBukti !== null) {
                $this->hapusBuktiBaru($namaFileBukti);
            }

            $this->redirectAdminDenganPesan('error', $e->getMessage(), $tujuan);
        } catch (Throwable $e) {
            error_log('Proses pelunasan gagal: ' . $e->getMessage());

            if ($namaFileBukti !== null) {
                $this->hapusBuktiBaru($namaFileBukti);
            }

            $this->redirectAdminDenganPesan(
                'error',
                'Pelunasan belum berhasil dicatat. Pastikan transaksi masih memiliki sisa kewajiban dan belum pernah dilunasi.',
                $tujuan
            );
        }
    }

    // P10: Menampilkan dokumen transaksi yang siap dicetak.
    public function dokumenTransaksi(string $kodeSewa = ''): void
    {
        require_admin_login();
        $this->wajibMetode('GET');

        $kodeSewa = trim(str_replace('~', '/', $kodeSewa));

        if ($kodeSewa === '') {
            http_response_code(400);
            exit('Kode transaksi sewa wajib tersedia.');
        }

        try {
            $detailPelunasan = $this->pembayaranModel
                ->getDetailPelunasan($kodeSewa);

            if ($detailPelunasan === null) {
                http_response_code(404);
                exit('Data transaksi tidak ditemukan.');
            }

            $this->view('admin/dokumen_transaksi', [
                'detailPelunasan' => $detailPelunasan
            ]);
        } catch (Throwable $e) {
            error_log('Dokumen transaksi gagal ditampilkan: ' . $e->getMessage());

            http_response_code(500);
            exit('Dokumen transaksi belum dapat ditampilkan. Silakan coba kembali.');
        }
    }

    // Memeriksa apakah penyewa sudah login.
    private function wajibLoginPenyewa(): string
    {
        $userPlg = trim((string) ($_SESSION['penyewa_user_plg'] ?? ''));

        if ($userPlg === '') {
            $_SESSION['flash_penyewa_nav'] =
                'Silakan login terlebih dahulu untuk mengakses pembayaran.';

            header('Location: ' . site_url('auth/login-penyewa'));
            exit;
        }

        return $userPlg;
    }

    // Membatasi metode request.
    private function wajibMetode(string $metodeDiizinkan): void
    {
        $metodeAktif = strtoupper((string) ($_SERVER['REQUEST_METHOD'] ?? 'GET'));

        if ($metodeAktif !== strtoupper($metodeDiizinkan)) {
            http_response_code(405);
            header('Allow: ' . strtoupper($metodeDiizinkan));
            exit('Method Not Allowed');
        }
    }

    /**
     * Memvalidasi dan menyimpan file bukti pembayaran.
     * Mengembalikan array success dan filename/error.
     */
    private function simpanFileBukti(string $namaInput): array
    {
        if (!isset($_FILES[$namaInput]) || !is_array($_FILES[$namaInput])) {
            return [
                'success' => false,
                'error' => 'Bukti transfer wajib diunggah.'
            ];
        }

        $file = $_FILES[$namaInput];

        if (($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
            return [
                'success' => false,
                'error' => 'Upload bukti transfer gagal. Silakan pilih file kembali.'
            ];
        }

        if (
            !isset($file['tmp_name'], $file['size']) ||
            !is_uploaded_file($file['tmp_name'])
        ) {
            return [
                'success' => false,
                'error' => 'File bukti transfer tidak valid.'
            ];
        }

        if ((int) $file['size'] <= 0 || (int) $file['size'] > 5 * 1024 * 1024) {
            return [
                'success' => false,
                'error' => 'Ukuran bukti transfer maksimal 5 MB.'
            ];
        }

        $finfo = new finfo(FILEINFO_MIME_TYPE);
        $mime = $finfo->file($file['tmp_name']);

        $tipeDiizinkan = [
            'image/jpeg' => 'jpg',
            'image/png' => 'png',
            'image/webp' => 'webp'
        ];

        if (!isset($tipeDiizinkan[$mime])) {
            return [
                'success' => false,
                'error' => 'Format file harus JPG, PNG, atau WEBP.'
            ];
        }

        $folderUpload = FCPATH . 'uploads/bayar/';

        if (
            !is_dir($folderUpload) &&
            !mkdir($folderUpload, 0755, true) &&
            !is_dir($folderUpload)
        ) {
            return [
                'success' => false,
                'error' => 'Folder upload bukti pembayaran gagal dibuat.'
            ];
        }

        $namaFile = 'bukti_' . bin2hex(random_bytes(12)) . '.' . $tipeDiizinkan[$mime];
        $tujuanFile = $folderUpload . $namaFile;

        if (!move_uploaded_file($file['tmp_name'], $tujuanFile)) {
            return [
                'success' => false,
                'error' => 'File bukti transfer gagal disimpan.'
            ];
        }

        return [
            'success' => true,
            'filename' => $namaFile
        ];
    }

    // Menghapus file bukti yang baru diunggah jika proses database gagal.
    private function hapusBuktiBaru(string $namaFile): void
    {
        // Hanya menerima nama file, bukan path dari input pengguna.
        $namaFile = basename($namaFile);
        $pathFile = FCPATH . 'uploads/bayar/' . $namaFile;

        if (is_file($pathFile)) {
            unlink($pathFile);
        }
    }

    // Redirect setelah proses pembayaran penyewa.
    private function redirectDenganPesan(string $jenis, string $pesan): never
    {
        $_SESSION['flash_pembayaran'] = [
            'type' => $jenis,
            'message' => $pesan
        ];

        header('Location: ' . site_url('pembayaran'));
        exit;
    }

    // Redirect setelah proses verifikasi dan pelunasan admin.
    private function redirectAdminDenganPesan(
        string $jenis,
        string $pesan,
        string $tujuan = 'admin/pembayaran'
    ): never {
        $_SESSION['flash_pembayaran_admin'] = [
            'type' => $jenis,
            'message' => $pesan
        ];

        header('Location: ' . site_url($tujuan));
        exit;
    }
}
