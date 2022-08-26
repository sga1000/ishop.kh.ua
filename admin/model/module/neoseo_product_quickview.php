<?php
require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoProductQuickview extends NeoSeoModel {
	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_product_quickview";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;

		$this->params = array(
			$this->_moduleSysName . "_status" => 1,
			$this->_moduleSysName . "_debug" => 0,
		);
	}

	public function install(){
		// Недостающие таблицы
		// Недостающие права
		// Настройки по умолчанию
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting($this->_moduleSysName, $this->params);

		return true;
	}

	public function uninstall() {
		return true;
	}

	public function upgrade() {
		return true;
	}
}