<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoBrandsAbc extends NeoSeoController {
	private $error = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_brands_abc";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index() {
		$data = $this->load->language('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == 'save_and_close') {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		), $data);

		$data['token'] = $this->session->data['token'];
		
		$data = $this->initButtons($data);

		$data = $this->initParamsList(array(
			'status',
			'debug'
		), $data);

		$data['params'] = $data;

		if (is_file(DIR_LOGS . $this->_logFile)) {
			$file = fopen(DIR_LOGS . $this->_logFile, "r");
			fseek($file, -10000, SEEK_END);
			$data["logs"] = fread($file, 10000);
			fclose($file);
		} else {
			$data["logs"] = "";
		}


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

}