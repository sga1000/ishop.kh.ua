<?php
require_once(DIR_SYSTEM."/engine/neoseo_controller.php");

class ControllerModuleNeoSeoBackup extends NeoSeoController {
	private $error = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_backup';
		$this->_logFile = $this->_moduleSysName.'.log';
		$this->debug = $this->config->get($this->_moduleSysName.'_debug') == 1;
	}

	public function index() {
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load('module/'.$this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$settings = $this->request->post;

			if (isset($this->request->post[$this->_moduleSysName.'_password']) &&
				$this->request->post[$this->_moduleSysName.'_password'] != "" )
			{
				$this->log("backup password has been changed");
				$settings[$this->_moduleSysName.'_real_password'] = $this->request->post[$this->_moduleSysName.'_password'];
			} else {
				$this->log("backup password has NOT changed");
				$settings[$this->_moduleSysName.'_real_password'] =  $this->config->get($this->_moduleSysName.'_real_password');
			}

			if (isset($this->request->post[$this->_moduleSysName.'_drive_token']) &&
				$this->request->post[$this->_moduleSysName.'_drive_token'] != "" )
			{
				$this->log("backup drive token has been changed");
				$settings[$this->_moduleSysName.'_drive_token'] = $this->request->post[$this->_moduleSysName.'_drive_token'];
			} else {
				$this->log("backup drive token has NOT changed");
				$settings[$this->_moduleSysName.'_drive_token'] =  $this->config->get($this->_moduleSysName.'_drive_token');
			}

			$this->model_setting_setting->editSetting(''.$this->_moduleSysName, $settings);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link('module/'.$this->_moduleSysName, 'token='.$this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/module', 'token='.$this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		if (!class_exists("ZipArchive")) {
			$data['error_warning'] .= $this->language->get("error_zip_archive_missing");
		}

		if (isset($this->session->data['success'] )) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(array(
			array('extension/module', 'text_module'),
			array('module/'.$this->_moduleSysName, 'heading_title_raw')
		), $data);

		$data = $this->initButtons($data);
		$data['check_password'] = $this->url->link('module/'.$this->_moduleSysName.'/check_password', 'token='.$this->session->data['token'], 'SSL');
		$data['get_token'] = $this->url->link('module/'.$this->_moduleSysName.'/get_token', 'token='.$this->session->data['token'], 'SSL');
		$data['check_token'] = $this->url->link('module/'.$this->_moduleSysName.'/check_token', 'token='.$this->session->data['token'], 'SSL');
		$data['get_access'] = $this->url->link('module/'.$this->_moduleSysName.'/get_access', 'token='.$this->session->data['token'], 'SSL');
		$data['check_access'] = $this->url->link('module/'.$this->_moduleSysName.'/check_access', 'token='.$this->session->data['token'], 'SSL');

		$data = $this->initParamsList(array(
			'status',
			'debug',
			'replace_system_backup',
			'notify_list',
			'max_copies',
			'destination',
			'token',
			'api_key',
			'api_secret',
			'drive_token',
			'google_api',
			'client_id',
			'client_secret',
			'server',
			'folder',
			'username',
			'exclude_tables',
			'exclude_files',
			'send_statistics',
			'statistics_server',
		), $data);

		$data[$this->_moduleSysName.'_google_url'] = ((!empty($this->request->server['HTTPS']) ? 'https://' : 'http://').$this->request->server['SERVER_NAME'].'/').'index.php?route=module/'.$this->_moduleSysName.'/drive';
		$data[$this->_moduleSysName . "_cron"] = "php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		if (PHP_VERSION_ID < 50300) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php52/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 50400) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php53/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 50500) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php54/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 50600) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php55/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 50700) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php56/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 70100) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php70/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 70200) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php71/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php72/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		}

		$data[$this->_moduleSysName . "_cron_orders"] = "php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php") . " ordersOnly";
		if (PHP_VERSION_ID < 50300) {
			$data[$this->_moduleSysName . "_cron_orders_cpanel"] = "/opt/cpanel/ea-php52/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php") . " ordersOnly";
		} else if (PHP_VERSION_ID < 50400) {
			$data[$this->_moduleSysName . "_cron_orders_cpanel"] = "/opt/cpanel/ea-php53/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php") . " ordersOnly";
		} else if (PHP_VERSION_ID < 50500) {
			$data[$this->_moduleSysName . "_cron_orders_cpanel"] = "/opt/cpanel/ea-php54/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php") . " ordersOnly";
		} else if (PHP_VERSION_ID < 50600) {
			$data[$this->_moduleSysName . "_cron_orders_cpanel"] = "/opt/cpanel/ea-php55/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php") . " ordersOnly";
		} else if (PHP_VERSION_ID < 50700) {
			$data[$this->_moduleSysName . "_cron_orders_cpanel"] = "/opt/cpanel/ea-php56/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php") . " ordersOnly";
		} else if (PHP_VERSION_ID < 70100) {
			$data[$this->_moduleSysName . "_cron_orders_cpanel"] = "/opt/cpanel/ea-php70/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php") . " ordersOnly";
		} else if (PHP_VERSION_ID < 70200) {
			$data[$this->_moduleSysName . "_cron_orders_cpanel"] = "/opt/cpanel/ea-php71/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php") . " ordersOnly";
		} else {
			$data[$this->_moduleSysName . "_cron_orders_cpanel"] = "/opt/cpanel/ea-php72/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php") . " ordersOnly";
		}
		$data[$this->_moduleSysName.'_password'] = "";

		$data[$this->_moduleSysName.'_destinations'] = array(
			"yandex.disk" => $this->language->get("text_destination_"."yandex.disk" ),
			"dropbox" => $this->language->get("text_destination_"."dropbox" ),
			"ftp" => $this->language->get("text_destination_"."ftp" ),
			"drive" => $this->language->get("text_destination_"."drive" ),
			/* "webdav" => $this->language->get("text_destination_"."webdav" ), */
		);

		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/'.$this->_moduleSysName.'.tpl', $data));
	}

	public function check_password() {
		if (!isset($this->request->post['destination'])) {
			die(json_encode(array("message" => "Укажите хранилище")));
		}
		if ($this->request->post['destination'] == "ftp" && ( !isset($this->request->post['server']) || $this->request->post['server'] == "" )) {
			die(json_encode(array("message" => "Укажите сервер")));
		}
		if (!isset($this->request->post['login']) || $this->request->post['login'] == "") {
			die(json_encode(array("message" => "Укажите логин")));
		}
		if (!isset($this->request->post['password']) || $this->request->post['password'] == "") {
			die(json_encode(array("message" => "Укажите пароль")));
		}
		if ($this->request->post['destination'] == "ftp") {
			$this->load->model('tool/'.$this->_moduleSysName.'_ftp');
			$error = $this->model_tool_neoseo_backup_ftp->checkPassword($this->request->post['server'],$this->request->post['folder'],$this->request->post['login'],$this->request->post['password']);
		} else {
			$this->load->model('tool/'.$this->_moduleSysName.'_yandex_disk');
			$error = $this->model_tool_neoseo_backup_yandex_disk->checkPassword($this->request->post['folder'],$this->request->post['login'],$this->request->post['password']);
		}
		if (!$error) {
			die(json_encode(array("message" => "Подключение выполнено успешно")));
		} else {
			die(json_encode(array("message" => "Ошибка подключения: $error")));
		}
	}

	public function get_token() {
		if (!isset($this->request->post['destination'])) {
			die(json_encode(array("message" => "Укажите хранилище")));
		}
		if ($this->request->post['destination'] == "dropbox" && ( !isset($this->request->post['apikey']) || $this->request->post['apikey'] == "" )) {
			die(json_encode(array("message" => "Укажите Api ключ")));
		} else {
			$apikey=true;
		}
		if ($this->request->post['destination'] == "dropbox" && ( !isset($this->request->post['apisecret']) || $this->request->post['apisecret'] == "" )) {
			die(json_encode(array("message" => "Укажите Api секрет")));
		} else {
			$apisecret=true;
		}
		if (($this->request->post['destination'] == "dropbox") && ($apikey) && ($apisecret)) {
			$this->load->model('tool/'.$this->_moduleSysName.'_dropbox');
			$response = $this->model_tool_neoseo_backup_dropbox->gettoken($this->request->post['apikey'],$this->request->post['apisecret']);
		}
		$this->debug("Получение ссылки: ".$response);
		if ($response) {
			die(json_encode(array("message" => $response)));
		} else {
			die(json_encode(array("message" => "Ошибка подключения")));
		}
	}

	public function check_token() {
		if (!isset($this->request->post['token']) || $this->request->post['token'] == "") {
			die(json_encode(array("message" => "Ошибка. Укажите Token")));
		} else {
			$get_toket=true;
		}
		if ($this->request->post['destination'] == "dropbox" && ( !isset($this->request->post['apikey']) || $this->request->post['apikey'] == "" )) {
			die(json_encode(array("message" => "Ошибка. Укажите Api ключ")));
		} else {
			$apikey=true;
		}
		if ($this->request->post['destination'] == "dropbox" && ( !isset($this->request->post['apisecret']) || $this->request->post['apisecret'] == "" )) {
			die(json_encode(array("message" => "Ошибка. Укажите Api секрет")));
		} else {
			$apisecret=true;
		}
		if (($this->request->post['destination'] == "dropbox") && ($get_toket) && ($apikey) && ($apisecret)) {
			$this->load->model('tool/'.$this->_moduleSysName.'_dropbox');
			$response = $this->model_tool_neoseo_backup_dropbox->checktoken($this->request->post['token'],$this->request->post['apikey'],$this->request->post['apisecret']);

		}
		$this->debug("Проверка токен: ".$response);
		if ($response) {
			die(json_encode(array("message" => $response)));
		} else {
			die(json_encode(array("message" => "Ошибка подключения")));
		}
	}

	public function get_access() {
		if (!isset($this->request->post['destination'])) {
			die(json_encode(array("message" => "Укажите хранилище")));
		}
		if ($this->request->post['destination'] == "drive" && ( !isset($this->request->post['googleApi']) || $this->request->post['googleApi'] == "" )) {
			die(json_encode(array("message" => "Укажите Api ключ")));
		} else {
			$apikey=true;
		}
		if ($this->request->post['destination'] == "drive" && ( !isset($this->request->post['clientId']) || $this->request->post['clientId'] == "" )) {
			die(json_encode(array("message" => "Укажите Клиент id")));
		} else {
			$clientid=true;
		}
		if ($this->request->post['destination'] == "drive" && ( !isset($this->request->post['clientSecret']) || $this->request->post['clientSecret'] == "" )) {
			die(json_encode(array("message" => "Укажите Клиент секрет")));
		} else {
			$clientsecret=true;
		}
		if (($this->request->post['destination'] == "drive") && ($apikey) && ($clientid) && ($clientsecret)) {
			$this->debug("Получили запрос на авторизацю");
			$this->load->model('tool/'.$this->_moduleSysName.'_drive');
			$response = $this->model_tool_neoseo_backup_drive->getAccess($this->request->post['googleApi'],$this->request->post['clientId'],$this->request->post['clientSecret']);
		}
		$this->debug("Получение ссылки: ".$response);
		if ($response) {
			die(json_encode(array("message" => $response)));
		} else {
			die(json_encode(array("message" => "Ошибка подключения")));
		}
	}

	public function check_access() {
		if (!isset($this->request->post['destination'])) {
			die(json_encode(array("message" => "Укажите хранилище")));
		}
		if ($this->request->post['destination'] == "drive" && ( !isset($this->request->post['googleApi']) || $this->request->post['googleApi'] == "" )) {
			die(json_encode(array("message" => "Укажите Api ключ")));
		} else {
			$apikey=true;
		}
		if ($this->request->post['destination'] == "drive" && ( !isset($this->request->post['clientId']) || $this->request->post['clientId'] == "" )) {
			die(json_encode(array("message" => "Укажите Клиент id")));
		} else {
			$clientid=true;
		}
		if ($this->request->post['destination'] == "drive" && ( !isset($this->request->post['clientSecret']) || $this->request->post['clientSecret'] == "" )) {
			die(json_encode(array("message" => "Укажите Клиент секрет")));
		} else {
			$clientsecret=true;
		}
		if (($this->request->post['destination'] == "drive") && ($apikey) && ($clientid) && ($clientsecret)) {
			$this->debug("Получили запрос на проверку авторизации");
			$this->load->model('tool/'.$this->_moduleSysName.'_drive');
			$response = $this->model_tool_neoseo_backup_drive->checkAccess($this->request->post['googleApi'],$this->request->post['clientId'],$this->request->post['clientSecret']);
		}
		$this->debug("Получение ссылки: ".$response);
		if ($response) {
			die(json_encode(array("message" => $response)));
		} else {
			die(json_encode(array("message" => "Ошибка подключения")));
		}
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/'.$this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if ((($this->request->post[$this->_moduleSysName.'_destination'] == 'dropbox') || ($this->request->post[$this->_moduleSysName.'_destination'] == 'drive'))  && (!$this->request->post[$this->_moduleSysName.'_folder'])) {
			$this->error['warning'] = $this->language->get('error_empty_folder');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>