<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoBackupWidget extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_backup_widget';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;

		$this->language->load("module/" . $this->_moduleSysName);
		$this->load->model("localisation/language");
		$languages = $this->model_localisation_language->getLanguages();
		foreach ($languages as $language) {
			$title[$language['language_id']] = $this->language->get('text_title');
		}

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'limit' => 1,
			'title' => $title,
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Добавляем права на нестандартные контроллеры, если они используются
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'dashboard/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'dashboard/' . $this->_moduleSysName);


		return TRUE;
	}

	public function installTables()
	{
		return TRUE;
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);
	}

	public function uninstall()
	{
		return TRUE;
	}

}