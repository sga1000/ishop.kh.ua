<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoFilterPageGenerator extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_filter_page_generator";
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();
		$this->checkFilter();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting($this->_moduleSysName(), $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else if (isset($this->session->data['error_warning'])) {
			$data['error_warning'] = $this->session->data['error_warning'];
			unset($this->session->data['error_warning']);
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(array(
			array('extension/module', 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName(), "heading_title_raw")
		    ), $data);


		$data = $this->initButtons($data);

		$data['generate_rules'] = 'tool/' . $this->_moduleSysName() . '/jsonGenerateRules';

		$this->load->model($this->_route . "/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params, $data);

		$data[$this->_moduleSysName . '_cron'] = "php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName() . ".php");

		$data['patterns'] = $this->getPatterns();

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data["token"] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() . '.tpl', $data));
	}

	protected function getPatterns()
	{
		$result = array();

		$result['page_category'] = $this->language->get("pattern_desc_page_category");
		$result['page_filters'] = $this->language->get("pattern_desc_page_filters");
		$result['page_options'] = $this->language->get("pattern_desc_page_options");
		$result['page_option_values'] = $this->language->get("pattern_desc_page_option_values");
		$result['page_name'] = $this->language->get("pattern_desc_page_name");
		$result['page_title'] = $this->language->get("pattern_desc_page_title");
		$result['page_h1'] = $this->language->get("pattern_desc_page_page_h1");

		return $result;
	}

	private function checkFilter()
	{
		$this->load->model($this->_route . "/" . $this->_moduleSysName());
		$check_filter = $this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->checkFilter();
		if (!$check_filter) {
			$this->error['error_no_filter_tables'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName())) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

}
