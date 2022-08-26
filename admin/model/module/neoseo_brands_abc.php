<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoBrandsAbc extends NeoSeoModel {
	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_brands_abc";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function install() {
		$params = array(
			$this->_moduleSysName . "_status" => 1,
			$this->_moduleSysName . "_debug" => 0);
		
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting($this->_moduleSysName, $params);
		
		// Недостающие права
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'module/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'module/' . $this->_moduleSysName);

		return true;
	}

	public function uninstall() {
		return true;
	}
}