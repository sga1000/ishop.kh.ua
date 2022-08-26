<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoCarousel extends NeoSeoModel
{
	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_carousel";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	// Install/Uninstall
	public function install()
	{
	}

	public function uninstall()
	{
	}

	public function upgrade()
	{
	}

}
