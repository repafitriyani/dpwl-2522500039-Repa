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
            error_log(
                'Tampilan pembayaran gagal: ' . $e->getMessage()
            );

            http_response_code(500);
            exit(
                'Halaman pembayaran belum dapat ditampilkan. Silakan coba kembali.'
            );
        }
    }

    // Memproses upload bukti pembayaran oleh penyewa.
    public function uploadBukti(): void
    {
        $userPlg = $this->wajibLoginPenyewa();
        $this->wajibMetode('POST');

        $kodeBayar = trim(
            (string) ($_POST['kode_bayar'] ?? '')
        );

        if ($kodeBayar === '') {
            $this->redirectDenganPesan(
                'error',
                'Kode pembayaran wajib diisi.'
            );
        }

        try {
            $dataBayar = $this->pembayaranModel
                ->getPembayaranByKode($kodeBayar, $userPlg);

            if ($dataBayar === null) {
                $this->redirectDenganPesan(
                    'error',
                    'Data pembayaran tidak ditemukan.'
                );
            }

            if (
                $dataBayar['sttus_byr'] !== 'pending' ||
                $dataBayar['mtode_byr'] !== 'transfer'
            ) {
                $this->redirectDenganPesan(
                    'error',
                    'Pembayaran ini tidak dapat diunggah kembali.'
                );
            }

            if (
                !isset($_FILES['ft_byr']) ||
                !is_array($_FILES['ft_byr'])
            ) {
                $this->redirectDenganPesan(
                    'error',
                    'Bukti transfer wajib diunggah.'
                );
            }

            $file = $_FILES['ft_byr'];

            if ($file['error'] !== UPLOAD_ERR_OK) {
                $this->redirectDenganPesan(
                    'error',
                    'Upload bukti transfer gagal. Silakan pilih file kembali.'
                );
            }

            // Ukuran maksimal 5 MB.
            if (
                $file['size'] <= 0 ||
                $file['size'] > 5 * 1024 * 1024
            ) {
                $this->redirectDenganPesan(
                    'error',
                    'Ukuran bukti transfer maksimal 5 MB.'
                );
            }

            // Memeriksa MIME file.
            $finfo = new finfo(FILEINFO_MIME_TYPE);
            $mime = $finfo->file($file['tmp_name']);

            $tipeDiizinkan = [
                'image/jpeg' => 'jpg',
                'image/png' => 'png',
                'image/webp' => 'webp'
            ];

            if (!isset($tipeDiizinkan[$mime])) {
                $this->redirectDenganPesan(
                    'error',
                    'Format file harus JPG, PNG, atau WEBP.'
                );
            }

            // Membuat folder upload jika belum tersedia.
            $folderUpload = FCPATH . 'uploads/bayar/';

            if (
                !is_dir($folderUpload) &&
                !mkdir($folderUpload, 0755, true) &&
                !is_dir($folderUpload)
            ) {
                throw new RuntimeException(
                    'Folder upload bukti pembayaran gagal dibuat.'
                );
            }

            // Membuat nama file acak.
            $namaFile = 'bukti_' .
                bin2hex(random_bytes(12)) .
                '.' . $tipeDiizinkan[$mime];

            $tujuanFile = $folderUpload . $namaFile;

            if (!move_uploaded_file(
                $file['tmp_name'],
                $tujuanFile
            )) {
                throw new RuntimeException(
                    'File bukti transfer gagal disimpan.'
                );
            }

            // Menyimpan nama file ke database.
            $berhasil = $this->pembayaranModel->simpanBukti(
                $kodeBayar,
                $userPlg,
                $namaFile
            );

            if (!$berhasil) {
                if (is_file($tujuanFile)) {
                    unlink($tujuanFile);
                }

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
            error_log(
                'Upload bukti pembayaran gagal: ' . $e->getMessage()
            );

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
            $pembayaran = $this->pembayaranModel
                ->getDaftarVerifikasi();

            $flash = $_SESSION['flash_pembayaran_admin'] ?? null;
            unset($_SESSION['flash_pembayaran_admin']);

            $this->view('admin/pembayaran_verifikasi', [
                'pembayaran' => $pembayaran,
                'flash' => $flash
            ]);

        } catch (Throwable $e) {
            error_log(
                'Daftar verifikasi pembayaran gagal: ' . $e->getMessage()
            );

            http_response_code(500);
            exit(
                'Daftar pembayaran belum dapat ditampilkan.'
            );
        }
    }

    // Memproses keputusan admin terhadap pembayaran.
    public function verifikasi(): void
    {
        require_admin_login();
        $this->wajibMetode('POST');

        $kodeBayar = trim(
            (string) ($_POST['kode_bayar'] ?? '')
        );

        $status = trim(
            (string) ($_POST['status'] ?? '')
        );

        if ($kodeBayar === '') {
            $this->redirectAdminDenganPesan(
                'error',
                'Kode pembayaran wajib diisi.'
            );
        }

        if (!in_array($status, ['valid', 'invalid'], true)) {
            $this->redirectAdminDenganPesan(
                'error',
                'Status verifikasi tidak valid.'
            );
        }

        try {
            $berhasil = $this->pembayaranModel->verifikasi(
                $kodeBayar,
                $status
            );

            if (!$berhasil) {
                $this->redirectAdminDenganPesan(
                    'error',
                    'Pembayaran gagal diverifikasi atau sudah diproses sebelumnya.'
                );
            }

            $pesan = $status === 'valid'
                ? 'Pembayaran berhasil dinyatakan valid.'
                : 'Pembayaran berhasil dinyatakan tidak valid.';

            $this->redirectAdminDenganPesan(
                'success',
                $pesan
            );

        } catch (Throwable $e) {
            error_log(
                'Verifikasi pembayaran gagal: ' . $e->getMessage()
            );

            $this->redirectAdminDenganPesan(
                'error',
                'Proses verifikasi gagal. Silakan coba kembali.'
            );
        }
    }

    // Memeriksa apakah penyewa sudah login.
    private function wajibLoginPenyewa(): string
    {
        $userPlg = trim(
            (string) ($_SESSION['penyewa_user_plg'] ?? '')
        );

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
        $metodeAktif = strtoupper(
            (string) ($_SERVER['REQUEST_METHOD'] ?? 'GET')
        );

        if ($metodeAktif !== $metodeDiizinkan) {
            http_response_code(405);
            header('Allow: ' . $metodeDiizinkan);
            exit('Method Not Allowed');
        }
    }

    // Redirect setelah proses pembayaran penyewa.
    private function redirectDenganPesan(
        string $jenis,
        string $pesan
    ): never {
        $_SESSION['flash_pembayaran'] = [
            'type' => $jenis,
            'message' => $pesan
        ];

        header('Location: ' . site_url('pembayaran'));
        exit;
    }

    // Redirect setelah proses verifikasi admin.
    private function redirectAdminDenganPesan(
        string $jenis,
        string $pesan
    ): never {
        $_SESSION['flash_pembayaran_admin'] = [
            'type' => $jenis,
            'message' => $pesan
        ];

        header('Location: ' . site_url('admin/pembayaran'));
        exit;
    }
}
