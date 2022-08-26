<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoBlog extends NeoSeoModel
{
	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_blog';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_status') == 1;

		$this->params = array(
			'debug' => 0,
			'comment_auto_approval' => 0,
			'article_time_format' => '%Y-%m-%d',
			'comment_time_format' => '%Y-%m-%d',
			'image_article_list_width' => '200',
			'image_article_list_height' => '100',
			'image_article_block_width' => '400',
			'image_article_block_height' => '200',
			'image_product_block_width' => $this->config->get('config_image_product_width'),
			'image_product_block_height' => $this->config->get('config_image_product_height'),
			'image_category_block_width' => $this->config->get('config_image_category_width'),
			'image_category_block_height' => $this->config->get('config_image_category_height'),
			'image_author_block_width' => $this->config->get('config_image_category_width'),
			'image_author_block_height' => $this->config->get('config_image_category_height'),
		);
	}

	public function install()
	{
		$this->load->model('localisation/language');
		$this->load->language('module/' . $this->_moduleSysName);
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$text_complete[$language['language_id']] = $this->language->get('text_order_complete');
		}

		// Значения параметров по умолчанию
		$this->initParams($this->params);

		$this->installTables();

		return TRUE;
	}

	public function installTables()
	{
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_article` (
			  `article_id` INT NOT NULL AUTO_INCREMENT,
			  `author_id` INT NOT NULL,
			  `allow_comment` INT NOT NULL,
			  `image` TEXT NOT NULL,
			  `sort_order` INT NOT NULL,
			  `status` INT NOT NULL,
			  `viewed` INT NOT NULL,
			  `date_added` datetime NOT NULL,
			  `date_modified` datetime NOT NULL,
			   PRIMARY KEY (`article_id`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_article_description` (
			  `article_description_id` INT NOT NULL AUTO_INCREMENT,
			  `article_id` INT NOT NULL,
			  `language_id` INT NOT NULL,
			  `name` VARCHAR(255) NOT NULL,
			  `meta_title` VARCHAR(255) NOT NULL,
			  `meta_h1` VARCHAR(255) NOT NULL,
			  `teaser` TEXT NOT NULL,
			  `description` TEXT NOT NULL,
			  `meta_description` VARCHAR(255) NOT NULL,
			  `meta_keyword` VARCHAR(255) NOT NULL,
			  PRIMARY KEY (`article_description_id`),
			  KEY `article` (`article_id`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_article_related_product` (
			  `article_id` INT NOT NULL,
			  `product_id` INT NOT NULL,
			  PRIMARY KEY (`article_id`,`product_id`),
			  KEY `product` (`product_id`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_article_related_article` (
			  `related_article_id` INT NOT NULL AUTO_INCREMENT,
			  `article_id` INT NOT NULL,
			  `related_id` INT NOT NULL,
			  `sort_order` INT NOT NULL,
			  `status` INT NOT NULL,
			  `date_added` datetime NOT NULL,
			  PRIMARY KEY (`related_article_id`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_article_to_category` (
			  `article_id` INT NOT NULL,
			  `category_id` INT NOT NULL,
			  `main_category` INT NOT NULL DEFAULT '0',
			  PRIMARY KEY (`article_id`,`category_id`),
			  KEY `category` (`category_id`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_article_to_layout` (
			  `article_id` INT NOT NULL,
			  `store_id` INT NOT NULL,
			  `layout_id` INT NOT NULL,
			  PRIMARY KEY (`article_id`,`store_id`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_article_to_store` (
			  `article_id` INT NOT NULL,
			  `store_id` INT NOT NULL
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_author` (
			  `author_id` INT NOT NULL AUTO_INCREMENT,
			  `name` VARCHAR(255) NOT NULL,
			  `image` TEXT NOT NULL,
			  `status` INT NOT NULL,
			  `date_added` datetime NOT NULL,
			  `date_modified` datetime NOT NULL,
			  PRIMARY KEY (`author_id`),
			  KEY `author_status` (`author_id`,`status`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_author_description` (
			  `author_description_id` INT NOT NULL AUTO_INCREMENT,
			  `author_id` INT NOT NULL,
			  `language_id` INT NOT NULL,
			  `meta_title` VARCHAR(255) NOT NULL,
			  `meta_h1` VARCHAR(255) NOT NULL,
			  `teaser` TEXT NOT NULL,
			  `description` TEXT NOT NULL,
			  `meta_description` VARCHAR(255) NOT NULL,
			  `meta_keyword` VARCHAR(255) NOT NULL,
			  `date_added` datetime NOT NULL,
			  PRIMARY KEY (`author_description_id`),
			  KEY `author` (`author_id`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_category` (
			  `category_id` INT NOT NULL AUTO_INCREMENT,
			  `image` TEXT NOT NULL,
			  `parent_id` INT NOT NULL,
			  `sort_order` INT NOT NULL,
			  `status` INT NOT NULL,
			  `date_added` datetime NOT NULL,
			  `date_modified` datetime NOT NULL,
			  PRIMARY KEY (`category_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_category_description` (
			  `category_description_id` INT NOT NULL AUTO_INCREMENT,
			  `category_id` INT NOT NULL,
			  `language_id` INT NOT NULL,
			  `name` VARCHAR(255) NOT NULL,
			  `meta_title` VARCHAR(255) NOT NULL,
			  `meta_h1` VARCHAR(255) NOT NULL,
			  `teaser` TEXT NOT NULL,
			  `description` TEXT NOT NULL,
			  `meta_description` VARCHAR(255) NOT NULL,
			  `meta_keyword` VARCHAR(255) NOT NULL,
			  PRIMARY KEY (`category_description_id`),
			  KEY `category` (`category_id`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_category_path` (
			  `category_id` INT NOT NULL,
			  `path_id` INT NOT NULL,
			  `level` INT NOT NULL,
			  PRIMARY KEY (`category_id`,`path_id`)
			) ENGINE=MyISAM DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_category_to_layout` (
			  `category_id` INT NOT NULL,
			  `store_id` INT NOT NULL,
			  `layout_id` INT NOT NULL
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_category_to_store` (
			  `category_id` INT NOT NULL,
			  `store_id` INT NOT NULL
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "blog_comment` (
			  `comment_id` INT NOT NULL AUTO_INCREMENT,
			  `article_id` INT NOT NULL,
			  `comment_reply_id` INT NOT NULL,
			  `author` VARCHAR(255) NOT NULL,
			  `comment` TEXT NOT NULL,
			  `status` INT NOT NULL,
			  `date_added` datetime NOT NULL,
			  `date_modified` datetime NOT NULL,
			  `rating` INT NOT NULL,
			  PRIMARY KEY (`comment_id`)
			) DEFAULT CHARSET=utf8;");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "category_to_blog_article` (
			  `category_to_blog_article_id` INT NOT NULL AUTO_INCREMENT,
			  `category_id` INT NOT NULL,
			  `article_id` INT NOT NULL,
			  PRIMARY KEY (`category_to_blog_article_id`),
			  KEY (`category_id`)
			) DEFAULT CHARSET=utf8;");
	}

	public function upgrade()
	{
		$this->installTables();

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "blog_article_description` LIKE 'meta_h1'";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "blog_article_description`  ADD `meta_h1` VARCHAR(255) NOT NULL";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "blog_author_description` LIKE 'meta_h1'";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "blog_author_description`  ADD `meta_h1` VARCHAR(255) NOT NULL";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "blog_category_description` LIKE 'meta_h1'";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "blog_category_description`  ADD `meta_h1` VARCHAR(255) NOT NULL";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "blog_article_description` LIKE 'meta_title'";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "blog_article_description`  ADD `meta_title` VARCHAR(255) NOT NULL";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "blog_author_description` LIKE 'meta_title'";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "blog_author_description`  ADD `meta_title` VARCHAR(255) NOT NULL";
			$this->db->query($sql);
		}

		$sql = "SHOW COLUMNS FROM `" . DB_PREFIX . "blog_category_description` LIKE 'meta_title'";
		$query = $this->db->query($sql);
		if (!$query->num_rows) {
			$sql = "ALTER TABLE `" . DB_PREFIX . "blog_category_description`  ADD `meta_title` VARCHAR(255) NOT NULL";
			$this->db->query($sql);
		}
	}

	public function uninstall()
	{

		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_article");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_article_description");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_article_related_product");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_article_related_article");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_article_to_category");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_article_to_layout");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_article_to_store");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_author");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_author_description");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_category");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_category_description");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_category_path");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_category_to_layout");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_category_to_store");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "blog_comment");
		$this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "category_to_blog_article");

		return TRUE;
	}

}

?>