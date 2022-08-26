<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoActionManager extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_action_manager';
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_status') == 1;

		$this->params = array(
			'status' => 1,
			'series' => 1,
			'debug' => 0,
			'meta_title_ml' => array(),
			'meta_description_ml' => array(),
			'meta_keyword_ml' => array(),
			'meta_title' => '',
			'meta_description' => '',
			'meta_keyword' => '',
			'brand_to_related' => '',
			'category_to_related' => '',
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

		// Пишем ЧПУ для модуля
		$this->db->query("INSERT INTO `" . DB_PREFIX . "url_alias` SET query = 'module/" . $this->db->escape($this->_moduleSysName()) . "', keyword = 'actions'");
	}

	public function installTables()
	{
		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "actions` (";
		$sql .= " `action_id` int(11) NOT NULL AUTO_INCREMENT,";
		$sql .= " `action_status` tinyint(1) NOT NULL DEFAULT '0',";
		$sql .= " `main_page` tinyint(1) NOT NULL DEFAULT '0',";
		$sql .= " `all_category` tinyint(1) NOT NULL DEFAULT '0',";
		$sql .= " `keyword` varchar(255) COLLATE utf8_bin NOT NULL,";
		$sql .= " `image` varchar(255) COLLATE utf8_bin NOT NULL,";
		$sql .= " `image_width` varchar(255) NOT NULL,";
		$sql .= " `image_height` varchar(255) NOT NULL,";
		$sql .= " `date_end` date NOT NULL DEFAULT '0000-00-00',";
		$sql .= " PRIMARY KEY (`action_id`)";
		$sql .= ") CHARSET=utf8 COLLATE=utf8_general_ci";
		$this->db->query($sql);


		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "actions_description` (";
		$sql .= " `action_id` int(11) NOT NULL,";
		$sql .= " `language_id` int(11) NOT NULL,";
		$sql .= " `name` varchar(255) COLLATE utf8_bin NOT NULL,";
		$sql .= " `short_text` text COLLATE utf8_bin NOT NULL,";
		$sql .= " `full_text` text COLLATE utf8_bin NOT NULL,";
		$sql .= " `meta_title` varchar(255) COLLATE utf8_bin NOT NULL,";
		$sql .= " `meta_description` text COLLATE utf8_bin NOT NULL,";
		$sql .= " `meta_keyword` text COLLATE utf8_bin NOT NULL,";
		$sql .= " PRIMARY KEY (`action_id`, `language_id`)";
		$sql .= ") CHARSET=utf8 COLLATE=utf8_general_ci";
		$this->db->query($sql);


		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "actions_products` (";
		$sql .= " `action_id` int(11) NOT NULL,";
		$sql .= " `product_id` int(11) NOT NULL,";
		$sql .= " PRIMARY KEY (`action_id`, `product_id`)";
		$sql .= ") CHARSET=utf8 COLLATE=utf8_general_ci";
		$this->db->query($sql);

		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "actions_categories` (";
		$sql .= " `id` int(11) NOT NULL AUTO_INCREMENT,";
		$sql .= " `action_id` int(11) NOT NULL,";
		$sql .= " `category_id` int(11) NOT NULL,";
		$sql .= " PRIMARY KEY (`id`)";
		$sql .= ") CHARSET=utf8 COLLATE=utf8_general_ci";
		$this->db->query($sql);

		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "actions_brands` (";
		$sql .= " `id` int(11) NOT NULL AUTO_INCREMENT,";
		$sql .= " `action_id` int(11) NOT NULL,";
		$sql .= " `brand_id` int(11) NOT NULL,";
		$sql .= " PRIMARY KEY (`id`)";
		$sql .= ") CHARSET=utf8 COLLATE=utf8_general_ci";
		$this->db->query($sql);
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		// Создаем недостающие таблицы в актуальной структуре
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "actions` LIKE 'main_page';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "actions`  ADD COLUMN `main_page` tinyint(1) NOT NULL DEFAULT '0' AFTER `action_status`;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "actions` LIKE 'all_category';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "actions`  ADD COLUMN `all_category` tinyint(1) NOT NULL DEFAULT '0' AFTER `action_status`;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "actions` LIKE 'image_width';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "actions`  ADD COLUMN `image_width`  VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "actions` LIKE 'image_height';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "actions`  ADD COLUMN `image_height` VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}
	}

	public function uninstall()
	{
		// Удаляем ЧПУ для модуля
		$this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query = 'module/" . $this->db->escape($this->_moduleSysName()) . "'");

		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "actions");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "actions_description");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "actions_products");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "actions_categories");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "actions_brands");

		return TRUE;
	}

}

?>