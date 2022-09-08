<?php

// Version
define('VERSION', '2.1.0.1');

$sapi = php_sapi_name();

// Configuration
require_once(dirname(__FILE__) . "/../admin/config.php");

function log1($message)
{
	file_put_contents(DIR_LOGS . "neoseo_seogen.log", date("Y-m-d H:i:s - ") . $message . "\r\n", FILE_APPEND);
}

log1("Начинаем генерацию чпу и метаданных");

log1("Подключаем движок опенкарт");
// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Request
$request = new Request();
$registry->set('request', $request);

// Response
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$registry->set('response', $response);

// Config
$config = new Config();
$registry->set('config', $config);

// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);


// Store
// todo: сделать параметром
$config->set('config_store_id', 0);

// Settings
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE store_id = '0' OR store_id = '" . (int)$config->get('config_store_id') . "' ORDER BY store_id ASC");
foreach($query->rows as $result) {
	if (!$result['serialized']) {
		$config->set($result['key'], $result['value']);
	} else {
		$config->set($result['key'], json_decode($result['value'], true));
	}
}

$config->set('config_url', HTTP_SERVER);
$config->set('config_ssl', HTTPS_SERVER);

// Cache
$cache = new Cache('file');
$registry->set('cache', $cache);

// Session
//$session = new Session();
//$registry->set('session', $session);

// Language Detection
$languages = array();

$query = $db->query("SELECT * FROM " . DB_PREFIX . "language WHERE status = '1'");
foreach($query->rows as $result) {
	$languages[$result['code']] = $result;
}

$code = $config->get('config_language');
$config->set('config_language_id', $languages[$code]['language_id']);
$config->set('config_language', $languages[$code]['code']);

// Language
$language = new Language($languages[$code]['directory']);
$language->load($languages[$code]['directory']);
$registry->set('language', $language);

// Url
$url = new Url($config->get('config_url'), $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url'));
$registry->set('url', $url);

// Log
$log = new Log($config->get('config_error_filename'));
$registry->set('log', $log);

// Currency
$registry->set('currency', new Currency($registry));

// Tax
$registry->set('tax', new Tax($registry));

// Weight
$registry->set('weight', new Weight($registry));

// Length
$registry->set('length', new Length($registry));

function error_handler($errno, $errstr, $errfile, $errline)
{
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

	log1('Произошла ошибка PHP ' . $error . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
	return true;
}

// Error Handler
set_error_handler('error_handler');

log1("Инициализируем сео-компонент");

if (!$seo_type = $config->get('config_seo_url_type')) {
	$seo_type = 'SeoUrl';
}
$seoFile = DIR_CATALOG . 'controller/common/' . str_replace(array('../', '..', '..'), '', $seo_type) . '.php';
if (file_exists($seoFile)) {
	require_once($seoFile);
	$seoClass = 'ControllerCommon' . preg_replace('/[^a-zA-Z0-9]/', '', $seo_type);
	$seoController = new $seoClass($registry);
	$url->addRewrite($seoController);
}

putenv("SERVER_NAME=localhost"); // это чтобы почта работала
$loader->model('tool/neoseo_seogen');
log1("Запускаем задачу по расписанию");
$registry->get("model_tool_neoseo_seogen")->urlifyAll();
log1("Генерация окончена");

