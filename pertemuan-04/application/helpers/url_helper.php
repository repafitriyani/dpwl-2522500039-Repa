<?php

function base_url(string $uri = ''): string
{
    global $config;

    return rtrim($config['base_url'], '/') . '/' . ltrim($uri, '/');
}

function site_url(string $uri = ''): string
{
    global $config;

    $url = rtrim($config['base_url'], '/');

    if (!empty($config['index_page'])) {
        $url .= '/' . trim($config['index_page'], '/');
    }

    if ($uri !== '') {
        $url .= '/' . ltrim($uri, '/');
    }

    return $url;
}