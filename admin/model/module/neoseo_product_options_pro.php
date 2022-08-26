<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoProductOptionsPro extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_product_options_pro';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status');
	}

	public function installTables()
	{
		$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "product_option_pro ("
		    . "product_option_pro_id INT(11) NOT NULL AUTO_INCREMENT,"
		    . "sort_order INT(11) NOT NULL,"
		    . "status INT(1) NOT NULL,"
		    . "status_image INT(1) NOT NULL,"
		    . "PRIMARY KEY (`product_option_pro_id`))");

		$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "product_option_pro_description ("
		    . "product_option_pro_id INT(11) NOT NULL,"
		    . "language_id INT(11) NOT NULL,"
		    . "name VARCHAR(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL )");

		$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "product_option_pro_kit ("
		    . "product_option_pro_id INT(11) NOT NULL,"
		    . "sort_order INT(11) NOT NULL,"
		    . "option_id INT(11) NOT NULL )");

		$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "product_option_pro_to_product ("
		    . "product_id INT(11) NOT NULL,"
		    . "product_option_pro_id INT(11) NOT NULL,"
		    . "PRIMARY KEY (`product_id`))");

		$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "product_option_pro_value ("
		    . "product_option_pro_value_id INT(11) NOT NULL AUTO_INCREMENT,"
		    . "product_id INT(11) NOT NULL,"
		    . "quantity INT(11) NOT NULL,"
		    . "sku VARCHAR(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,"
		    . "model VARCHAR(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,"
		    . "PRIMARY KEY (`product_option_pro_value_id`))");

		$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "product_option_pro_price ("
			. "product_option_pro_value_id INT(11) NOT NULL,"
			. "product_id INT(11) NOT NULL,"
			. "customer_group_id INT(11) NOT NULL,"
			. "price DECIMAL(15,4) NOT NULL,"
			. "base_price DECIMAL(15,4) NOT NULL )");

		$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "product_option_pro_detail ("
		    . "product_option_pro_value_id INT(11) NOT NULL,"
		    . "product_id INT(11) NOT NULL,"
		    . "option_id INT(11) NOT NULL,"
		    . "option_value_id INT(11) NOT NULL )");

		$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "product_option_pro_image ("
		    . "product_id INT(11) NOT NULL, "
		    . "option_id INT(11) NOT NULL, "
		    . "product_option_pro_id INT(11) NOT NULL )");

		$this->db->query("CREATE TABLE IF NOT EXISTS " . DB_PREFIX . "product_option_pro_image_value ("
		    . "product_id INT(11) NOT NULL,"
		    . "option_value_id INT(11) NOT NULL,"
		    . "product_option_pro_value_id INT(11) NOT NULL,"
		    . "image VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL )");

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "option` LIKE 'image_view';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "option` ADD `image_width` INT NOT NULL AFTER `sort_order`,"
				."ADD `image_height` INT NOT NULL AFTER `image_width`, "
				."ADD `image_view` INT NOT NULL AFTER `image_height`, "
				."ADD `image_view_name` VARCHAR(255) NOT NULL AFTER `image_view`";
			$this->db->query($sql);
		}


	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParamsDefaults(array(
			'status' => 1,
			'debug' => 0,
			'product_list_status' => 0,
		));

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		// Добавляем права на нестандартные контроллеры, если они используются
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'catalog/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'catalog/' . $this->_moduleSysName);
	}

	public function upgrade()
	{
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "product_option_pro_value` LIKE 'model';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "product_option_pro_value` ADD COLUMN model VARCHAR(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "option_value` LIKE 'status';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "option_value` ADD COLUMN `status` INT(11) NOT NULL DEFAULT '1';";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "option` LIKE 'image_width';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "option` ADD COLUMN image_width INT(11) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "option` LIKE 'image_height';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "option` ADD COLUMN image_height INT(11) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "option` LIKE 'image_view_name';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "option` ADD COLUMN image_view_name VARCHAR(255) NOT NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "option` LIKE 'image_view';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "option` ADD COLUMN image_view INT(11) NOT NULL;";
			$this->db->query($sql);
		}

	}

	public function uninstall()
	{
		// Удаляем таблицы модуля
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_option_pro");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_option_pro_description");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_option_pro_kit");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_option_pro_to_product");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_option_pro_value");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_option_pro_price");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_option_pro_detail");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_option_pro_image");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_option_pro_image_value");
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "option`  DROP `image_width`,  DROP `image_height`,  DROP `image_view`,  DROP `image_view_name`;");
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "option_value`  DROP `status`;");

	}

}
