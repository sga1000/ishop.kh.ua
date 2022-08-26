<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelShippingNeoSeoShippingPlus extends NeoSeoModel {
	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_shippingplus";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function install() {
        $this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "shippingplus` (
			`shipping_id` int(11) NOT NULL AUTO_INCREMENT,
			`status` int(11) DEFAULT NULL,
			`sort_order` int(11) DEFAULT '0',
			`price_min` decimal(10,0) DEFAULT NULL,
			`price_max` decimal(10,0) DEFAULT NULL,
			`fix_payment` decimal(10,0) DEFAULT NULL,
			`geo_zone_id` int(11) DEFAULT NULL,
			`geo_zones_id` longtext,
			`cities` longtext,
			`weight_price` longtext,
			`stores` longtext,
			PRIMARY KEY (`shipping_id`)
			) DEFAULT CHARSET=utf8 ;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "shippingplus_description` (
			`id` int(11) NOT NULL AUTO_INCREMENT,
			`shipping_id` int(11) DEFAULT NULL,
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
        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "shippingplus` LIKE 'weight_price'";
        $query = $this->db->query($sql);
        if( !$query->num_rows ) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "shippingplus` ADD `weight_price` longtext";
            $this->db->query($sql);
        }

        $sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "shippingplus` LIKE 'fix_payment'";
        $query = $this->db->query($sql);
        if( !$query->num_rows ) {
            $sql = "ALTER TABLE `" . DB_PREFIX . "shippingplus` ADD `fix_payment` decimal(10,0)";
            $this->db->query($sql);
        }

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "shippingplus` LIKE 'geo_zones_id'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "shippingplus` ADD `geo_zones_id` longtext";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "shippingplus` LIKE 'stores'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "shippingplus` ADD `stores` longtext COLLATE 'utf8_general_ci' NULL";
			$this->db->query($sql);
		}
    }

	public function uninstall() {
		$this->load->model('setting/setting');
		$this->model_setting_setting->deleteSetting($this->_moduleSysName, $this->config->get('config_store_id'));

		$this->db->query("DROP TABLE IF EXISTS
			`" . DB_PREFIX . "shippingplus_description`,
			`" . DB_PREFIX . "shippingplus`");

		return true;
	}
}
