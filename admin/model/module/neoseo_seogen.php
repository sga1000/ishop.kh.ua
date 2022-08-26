<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoSeogen extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_seogen";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;

		$this->params = array(
			'debug' => 0,
			'status' => 1,
			'limit_title' => 160,
			'limit_description' => 300,
			'option_name_value_separator' => '-',
			'option_values_separator' => ',',
			'options_separator' => ';',
			'attribute_name_value_separator' => '-',
			'attributes_separator' => ';',
			'language' => $this->config->get('config_language_id'),
		);
	}

	public function install()
	{
		$this->initParams($this->params);

		$this->load->model('extension/event');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.product.add', 'tool/neoseo_seogen/handler_product');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.product.edit', 'tool/neoseo_seogen/handler_product');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.category.add', 'tool/neoseo_seogen/handler_category');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.category.edit', 'tool/neoseo_seogen/handler_category');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.manufacturer.add', 'tool/neoseo_seogen/handler_manufacturer');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.manufacturer.edit', 'tool/neoseo_seogen/handler_manufacturer');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.information.add', 'tool/neoseo_seogen/handler_information');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.information.edit', 'tool/neoseo_seogen/handler_information');

		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.blog.category.add', 'tool/neoseo_seogen/handler_blog_category');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.blog.category.edit', 'tool/neoseo_seogen/handler_blog_category');

		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.blog.author.add', 'tool/neoseo_seogen/handler_blog_author');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.blog.author.edit', 'tool/neoseo_seogen/handler_blog_author');

		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.blog.article.add', 'tool/neoseo_seogen/handler_blog_article');
		$this->model_extension_event->addEvent($this->_moduleSysName, 'post.admin.blog.article.edit', 'tool/neoseo_seogen/handler_blog_article');
	}

	public function uninstall()
	{
		$this->load->model('extension/event');
		$this->model_extension_event->deleteEvent($this->_moduleSysName);
	}

	public function upgrade()
	{

	}

}
