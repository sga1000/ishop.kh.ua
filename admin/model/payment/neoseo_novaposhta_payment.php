<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelPaymentNeoseoNovaposhtaPayment extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_novaposhta';
		$this->_modulePostfix = "_payment"; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

		$this->params = array(
			'status' => 0,
			'debug' => 0,
			'sort_order' => 0,
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();


		return TRUE;
	}

	public function installTables()
	{

	}

	public function upgrade()
	{

	}

	public function uninstall()
	{

		return TRUE;
	}

}

