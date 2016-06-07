<?php
// HTTP
define('HTTP_SERVER', 'http://banzai-sushi.ru/admin/');
define('HTTP_CATALOG', 'http://banzai-sushi.ru/');
define('HTTP_IMAGE', 'http://banzai-sushi.ru/image/');

// HTTPS
define('HTTPS_SERVER', 'http://banzai-sushi.ru/admin/');
define('HTTPS_CATALOG', 'http://banzai-sushi.ru/');
define('HTTPS_IMAGE', 'http://banzai-sushi.ru/image/');

// DIR
define('DIR_APPLICATION', '/var/www/admin/data/www/banzai-sushi.ru/admin/');
define('DIR_SYSTEM', '/var/www/admin/data/www/banzai-sushi.ru/system/');
define('DIR_DATABASE', '/var/www/admin/data/www/banzai-sushi.ru/system/database/');
define('DIR_LANGUAGE', '/var/www/admin/data/www/banzai-sushi.ru/admin/language/');
define('DIR_TEMPLATE', '/var/www/admin/data/www/banzai-sushi.ru/admin/view/template/');
define('DIR_CONFIG', '/var/www/admin/data/www/banzai-sushi.ru/system/config/');
define('DIR_IMAGE', '/var/www/admin/data/www/banzai-sushi.ru/image/');
define('DIR_CACHE', '/var/www/admin/data/www/banzai-sushi.ru/system/cache/');
define('DIR_DOWNLOAD', '/var/www/admin/data/www/banzai-sushi.ru/download/');
define('DIR_LOGS', '/var/www/admin/data/www/banzai-sushi.ru/system/logs/');
define('DIR_CATALOG', '/var/www/admin/data/www/banzai-sushi.ru/catalog/');

// AUTOLOGIN
define('AUTOLOGIN_USER', 'callcenter');
define('AUTOLOGIN_PASS', 'callcenter');

// DB
define('DB_DRIVER', 'mysql');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'banzainew');
define('DB_PASSWORD', 'pKYg2c4x');
define('DB_DATABASE', 'banzainew');
define('DB_PREFIX', '');

// extra configs
define('CHANGE_ORDER_PASSWORD', '123');
define('NEW_ORDER_STATUS_ID', 1);
define('CONFIRM_ORDER_STATUS_ID', 2);
define('PREPARE_ORDER_STATUS_ID', 3);
define('COMPLETE_ORDER_STATUS_ID', 4);
define('CANCELED_ORDER_STATUS_ID', 5);
define('Z_INVISIBLE_ORDER_STATUS_ID', 6);
define('ORDER_NUM_RESET_HOUR', 8);
define('REPORT_HOUR', 23);
define('DELIVERY_TIME', 3600);
define('FREE_DELIVERY_TOTAL', 500);
define('FREE_DELIVERY_DISTANCE', 10000); // расстояние после которого все правила бесплатной доставки будут игнорироваться. используется для расчета доставки за пределы города
define('DELIVERY_PRICE', 15); // за 1 км
define('PREORDER_COFIRM_TIME', 10800); // время, когда оператор должен обработать предзаказ
define('COMPANY_ORIGIN', 'Калининград, ул. Сибирякова, 23Б');
define('CALLCENTER_EMAIL', 'zakaz@banzai-sushi.ru');
define('DIR_PDF', '/var/www/admin/data/www/banzai-sushi.ru/pdf/');
define('HTTP_PDF', 'http://banzai-sushi.ru/pdf/');

define('KEY_PRIVATE', 'MIIBVgIBADANBgkqhkiG9w0BAQEFAASCAUAwggE8AgEAAkEAwmwQsplxinKtXUrXvx6MsPrsQ17c5tG1LHZHel7w+w5wQaqTT6E9Z4oeYB5Ju7uFQxp03t8AgRFfU1sKIbkg4QIDAQABAkEAum4beNcwi9y5JttMlER8Dn0eLt/5HRB8FR16HvqJQ4KAVES9Np0M8tNmlnRpCYZBvSNVprjxPHcg+5VoArDjHQIhAPO3162UlnRROiQ2xu1ZG3XYJ9sMmviGDTx/MhjT7YcDAiEAzDhD3qpeHRkx8+eriFcTRBBdpiCqKFgOg4zqFXcZMUsCIQDGaYLy06bxJze4R8gHbqXGeKVp1YdMkIWyHLNCNzaG1QIgTOPGUfitNKF+2ElaoRu/yjmrONhFmKkG1erhW7Gaz58CIQC01CB1nGaou0JkyllDNwEShD+M6XCpzJMqvdMPNE33pA==');
define('KEY_PUBLIC', 'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAMJsELKZcYpyrV1K178ejLD67ENe3ObRtSx2R3pe8PsOcEGqk0+hPWeKHmAeSbu7hUMadN7fAIERX1NbCiG5IOECAwEAAQ==');
define('ACCOUNT', '1001390100000006');
define('TOKEN_NAME', 'BC_TOKEN');
?>