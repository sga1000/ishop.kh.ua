<?php

// Configuration
require_once(dirname(__FILE__) . "/../admin/config.php");
// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);

// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);
// For mail working
putenv("SERVER_NAME=localhost");

$config->set('config_store_id', 0);

// Settings
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE store_id = '0'");
foreach ($query->rows as $result) {
	if (!$result['serialized']) {
		$config->set($result['key'], $result['value']);
	} else {
		$config->set($result['key'], json_decode($result['value'],true));
	}
}

function log1( $message ){
	global $config;
	file_put_contents(DIR_LOGS . "neoseo_checkout.log" , date("Y-m-d H:i:s - ") . "NeoSeo Checkout " . $message . "\r\n", FILE_APPEND );
}

// Url
$url = new Url(HTTP_CATALOG, $config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG);
$registry->set('url', $url);

// Language Detection
$languages = array();

$query = $db->query("SELECT * FROM " . DB_PREFIX . "language WHERE status = '1'");
foreach ($query->rows as $result) {
	$languages[$result['code']] = $result;
}
$code = $config->get('config_language');

$config->set('config_language_id', $languages[$code]['language_id']);
$config->set('config_language', $languages[$code]['code']);
// Language
$language = new Language($languages[$code]['directory']);
$language->load('default');
$registry->set('language', $language);

// Event
$event = new Event($registry);
$registry->set('event', $event);

$loader->model('sale/neoseo_dropped_cart');
$model = $registry->get('model_sale_neoseo_dropped_cart');

$notified = array();

$dropped_carts = $model->getDroppedCarts();
//log1(print_r($dropped_carts,true));
foreach ($dropped_carts as $dropped_cart) {
	$res = $model->notify($dropped_cart['dropped_cart_id']);

	if ($res['status'] == 'ok') {
		$notified[] = $res['email'];
	}

	if ($res['status'] == 'error') {
		echo 'Error: ' . $res['message'];
	}
}

if ($dropped_carts) {
	echo sprintf("%s email(s) has been sent: %s\n", sizeof($notified),implode(', ', $notified));
} else {
	echo "No new dropped carts without notification has been found.\n";
}