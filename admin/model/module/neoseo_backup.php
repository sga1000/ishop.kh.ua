<?php
require_once(DIR_SYSTEM.'/engine/neoseo_model.php');

class ModelModuleNeoSeoBackup extends NeoSeoModel {
	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_backup';
		$this->_logFile = $this->_moduleSysName.'.log';
		$this->debug = $this->config->get($this->_moduleSysName.'_status') == 1;
	}

	public function install() {
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'tool/'.$this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'tool/'.$this->_moduleSysName);

		return true;
	}

	public function uninstall() {
		return true;
	}

	public function upgrade() {
		return true;
	}
}