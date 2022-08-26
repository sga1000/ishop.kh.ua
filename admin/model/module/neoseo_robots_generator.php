<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoRobotsGenerator extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleName = "NeoSeo Robots Generator";
		$this->_moduleSysName = "neoseo_robots_generator";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get("neoseo_robots_generator_debug");
	}

	public function install()
	{
		$params = array(
			$this->_moduleSysName . '_status' => 1,
			$this->_moduleSysName . '_debug' => 0,
		);

		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting($this->_moduleSysName, $params);

		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'tool/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'tool/' . $this->_moduleSysName);

		return TRUE;
	}

	public function uninstall()
	{
		$this->db->query("DELETE FROM `" . DB_PREFIX . "setting` WHERE `code` = '" . $this->_moduleSysName . "'");
		return TRUE;
	}

}

?>