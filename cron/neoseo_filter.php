<?php

// Version
define('VERSION', '2.1.0.1');

// Configuration
require_once(dirname(__FILE__) . "/../admin/config.php");
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();


// Config
$config = new Config();
$registry->set('config', $config);

// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);

$config->set('config_url', HTTP_CATALOG);
$config->set('config_ssl', HTTPS_CATALOG);

// Settings
$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting");
foreach ($query->rows as $setting) {
	if (!$setting['serialized']) {
		$config->set($setting['key'], $setting['value']);
	} else {
		$config->set($setting['key'], json_decode($setting['value'], true));
	}
}

// Url
$url = new Url($config->get('config_url'), $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url'));
$registry->set('url', $url);

// Log
$log = new Log($config->get('config_error_filename'));
$registry->set('log', $log);

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

function log1($message)
{
	file_put_contents(DIR_LOGS . "neoseo_filter.log", date("Y-m-d H:i:s - ") . " " . $message . "\r\n", FILE_APPEND);
}

// Error Handler
function error_handler($errno, $errstr, $errfile, $errline)
{

	if (0 === error_reporting())
		return TRUE;
	switch ($errno) {
		case E_NOTICE:
		case E_USER_NOTICE:
			$error = 'Notice';
			break;
		case E_WARNING:
		case E_USER_WARNING:
			$error = 'Warning';
			break;
		case E_ERROR:
		case E_USER_ERROR:
			$error = 'Fatal Error';
			break;
		default:
			$error = 'Unknown';
			break;
	}
	log1('PHP ' . $error . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
	return TRUE;
}

// Error Handler
set_error_handler('error_handler');

// Request
$request = new Request();
$registry->set('request', $request);

// Response
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$registry->set('response', $response);

// Cache
$cache = new Cache('file');
$registry->set('cache', $cache);

// Session
$session = new Session();
$registry->set('session', $session);

// Language
$languages = array();

$query = $db->query("SELECT * FROM `" . DB_PREFIX . "language`");

foreach ($query->rows as $result) {
	$languages[$result['code']] = $result;
}

$config->set('config_language_id', $languages[$config->get('config_language')]['language_id']);

// Language
$language = new Language($languages[$config->get('config_admin_language')]['directory']);
$language->load($languages[$config->get('config_admin_language')]['directory']);
$registry->set('language', $language);

// Document
$registry->set('document', new Document());

// Currency
$registry->set('currency', new Currency($registry));

// Weight
$registry->set('weight', new Weight($registry));

// Length
$registry->set('length', new Length($registry));

// User
$registry->set('user', new User($registry));

// Event
$event = new Event($registry);
$registry->set('event', $event);

$query = $db->query("SELECT * FROM " . DB_PREFIX . "event");

foreach ($query->rows as $result) {
	$event->register($result['trigger'], $result['action']);
}

// Front Controller
$controller = new Front($registry);

log1("Копирование данных по крону");
// Router 
if (isset($argv[1])) {
	switch ($argv[1]) {
		case 'copy_from_ocfilter':
			log1("Запущено копирование данных с OcFilter");
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->copyFromOcFilter();
			log1("Копирование завершено");
			echo "copy_from_ocfilter success\n";
			break;

		case 'copy_attributes':
			log1("Запущено копирование данных с атрибутов товаров");
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->copyAttributes();
			log1("Копирование завершено");
			echo "copy_attributes success\n";
			break;

		case 'copy_options':
			log1("Запущено копирование данных с опций товаров");
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->copyOptions();
			log1("Копирование завершено");
			echo "copy_options success\n";
			break;

		case 'copy_product_data':
			log1("Запущено копирование данных с товаров");
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->copyProductData();
			log1("Копирование завершено");
			echo "copy_product_data success\n";
			break;

		case 'copy_warehouse':
			log1("Запущено копирование данных со складов");
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->updateWarehouse();
			log1("Копирование завершено");
			echo "copy_product_data success\n";
			break;

		case 'copy_warehouse':
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->updateWarehouse();
			echo "copy_product_data success\n";
			break;

		default:
			echo "cron neoseo_filter\n";
	}
} elseif (isset($request->get['type'])) {
	switch ($request->get['type']) {
		case 'copy_from_ocfilter':
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->copyFromOcFilter();
			echo "copy_from_ocfilter success\n";
			break;

		case 'copy_attributes':
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->copyAttributes();
			echo "copy_attributes success\n";
			break;

		case 'copy_options':
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->copyOptions();
			echo "copy_options success\n";
			break;

		case 'copy_product_data':
			$loader->model("catalog/neoseo_filter");
			$result = $registry->get("model_catalog_neoseo_filter")->copyProductData();
			echo "copy_product_data success\n";
			break;

		default:
			echo "cron neoseo_filter\n";
	}
} else {
	echo "cron neoseo_filter\n";
}
?>
