<?php
/**
 * Created by PhpStorm.
 * User: mikel
 * Date: 02.02.17
 * Time: 14:57
 */
$sapi = php_sapi_name();
//if( !in_array($sapi, array("cli") ) )
//    die("WTF: $sapi");

// Configuration
require_once(dirname(__FILE__) . "/../admin/config.php");
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

// Cache
if(!defined('CACHE_DRIVER')) {
	$cache = new Cache('file');
} else {
	$cache = new Cache(CACHE_DRIVER);
}
$registry->set('cache', $cache);
// Settings
$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '0'");

foreach ($query->rows as $setting) {
	if (!$setting['serialized']) {
		$config->set($setting['key'], $setting['value']);
	} else {
		$config->set($setting['key'], json_decode($setting['value'], true));
	}
}
//die(print_r($loader->get('model_localisation_neoseo_address'),1));
function getCities() {
	global $loader,$registry;
	// Справочник областей
	$areas = array(
		"CR" => "71508128-9b87-11de-822f-000c2965ae0e", // АРК
		"VI" => "71508129-9b87-11de-822f-000c2965ae0e", // Вінницька
		"VO" => "7150812a-9b87-11de-822f-000c2965ae0e", // Волинська
		"DN" => "7150812b-9b87-11de-822f-000c2965ae0e", // Дніпропетровська
		"DO" => "7150812c-9b87-11de-822f-000c2965ae0e", // Донецька
		"ZH" => "7150812d-9b87-11de-822f-000c2965ae0e", // Житомирська
		"ZK" => "7150812e-9b87-11de-822f-000c2965ae0e", // Закарпатська
		"ZA" => "7150812f-9b87-11de-822f-000c2965ae0e", // Запорізька
		"IV" => "71508130-9b87-11de-822f-000c2965ae0e", // Івано-Франківська
		"KV" => "71508131-9b87-11de-822f-000c2965ae0e", // Київська
		"KY" => "8d5a980d-391c-11dd-90d9-001a92567626", // Київ
		"KR" => "71508132-9b87-11de-822f-000c2965ae0e", // Кіровоградська
		"LU" => "71508133-9b87-11de-822f-000c2965ae0e", // Луганська
		"LV" => "71508134-9b87-11de-822f-000c2965ae0e", // Львівська
		"MY" => "71508135-9b87-11de-822f-000c2965ae0e", // Миколаївська
		"OD" => "71508136-9b87-11de-822f-000c2965ae0e", // Одеська
		"PO" => "71508137-9b87-11de-822f-000c2965ae0e", // Полтавська
		"RI" => "71508138-9b87-11de-822f-000c2965ae0e", // Рівненська
		"SU" => "71508139-9b87-11de-822f-000c2965ae0e", // Сумська
		"TE" => "7150813a-9b87-11de-822f-000c2965ae0e", // Тернопільська
		"KH" => "7150813b-9b87-11de-822f-000c2965ae0e", // Харківська
		"KE" => "7150813c-9b87-11de-822f-000c2965ae0e", // Херсонська
		"KM" => "7150813d-9b87-11de-822f-000c2965ae0e", // Хмельницька
		"CK" => "7150813e-9b87-11de-822f-000c2965ae0e", // Черкаська
		"CV" => "7150813f-9b87-11de-822f-000c2965ae0e", // Чернівецька
		"CH" => "71508140-9b87-11de-822f-000c2965ae0e", // Чернігівська
	);
	$loader->model('localisation/zone');

	$model = new ModelLocalisationZone($registry);
	$zones_by_area = array();
	foreach( $model->getZones() as $zone ) {
		if( !isset($areas[$zone['code']]) ) {
			continue;
		}
		$zones_by_area[$areas[$zone['code']]] = $zone['zone_id'];
	}

	// Справочник городов
	$curl = curl_init();
	if( !$curl ) {
		log1('Curl initialization problems!');
		exit();
	}

	$data_string = '
		{
			"modelName": "Address", 
			"calledMethod": "getCities",
			"apiKey": "d009d7a3cec37675f4fbc2c76bf39222"
		}';
	$url = 'https://api.novaposhta.ua/v2.0/json/AddressGeneral/getWarehouses';
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_HTTPHEADER,array(
		'Content-Type: application/json',
		'Content-Length: ' . strlen($data_string)
	));
	curl_setopt($curl, CURLOPT_RETURNTRANSFER,true);
	curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
	curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
	$response_raw = curl_exec($curl);
	curl_close($curl);

	$result = array();
	$response = json_decode($response_raw);

	foreach ($response->data as $city) {
		if( isset($zones_by_area[$city->Ref]) ) {
			// Киев это отдельная область
			$result[$city->Ref] = $zones_by_area[$city->Ref];
			continue;
		}

		if( isset($zones_by_area[$city->Area]) ) {
			$result[$city->Ref] = $zones_by_area[$city->Area];
			continue;
		}
	}


	return $result;
}
function log1( $message ){
	global $config;
	file_put_contents(DIR_LOGS . "neoseo_address_refresh.log" , date("Y-m-d H:i:s - ") . "NeoSeo Localization Address Refresh " . $message . "\r\n", FILE_APPEND );
}

