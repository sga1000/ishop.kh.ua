<?php
// Version
define('VERSION', '2.1.0.2.1'); /* Fix version 02.04.2016 */


// Configuration
if (is_file('config_local.php')) {
	require_once('config_local.php');
} else if (is_file('config.php')) {
	require_once('config.php');
}

// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: install/index.php');
	exit;
}

if (file_exists($li = DIR_APPLICATION.'/controller/extension/lightning/gamma.php')) require_once($li); //Lightning

if(isset($_SERVER['HTTP_HOST']) && strpos(HTTPS_SERVER,$_SERVER['HTTP_HOST']) === false && $_SERVER['HTTP_HOST'] != ""){
	header("HTTP/1.0 404 Not Found");
	exit;
}



/* NeoSeo Profiler - begin
if (is_file(DIR_SYSTEM . 'storage/neoseo_profiler_enabled') && is_file(DIR_SYSTEM . 'engine/neoseo_profiler.php')) {
	require_once(DIR_SYSTEM . 'engine/neoseo_profiler.php');
	$GLOBALS['profiler'] = new NeoSeoProfiler();
	$begin = $GLOBALS['profiler']->page_started();
}
/* NeoSeo Profiler - end */

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
$db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);
$registry->set('db', $db);

// Store
if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) {
//if ((isset($_SERVER['HTTPS']) && ($_SERVER['HTTPS'] == 'on' || $_SERVER['HTTPS'] == '1' || $_SERVER['HTTPS']))){
	$store_query = $db->query("SELECT * FROM " . DB_PREFIX . "store WHERE REPLACE(`ssl`, 'www.', '') = '" . $db->escape('https://' . str_replace('www.', '', $_SERVER['HTTP_HOST']) . rtrim(dirname($_SERVER['PHP_SELF']), '/.\\') . '/') . "'");
} else {
	$store_query = $db->query("SELECT * FROM " . DB_PREFIX . "store WHERE REPLACE(`url`, 'www.', '') = '" . $db->escape('http://' . str_replace('www.', '', $_SERVER['HTTP_HOST']) . rtrim(dirname($_SERVER['PHP_SELF']), '/.\\') . '/') . "'");
}

if ($store_query->num_rows) {
	$config->set('config_store_id', $store_query->row['store_id']);
} else {
	$config->set('config_store_id', 0);
}

// Settings
$query = $db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE store_id = '0' OR store_id = '" . (int)$config->get('config_store_id') . "' ORDER BY store_id ASC");

foreach ($query->rows as $result) {
	if (!$result['serialized']) {
		$config->set($result['key'], $result['value']);
	} else {
		$config->set($result['key'], json_decode($result['value'], true));
	}
}

//optimisation start
$addPushes = function ($links, $type = "script"){
	global $config;
	$minify_status = $type == "script" ? 'neoseo_optimizer_minify_js' : 'neoseo_optimizer_minify_css';

	foreach ($links as $link){
		if($config->get($minify_status)){
			$link = "/media/" . (str_replace("/", "_", $link));
		}else{
			$link = "/" . $link;
		}
		$link = 'Link: <' . $link . '>; rel=preload; as='. $type;

		header($link, false);
	}
};
if($config->get('neoseo_optimizer_status')) {
	$mainScripts = [
		"catalog/view/javascript/jquery/jquery-2.1.1.min.js",
		"catalog/view/theme/neoseo_unistor/javascript/jquery-ui.min.js",
		"catalog/view/theme/neoseo_unistor/javascript/jquery.ui.touch-punch.min.js",
		"catalog/view/theme/neoseo_unistor/javascript/jquery.mousewheel.min.js",
		"catalog/view/theme/neoseo_unistor/javascript/neoseo_unistor.js",
		"catalog/view/javascript/bootstrap/js/bootstrap.min.js",
		"catalog/view/theme/neoseo_unistor/javascript/jquery.responsive_countdown.min.js"
	];
	$mainStyles = [
		"catalog/view/theme/neoseo_unistor/stylesheet/jquery-ui.css",
		//"catalog/view/javascript/bootstrap/css/bootstrap.min.css",
		"catalog/view/javascript/font-awesome/css/font-awesome.min.css",

	];

	$addPushes($mainScripts);
	$addPushes($mainStyles, "style");

	if (isset($_SERVER['HTTP_USER_AGENT']) && (strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'serpstat') !== false OR strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'lighthouse') !== false)) {
		$config->set('bot_lighthouse', true);
		//$config->set('neoseo_microdata_status', false);
	}else{
		$config->set('bot_lighthouse', false);
	}
	$config->set('js_pushes', []);
	$config->set('css_pushes', []);
}
//optimisation end

