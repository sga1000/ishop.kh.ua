<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoFeaturedProducts extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_featured_products";
		$this->defaultTitle = $this->getDefaultTitle();
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;
		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'name' => '',
			'title' => $this->defaultTitle,
			'use_related' => 0,
			'template' => 'default',
			);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		return TRUE;
	}

	public function installTables()
	{
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "featured_products_tabs` (
			`tab_id` int(11) NOT NULL AUTO_INCREMENT, 
			`module_id` int(11) NOT NULL, 
			`status` int(1) NOT NULL DEFAULT 0, 
			`name` varchar(255) NOT NULL, 
			`limit` varchar(255) NOT NULL,   
			`width` varchar(255) NOT NULL,
			`height` varchar(255) NOT NULL,
			`order` varchar(255) NOT NULL,  
			`url`  varchar(255) NOT NULL,
			`url_text` varchar(255) NOT NULL, 
			`products` varchar(255) NOT NULL,   
			PRIMARY KEY (`tab_id`) 
		)  CHARACTER SET utf8 COLLATE utf8_general_ci;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "featured_related_products_tabs` (
			`tab_id` int(11) NOT NULL AUTO_INCREMENT, 
			`product_id` int(11) NOT NULL, 
			`module_id` int(11) NOT NULL, 
			`status` int(1) NOT NULL DEFAULT 0, 
			`name` varchar(255) NOT NULL, 
			`limit` varchar(255) NOT NULL,   
			`width` varchar(255) NOT NULL,
			`height` varchar(255) NOT NULL,
			`order` varchar(255) NOT NULL,  
			`url`  varchar(255) NOT NULL,
			`url_text` varchar(255) NOT NULL, 
			`products` varchar(255) NOT NULL,   
			PRIMARY KEY (`tab_id`) 
		)  CHARACTER SET utf8 COLLATE utf8_general_ci;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "featured_products_to_module` (
			`id` int(11) NOT NULL AUTO_INCREMENT, 
			`product_id` int(11) NOT NULL, 
			`module_id` int(11) NOT NULL, 
			`name` varchar(255) NOT NULL, 
			`template` varchar(255) NOT NULL, 
			PRIMARY KEY (`id`) 
		)  CHARACTER SET utf8 COLLATE utf8_general_ci;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "featured_related_category_tabs` (
			`tab_id` int(11) NOT NULL AUTO_INCREMENT, 
			`category_id` int(11) NOT NULL, 
			`module_id` int(11) NOT NULL, 
			`status` int(1) NOT NULL DEFAULT 0, 
			`name` varchar(255) NOT NULL, 
			`limit` varchar(255) NOT NULL,   
			`width` varchar(255) NOT NULL,
			`height` varchar(255) NOT NULL,
			`order` varchar(255) NOT NULL,   
			`products` varchar(255) NOT NULL,   
			PRIMARY KEY (`tab_id`) 
		)  CHARACTER SET utf8 COLLATE utf8_general_ci;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "featured_category_to_module` (
			`id` int(11) NOT NULL AUTO_INCREMENT, 
			`category_id` int(11) NOT NULL, 
			`module_id` int(11) NOT NULL, 
			`name` varchar(255) NOT NULL, 
			`template` varchar(255) NOT NULL, 
			PRIMARY KEY (`id`) 
		)  CHARACTER SET utf8 COLLATE utf8_general_ci;");
	}

	public function upgrade()
	{
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "featured_related_products_tabs` LIKE 'module_id';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "featured_related_products_tabs` ADD COLUMN module_id int(11) NOT NULL DEFAULT 0;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "featured_products_tabs` LIKE 'url';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "featured_products_tabs` ADD COLUMN url  varchar(255) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "featured_products_tabs` LIKE 'url_text';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "featured_products_tabs` ADD COLUMN url_text  varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "featured_related_products_tabs` LIKE 'url';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "featured_related_products_tabs` ADD COLUMN url  varchar(255) NOT NULL;";
			$this->db->query($sql);
		}
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "featured_related_products_tabs` LIKE 'url_text';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "featured_related_products_tabs` ADD COLUMN url_text  varchar(255) NOT NULL;";
			$this->db->query($sql);
		}


		return TRUE;
	}

	public function uninstall()
	{
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "featured_products_tabs`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "featured_related_products_tabs`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "featured_products_to_module`");
		return TRUE;
	}

	public function getDefaultTitle()
	{
		$this->load->model('localisation/language');
		$data = $this->load->language('module/' . $this->_moduleSysName);

		$defaultTitle = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$defaultTitle[$language['language_id']] = $data['text_default_title'];
		}

		return $defaultTitle;
	}

}

?>