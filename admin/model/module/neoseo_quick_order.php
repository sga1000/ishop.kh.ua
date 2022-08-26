<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoQuickOrder extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_quick_order';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;
	}

	public function install()
	{

		$this->load->model('localisation/language');
		$this->load->language('module/' . $this->_moduleSysName);
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$text_complete[$language['language_id']] = $this->language->get('text_order_complete');
		}

		// Значения параметров по умолчанию
		$this->initParamsDefaults(array(
			'status' => 1,
			'debug' => 0,
			'phone_mask' => '+38 (099) 999-99-99',
			'order_status_id' => $this->config->get('config_order_status_id'),
			'ecommerce' => 0,
			'image_width' => 240,
			'image_height' => 240,
			'status_product' => 1,
			'status_popup_cart' => 1,
			'status_cart' => 1,
			'status_popup_form' => 1,
			'text_complete' => $text_complete,
			'product_template' => 'product_template_form',
			'popup_cart_template' => 'popup_cart_template_form',
			'cart_template' => 'cart_template_form',
			'popup_form_template' => 'popup_form_template_form',
			'country_id' => $this->config->get('config_country_id'),
			'agreement_id'=> 3,
			'agreement_default'=> 1,
		));

		return TRUE;
	}

	public function uninstall()
	{
		return TRUE;
	}

}
