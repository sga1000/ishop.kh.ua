<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoQuickSetup extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_quick_setup';
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'complete' => 0,
			'complete2' => 0,
			'complete3' => 0,
			'complete4' => 0,
			'neoseo_unistor_phone1' => '',
			'neoseo_unistor_phone2' => '',
			'neoseo_unistor_phone3' => '',
			'neoseo_unistor_scheme_style'=> '',
			'neoseo_unistor_logo'=> '',
			//'neoseo_unistor_work_time'=> '',
			'neoseo_unistor_contact_google_api_key'=> '', // Карта не заработает без координат !!!
			'neoseo_unistor_contact_map'=> 'none',
			'neoseo_unistor_menu_main_type' => 'menu_hybrid',
			'neoseo_unistor_contact_latitude' => '',
			'neoseo_unistor_contact_longitude' => '',
			'neoseo_unistor_general_style' => 0,
			'neoseo_unistor_use_wide_style' => 0,
			'neoseo_unistor_delivery' => '',
			'neoseo_unistor_payment' => '',
			'neoseo_unistor_guarantee' => '',
			'neoseo_google_analytics_code' => array(),
			'neoseo_jivosite_code' => array(),

			'config_langdata' =>array(),
			'config_email' => '',
			'config_language' => 'ru',
			'config_admin_language' => 'ru',
			'config_country_id' => 220,
			'config_zone_id' => 0,
			'config_currency' => 'USD',
			'config_icon' => '',

			'config_seo_url_include_path' => 1,
			'config_category_short' => 0,
			'neoseo_fast_sitemap_seo_lang_status' => 1,

			/* Лучше просто отключить маленькие слайды. В модуле со старта сделать без маленьких 1200*400 */
			'big_slides' => array(), // Указать размер слайдов. большие 1200 * 400 без маленьких слайдов с маленькими 800*400
			'small_slides' => array(), // 400*200, 400*130
		);
	}

	public function getMultistoreOptions()
	{
		// Опции которіе используются в мультимагазине
		return array(
			'neoseo_google_analytics_code',
			'neoseo_jivosite_code',
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		// Добавляем права на нестандартные контроллеры, если они используются
		//$this->load->model('user/user_group');
		//$this->model_user_user_group->addPermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
		//$this->model_user_user_group->addPermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());

		// Добавляем обработчики событий, если они у нас есть
		//$this->load->model('extension/event');
		//$this->model_extension_event->addEvent($this->_moduleSysName(), 'post.order.history.add', 'module/neoseo_quick_setup/handle');

		return TRUE;
	}

	public function installTables(){
		/*$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "neoseo_module` (
              `neoseo_module_id` INT NOT NULL AUTO_INCREMENT,
              `date_modified` datetime NOT NULL,
               PRIMARY KEY (`neoseo_module_id`)
            ) DEFAULT CHARSET=utf8;");*/
	}

	public function upgrade(){

		// Добавляем недостающие новые параметры
		$this->initParams($this->params);

		// Создаем недостающие таблицы в актуальной структуре
		$this->installTables();

		// Удаляем лишние столбцы
		/*$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_module` LIKE 'meta_h1'";
		$query = $this->db->query($sql);
		if( $query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_module`  DROP `meta_h1`";
			$this->db->query($sql);
		}*/

		// Добавляем недостающие столбцы
		/*$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "neoseo_module` LIKE 'date_modified'";
		$query = $this->db->query($sql);
		if( !$query->num_rows ) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "neoseo_module`  ADD `date_modified` VARCHAR(255) NOT NULL";
			$this->db->query($sql);
		}*/

	}

	public function uninstall()
	{
		// Удаляем таблицы модуля
		/*$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "neoseo_module");

		// Удаляем обработчики событий, если они у нас есть
		$this->load->model('extension/event');
		$this->model_extension_event->deleteEvent($this->_moduleSysName());

		// Удаляем права на нестандартные контроллеры, если они используются
		$this->load->model('user/user_group');
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());*/

		return TRUE;
	}

}

