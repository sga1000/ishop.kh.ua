<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerShippingNeoSeoShippingPlus extends NeoSeoController
{
	private $error = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_shippingplus";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();
		$this->language->load('shipping/' . $this->_moduleSysName);
		$this->load->model('setting/setting');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == 'save_and_close') {
				$this->response->redirect($this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('shipping/' . $this->_moduleSysName);

		$this->getList();
	}

	public function add()
	{
		$this->language->load('shipping/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('tool/' . $this->_moduleSysName);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			if(empty($this->request->post['shipping_stores'])) {
				$this->request->post['shipping_stores'] = array();
			}

			$shipping_id = $this->{'model_tool_' . $this->_moduleSysName}->addShipping($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$url = '';
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if ($this->request->post['action'] == 'save') {
				$this->response->redirect($this->url->link('shipping/' . $this->_moduleSysName . '/edit', 'shipping_id=' . $shipping_id . '&token=' . $this->session->data['token'] . $url, 'SSL'));
			}

			if ($this->request->post['action'] == 'save_and_close') {
				$this->response->redirect($this->url->link('shipping/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
		}

		$this->getForm();
	}


	public function copy() {
		$this->language->load('shipping/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('tool/' . $this->_moduleSysName);

		if (isset($this->request->post['selected']) && $this->validateCopy()) {
			foreach ($this->request->post['selected'] as $shipping_id) {
				$this->{'model_tool_' . $this->_moduleSysName}->copyShipping($shipping_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('shipping/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}


	protected function getList()
	{
		$data = $this->language->load('shipping/' . $this->_moduleSysName);

		$data = $this->initParamsList(array(
			'status',
			'debug',
			'sort_order'
		), $data);

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data = $this->initBreadcrumbs(array(
			array("extension/shipping", "text_shipping", $url),
			array("shipping/" . $this->_moduleSysName, "heading_title_raw", $url)), $data);

		$data = $this->initButtons($data);

		$data['add'] = $this->url->link('shipping/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('shipping/' . $this->_moduleSysName . '/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['clone'] = $this->url->link('shipping/' . $this->_moduleSysName . '/copy', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['shippings'] = array();

		$filter_data = array(
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$this->load->model('tool/' . $this->_moduleSysName);

		$shipping_total = $this->{'model_tool_' . $this->_moduleSysName}->getTotalShippings();

		$results = $this->{'model_tool_' . $this->_moduleSysName}->getShippings($filter_data);

		foreach ($results as $result) {
			$data['shippings'][] = array(
				'shipping_id' => $result['shipping_id'],
				'name' => $result['name'],
				'sort_order' => $result['sort_order'],
				'status' => $result['status'],
				'edit' => $this->url->link('shipping/' . $this->_moduleSysName . '/edit', 'token=' . $this->session->data['token'] . '&shipping_id=' . $result['shipping_id'] . $url, 'SSL'),
				'delete' => $this->url->link('shipping/' . $this->_moduleSysName . '/delete', 'token=' . $this->session->data['token'] . '&shipping_id=' . $result['shipping_id'] . $url, 'SSL'),
				'clone' => $this->url->link('shipping/' . $this->_moduleSysName . '/copy', 'token=' . $this->session->data['token'] . '&shipping_id=' . $result['shipping_id'] . $url, 'SSL')
			);
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$url = '';

		$pagination = new Pagination();
		$pagination->total = $shipping_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('shipping/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($shipping_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($shipping_total - $this->config->get('config_limit_admin'))) ? $shipping_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $shipping_total, ceil($shipping_total / $this->config->get('config_limit_admin')));

		$data['params'] = $data;

		$data['logs'] = $this->getLogs();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('shipping/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function edit()
	{
		$this->language->load('shipping/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('tool/' . $this->_moduleSysName);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			if(empty($this->request->post['shipping_stores'])) {
				$this->request->post['shipping_stores'] = array();
			}

			$this->{'model_tool_' . $this->_moduleSysName}->editShipping($this->request->get['shipping_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if ($this->request->post['action'] == 'save_and_close') {
				$this->response->redirect($this->url->link('shipping/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
		}

		$this->getForm();
	}

	public function delete()
	{

		$this->language->load('shipping/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('tool/' . $this->_moduleSysName);

		if ((isset($this->request->post['selected']) or isset($this->request->get['shipping_id'])) && $this->validateDelete()) {
			if (isset($this->request->post['selected'])) {
				foreach ($this->request->post['selected'] as $shipping_id) {
					$this->{'model_tool_' . $this->_moduleSysName}->deleteShipping($shipping_id);
				}
			} else {
				$this->{'model_tool_' . $this->_moduleSysName}->deleteShipping($this->request->get['shipping_id']);
			}


			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';


			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('shipping/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getForm()
	{

		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
		}

		$data = $this->language->load('shipping/' . $this->_moduleSysName);

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = array();
		}

		$data = $this->initBreadcrumbs(array(
			array("extension/shipping", "text_shipping"),
			array("shipping/" . $this->_moduleSysName, "heading_title_raw")
		), $data);

		if (isset($this->request->get['shipping_id'])) {
			$data['save'] = $this->url->link('shipping/' . $this->_moduleSysName . '/edit', 'shipping_id=' . $this->request->get['shipping_id'] . '&token=' . $this->session->data['token'], 'SSL');
			$data['save_and_close'] = $this->url->link('shipping/' . $this->_moduleSysName . '/add', 'shipping_id=' . $this->request->get['shipping_id'] . '&token=' . $this->session->data['token'] . "&close=1", 'SSL');
		} else {
			$data['save'] = $this->url->link('shipping/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'], 'SSL');
			$data['save_and_close'] = $this->url->link('shipping/' . $this->_moduleSysName . '/add', 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
		}

		$data['close'] = $this->url->link('shipping/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('tool/' . $this->_moduleSysName);
		if (isset($this->request->get['shipping_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$shipping_info = $this->{'model_tool_' . $this->_moduleSysName}->getShipping($this->request->get['shipping_id']);
		}

		$data['token'] = $this->session->data['token'];
		$data['ckeditor'] = $this->config->get('config_editor_default');

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['lang'] = $this->language->get('lang');

		if (isset($this->request->post['shipping_description'])) {
			$data['shipping_description'] = $this->request->post['shipping_description'];
		} elseif (isset($this->request->get['shipping_id'])) {
			$data['shipping_description'] = $this->{'model_tool_' . $this->_moduleSysName}->getShippingDescriptions($this->request->get['shipping_id']);
		} else {
			$data['shipping_description'] = array();
		}

		$this->load->model('localisation/geo_zone');
		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();


		foreach ($data['geo_zones'] as $geo_zone){
			$geo_zones_list[$geo_zone['geo_zone_id']] = $geo_zone['name'];
		}
		$data['geo_zones_list'] = $geo_zones_list;

		if (isset($this->request->post['price_min'])) {
			$data['price_min'] = $this->request->post['price_min'];
		} elseif (!empty($shipping_info)) {
			$data['price_min'] = $shipping_info['price_min'];
		} else {
			$data['price_min'] = '';
		}

		if (isset($this->request->post['price_max'])) {
			$data['price_max'] = $this->request->post['price_max'];
		} elseif (!empty($shipping_info)) {
			$data['price_max'] = $shipping_info['price_max'];
		} else {
			$data['price_max'] = '';
		}

		if (isset($this->request->post['fix_payment'])) {
			$data['fix_payment'] = $this->request->post['fix_payment'];
		} elseif (!empty($shipping_info)) {
			$data['fix_payment'] = $shipping_info['fix_payment'];
		} else {
			$data['fix_payment'] = '';
		}

		if (isset($this->request->post['geo_zone_id']) && $this->request->post['geo_zone_id'] != 0 ) {
			$data['geo_zone_id'] = $this->request->post['geo_zone_id'];
		} elseif (!empty($shipping_info) && unserialize($shipping_info['geo_zones_id'])) {
			$data['geo_zone_id'] = unserialize($shipping_info['geo_zones_id']);
		} else {
			$data['geo_zone_id'] = array(0);
		}

		if (isset($this->request->post['cities'])) {
			$data['cities'] = $this->request->post['cities'];
		} elseif (!empty($shipping_info)) {
			$data['cities'] = $shipping_info['cities'];
		} else {
			$data['cities'] = '';
		}

		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($shipping_info)) {
			$data['sort_order'] = $shipping_info['sort_order'];
		} else {
			$data['sort_order'] = 0;
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($shipping_info)) {
			$data['status'] = $shipping_info['status'];
		} else {
			$data['status'] = true;
		}

		if (isset($this->request->post['shipping_weight_price'])) {
			$data['shipping_weight_price'] = $this->request->post['shipping_weight_price'];
		} elseif (!empty($shipping_info)) {
			$data['shipping_weight_price'] = unserialize($shipping_info['weight_price']);
		} else {
			$data['shipping_weight_price'] = 0;
		}

		$this->load->model($this->_route . '/' . $this->_moduleSysName);
		$data['stores'] = $this->{'model_' . $this->_route . '_' . $this->_moduleSysName}->getStores();
		$data['entry_stores'] = $this->language->get('entry_stores');

		$payments = $this->{'model_tool_' . $this->_moduleSysName}->getAllShippings();
		$data['shipping_stores'] = array();
		if (isset($this->request->get['shipping_id']) && isset($payments[$this->request->get['shipping_id']]) && !empty($payments[$this->request->get['shipping_id']]['stores'])) {
			$data['shipping_stores'] = json_decode($payments[$this->request->get['shipping_id']]['stores'], true);
		}


		$data['params'] = $data;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('shipping/' . $this->_moduleSysName . '_form.tpl', $data));
	}

	protected function validateForm()
	{
		if (!$this->user->hasPermission('modify', 'shipping/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['shipping_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 255)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}


		return !$this->error;
	}

	protected function validateDelete()
	{
		if (!$this->user->hasPermission('modify', 'shipping/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	protected function validate()
	{
		if (!$this->user->hasPermission('modify', 'shipping/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}


	protected function validateCopy()
	{
		if (!$this->user->hasPermission('modify', 'shipping/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}