// Справочник городов
$cities = getCities();
if( !$cities ) {
	log1('Getting cities error!');
	exit();
}

// Обновляем адреса согласно новой почте
$curl = curl_init();
if( !$curl ) {
	log1('Curl initialization error!');
	exit();
}

$data_string = '
		{
			"modelName": "AddressGeneral", 
			"calledMethod": "getWarehouses", 
			"apiKey": "d009d7a3cec37675f4fbc2c76bf39222"
		}';
$url = 'https://api.novaposhta.ua/v2.0/json/AddressGeneral/getWarehouses';
curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_HTTPHEADER,array(
	'Content-Type: application/json',
	'Content-Length: ' . strlen($data_string)
));
curl_setopt($curl, CURLOPT_RETURNTRANSFER,true);
curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
$response_raw = curl_exec($curl);
curl_close($curl);

if( !$response_raw) {
	log1('No responce!');
	exit();
}

// Интеллектуальный детект языков
$russian_language_id = 1;
$ukrainian_language_id = 3;
$query = $db->query('SELECT * FROM ' . DB_PREFIX .'language');
$languages = $query->rows;
foreach( $languages as $language ) {
	if( $language['code'] == "ru" ) {
		$russian_language_id = $language['language_id'];
	} else if( $language['code'] == "ua" || $language['code'] == "uk" ) {
		$ukrainian_language_id = $language['language_id'];
	}
}


$loader->model('localisation/neoseo_address');
$model_localisation_neoseo_address = new ModelLocalisationNeoSeoAddress($registry);

$shipping_methods = $config->get('neoseo_checkout_shipping_novaposhta');
if(!is_array($shipping_methods)) $shipping_methods = array($shipping_methods);

$model_localisation_neoseo_address->clearAddresses($shipping_methods);

$response = json_decode($response_raw);
foreach($shipping_methods as $shipping_method) {
	reset($response->data);
	foreach ($response->data as $address)
	{
		if( $address->TypeOfWarehouse != "841339c7-591a-42e2-8233-7a0a00f0ed6f" &&
			$address->TypeOfWarehouse != "9a68df70-0267-42a8-bb5c-37f427e36ee4" ) {
			continue;
		}
		// "6f8c7162-4b72-4b0a-88e5-906948c6a92f" - "Parcel Shop"
		// "841339c7-591a-42e2-8233-7a0a00f0ed6f" - "Поштове відділення"
		// "95dc212d-479c-4ffb-a8ab-8c1b9073d0bc" - "Поштомат приват банку"
		// "9a68df70-0267-42a8-bb5c-37f427e36ee4" - "Вантажне відділення"
		// "cab18137-df1b-472d-8737-22dd1d18b51d" - "Поштомат InPost"
		// "f9316480-5f2d-425d-bc2c-ac7cd29decf0" - "Поштомат"

		$data = array();
		$data['name'] = htmlspecialchars($address->DescriptionRu);
		$zone_id = 0;
		if( isset($cities[$address->CityRef])) {
			$zone_id = $cities[$address->CityRef];
		}
		$data['zone_id'] = $zone_id;
		$data['cities'] = array(
			$russian_language_id => htmlspecialchars(trim(preg_replace('/([\(][\s.\W]*[\)])/', '', $address->CityDescriptionRu))),
			$ukrainian_language_id => htmlspecialchars(trim(preg_replace('/([\(][\s.\W]*[\)])/', '', $address->CityDescription))),
		);
		$data['shipping_method'] = $shipping_method;
		$data['names'] = array(
			$russian_language_id => htmlspecialchars($address->DescriptionRu),
			$ukrainian_language_id => htmlspecialchars($address->Description),
		);
		$model_localisation_neoseo_address->addAddress($data);
	}
}
