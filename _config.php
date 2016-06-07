<?php
// HTTP
define('HTTP_SERVER', 'http://demo14.unibix.ru/admin/');
define('HTTP_CATALOG', 'http://demo14.unibix.ru/');
define('HTTP_IMAGE', 'http://demo14.unibix.ru/image/');

// HTTPS
define('HTTPS_SERVER', 'http://demo14.unibix.ru/admin/');
define('HTTPS_CATALOG', 'http://demo14.unibix.ru/');
define('HTTPS_IMAGE', 'http://demo14.unibix.ru/image/');

// DIR
define('DIR_APPLICATION', '/var/www/dev/data/www/demo14.unibix.ru/admin/');
define('DIR_SYSTEM', '/var/www/dev/data/www/demo14.unibix.ru/system/');
define('DIR_DATABASE', '/var/www/dev/data/www/demo14.unibix.ru/system/database/');
define('DIR_LANGUAGE', '/var/www/dev/data/www/demo14.unibix.ru/admin/language/');
define('DIR_TEMPLATE', '/var/www/dev/data/www/demo14.unibix.ru/admin/view/template/');
define('DIR_CONFIG', '/var/www/dev/data/www/demo14.unibix.ru/system/config/');
define('DIR_IMAGE', '/var/www/dev/data/www/demo14.unibix.ru/image/');
define('DIR_CACHE', '/var/www/dev/data/www/demo14.unibix.ru/system/cache/');
define('DIR_DOWNLOAD', '/var/www/dev/data/www/demo14.unibix.ru/download/');
define('DIR_LOGS', '/var/www/dev/data/www/demo14.unibix.ru/system/logs/');
define('DIR_CATALOG', '/var/www/dev/data/www/demo14.unibix.ru/catalog/');

// AUTOLOGIN
define('AUTOLOGIN_USER', 'callcenter');
define('AUTOLOGIN_PASS', 'callcenter');

// DB
define('DB_DRIVER', 'mysql');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'demo14');
define('DB_PASSWORD', 'demo14');
define('DB_DATABASE', 'demo14');
define('DB_PREFIX', '');

// define('DB_DRIVER', 'mysql');
// define('DB_HOSTNAME', 'localhost');
// define('DB_USERNAME', 'root');
// define('DB_PASSWORD', '');
// define('DB_DATABASE', 'banzai');
define('DB_PREFIX', '');

// extra configs
define('NEW_ORDER_STATUS_ID', 1);
define('CONFIRM_ORDER_STATUS_ID', 2);
define('PREPARE_ORDER_STATUS_ID', 3);
define('COMPLETE_ORDER_STATUS_ID', 4);
define('CANCELED_ORDER_STATUS_ID', 5);
define('ORDER_NUM_RESET_HOUR', 9);
define('DELIVERY_TIME', 3600);
?>