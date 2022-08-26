<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoFilterPageGenerator extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_filter_page_generator';
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

		$this->DefaultParams = $this->getDefaultParams();

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'ip_list' => '',
			'limit_pagination' => 20,
			'page_status_default' => 0,
			'limit_url' => 60,
			'limit_records' => 10,
			'limit_categories' => 10,
			'pattern_name_default' => $this->DefaultParams['pattern_name'],
			'pattern_title_default' => $this->DefaultParams['pattern_title'],
			'pattern_meta_description_default' => $this->DefaultParams['pattern_meta_description'],
			'pattern_url_default' => $this->DefaultParams['pattern_url'],
			'pattern_description_default' => $this->DefaultParams['pattern_description'],
			'pattern_h1_default' => $this->DefaultParams['pattern_h1'],
			'pattern_manufacturer' => $this->DefaultParams['manufacturer'],
			'use_direct_link_default' => 0,
			'use_end_slash_default' => 0,
			'separator_page_options' => ',',
			'separator_page_option_values' => ',',
			'separator_page_filters' => ':',
			'separator_page_option_option_values' => ';',
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		// Добавляем права на нестандартные контроллеры, если они используются
		$this->addPermission($this->user->getGroupId(), 'access', 'catalog/' . $this->_moduleSysName());
		$this->addPermission($this->user->getGroupId(), 'modify', 'catalog/' . $this->_moduleSysName());
		$this->addPermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
		$this->addPermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());

		return TRUE;
	}

	public function installTables()
	{
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_page_generator` (
		  `rule_id` INT NOT NULL AUTO_INCREMENT,
		  `category_id` INT NOT NULL,
		  `options` longtext NOT NULL,
		  `status` INT NOT NULL,
		  `pattern_name` text NOT NULL,
		  `pattern_title` text NOT NULL,
		  `pattern_meta_description` text NOT NULL,
		  `pattern_h1` text NOT NULL,
		  `pattern_url` text NOT NULL,
		  `pattern_description` text NOT NULL,
		  `use_direct_link` INT NOT NULL,
		  `use_end_slash` INT NOT NULL,
		  PRIMARY KEY (`rule_id`)
		  ) DEFAULT CHARSET=utf8;");

		return TRUE;
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);
		// Создаем недостающие таблицы в актуальной структуре
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page_generator` LIKE 'pattern_description';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page_generator` ADD COLUMN pattern_description text NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page_generator` LIKE 'use_direct_link';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page_generator` ADD COLUMN use_direct_link int(11) NOT NULL DEFAULT 0;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page_generator` LIKE 'use_end_slash';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page_generator` ADD COLUMN use_end_slash int(11) NOT NULL DEFAULT 0;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page_generator` LIKE 'pattern_meta_description';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page_generator` ADD COLUMN pattern_meta_description text NOT NULL;";
			$this->db->query($sql);
		}
	}

	public function uninstall()
	{
		// Удаляем таблицы модуля
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "filter_page_generator");

		// Удаляем права на нестандартные контроллеры, если они используются
		$this->load->model('user/user_group');
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'access', 'catalog/' . $this->_moduleSysName());
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'modify', 'catalog/' . $this->_moduleSysName());
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());


		return TRUE;
	}

	public function checkFilter()
	{
		$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "filter_page'");
		if (!$query->num_rows) {
			return FALSE;
		}

		$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "filter_page_description'");
		if (!$query->num_rows) {
			return FALSE;
		}

		return TRUE;
	}

	public function getDefaultParams()
	{
		$this->load->model('localisation/language');
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$defaultParams = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$defaultParams['pattern_name'][$language['language_id']] = $data['text_pattern_name_default'];
			$defaultParams['pattern_description'][$language['language_id']] = $data['text_pattern_description_default'];
			$defaultParams['pattern_title'][$language['language_id']] = $data['text_pattern_title_default'];
			$defaultParams['pattern_meta_description'][$language['language_id']] = $data['text_pattern_meta_description_default'];
			$defaultParams['pattern_url'][$language['language_id']] = $data['text_pattern_url_default'];
			$defaultParams['pattern_h1'][$language['language_id']] = $data['text_pattern_h1_default'];
			$defaultParams['manufacturer'][$language['language_id']] = $data['text_manufacturer_default'];
		}

		return $defaultParams;
	}

}
