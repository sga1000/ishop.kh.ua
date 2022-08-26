<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoFilterTag extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_filter_tag";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function install()
	{
		return TRUE;
	}

	public function upgrade()
	{
		return TRUE;
	}

	public function uninstall()
	{
		return TRUE;
	}

}

?>