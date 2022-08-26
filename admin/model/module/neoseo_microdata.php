<?php

require_once(DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoMicrodata extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_microdata';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_debug') == 1;

		$this->load->model('localisation/language');

		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$address_locality[$language['language_id']] = '';
			$address_region[$language['language_id']] = '';
			$street_address[$language['language_id']] = '';
		}

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'address_region' => $address_region,
			'address_locality' => $address_locality,
			'postal_code' => '',
			'street_address' => $street_address,
			'stock_status' => array(
				7 => 1,
				8 => 2,
			)
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

        $this->load->model('user/user_group');
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'tool/' . $this->_moduleSysName);
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'tool/' . $this->_moduleSysName);

		return TRUE;
	}

	public function upgrade()
	{

		// Добавляем недостающие новые параметры
		$this->initParams($this->params);
	}

	public function uninstall()
	{

        $this->load->model('user/user_group');

        $this->model_user_user_group->removePermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
        $this->model_user_user_group->removePermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());

		return TRUE;
	}

}

