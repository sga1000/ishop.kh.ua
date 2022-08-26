<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoCategoryMenu extends NeoSeoModel {

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_category_menu";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	// Install/Uninstall
    public function install() {
        $params = array(
            $this->_moduleSysName.'_status' => 1,
            $this->_moduleSysName.'_debug' => 0,
            $this->_moduleSysName.'_view' => 0,
        );
        $this->load->model('setting/setting');
        $this->model_setting_setting->editSetting($this->_moduleSysName, $params);
        return TRUE;
    }

    public function uninstall() {
        return TRUE;
    }

    public function upgrade() {
        
    }

}
