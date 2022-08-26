<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoseoTestimonialsWidget extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_testimonials_widget';
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
			'show_testimonial_number' => 0,
			'show_text' => 1,
			'show_admin_text' => 1,
			'show_author' => 1,
			'show_rating' => 1,
			'show_date_added' => 1,
			'show_youtube' => 0,
			'show_image' => 0,
			'show_status' => 1,
			'limit' => 5,
			'height_image' => 100,
			'width_image' => 100,
			'title' => $title,
			'method' => array(2),
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Добавляем права на нестандартные контроллеры, если они используются
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'dashboard/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'dashboard/' . $this->_moduleSysName);
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
