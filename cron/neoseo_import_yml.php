<?php
// Version
define('VERSION', '2.1.0.1');
define('CACHE_DRIVER', '');


// Configuration
require_once(dirname(__FILE__) . "/../admin/config.php");
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry=new Registry();


// Config
$config=new Config();
$registry->set('config', $config);

// Database
$db=new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
$registry->set('db', $db);

// Settings
$query=$db->query("SELECT * FROM " . DB_PREFIX . "setting");
foreach($query->rows as $setting) {
	if(!$setting['serialized']) {
		$config->set($setting['key'], $setting['value']);
	} else {
		$config->set($setting['key'], json_decode($setting['value'], true));
	}
}

// Loader
$loader=new Loader($registry);
$registry->set('load', $loader);

// Url
$url=new Url(HTTP_SERVER, $config->get('config_use_ssl') ? HTTPS_SERVER : HTTP_SERVER);
$registry->set('url', $url);

// Log
$log=new Log($config->get('config_error_filename'));
$registry->set('log', $log);

function log1($message)
{
	file_put_contents(DIR_LOGS . "neoseo_import_yml.log", date("Y-m-d H:i:s - ") . $message . "\r\n", FILE_APPEND);
}

// Error Handler
function error_handler($errno, $errstr, $errfile, $errline)
{
	
	if(0 === error_reporting())
		return TRUE;
	switch($errno) {
		case E_NOTICE:
		case E_USER_NOTICE:
			$error='Notice';
			break;
		case E_WARNING:
		case E_USER_WARNING:
			$error='Warning';
			break;
		case E_ERROR:
		case E_USER_ERROR:
			$error='Fatal Error';
			break;
		default:
			$error='Unknown';
			break;
	}
	log1('PHP ' . $error . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
	return TRUE;
}

// Error Handler
set_error_handler('error_handler');

// Request
$request=new Request();
$registry->set('request', $request);

// Response
$response=new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$registry->set('response', $response);

// Cache
$cache=new Cache('file');
$registry->set('cache', $cache);

// Session
$session=new Session();
$registry->set('session', $session);

// Language
$languages=array();

$query=$db->query("SELECT * FROM `" . DB_PREFIX . "language`");

foreach($query->rows as $result) {
	$languages[$result['code']]=$result;
}

$config->set('config_language_id', $languages[$config->get('config_language')]['language_id']);

// Language
$language=new Language($languages[$config->get('config_admin_language')]['directory']);
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
$event=new Event($registry);
$registry->set('event', $event);

$query=$db->query("SELECT * FROM " . DB_PREFIX . "event");

foreach($query->rows as $result) {
	$event->register($result['trigger'], $result['action']);
}

log1("INFO: Начинаем импорт по запросу от консоли");
putenv("SERVER_NAME=localhost"); // это чтобы почта работала
$loader->model("tool/neoseo_import_yml");

if (isset($argv[1])) {
	log1("INFO: Используем одиночный старт с параметром " . $argv[1]);
	$result=$registry->get("model_tool_neoseo_import_yml")->import($argv[1]);
}else{
	$result=$registry->get("model_tool_neoseo_import_yml")->imports();
}

log1("INFO: Импорты успешно выполнены!");

