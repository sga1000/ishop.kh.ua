<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoProductArchive extends NeoseoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_product_archive';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_debug');

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'stock_statuses' => array(5),
			'image_width' => 100,
			'image_height' => 100,
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
		$sql = "
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_similar_product` (
				`id` int(11) NOT NULL AUTO_INCREMENT,
				`product_id` int(11) NOT NULL,
				`similar_product_id` int(11) NOT NULL,
				PRIMARY KEY (`id`)
			) DEFAULT CHARSET=utf8;";
		$this->db->query($sql);

		$sql = "
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_similar_category` (
				`id` int(11) NOT NULL AUTO_INCREMENT,
				`product_id` int(11) NOT NULL,
				`similar_category_id` int(11) NOT NULL,
				PRIMARY KEY (`id`)
			) DEFAULT CHARSET=utf8;";
		$this->db->query($sql);
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		// Создаем недостающие таблицы в актуальной структуре
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "category` LIKE 'product_similar_category';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "category` ADD COLUMN product_similar_category varchar(255);";
			$this->db->query($sql);
		}
	}

	public function uninstall()
	{
		// Удаляем таблицы модуля
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_similar_product");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_similar_category");

		return TRUE;
	}

}
