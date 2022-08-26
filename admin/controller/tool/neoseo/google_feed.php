<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerToolNeoSeoGoogleFeed extends NeoSeoController {

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo/google_feed";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

}
