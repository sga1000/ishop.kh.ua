<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoWidgetOrders extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_widget_orders';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;

		$order_status_id = $this->config->get('config_order_status_id');

		$this->language->load("module/" . $this->_moduleSysName);
		$this->load->model("localisation/language");
		$languages = $this->model_localisation_language->getLanguages();
		foreach ($languages as $language) {
			$title[$language['language_id']] = $this->language->get('text_title');
		}

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'show_order_number' => 1,
			'show_customer' => 1,
			'show_customer_email' => 1,
			'show_customer_telephone' => 1,
			'show_order_status' => 1,
			'show_date_added' => 1,
			'show_order_total' => 1,
			'show_order_view' => 1,
			'show_comment' => 0,
			'show_order_referrer' => 0,
			'limit' => 5,
			'product_image_width' => 50,
			'product_image_height' => 50,
			'title' => $title,
			'order_statuses' => array($order_status_id),
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
		return TRUE;
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);
	}

	public function uninstall()
	{
		return TRUE;
	}

}
