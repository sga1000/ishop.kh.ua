<?php
require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoSimpleExcelExchange extends NeoSeoModel {

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_simple_excel_exchange";
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get( $this->_moduleSysName() . "_debug") == 1;

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'import_action'=>'only_update'
			
		);
	}

	public function install()
	{
		$this->addPermission($this->user->getId(), 'access', 'tool/' . $this->_moduleSysName);
		$this->addPermission($this->user->getId(), 'modify', 'tool/' . $this->_moduleSysName);
		return TRUE;
	}

	public function uninstall()
	{
		$this->load->model('user/user_group');
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());

		return TRUE;
	}

	public function upgrade()
	{
		
	}
	
	

	

	
}
