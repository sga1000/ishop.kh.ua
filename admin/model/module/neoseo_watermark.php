<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoWatermark extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_watermark";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
		$this->language->load('module/' . $this->_moduleSysName);

		$this->load->model('setting/store');
		$stores = array();
		$stores[0] = array(
			"name" => $this->config->get('config_name') . $this->language->get('text_default'),
			"url" => rtrim($this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG, "/") . "/");
		foreach ($this->model_setting_store->getStores() as $store) {
			$stores[$store['store_id']] = array(
				"name" => $store['name'],
				"url" => rtrim($store["url"], "/") . "/");
		}

		foreach ($stores as $store_id => $store_data) {

			$data["status_${store_id}"] = 0;
			$data["transparent_${store_id}"] = 1;
			$data["hide_real_path_${store_id}"] = 1;
			$data["debug_${store_id}"] = 1;
			$data["exclude_${store_id}"] = "";
			$data["size_${store_id}"] = 0;
			$data["min_height_${store_id}"] = 10;
			$data["min_width_${store_id}"] = 10;
			$data["max_height_${store_id}"] = 100;
			$data["max_width_${store_id}"] = 100;
			$data["left_${store_id}"] = 0;
			$data["top_${store_id}"] = 0;
			$data["width_${store_id}"] = 0;
			$data["height_${store_id}"] = 0;
			$data["angle_${store_id}"] = 0;
			$data["default_image_width_${store_id}"] = 0;
			$data["default_image_height_${store_id}"] = 0;
			$data["default_image_left_${store_id}"] = 0;
			$data["default_image_angle_${store_id}"] = 0;
			$data["default_image_top_${store_id}"] = 0;
		}
		$data['debug'] = 0;
		$data['header_clear_cache'] = 0;

		$this->params = $data;
	}

	public function install()
	{
		$this->initParams($this->params);
	}

	public function uninstall()
	{

		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE code='" . $this->_moduleSysName . "'");
		return TRUE;
	}

	public function upgrade()
	{
		$this->initParams($this->params);
	}

}
