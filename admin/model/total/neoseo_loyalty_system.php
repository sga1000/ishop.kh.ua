<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelTotalNeoseoLoyaltySystem extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_loyalty_system';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_debug');
		$this->language->load($this->_route . '/' . $this->_moduleSysName);
		$this->load->model('localisation/language');
		$default_text = array();
		$stores = $this->getStores();
		foreach ( $stores as $tore)
		foreach ($this->model_localisation_language->getLanguages() as $language){
			$default_text[$tore['store_id']][$language['language_id']]= $this->language->get('incart_text');
		}

		// Значения параметров по умолчанию
		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'customer_discount_status' => 0,
			'group_discount_status' => 0,
			'cumulative_discount_status' => 0,
			'total_discount_status' => 0,
			'total_discount_gradation' => array(),
			'cumulative_discount_gradation' => array(),
			'excluded_categories' => array(),
			'excluded_manufacturers'  => array(),
			'excluded_products'  => array(),
			'sort_order' => 2,
			'personal_sort_order' => array('0' => 1),
			'group_sort_order' => array('0' => 2),
			'accumulative_sort_order' => array('0' => 3),
			'sum_sort_order' => array('0' => 4),
			'incart_text_status' => 0,
			'incart_text' => $default_text,
			'in_neoseo_checkout_text_status' => 0,
			'in_neoseo_checkout_text' => $default_text,
		);
	}

	public function install()
	{
		$this->initParams($this->params);

		$this->installTables();

		// Пермишены
		$this->addPermission($this->user->getId(), 'access', 'total/'. $this->_moduleSysName);
		$this->addPermission($this->user->getId(), 'modify', 'total/'. $this->_moduleSysName);

		return TRUE;
	}

	public function upgrade()
	{
		$this->installTables();
	}
	
	public function installTables(){
		
		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "loyalty_customer_discount` (
			`customer_discount_id` int(11) NOT NULL AUTO_INCREMENT,
			`customer_id` int(11),
			`discount` decimal(15,4) NOT NULL,
			PRIMARY KEY (`customer_discount_id`)
			) CHARACTER SET utf8 COLLATE utf8_general_ci;";
		$this->db->query($sql);

		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "loyalty_group_discount` (
			`group_discount_id` int(11) NOT NULL AUTO_INCREMENT,
			`group_id` int(11),
			`discount` decimal(15,4) NOT NULL,
			PRIMARY KEY (`group_discount_id`)
			) CHARACTER SET utf8 COLLATE utf8_general_ci;";
		$this->db->query($sql);
	}

	public function uninstall()
	{
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "loyalty_customer_discount`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "loyalty_group_discount`");

		// Пермишены
		$this->load->model('user/user_group');
		$this->model_user_user_group->removePermission($this->user->getId(), 'access', 'total/' . $this->_moduleSysName);
		$this->model_user_user_group->removePermission($this->user->getId(), 'modify', 'total/' . $this->_moduleSysName);

		return TRUE;
	}

}

?>