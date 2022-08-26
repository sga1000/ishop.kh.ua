<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoText extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_text";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index($setting)
	{
		$content = '';
		if (isset($setting['content'][(int) $this->config->get('config_language_id')])) {
			$content = $setting['content'][(int) $this->config->get('config_language_id')];
		}
		return html_entity_decode($content);
	}

}

?>