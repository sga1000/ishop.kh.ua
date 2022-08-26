<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoAccount extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_account";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	// Install/Uninstall
	public function install()
	{
		$this->load->model('localisation/language');
		$this->load->language('module/' . $this->_moduleSysName);
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$text_title[$language['language_id']] = $this->language->get('text_title_default');
		}
		$this->initParamsDefaults(array(
			'status' => 0,
			'debug' => 0,
			'social_status' => 1,
			'social_sort' => 0,
			'social_title' => $text_title,
			'social_networks' => array('googleplus', 'instagram', 'vkontakte', 'facebook'),
		));
		$this->upgrade();
	}

	public function upgrade()
	{
		$this->alterTables();
	}

	public function alterTables()
	{
		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer` LIKE 'identity';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer` ADD COLUMN identity  VARCHAR(255) NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer` LIKE 'network';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer` ADD COLUMN network  VARCHAR(255) NULL;";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "customer` LIKE 'profile';";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "customer` ADD COLUMN profile  VARCHAR(255) NULL;";
			$this->db->query($sql);
		}
	}

	public function uninstall()
	{
		
	}

}
