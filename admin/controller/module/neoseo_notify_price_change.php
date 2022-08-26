<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoNotifyPriceChange extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_notify_price_change";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . '_debug');
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		//CKEditor or Summernote
		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
		} else {
			$this->document->addScript('view/javascript/summernote/summernote.js');
			$this->document->addScript('view/javascript/summernote/lang/summernote-' . $this->language->get('lang') . '.js');
			$this->document->addScript('view/javascript/summernote/opencart.js');
			$this->document->addStyle('view/javascript/summernote/summernote.css');
		}

		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == 'save') {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
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
			array($this->_route . '/' . $this->_moduleSysName, "heading_title_raw")
		), $data);

		$data = $this->initButtons($data);

		$this->load->model($this->_route . "/" . $this->_moduleSysName);
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		$data['ckeditor'] = $this->config->get('config_editor_default');

		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
		}

		$this->load->model('localisation/language');
		$data['full_languages'] = $this->model_localisation_language->getLanguages();
		$data[$this->_moduleSysName . "_cron"] = "php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");

		$this->load->model('localisation/stock_status');
		$data['stock_statuses'] = $this->model_localisation_stock_status->getStockStatuses();
		$data['config_language_id'] = $this->config->get('config_language_id');

		$data['params'] = $data;
		$data['token'] = $this->session->data['token'];
		$data["logs"] = $this->getLogs();

		$data['fields'] = $this->getFields();

		$widgets = new NeoSeoWidgets($this->_moduleSysName . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	protected function getFields()
	{
		$result = array();

		$result['id'] = $this->language->get("field_desc_id");
		$result['name'] = $this->language->get("field_desc_name");
		$result['phone'] = $this->language->get("field_desc_phone");
		$result['email'] = $this->language->get("field_desc_email");
		$result['product_name'] = $this->language->get("field_desc_product_name");
		$result['product_url'] = $this->language->get("field_desc_product_url");
		$result['price_old'] = $this->language->get("field_desc_price_old");
		$result['price_new'] = $this->language->get("field_desc_price_new");

		return $result;
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}