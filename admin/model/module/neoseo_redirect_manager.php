<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoRedirectManager extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_redirect_manager";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;

		// Значения параметров по умолчанию
		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'joomla_status' => 0,
			'joomla_product' => "shop.product_details",
			'joomla_category' => "shop.browse",
			'oscommerce_status' => 0,
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		// Пермишены
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'tool/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'tool/' . $this->_moduleSysName);

		return TRUE;
	}

	public function installTables()
	{
		$sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "redirect` (";
		$sql .= " `redirect_id` int(11) NOT NULL AUTO_INCREMENT,";
		$sql .= " `active` tinyint(1) NOT NULL DEFAULT '0',";
		$sql .= " `from_url` varchar(256) NOT NULL,";
		$sql .= " `to_url` varchar(256) NOT NULL,";
		$sql .= " `response_code` int(3) NOT NULL DEFAULT '301',";
		$sql .= " `date_start` date NOT NULL DEFAULT '0000-00-00',";
		$sql .= " `date_end` date NOT NULL DEFAULT '0000-00-00',";
		$sql .= " `times_used` int(5) NOT NULL DEFAULT '0',";
		$sql .= " PRIMARY KEY (`redirect_id`),";
		$sql .= " KEY `from_url` (`from_url`)";
		$sql .= ") CHARSET=utf8 COLLATE=utf8_general_ci";
		$this->db->query($sql);
	}

	public function upgrade()
	{
		return TRUE;
	}

	public function uninstall()
	{
		// Пермишены
		$this->load->model('user/user_group');
		$this->model_user_user_group->removePermission($this->user->getId(), 'access', 'module/' . $this->_moduleSysName);
		$this->model_user_user_group->removePermission($this->user->getId(), 'modify', 'module/' . $this->_moduleSysName);
		$this->model_user_user_group->removePermission($this->user->getId(), 'access', 'tool/' . $this->_moduleSysName);
		$this->model_user_user_group->removePermission($this->user->getId(), 'modify', 'tool/' . $this->_moduleSysName);

		return TRUE;
	}

}

?>