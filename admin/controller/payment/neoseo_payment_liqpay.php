<?php
require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerPaymentNeoSeoPaymentLiqPay extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_payment_liqpay";
		$this->_modulePostfix = "";
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

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
			array('extension/' . $this->_route, "text_payment"),
			array($this->_route . '/' . $this->_moduleSysName, "heading_title_raw")
		), $data);

		$data = $this->initButtons($data);

		$this->load->model($this->_route . "/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params, $data);

		$this->load->model('localisation/order_status');

		$order_statuses = $this->model_localisation_order_status->getOrderStatuses();

		$statuses = array();

		foreach ($order_statuses as $order_status) {
			$statuses[$order_status['order_status_id']] = $order_status['name'];
		}
		$data['order_statuses'] = $statuses;

		$this->load->model('localisation/geo_zone');

		$geo_zones = $this->model_localisation_geo_zone->getGeoZones();

		$zones = array(0 => $data['text_all_zones']);

		foreach ($geo_zones as $geo_zone) {
			$zones[$geo_zone['geo_zone_id']] = $geo_zone['name'];
		}
		$data['geo_zones'] = $zones;

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

	private function validate()
	{
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName())) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['neoseo_payment_liqpay_merchant']) {
			$this->error['warning'] = $this->language->get('error_merchant');
		}

		if (!$this->request->post['neoseo_payment_liqpay_signature']) {
			$this->error['warning'] = $this->language->get('error_signature');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

}