if (!$store_query->num_rows) {
	$config->set('config_url', HTTP_SERVER);
	$config->set('config_ssl', HTTPS_SERVER);
}

// Url
$url = new Url($config->get('config_url'), $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url'));
$registry->set('url', $url);

// Log
$log = new Log($config->get('config_error_filename'));
$registry->set('log', $log);

function error_handler($code, $message, $file, $line) {
	global $log, $config;

	// error suppressed with @
	if (error_reporting() === 0) {
		return false;
	}

	switch ($code) {
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

	if ($config->get('config_error_display')) {
		echo '<b>' . $error . '</b>: ' . $message . ' in <b>' . $file . '</b> on line <b>' . $line . '</b>';
	}

	if ($config->get('config_error_log')) {
		$log->write('PHP ' . $error . ':  ' . $message . ' in ' . $file . ' on line ' . $line);
	}

	return true;
}

// Error Handler
set_error_handler('error_handler');

// Request
$request = new Request();
$registry->set('request', $request);

// Response
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$response->setCompression($config->get('config_compression'));
$registry->set('response', $response);

$uri = $_SERVER['REQUEST_URI'];
if(strpos($uri,'//') !== false){
	while (strpos($uri,'//') !== false){
		$uri = trim(str_replace('//','/',$uri),'/');
	}
	if($uri != '') $uri.='/';
	$response->redirect(HTTPS_SERVER.$uri,301);
}

// Cache
$cache = new Cache('file');
$registry->set('cache', $cache);

// Session
if (isset($request->get['token']) && isset($request->get['route']) && substr($request->get['route'], 0, 4) == 'api/') {
	$db->query("DELETE FROM `" . DB_PREFIX . "api_session` WHERE TIMESTAMPADD(HOUR, 1, date_modified) < NOW()");

	$query = $db->query("SELECT DISTINCT * FROM `" . DB_PREFIX . "api` `a` LEFT JOIN `" . DB_PREFIX . "api_session` `as` ON (a.api_id = as.api_id) LEFT JOIN " . DB_PREFIX . "api_ip `ai` ON (as.api_id = ai.api_id) WHERE a.status = '1' AND as.token = '" . $db->escape($request->get['token']) . "' AND ai.ip = '" . $db->escape($request->server['REMOTE_ADDR']) . "'");

	if ($query->num_rows) {
		// Does not seem PHP is able to handle sessions as objects properly so so wrote my own class
		$session = new Session($query->row['session_id'], $query->row['session_name']);
		$registry->set('session', $session);

		// keep the session alive
		$db->query("UPDATE `" . DB_PREFIX . "api_session` SET date_modified = NOW() WHERE api_session_id = '" . $query->row['api_session_id'] . "'");
	}
} else {
	$session = new Session();
	$registry->set('session', $session);
}

// Language Detection
$languages = array();

$query = $db->query("SELECT * FROM `" . DB_PREFIX . "language` WHERE status = '1'");

foreach ($query->rows as $result) {
	$languages[$result['code']] = $result;
}

if (isset($session->data['language']) && array_key_exists($session->data['language'], $languages)) {
	$code = $session->data['language'];
} elseif (isset($request->cookie['language']) && array_key_exists($request->cookie['language'], $languages)) {
	$code = $request->cookie['language'];
} else {
	$detect = '';

	if (isset($request->server['HTTP_ACCEPT_LANGUAGE']) && $request->server['HTTP_ACCEPT_LANGUAGE']) {
		$browser_languages = explode(',', $request->server['HTTP_ACCEPT_LANGUAGE']);

		foreach ($browser_languages as $browser_language) {
			foreach ($languages as $key => $value) {
				if ($value['status']) {
					$locale = explode(',', $value['locale']);

					if (in_array($browser_language, $locale)) {
						$detect = $key;
						break 2;
					}
				}
			}
		}
	}

	$code = $detect ? $detect : $config->get('config_language');
}

if (!isset($session->data['language']) || $session->data['language'] != $code) {
	$session->data['language'] = $code;
}

if (!isset($request->cookie['language']) || $request->cookie['language'] != $code) {
	setcookie('language', $code, time() + 60 * 60 * 24 * 30, '/', $request->server['HTTP_HOST']);
}

$config->set('config_language_id', $languages[$code]['language_id']);
$config->set('config_language', $languages[$code]['code']);

// Language
$language = new Language($languages[$code]['directory']);
$language->load($languages[$code]['directory']);
$registry->set('language', $language);

//MultiLanguage Settings
$langdata = $config->get('config_langdata');
if (isset($langdata[$languages[$code]['language_id']])) {
	foreach ($langdata[$languages[$code]['language_id']] as $key => $value) {
		$config->set('config_' . $key, $value);
	}
}

// Document
$registry->set('document', new Document());

// Customer
$customer = new Customer($registry);
$registry->set('customer', $customer);

// Customer Group
if ($customer->isLogged()) {
	$config->set('config_customer_group_id', $customer->getGroupId());
} elseif (isset($session->data['customer']) && isset($session->data['customer']['customer_group_id'])) {
	// For API calls
	$config->set('config_customer_group_id', $session->data['customer']['customer_group_id']);
} elseif (isset($session->data['guest']) && isset($session->data['guest']['customer_group_id'])) {
	$config->set('config_customer_group_id', $session->data['guest']['customer_group_id']);
}

// Tracking Code
if (isset($request->get['tracking'])) {
	setcookie('tracking', $request->get['tracking'], time() + 3600 * 24 * 1000, '/');

	$db->query("UPDATE `" . DB_PREFIX . "marketing` SET clicks = (clicks + 1) WHERE code = '" . $db->escape($request->get['tracking']) . "'");
}

// Affiliate
$registry->set('affiliate', new Affiliate($registry));

// Currency
$registry->set('currency', new Currency($registry));

// Tax
$registry->set('tax', new Tax($registry));

// Weight
$registry->set('weight', new Weight($registry));

// Length
$registry->set('length', new Length($registry));

// Cart
$registry->set('cart', new Cart($registry));

// Encryption
$registry->set('encryption', new Encryption($config->get('config_encryption')));

// OpenBay Pro
$registry->set('openbay', new Openbay($registry));

// Event
$event = new Event($registry);
$registry->set('event', $event);

$query = $db->query("SELECT * FROM " . DB_PREFIX . "event");

foreach ($query->rows as $result) {
	$event->register($result['trigger'], $result['action']);
}

// Front Controller
$controller = new Front($registry);

/* NeoSeo Fast Sitemap - begin */
if( isset($request->get["route"]) && $request->get["route"] == "feed/neoseo_fast_sitemap" ) {
	if (!$seo_type = $config->get('config_seo_url_type')) {
		$seo_type = 'seo_url';
	}
	$seoFile = DIR_APPLICATION . 'controller/common/' . str_replace(array('../', '..', '..'), '', $seo_type) . '.php';
	if (file_exists($seoFile)) {
		require_once($seoFile);
		$seoClass = 'ControllerCommon' . preg_replace('/[^a-zA-Z0-9]/', '', $seo_type);
		$seoController = new $seoClass($registry);
		$url->addRewrite($seoController);
	}
	$action = new Action($request->get['route']);
	$controller->dispatch($action, new Action('error/not_found'));
	$response->output();
	return;
}
/* NeoSeo Fast Sitemap - end */

// Maintenance Mode
$controller->addPreAction(new Action('common/maintenance'));

// SEO URL's
if (!$seo_type = $config->get('config_seo_url_type')) {
	$seo_type = 'seo_url';
}

$controller->addPreAction(new Action('common/' . $seo_type));

// Router
if (isset($request->get['route'])) {
	$action = new Action($request->get['route']);
} else {
	$action = new Action('common/home');
}

// Dispatch
$controller->dispatch($action, new Action('error/not_found'));

//header("Cache-control: max-age=31536000");

// Output
$response->output();

/* NeoSeo Profiler - begin
if (isset($GLOBALS['profiler'])) {
	$GLOBALS['profiler']->page_finished($begin);
}
/* NeoSeo Profiler - end */