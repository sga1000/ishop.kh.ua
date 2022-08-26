<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoDisplayMore extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_display_more';
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

		$this->params = array(
			'status' => 1,
			'status_more_btn_enable' => 0,
			'status_pagination' => 0,
			'debug' => 0,
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		return TRUE;
	}

	public function installTables()
	{
		
	}

	public function uninstall()
	{
		return TRUE;
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		// Создаем недостающие таблицы в актуальной структуре
		$this->installTables();
	}

}
