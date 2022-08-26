<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoInformativeMessage extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_informative_message";
		$this->_modulePostfix = "";
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

		$this->load->model('localisation/language');

		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$message[$language['language_id']] = '';
			$button_text[$language['language_id']] = 'Закрыть';
		}

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'show_close_button' => 0,
			'close_button_text' => $button_text,
			'color_background' => '#0655c9',
			'color_close_button' => '#1292d9',
			'text' => $message,
		);
	}

	public function install()
	{

		$this->initParams($this->params);
		return TRUE;
	}

	public function upgrade()
	{
		$this->initParams($this->params);
		return TRUE;
	}

	public function uninstall()
	{
		return TRUE;
	}

}

?>