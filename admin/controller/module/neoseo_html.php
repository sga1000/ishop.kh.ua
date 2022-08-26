<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoHtml extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_html";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{

		$this->upgrade();

		$this->load->model($this->_route . '/' . $this->_moduleSysName);
		$data = $this->language->load('module/' . $this->_moduleSysName);
		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$globalModuleData[$this->_moduleSysName . '_debug'] = $this->request->post[$this->_moduleSysName . '_debug'];
			$this->model_setting_setting->editSetting($this->_moduleSysName, $globalModuleData);

			$moduleData = array();
			foreach ($this->request->post as $key => $value) {
				$shortKey = str_replace($this->_moduleSysName . "_", "", $key);
				if (in_array($shortKey, array("action", "debug"))) {
					continue;
				}
				$moduleData[$shortKey] = $value;
			}
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule($this->_moduleSysName, $moduleData);
				$module_id = $this->db->getLastId();
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $moduleData);
				$module_id = $this->request->get['module_id'];
			}

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($this->request->get['close'])) {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, "module_id=" . $module_id . '&token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		if (!isset($this->request->get['module_id'])) {
			$data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
			$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
		} else {
			$data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'module_id=' . $this->request->get['module_id'] . '&token=' . $this->session->data['token'], 'SSL');
			$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'module_id=' . $this->request->get['module_id'] . '&token=' . $this->session->data['token'] . "&close=1", 'SSL');
		}
		$data = $this->initButtons($data);
		$data['token'] = $this->session->data['token'];
		$data['modules'] = array();

		$this->load->model('localisation/language');
		$languages = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$languages[$language['language_id']] = $language['name'];
		}
		$data['languages'] = $languages;
		$data['full_languages'] = $this->model_localisation_language->getLanguages();

		$defaultTitle = array();
		foreach ($data['languages'] as $language_id => $name) {
			$defaultTitle[$language_id] = $this->language->get('text_default_title');
			$defaultHTML[$language_id] = $this->language->get('text_default_html');
		}

		$data['ckeditor'] = $this->config->get('config_editor_default');
		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
		}

		$data = $this->initModuleParams(array(
			array($this->_moduleSysName . '_status', 1),
			array($this->_moduleSysName . '_debug', 0),
			array($this->_moduleSysName . '_name', ""),
			array($this->_moduleSysName . '_html_content', $defaultHTML),
			array($this->_moduleSysName . '_title', $defaultTitle),
			array($this->_moduleSysName . '_height', 600),
			array($this->_moduleSysName . '_template', "default"),
		    ), $data, $this->_moduleSysName);

		$data = $this->initParams(array(
			array($this->_moduleSysName . '_debug', 0),
		    ), $data, $this->_moduleSysName);

		$data['templates'] = array();

		$template_files = glob(DIR_CATALOG . 'view/theme/neoseo_unistor/template/module/' . $this->_moduleSysName . '_*.tpl');
		if ($template_files) {
			foreach ($template_files as $template_file) {
				$template_file_name = str_replace($this->_moduleSysName . "_", "", basename($template_file, '.tpl'));
				$data['templates'][$template_file_name] = $this->language->get('text_template') . " - " . $template_file_name;
			}
		}

		$data['params'] = $data;

		if (is_file(DIR_LOGS . $this->_logFile))
			$data["logs"] = substr(nl2br(file_get_contents(DIR_LOGS . $this->_logFile)), -10000);
		else
			$data["logs"] = "";

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}

?>