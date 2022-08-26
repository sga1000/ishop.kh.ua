<?php
require_once(DIR_SYSTEM.'/engine/neoseo_model.php');

class ModelModuleNeoseoSmartSearch extends NeoSeoModel {
	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_smart_search';
		$this->_logFile = $this->_moduleSysName.'.log';
		$this->debug = $this->config->get($this->_moduleSysName.'_debug') == 1;

		$this->params = array(
			"status" => 1,
			"debug" => 0,
			"name_status" => 1,
			"model_status" => 0,
			"sku_status" => 1,
			"show_categories" => 0,
			"product_limit" => 4,
			"image_status" => 1,
			"image_width" => 40,
			"image_height" => 40,
			"price_status" => 1,
			"rating_status" => 0,
			"description_limit" => 100,
			"selector" => "[name=search]:not(#input-search)",
		);

	}

	public function install() {

		// Значения параметров по умолчанию
		$this->initParams($this->params);

		return true;
	}

	public function uninstall() {
		return true;
	}

	public function upgrade() {

		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		return true;
	}
}