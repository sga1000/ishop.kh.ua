<?php

require_once(DIR_SYSTEM . '/engine/neoseo_model.php');

class ModelTotalNeoseoProductBundles extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_product_bundles';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'sort_order' => 0,
			'price_type' => 'clear_price',
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);
		$this->load->model('user/user_group');
		$this->addPermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName);
		$this->addPermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName);

		return true;
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);
	}

	public function uninstall()
	{
		return true;
	}

}
