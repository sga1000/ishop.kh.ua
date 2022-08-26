<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoCatchContacts extends NeoSeoModel
{
	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_catch_contacts";
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;


		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();

		$this->language->load($this->_route . '/' . $this->_moduleSysName());
		$title = array();
		$titleForm = array();
		foreach ($languages as $language) {
			$title[$language['language_id']] = $this->language->get('text_title');
			$titleForm[$language['language_id']] = $this->language->get('text_title_form');
			$text_subscribe[$language['language_id']] = $this->language->get('param_subscribe_text');
			$subject[$language['language_id']] = $this->language->get('param_subscribe_subject');
			$message[$language['language_id']] = $this->language->get('param_subscribe_message');
		}
		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'name' => '',
			'title' => $title,
			'phone_mask' => '+38 (099) 999-99-99',
			'title_form' => $titleForm,
			'background' => 'catalog/' . $this->_moduleSysName() . '/neoseo_background.png',
			'type_subscription' => $this->language->get('text_type_subscription'),
			'position_form' => 'position_buttom',
			'subscribe_text' => $text_subscribe,
			'subscribe_subject' => $subject,
			'subscribe_message' => $message,
			'admin_subscribe' => '',
			'admin_subscribe_subject' => $this->language->get('param_admin_subscribe_subject'),
			'admin_subscribe_message' => $this->language->get('param_admin_subscribe_message')
		);
	}

	private function installTables()
	{
		//Таблица для заявок
		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "catch_contacts` (
			`catch_id` int(11) NOT NULL AUTO_INCREMENT,
			`type_subscription` varchar(256) NOT NULL,
			`language`  varchar(256) NOT NULL,
			`date` datetime NOT NULL,
			`name` varchar(256) NOT NULL,
			`email` varchar(256) NOT NULL,
			`phone` varchar(256) NOT NULL,
			`site` varchar(256) NOT NULL,
			`description` text NOT NULL,
			`status` int(1) NOT NULL,
			PRIMARY KEY (`catch_id`)
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);
	}

	public function install()
	{

		$this->installTables();

		// Недостающие права
		$this->addPermission($this->user->getGroupId(), 'access', 'sale/' . $this->_moduleSysName());
		$this->addPermission($this->user->getGroupId(), 'modify', 'sale/' . $this->_moduleSysName());

		return TRUE;
	}

	public function upgrade()
	{
		$this->installTables();
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "catch_contacts` LIKE 'site';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "catch_contacts`  ADD COLUMN `site` VARCHAR(255) NOT NULL  AFTER `phone`;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "catch_contacts` LIKE 'description';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "catch_contacts`  ADD COLUMN `description` TEXT NOT NULL  AFTER `phone`;";
			$this->db->query($sql);
		}
		return TRUE;
	}

	public function uninstall()
	{
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "catch_contacts`");

		return TRUE;
	}

}

?>