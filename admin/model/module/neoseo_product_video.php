<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoProductVideo extends NeoseoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_product_video";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;

		$this->params = array(
		 'status' => 1,
		 'debug' => 0,
		 "get_yt_image" => 1
		);
	}

	// Install/Uninstall
	public function install()
	{
		$this->initParams($this->params);
		$this->installTables();
		return TRUE;
	}

	public function upgrade()
	{
		$this->initParams($this->params);
		$this->installTables();
	}

	public function uninstall()
	{
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_video");

	}

	protected function installTables()
	{
		$this->db->query(
		 'CREATE TABLE IF NOT EXISTS `' . DB_PREFIX . 'product_video` (
			`video_id` int(11) NOT NULL,
			`product_id` int(11) NOT NULL,
			`product_image_id` int(11) NOT NULL,
			`language_id` int(11) NOT NULL,
			`store_id` int(11) NOT NULL,
			`video_url` varchar(255) NOT NULL,
			KEY `video_id` (`video_id`),
			KEY `product_image_id` (`product_image_id`)
			) DEFAULT CHARSET=utf8'
		);
	}

}
