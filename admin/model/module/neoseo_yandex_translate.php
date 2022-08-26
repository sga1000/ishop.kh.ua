<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoYandexTranslate extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_yandex_translate";
		$this->_modulePostfix = "";
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug") == 1;

		$this->params = array(
			'status' => 1,
			'debug' => 0,
			'api_key' => '',
			'params' => array('name', 'description', 'meta_title', 'meta_description', 'meta_keyword', 'meta_h1', 'tag',),
			'params_blog_articles' => array('name', 'description', 'teaser', 'meta_title', 'meta_h1', 'meta_description', 'meta_keyword',),
			'params_blog_categories' => array('name', 'description', 'meta_title', 'meta_h1', 'meta_description', 'meta_keyword',),
			'params_blog_authors' => array('teaser', 'description', 'meta_title', 'meta_h1', 'meta_description', 'meta_keyword',),
			'proxy' => '',
			'from_language' => 1,
			'from_language_blog_articles' => 1,
			'from_language_blog_categories' => 1,
			'from_language_blog_authors' => 1,
			'translate_source' => 0,
			'translate_source_blog_articles' => 0,
			'translate_source_blog_categories' => 0,
			'translate_source_blog_authors' => 0,
			"code_list" => '',
		);
	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);

		// Создаем новые и недостающие таблицы в актуальной структуре
		$this->installTables();

		// Недостающие права
		// Добавляем права на нестандартные контроллеры, если они используются
		$this->addPermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
		$this->addPermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());

		return TRUE;
	}

	public function uninstall()
	{
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "product_to_translate");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "article_to_translate");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "category_to_translate");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "author_to_translate");

		$this->load->model('user/user_group');
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'access', 'tool/' . $this->_moduleSysName());
		$this->model_user_user_group->removePermission($this->user->getGroupId(), 'modify', 'tool/' . $this->_moduleSysName());

		return TRUE;
	}

	public function installTables()
	{
		// Создаем недостающие таблички
		$this->db->query("
        CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "product_to_translate` (
            `translate_id` int(11) NOT NULL AUTO_INCREMENT,
            `trans_product_id` int(11) NOT NULL,
            `trans_status` int(11) NOT NULL,
            `trans_date` date NOT NULL,
            PRIMARY KEY (`translate_id`)
        ) DEFAULT CHARSET=utf8;
		");

		$this->db->query("
        CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "article_to_translate` (
            `translate_id` int(11) NOT NULL AUTO_INCREMENT,
            `trans_article_id` int(11) NOT NULL,
            `trans_status` int(11) NOT NULL,
            `trans_date` date NOT NULL,
            PRIMARY KEY (`translate_id`)
        ) DEFAULT CHARSET=utf8;
		");

		$this->db->query("
        CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "category_to_translate` (
            `translate_id` int(11) NOT NULL AUTO_INCREMENT,
            `trans_category_id` int(11) NOT NULL,
            `trans_status` int(11) NOT NULL,
            `trans_date` date NOT NULL,
            PRIMARY KEY (`translate_id`)
        ) DEFAULT CHARSET=utf8;
		");

		$this->db->query("
        CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "author_to_translate` (
            `translate_id` int(11) NOT NULL AUTO_INCREMENT,
            `trans_author_id` int(11) NOT NULL,
            `trans_status` int(11) NOT NULL,
            `trans_date` date NOT NULL,
            PRIMARY KEY (`translate_id`)
        ) DEFAULT CHARSET=utf8;
		");
	}


	public function upgrade()
	{
		$this->initParams($this->params);

		$this->installTables();
	}

}

?>