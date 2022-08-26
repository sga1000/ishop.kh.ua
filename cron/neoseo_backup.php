<?php
$sapi = php_sapi_name();
//if (!in_array($sapi, array("cli")) )
//	die("WTF: $sapi");

function log1( $message) {
	global $config;
	file_put_contents(DIR_LOGS."neoseo_backup.log" , date("Y-m-d H:i:s - ")."NeoSeo Backup ".$message."\r\n", FILE_APPEND );
}

// Configuration
if (is_file(dirname(__FILE__)."/../admin/config_local.php")) {
	require_once(dirname(__FILE__)."/../admin/config_local.php");
} elseif (is_file(dirname(__FILE__)."/../admin/config.php")) {
	require_once(dirname(__FILE__)."/../admin/config.php");
} else {
	log1("Отсутствует файл конфигурации");
	exit();
}

// Startup
require_once(DIR_SYSTEM.'startup.php');

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


// Store
// todo: сделать параметром
$config->set('config_store_id', 0);

// Settings
$query = $db->query("SELECT * FROM `".DB_PREFIX."setting` WHERE store_id = '0' OR store_id = '".(int)$config->get('config_store_id')."' ORDER BY store_id ASC");
foreach ($query->rows as $result) {
	if (!$result['serialized']) {
		$config->set($result['key'], $result['value']);
	} else {
		$config->set($result['key'], json_decode($result['value'],true));
	}
}

// Event
$event = new Event($registry);
$registry->set('event', $event);

// Event Register
if ($config->has('action_event')) {
	foreach ($config->get('action_event') as $key => $value) {
		$event->register($key, new Action($value));
	}
}

// Language Detection
$languages = array();

$query = $db->query("SELECT * FROM ".DB_PREFIX."language WHERE status = '1'");
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


$loader->model('tool/neoseo_backup');
$langData = $language->load('tool/neoseo_backup');

function error_handler($errno, $errstr, $errfile, $errline) {
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

	log1('PHP '.$error.':  '.$errstr.' in '.$errfile.' on line '.$errline);
	return true;
}

// Error Handler
set_error_handler('error_handler');

log1("INFO: Начинаем делать резервную копию по запросу от консоли");
putenv("SERVER_NAME=localhost"); // это чтобы почта работала
//$registry->dump();
//var_dump($registry->get("model_tool_neoseo_backup"));
$stat = $registry->get("model_tool_neoseo_backup")->doBackup($langData);
log1("INFO: Создание резервной копии завершено!");

