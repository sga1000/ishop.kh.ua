<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoNotesWidget extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_notes_widget';
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
			'title' => $title,
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		// Добавляем права на нестандартные контроллеры, если они используются
		$this->load->model('user/user_group');
		$this->model_user_user_group->addPermission($this->user->getId(), 'access', 'dashboard/' . $this->_moduleSysName);
		$this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'dashboard/' . $this->_moduleSysName);

		return TRUE;
	}

	public function installTables()
	{
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "notes` (
				`note_id` INT NOT NULL AUTO_INCREMENT,
				`title` varchar(255) NOT NULL, 
				`text` text NOT NULL, 
				`use_notification` int(1) DEFAULT 0, 
				`date_notification` datetime NOT NULL,
				`text_notification` varchar(255) NOT NULL, 
				`show_dashboard` int(1) DEFAULT 0, 
				`sort_order`  int(11) DEFAULT 0,  
				`color` varchar(255) NOT NULL, 
				`font_color` varchar(255) NOT NULL, 
				`notification` int(1) DEFAULT 0, 
				PRIMARY KEY (`note_id`)
				) DEFAULT CHARSET=utf8;");
		return TRUE;
	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();
	}

	public function uninstall()
	{
		// Удаляем таблицы модуля
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "notes");

		return TRUE;
	}

}
