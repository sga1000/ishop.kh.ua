<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoHTML extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_html";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index($setting)
	{
		static $module = 0;
		$data = $this->language->load('module/neoseo_unistor');
		$data['heading_title'] = $setting['title'][(int) $this->config->get('config_language_id')];
		$data['module'] = $module++;
		$data['setting'] = $setting;
		$data['html'] = html_entity_decode($setting['html_content'][(int) $this->config->get('config_language_id')]);
		$data['height'] = $setting['height'];
		$this->registry->set('data', $data);
		$data['registry'] = $this->registry;

		$template = $setting['template'];

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/' . $this->_moduleSysName . '_' . $template . '.tpl')) {
			$template = $this->config->get('config_template') . '/template/module/' . $this->_moduleSysName . '_' . $template . '.tpl';
		} else {
			$template = 'default/template/module/' . $this->_moduleSysName . '_' . $template . '.tpl';
		}
		return $this->load->view($template, $data);
	}

}

?>