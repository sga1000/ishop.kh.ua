<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoFilter extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_filter";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");


		$this->load->model('localisation/language');
		$this->language->load('module/' . $this->_moduleSysName . '_settings');

		$languages = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$languages[$language['language_id']] = $language['name'];
		}

		$defaultManUrl = array();
		foreach ($languages as $language_id => $name) {
			$defaultManUrl[$language_id] = $this->language->get('text_default_manufacturer_url');
		}

		$defaultPriceUrl = array();
		foreach ($languages as $language_id => $name) {
			$defaultPriceUrl[$language_id] = $this->language->get('text_default_price_url');
		}

		$this->params = array(
			// "status" => 1, нельзя сюда статус, иначе создается лишний модуль фильтра
			"debug" => 0,
			'show_attributes' => 0,
			'use_cache' => 1,
			'attributes_group' => 0,
			'use_discount' => 0,
			'use_special' => 0,
			'manufacturer_url' => $defaultManUrl,
			'price_url' => $defaultPriceUrl,
			'add_filters_to_h1' => 1,
			'import_filter_option' => 1,
			'import_product_field' => 'model',
			'manufacturer_sort_order' => 'default',
			'use_series' => 0,
			'not_flush_filter_module_cache' => 0,
			'option_for_warehouse' => 0,
			'attribute_values_sort_order_direction' => 'asc',
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		$this->createTables();

		// Недостающие права
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'catalog/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'catalog/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'catalog/' . $this->_moduleSysName . '_pages');
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'catalog/' . $this->_moduleSysName . '_pages');
		return TRUE;
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		$this->createTables();
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_module_cache` LIKE 'language_id';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_module_cache`  ADD COLUMN `language_id` int(11) NOT NULL  AFTER `quantity`;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_option_description` LIKE 'keyword';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_option_description`  ADD COLUMN `keyword` varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_option_value_description` LIKE 'keyword';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_option_value_description`  ADD COLUMN `keyword` varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page_description` LIKE 'keyword';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page_description`  ADD COLUMN `keyword` varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page_description` LIKE 'name';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page_description`  ADD COLUMN `name` varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page_description` LIKE 'tag_name';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page_description`  ADD COLUMN `tag_name` varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page` LIKE 'is_tag';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page`  ADD COLUMN `is_tag` int(11) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page` LIKE 'tags';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page`  ADD COLUMN `tags` text NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_option` LIKE 'after_manufacturer';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_option`  ADD COLUMN `after_manufacturer` int(11) NOT NULL  DEFAULT '0';";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page` LIKE 'use_direct_link';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page`  ADD COLUMN `use_direct_link` int(11) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_page` LIKE 'use_end_slash';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_page`  ADD COLUMN `use_end_slash` int(11) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "filter_option` LIKE 'sort_order_direction';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "filter_option`  ADD COLUMN `sort_order_direction` int(3) NOT NULL  DEFAULT '0';";
			$this->db->query($sql);
		}

		return TRUE;
	}

	public function uninstall()
	{
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "filter_option`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "filter_option_description`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "filter_option_value`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "filter_option_value_description`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "filter_option_value_to_product`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "filter_option_to_category`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "filter_page`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "filter_page_description`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "filter_cache`");
		return TRUE;
	}

	private function createTables()
	{
		//Опции фильтра
		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_option` (
			`option_id` int(11) NOT NULL AUTO_INCREMENT,
			`keyword` varchar(255) NOT NULL,
			`sort_order` int(11) NOT NULL DEFAULT '0',
			`type` varchar(255) NOT NULL,
			`status` int(11) NOT NULL,
			`style`  varchar(255) NOT NULL,
			`open` int(11) NOT NULL,
			`after_manufacturer` int(11) NOT NULL,
			`sort_order_direction` int(3) NOT NULL,
			PRIMARY KEY (`option_id`)
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);

		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_option_description` (
			`option_id` int(11) NOT NULL AUTO_INCREMENT,
			`language_id` int(11) NOT NULL,
			`name` varchar(255) NOT NULL,
			`keyword` varchar(255) NOT NULL,
			PRIMARY KEY (`option_id`,`language_id`)
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);

		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_option_to_category` (
			`option_id` int(11) NOT NULL AUTO_INCREMENT,
			`category_id` int(11) NOT NULL,
			PRIMARY KEY (`option_id`,`category_id`)
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);

		//Значения опций фильтра
		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_option_value` (
			`option_value_id` int(11) NOT NULL AUTO_INCREMENT,
			`option_id` int(11) NOT NULL,
			`keyword` varchar(255) NOT NULL,
			`sort_order` int(11) NOT NULL DEFAULT '0',
			`color` varchar(255) NOT NULL,
			`image` varchar(255) NOT NULL,
			`position`  varchar(255) NOT NULL,
			PRIMARY KEY (`option_value_id`)
		) DEFAULT CHARSET=utf8; 
		";
		$this->db->query($sql);

		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_option_value_description` (
			`option_value_id` int(11) NOT NULL AUTO_INCREMENT,
			`option_id` int(11) NOT NULL,
			`language_id` int(11) NOT NULL,
			`name` varchar(255) NOT NULL,
			`keyword` varchar(255) NOT NULL,
			PRIMARY KEY (option_value_id, `option_id`, `language_id`) 
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);

		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_option_value_to_product` (
			`product_id` int(11) NOT NULL,
			`option_id` int(11) NOT NULL,
			`option_value_id` int(11) NOT NULL,
			KEY (`product_id`,`option_id`,`option_value_id`),
			KEY (`product_id`,`option_value_id`),
			KEY (`option_value_id`,`product_id`)
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);

		//Посадочные страницы
		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_page` (
			`page_id` int(11) NOT NULL AUTO_INCREMENT,
			`category_id` int(11) NOT NULL,
			`keyword` varchar(255) NOT NULL,
			`status` int(11) NOT NULL,
			`options` varchar(255) NOT NULL,
			`use_direct_link` int(11) NOT NULL DEFAULT '0',
			`use_end_slash` int(11) NOT NULL DEFAULT '0',
			`is_tag` int(11) NOT NULL,
			`tags` text NOT NULL,
			PRIMARY KEY (`page_id`)
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);

		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_page_description` (
			`page_id` int(11) NOT NULL AUTO_INCREMENT,
			`language_id` int(11) NOT NULL,
			`h1` varchar(255) NOT NULL,
			`description` TEXT NOT NULL,
			`title` varchar(255) NOT NULL,
			`meta_keywords` varchar(255) NOT NULL,
			`meta_description` varchar(255) NOT NULL,
			`keyword` varchar(255) NOT NULL,
			`tag_name` varchar(255) NOT NULL,
			PRIMARY KEY (`page_id`,`language_id`)
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);

		// Закешированные данные по опциям фильтра
		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_cache` (
			`cache_id` int(11) NOT NULL AUTO_INCREMENT,
			`category_id` int(11) NOT NULL,
			`options` text NULL,
			`products` text NULL,
			`quantity` int(11) NOT NULL,
			PRIMARY KEY (`cache_id`),
			KEY `options` (`options`(255)),
			KEY `products` (`options`(1024))
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);

		// Закешированные данные по категориям
		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_category_cache` (
			`filter_category_id` int(11) NOT NULL AUTO_INCREMENT,
			`category_id` int(11) NOT NULL,
			`min_price` decimal(15,4) NULL,
			`max_price` decimal(15,4) NULL,			
			PRIMARY KEY (`filter_category_id`),
			KEY `category_id` (`category_id`)
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);

		// Закешированные данные по модулю фильтра в категории
		$sql = "
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "filter_module_cache` (
			`cache_id` int(11) NOT NULL AUTO_INCREMENT,
			`category_id` int(11) NOT NULL,
			`selected` text NULL,
			`quantity` text NULL,
			`language_id` int(11) NOT NULL,			
			PRIMARY KEY (`cache_id`),
			KEY `selected` (category_id,`selected`(255))			
		) DEFAULT CHARSET=utf8;
		";
		$this->db->query($sql);
	}

	public function onSeries()
	{
		$query = $this->db->query("SHOW tables like '%product_series'");
		if ($query->num_rows) {
			return false;
		}
		return true;
	}
}

?>