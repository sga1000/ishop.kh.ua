<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoCallback extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_callback";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;

		// Значения параметров по умолчанию
		$this->load->model('localisation/language');
		$this->language->load("module/neoseo_callback");

		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$message[$language['language_id']] = $this->language->get('param_message');
			$title[$language['language_id']] = $this->language->get('param_title');
		}
		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'message' => $message,
			'notify' => '',
			'notify_subject' => $this->language->get('param_notify_subject'),
			'notify_message' => $this->language->get('param_notify_message'),
			'phone_mask' => '+38 (099) 999-99-99',
			'use_email' => 0,
			'title' => $title,
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		// Недостающие права
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'sale/neoseo_callback');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'sale/neoseo_callback');

		return TRUE;
	}

	public function installTables()
	{
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "callback` (
			`callback_id` int(11) NOT NULL AUTO_INCREMENT,
			`date` datetime NOT NULL,
			`name` varchar(256) NOT NULL,
			`phone` varchar(256) NOT NULL,
			`email` varchar(256) NOT NULL,
			`message` text NOT NULL,
			`time_from` varchar(256) NOT NULL,
			`time_to` varchar(256) NOT NULL,
			`comment` varchar(256) NOT NULL,
			`manager` varchar(256) NOT NULL,
			`status` varchar(256) NOT NULL,
		PRIMARY KEY (`callback_id`)
		) DEFAULT CHARSET=utf8;
		");
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		// Создаем недостающие таблицы в актуальной структуре
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "callback` LIKE 'comment';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "callback` ADD COLUMN comment  varchar(256) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "callback` LIKE 'manager';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "callback` ADD COLUMN manager  varchar(256) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "callback` LIKE 'status';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "callback` ADD COLUMN status  varchar(256) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "callback` LIKE 'email';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "callback` ADD COLUMN email  varchar(256) NOT NULL;";
			$this->db->query($sql);
		}
		return TRUE;
	}

	public function uninstall()
	{

		return TRUE;
	}

}

?>