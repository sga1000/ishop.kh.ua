<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoReviewWidget extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_review_widget';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;

		$this->language->load("module/" . $this->_moduleSysName);
		$this->load->model("localisation/language");
		$languages = $this->model_localisation_language->getLanguages();
		foreach ($languages as $language) {
			$title[$language['language_id']] = $this->language->get('text_title');
		}

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'show_review_number' => 0,
			'show_author' => 1,
			'show_text' => 1,
			'show_rating' => 1,
			'show_date_added' => 1,
			'show_product' => 1,
			'show_product_image' => 0,
			'show_status' => 1,
			'limit' => 5,
			'height_image' => 100,
			'width_image' => 100,
			'title' => $title,
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
