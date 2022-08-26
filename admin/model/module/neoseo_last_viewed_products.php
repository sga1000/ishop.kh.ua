<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoLastViewedProducts extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_last_viewed_products";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	// Install/Uninstall
	public function install($store_id = 0)
	{
		$params = array(
			'neoseo_last_viewed_products_status' => 1,
			'neoseo_last_viewed_products_debug' => 0,
			'neoseo_last_viewed_products_view' => 0,
		);
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('neoseo_last_viewed_products', $params);
		return TRUE;
	}

	public function uninstall()
	{
        $query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "setting`  LIKE 'group'");

        if( $query->num_rows != 0 ) {
            $this->db->query("DELETE FROM `" . DB_PREFIX . "setting` WHERE `group` = 'neoseo_last_viewed_products'");
        }
		return TRUE;
	}

	public function upgrade()
	{
		
	}

}
