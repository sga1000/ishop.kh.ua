<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoInformation extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_information";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index($setting)
	{
		static $module = 0;
		$this->load->model('catalog/information');
		$data = $this->language->load('module/neoseo_information');
		$data['heading_title'] = $setting['title'][(int) $this->config->get('config_language_id')];
		$data['module'] = $module++;
		$data['setting'] = $setting;
		$data['height'] = $setting['height'];
		$information_id = $setting['information_id'];
		$this->registry->set('data', $data);
		$data['registry'] = $this->registry;
		$information_info = $this->model_catalog_information->getInformation($information_id);
		$template = $setting['template'];
		$data['html'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . $this->_moduleSysName . '_' . $template . '.tpl')) {
			$template = $this->config->get('config_template') . '/template/module/' . $this->_moduleSysName . '_' . $template . '.tpl';
		} else {
			$template = 'default/template/module/' . $this->_moduleSysName . '_' . $template . '.tpl';
		}
		return $this->load->view($template, $data);
	}

}

?>