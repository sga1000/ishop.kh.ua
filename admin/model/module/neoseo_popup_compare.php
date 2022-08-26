<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoPopupCompare extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleName = "";
		$this->_moduleSysName = "neoseo_popup_compare";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;

		$this->params = array(
			$this->_moduleSysName . "_status" => 1,
			$this->_moduleSysName . "_debug" => 0,
		);
	}

	public function install()
	{

		// Недостающие таблицы
		// Недостающие права
		// Настройки по умолчанию
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting($this->_moduleSysName, $this->params);

		return TRUE;
	}

	public function uninstall()
	{

		return TRUE;
	}

}

?>