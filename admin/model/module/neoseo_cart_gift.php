<?php

require_once( DIR_SYSTEM . '/engine/neoseo_model.php');

class ModelModuleNeoSeoCartGift extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_cart_gift';
		$this->_modulePostfix = ''; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

		$this->defaultTitle = $this->getDefaultTitle('text_default_title');
		$this->defaultGiftTitle = $this->getDefaultTitle('text_default_gift_title');
		$this->defaultEmptyTitle = $this->getDefaultTitle('text_default_empty_title');

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'title' => $this->defaultTitle,
			'gift_title' => $this->defaultGiftTitle,
			'show_gifts' => 0,
			'image_width' => 50,
			'image_height' => 50,
			'gift_status' => 1,
			'gift_name' => '',
			'min_price' => 0,
			'customer_groups' => array(),
			'stores' => array(),
			'product_statuses' => array(),
			'allow_on_empty_cart' => 0,
			'empty_cart_text' => $this->defaultEmptyTitle,
			'new_user' => array(),
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

	public function installTables(){
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "gift` (
              `gift_id` INT NOT NULL AUTO_INCREMENT,
              `name` varchar(255) NOT NULL,
              `min_price` int(11) NOT NULL,
              `status` int(1) NOT NULL,
               PRIMARY KEY (`gift_id`)
            ) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "gift_to_customer` (
              `gift_to_customer_id` INT NOT NULL AUTO_INCREMENT,
              `gift_id` int(11) NOT NULL,
              `customer_group_id` int(11) NOT NULL,
               PRIMARY KEY (`gift_to_customer_id`),
               KEY `gift_to_customer` (`gift_id`,`customer_group_id`)
            ) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "gift_to_store` (
              `gift_to_store_id` INT NOT NULL AUTO_INCREMENT,
              `gift_id` int(11) NOT NULL,
              `store_id` int(11) NOT NULL,
               PRIMARY KEY (`gift_to_store_id`),
               KEY `gift_to_store` (`gift_id`,`store_id`)
            ) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "gift_to_product` (
              `gift_to_product_id` INT NOT NULL AUTO_INCREMENT,
              `gift_id` int(11) NOT NULL,
              `product_id` int(11) NOT NULL,
               PRIMARY KEY (`gift_to_product_id`),
               KEY `gift_to_product` (`gift_id`,`product_id`)
            ) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "gift_is_selected` (
			  `selected_gift_id` INT NOT NULL AUTO_INCREMENT,
    		  `cart_id` int(11) NOT NULL,
              `product_id` int(11) NOT NULL,
              `session_id` varchar(32) NOT NULL,
              `customer_id` int(11) NOT NULL,
    		   PRIMARY KEY (`selected_gift_id`)
            ) DEFAULT CHARSET=utf8;");

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer` LIKE 'gift';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer`  ADD COLUMN `gift` tinyint(1) NOT NULL  DEFAULT '0';";
			$this->db->query($sql);
		}
	}

	public function upgrade(){
		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();
	}

	public function uninstall()
	{
		// Удаляем таблицы модуля
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "gift");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "gift_to_customer");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "gift_to_store");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "gift_to_product");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "gift_is_selected");

		// Удаляем лишние столбцы
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer` LIKE 'gift'";
		$query = $this->db->query($sql);
		if( $query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer`  DROP `gift`";
			$this->db->query($sql);
		}

		return TRUE;
	}

	private function getDefaultTitle($key)
	{
		$this->load->model('localisation/language');
		$data = $this->load->language('module/' . $this->_moduleSysName());

		$defaultTitle = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$defaultTitle[$language['language_id']] = $data[$key];
		}

		return $defaultTitle;
	}
}

