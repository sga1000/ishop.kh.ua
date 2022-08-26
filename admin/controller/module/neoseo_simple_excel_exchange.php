<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoSimpleExcelExchange extends NeoSeoController {

	private $error = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_simple_excel_exchange';
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;
	}

	public function index() {
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			}else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}


		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		}else if (isset($this->session->data['error_warning'])) {
			$data['error_warning'] = $this->session->data['error_warning'];
			unset($this->session->data['error_warning']);
		}else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(array(
			array('extension/' . $this->_route, 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName(), 'heading_title_raw')
				), $data);

		$data = $this->initButtons($data);


		$this->load->model($this->_route . "/" . $this->_moduleSysName());


		$data['action_import'] = $this->url->link('module/' . $this->_moduleSysName() . '/import', 'token=' . $this->session->data['token'], true);
		$data['action_export'] = $this->url->link('module/' . $this->_moduleSysName() . '/export2Excel', 'token=' . $this->session->data['token'], true);

		
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		$data['token'] = $this->session->data['token'];
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

	/**
	 * Экспорт товаров в эксель
	 */
	public function export2Excel() {
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->load->model('tool/' . $this->_moduleSysName());
			if(isset($this->request->post['example'])){
				$this->{'model_tool_' . $this->_moduleSysName()}->example();
			}else{
				$this->{'model_tool_' . $this->_moduleSysName()}->export();
			}
		}
		
	}

	public function import() {
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->load->model('tool/' . $this->_moduleSysName());
			$result = $this->{'model_tool_' . $this->_moduleSysName()}->import($this->request->post, $this->request->files);
			if (isset($result['error'])) {
				$this->session->data['error_warning'] = implode('<br />', $result['error']);
			}
			if (isset($result['success'])) {
				$this->session->data['success'] = implode('<br />', $result['success']);
			}
		}
		$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName())) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		}else {
			return false;
		}
	}

}
