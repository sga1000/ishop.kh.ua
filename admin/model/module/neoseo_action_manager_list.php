<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoActionManagerList extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_action_manager';
		$this->_modulePostfix = "_list"; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_status') == 1;

		$this->load->model('localisation/language');
		$this->language->load($this->_route . '/' . $this->_moduleSysName());
		$defaultTitle = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$defaultTitle[$language['language_id']] = $this->language->get('text_default_title');
		}
		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'name' => "",
			'title' => $defaultTitle,
			'view' => 0,
			'block' => 0,
			'limit' => 4,
			'description_limit' => 80,
			'template' => "default",
			'image_height' => 240,
			'image_width' => 240,
		);
	}

	// Install/Uninstall
	public function install()
	{
		$this->initParams($this->params);
		return TRUE;
	}

	public function uninstall()
	{
		return TRUE;
	}

	public function upgrade()
	{
		return TRUE;
	}

}

?>