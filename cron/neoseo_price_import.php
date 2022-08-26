<?php
define('JOURNAL_INSTALLED',1);
define('VERSION', '2.2.0.0');

$sapi = php_sapi_name();
//if( !in_array($sapi, array("cli") ) )
//    die("WTF: $sapi");

// Configuration
require_once(dirname(__FILE__) . "/../admin/config.php");

function log1($message)
{
	file_put_contents(DIR_LOGS . "neoseo_price_import.log", date("Y-m-d H:i:s - ") . $message . "\r\n", FILE_APPEND);
}

log1("Начинаем формирование экспорта по расписанию");

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
$config->load('default');
$config->load('admin');

// Database
$db = new DB($config->get('db_type'), $config->get('db_hostname'), $config->get('db_username'), $config->get('db_password'), $config->get('db_database'), $config->get('db_port'));
$registry->set('db', $db);

//settings
$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '0'");

foreach ($query->rows as $setting)
{
	if (!$setting['serialized'])
	{
		$config->set($setting['key'], $setting['value']);
	}
	else
	{
		$config->set($setting['key'], json_decode($setting['value'], true));
	}
}

$registry->set('config', $config);

// Session
if ($config->get('session_autostart')) {
	$session = new Session();
	$session->start();
	$registry->set('session', $session);
}

// Cache
$registry->set('cache', new Cache($config->get('cache_type'), $config->get('cache_expire')));

// Url
$registry->set('url', new Url($config->get('site_ssl')));


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

// Document
$registry->set('document', new Document());

// Event
$event = new Event($registry);
$registry->set('event', $event);

// Event Register
if ($config->has('action_event')) {
	foreach ($config->get('action_event') as $key => $value) {
		$event->register($key, new Action($value));
	}
}

// Config Autoload
if ($config->has('config_autoload')) {
	foreach ($config->get('config_autoload') as $value) {
		$loader->config($value);
	}
}

// Language Autoload
if ($config->has('language_autoload')) {
	foreach ($config->get('language_autoload') as $value) {
		$loader->language($value);
	}
}

// Library Autoload
if ($config->has('library_autoload')) {
	foreach ($config->get('library_autoload') as $value) {
		$loader->library($value);
	}
}

// Model Autoload
if ($config->has('model_autoload')) {
	foreach ($config->get('model_autoload') as $value) {
		$loader->model($value);
	}
}

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
$seoFile = DIR_APPLICATION . 'controller/common/' . str_replace(array('../', '..', '..'), '', $seo_type) . '.php';
if (file_exists($seoFile)) {
	require_once($seoFile);
	$seoClass = 'ControllerCommon' . preg_replace('/[^a-zA-Z0-9]/', '', $seo_type);
	$seoController = new $seoClass($registry);
	$url->addRewrite($seoController);
}

putenv("SERVER_NAME=localhost"); // это чтобы почта работала
log1("Загружаем модуль обновления цен");
$loader->model('tool/neoseo_price_import');
log1("Запускаем обновление цен");
$registry->get("model_tool_neoseo_price_import")->process();

