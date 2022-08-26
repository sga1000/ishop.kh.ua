<?php
// Configuration
if (is_file(dirname(__FILE__)."/../admin/config_local.php")) {
	require_once(dirname(__FILE__)."/../admin/config_local.php");
} elseif (is_file(dirname(__FILE__)."/../admin/config.php")) {
	require_once(dirname(__FILE__)."/../admin/config.php");
} else {
	write_to_log("Отсутствует файл конфигурации");
	exit();
}
// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();

// Config
$config = new Config();
$registry->set('config', $config);

// Database
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);
$registry->set('db', $db);

// Settings
$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '0'");

foreach ($query->rows as $setting) {
	if (!$setting['serialized']) {
		$config->set($setting['key'], $setting['value']);
	} else {
		$config->set($setting['key'], json_decode($setting['value'], true));
	}
}

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

if($config->get('neoseo_novaposhta_status')){
	$loader->model('tool/neoseo_novaposhta');
	$model_tool_neoseo_novaposhta = $registry->get('model_tool_neoseo_novaposhta');
	$model_tool_neoseo_novaposhta->updateHandbook();
	write_to_log("Обновление справочников по CRON завершено");
	$model_tool_neoseo_novaposhta->trackAll();
	write_to_log("Обновление состояний отправлений по CRON завершено");

}

function write_to_log( $message ){
	$logile = DIR_LOGS . "neoseo_novaposhta.log";
	if (file_exists($logile) && filesize($logile) >= 10 * 1024 * 1024 /* Erase after 10 mb */) {
		unlink($logile);
		file_put_contents( $logile, date("Y-m-d H:i:s - ") . " Файл логов очищен и начат заново" . "\r\n", FILE_APPEND );
	}

	file_put_contents( $logile, date("Y-m-d H:i:s - ") . $message . "\r\n", FILE_APPEND );
}