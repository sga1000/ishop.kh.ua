<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoSeoLanguages extends NeoSeoModel {

	static public $default_language = -1;

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_seo_languages";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;

		$code = $this->config->get("config_language");
		$this->switchLocale($code);
	}

	public function getDefaultLanguage(){
		if( self::$default_language != -1 ) {
			return self::$default_language;
		}
		$query = $this->db->query("SELECT value as code FROM `" . DB_PREFIX . "setting` WHERE (store_id = '0' OR store_id = '" . (int)$this->config->get('config_store_id') . "') AND `key`='config_language' LIMIT 1");
		if( !$query->num_rows) {
			self::$default_language = "";
			return self::$default_language;
		}

		self::$default_language = $query->row['code'];
		return self::$default_language;
	}

	public function switchLocale($code){
		// Если эта конструкция в упор не хочет работать, а точнее setlocale возвращает bool(false),
		// то значит вы не установили локализацию. Делаем так:
		// apt-get -y install language-pack-ru> /dev/null
		// locale-gen ru_RU ru_RU.UTF-8 > /dev/null
		// затем так
		// echo 'LC_ALL="ru_RU.UTF-8"' >> /etc/environment
		// и затем перезапуск сервера ( ну или сервисов, и вход\выход в ssh )

		switch ($code) {
			case 'ru':
				setlocale(LC_ALL, 'ru_RU.UTF-8');
				break;
			case 'en':
				setlocale(LC_ALL, 'en_US.UTF-8');
				break;
			case 'uk':
				setlocale(LC_ALL, 'uk_UA.UTF-8');
				break;
		}

	}
	public function initLanguage($code){

		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();

		// Localisation Language
		$language = new Language($languages[$code]['directory']);
		$language->load($languages[$code]['directory']);
		$this->registry->set('language', $language);

		// Session Language
		$this->config->set("config_language",$code);
		$this->config->set("config_language_id",$languages[$code]['language_id']);
		$this->session->data['language'] = $code;

		// Switch Locale
		$this->switchLocale($code);

	}

	public function getActiveLanguages(){
		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();

		$result = array();
		foreach($languages as $language){
			$result[] = $language['code'];
		}

		return $result;
	}

	public function insertLanguage($url, $code) {

		if( $code == $this->getDefaultLanguage() ) {
			return $url;
		}

		$result = $url;
		$base_url = rtrim(($this->request->server['HTTPS'] ? HTTPS_SERVER : HTTP_SERVER), "/");
		$rest_url = "/" . ltrim(str_replace($base_url, "", $url), "/");
		$rest_url_parts = explode("/",ltrim($rest_url,"/"));

		if( $rest_url_parts[0] != $code ) {
			$result = $base_url . "/" . $code . $rest_url;
		}
		return $result;
	}

	public function processCommonLanguage($data){

		$data['languages'] = array();
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE (store_id = '0' OR store_id = '" . (int)$this->config->get('config_store_id') . "') AND `key`='config_language' LIMIT 1");
		if( $query->num_rows) {
			$default_language = $query->row['value'];
		} else {
			$default_language = $this->config->get("config_language");
		}
		$base_url = rtrim(( $this->request->server['HTTPS'] ? HTTPS_SERVER : HTTP_SERVER ), "/");
		$this->load->model('localisation/language');
		$results = $this->model_localisation_language->getLanguages();
		foreach ($results as $result) {
			if ($result['status']) {
				$url = "/". ltrim(str_replace($base_url,"",$data['redirect']),"/");
				$explode_url = explode('/', $url);
				if(in_array($this->session->data['language'], $explode_url) && strpos($url,"/" . $this->session->data['language'] ) === 0 ) {
					$url = str_replace("/" . $this->session->data['language']."/","/",$url);
				}
				if( $result['code'] != $default_language ) {
					$url = "/" . $result['code'] . $url;
				}
				$data['languages'][] = array(
					'name'  => $result['name'],
					'code'  => $result['code'],
					'url'  => $base_url . $url,
					'image' => $result['image'],
				);
			}
		}
		return $data;
	}

	public function processCommonHeader($data){

		$currentLanguage = $this->config->get("config_language");
		$defaultLanguage = $this->getDefaultLanguage();
		if( $currentLanguage == $defaultLanguage ) {
			$data['current_language'] = '';
		} else {
			$data['current_language'] = $currentLanguage . "/";
		}

		$language_id = $this->config->get('config_language_id');
		$lang_data = $this->config->get('config_langdata');
		$this->config->set('config_name',$lang_data[$language_id]['name']);

		// Ссылки hreflang
		$data['languages'] = array();
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "setting` WHERE (store_id = '0' OR store_id = '" . (int)$this->config->get('config_store_id') . "') AND `key`='config_language' LIMIT 1");
		if( $query->num_rows) {
			$default_language = $query->row['value'];
		} else {
			$default_language = $this->config->get("config_language");
		}
		$base_url = rtrim(( $this->request->server['HTTPS'] ? HTTPS_SERVER : HTTP_SERVER ), "/");
		if( !$this->model_localisation_language ) {
			$this->load->model('localisation/language');
		}
		
		print_r($data);
		$results = $this->model_localisation_language->getLanguages();
		foreach ($results as $result) {
			if( $result['code'] == $this->session->data['language'] ){
				// текущий язык не добавляем
				continue;
			}
			if ($result['status']) {
				$url = "/". ltrim(str_replace($base_url,"",$data['redirect']),"/");
				$explode_url = explode('/', $url);
				if(in_array($this->session->data['language'], $explode_url) && strpos($url,"/" . $this->session->data['language'] ) === 0 ) {
					$url = str_replace("/" . $this->session->data['language']."/","/",$url);
				}
				if( $result['code'] != $default_language ) {
					$url = "/" . $result['code'] . $url;
				}

				$this->document->addLink($base_url . $url,"alternate\" hreflang=\"" . $result['code'] . "");
			}
		}

		return $data;
	}

	public function processCommonHome($data){

		$language_id = $this->config->get('config_language_id');
		$lang_data = $this->config->get('config_langdata');
		$this->document->setTitle($lang_data[$language_id]['meta_title']);
		$this->document->setDescription($lang_data[$language_id]['meta_description']);
		$this->document->setKeywords($lang_data[$language_id]['meta_keyword']);

		return $data;
	}
}
