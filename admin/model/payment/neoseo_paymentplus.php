<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelPaymentNeoSeoPaymentPlus extends NeoSeoModel {
	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_paymentplus";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function install() {
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "paymentplus` (
			`payment_id` int(11) NOT NULL AUTO_INCREMENT,
			`status` int(11) DEFAULT NULL,
			`sort_order` int(11) DEFAULT '0',
			`price_min` decimal(10,0) DEFAULT NULL,
			`price_max` decimal(10,0) DEFAULT NULL,
			`geo_zone_id` int(11) DEFAULT NULL,
			`order_status_id` int(11) DEFAULT NULL,
			`cities` longtext,
			`stores` longtext,
			PRIMARY KEY (`payment_id`)
		) DEFAULT CHARSET=utf8 ;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "paymentplus_description` (
				`id` int(11) NOT NULL AUTO_INCREMENT,
				`payment_id` int(11) DEFAULT NULL,
				`language_id` int(11) DEFAULT NULL,
				`name` varchar(255) DEFAULT NULL,
				`description` text,
				PRIMARY KEY (`id`)
			) DEFAULT CHARSET=utf8 ;");

		$params = array(
			$this->_moduleSysName . "_status" => 1,
			$this->_moduleSysName . "_debug" => 0,
			$this->_moduleSysName . "_sort_order" => '');

		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting($this->_moduleSysName, $params);

		return true;
	}

	public function upgrade() {
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "paymentplus` LIKE 'stores'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "paymentplus` ADD `stores` longtext COLLATE 'utf8_general_ci' NULL";
			$this->db->query($sql);
		}
	}

	public function uninstall() {
		$this->load->model('setting/setting');
		$this->model_setting_setting->deleteSetting($this->_moduleSysName, $this->config->get('config_store_id'));

		$this->db->query("DROP TABLE IF EXISTS
			`" . DB_PREFIX . "paymentplus_description`,
			`" . DB_PREFIX . "paymentplus`");

		return true;
	}

}
