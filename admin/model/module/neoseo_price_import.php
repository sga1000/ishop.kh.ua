<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoPriceImport extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_price_import";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;

		$this->language->load('module/' . $this->_moduleSysName);

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'barcode' => 'ean',
			'sku' => 'sku',
			'upc' => 'upc',
			'model' => 'model',
			'connect_symbol' => '_',
			'quantity_default' => 99,
			'zero_quantity' => $this->language->get('params_zero_quantity'),
			'admins_email' => '',
		);
	}

	public function install()
	{

		// Значения параметров по умолчанию
		$this->initParams($this->params);

		$this->addPermission($this->user->getId(), 'access', 'tool/' . $this->_moduleSysName);
		$this->addPermission($this->user->getId(), 'modify', 'tool/' . $this->_moduleSysName);
		$this->addPermission($this->user->getId(), 'access', 'tool/' . $this->_moduleSysName . '_vendor');
		$this->addPermission($this->user->getId(), 'modify', 'tool/' . $this->_moduleSysName . '_vendor');

		$this->installTables();
	}

	public function upgrade()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		$this->installTables();

		return TRUE;
	}

	public function uninstall()
	{
		$this->db->query("DELETE FROM `" . DB_PREFIX . "setting` WHERE `code` = '" . $this->_moduleSysName . "'");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "price_import_vendor`");
		return TRUE;
	}

	public function installTables()
	{
		$this->db->query("
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "price_import_vendor` (
			`id` int(11) NOT NULL AUTO_INCREMENT, 
			`code` varchar(255) NOT NULL,
			`name` varchar(255) NOT NULL, 
			`list` varchar(255) NOT NULL,
			`product_row` varchar(255) NOT NULL,
			`column_quantity` varchar(255) NOT NULL,
			`column_price` varchar(255) NOT NULL,
			`column_special` varchar(255) NOT NULL,
			`column_special_quantity` varchar(255) NOT NULL,
			`column_special_customer_group_id` varchar(255) NOT NULL,
			`column_use_special_groups` int(1) NOT NULL DEFAULT '0',
			`column_special_by_groups` text,
			`column_discount` varchar(255) NOT NULL,
			`column_discount_customer_group_id` varchar(255) NOT NULL,
			`column_use_discount_groups` int(1) NOT NULL DEFAULT '0',
			`column_discount_by_groups` text,
			`column_price_opt` varchar(255) NOT NULL,
			`column_barcode` varchar(255) NOT NULL,
			`column_model` varchar(255) NOT NULL, 
			`column_sku` varchar(255) NOT NULL,
			`column_manufacturer` varchar(255) NOT NULL,
			`column_stock_status` varchar(255) NOT NULL,
			`related_options` text,
			`options` text,
			`type` varchar(255), 
			`defaults` text,
			`fields` text,
			`images` varchar(255),
			`add` int,
			`add_status` int,
			`add_category_id` int,
			`category_from_file` int(2),
			`column_category` varchar(255) NOT NULL, 
			`create_category` int(2), 
			`get_category_column` int(2), 
			`update_categories` int(2),
			`disable_product` int(2),
			PRIMARY KEY (`id`) 
			)  CHARACTER SET utf8 COLLATE utf8_general_ci;");

		$this->db->query("
		CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "price_import_categories` (
			`id` int(11) NOT NULL AUTO_INCREMENT, 
			`vendor_id` int(2),
			`category_id` int(2),
			`category_name` varchar(255),
			PRIMARY KEY (`id`) 
			)  CHARACTER SET utf8 COLLATE utf8_general_ci;");

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_price_opt';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_price_opt  varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_model';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_model VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_manufacturer';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_manufacturer varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'related_options';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN related_options TEXT;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'options';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN options TEXT;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'fields';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN fields TEXT;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'update_fields';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN update_fields TEXT;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'filter';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN filter TEXT;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'images';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN images varchar(255);";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'image_delimiter';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN image_delimiter varchar(255);";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'add';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `add` int(11);";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'add_status';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `add_status` int(11);";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'update_price';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `update_price` int(11);";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'sum_quantity';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `sum_quantity` int(11);";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'add_category_id';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `add_category_id` int(11);";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'url';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `url` varchar(255)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'defaults';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `defaults` TEXT";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_quantity';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `column_quantity` INT(11)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'product_row';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `product_row` varchar(255)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'category_from_file';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `category_from_file` int(2)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_category';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `column_category` varchar(255)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'create_category';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `create_category` int(2)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'update_categories';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `update_categories` int(2)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_stock_status';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_stock_status varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'disable_product';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `disable_product` int(2)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'add_attributes';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `add_attributes` int(2)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'grid_attributes';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `grid_attributes` varchar(255)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'grid_attributes_lang';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `grid_attributes_lang` varchar(255)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'get_category_column';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `get_category_column` int(2)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'attributes';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN attributes TEXT;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'image_local';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `image_local` int(2)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'image_local_direction';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `image_local_direction` varchar(100)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'image_local_exten';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `image_local_exten` varchar(50)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'update_main_categorie';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN `update_main_categorie` int(2)";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_special';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_special  varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_special_quantity';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_special_quantity VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_special_customer_group_id';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_special_customer_group_id  varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_use_special_groups';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_use_special_groups int(1) NOT NULL DEFAULT '0';";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_special_by_groups';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_special_by_groups text;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_discount';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_discount varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_discount_customer_group_id';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_discount_customer_group_id  varchar(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_use_discount_groups';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_use_discount_groups int(1) NOT NULL DEFAULT '0';";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "price_import_vendor` LIKE 'column_discount_by_groups';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "price_import_vendor` ADD COLUMN column_discount_by_groups text;";
			$this->db->query($sql);
		}

		return TRUE;
	}

}