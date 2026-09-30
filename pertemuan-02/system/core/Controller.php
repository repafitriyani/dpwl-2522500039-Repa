<?php 
class controller
{
    protected function view(string $view, array $data = []): void 
    {
        $file = APPPATH . 'views/' . $view . '.php';

        if (!is_file($file)) {
            http_respons_code(500);
            exit('view tidak ditemukan');
        }

        extract($data, EXTR_SKIP);
        require $file;
    }
}