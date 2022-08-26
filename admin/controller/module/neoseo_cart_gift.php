<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoCartGift extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_cart_gift';
		$this->_modulePostfix = ''; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . '.log';
		$this->debug = $this->config->get($this->_moduleSysName() . '_debug') == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model('localisation/language');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting($this->_moduleSysName(), $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == 'save') {
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
			array('extension/' . $this->_route, 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName(), 'heading_title_raw')
		    ), $data);


		$data = $this->initButtons($data);

		$this->load->model($this->_route . '/' . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{'model_' . $this->_route . '_' . $this->_moduleSysName()}->params, $data);

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('localisation/stock_status');
		$stock_statuses = $this->model_localisation_stock_status->getStockStatuses();

		foreach ($stock_statuses as $status) {
			$data['stock_statuses'][$status['stock_status_id']] = $status['name'];
		}

		$this->load->model('tool/' . $this->_moduleSysName());
		$gifts = $this->{'model_tool_' . $this->_moduleSysName()}->getGifts();

		$data['help_gifts'] = array(
			'0' => $this->language->get('text_none'),
		);

		foreach ($gifts as $gift) {
			$data['help_gifts'][$gift['gift_id']] = $gift['name'];
		}

		$data['token'] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;

		$data['logs'] = $this->getLogs();

		//получим данные для таблицы Подарков
		$data = $this->getGiftsTable($data);

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() . '.tpl', $data));
	}

	public function add()
	{
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			$this->load->model('tool/' . $this->_moduleSysName());
			$this->model_tool_neoseo_cart_gift->addGift($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$url .= '#tab-gifts';

			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm($data);
	}

	public function edit() {

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->load->model('tool/' . $this->_moduleSysName());
			$this->model_tool_neoseo_cart_gift->editGift($this->request->get['gift_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$url .= '#tab-gifts';

			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm($data);
	}

	public function deleteGift()
	{
		$this->language->load($this->_route . '/' . $this->_moduleSysName());

		if (isset($this->request->get['gift_id']) && $this->validate()) {

			$this->load->model('tool/' . $this->_moduleSysName());

			$this->model_tool_neoseo_cart_gift->deleteGift($this->request->get['gift_id']);

			$this->session->data['success'] = $this->language->get('text_success');
		}

		if (isset($this->error['warning'])) {
			$this->session->data['error_warning'] = $this->error['warning'];
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$url .= '#tab-gifts';

		$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . $url, 'SSL'));
	}

	public function deleteGifts()
	{
		$this->language->load($this->_route . '/' . $this->_moduleSysName());

		$json = array(
			'success' => false,
		);

		if (isset($this->request->post['selected']) && $this->validate()) {

			$this->load->model('tool/' . $this->_moduleSysName());
			foreach ($this->request->post['selected'] as $gift_id) {
				$this->model_tool_neoseo_cart_gift->deleteGift($gift_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');
			$json['success'] = true;
		}

		if (isset($this->error['warning'])) {
			$this->session->data['error_warning'] = $this->error['warning'];
		}
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$url .= '#tab-gifts';

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	protected function getGiftsTable($data)
	{
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['add'] = $this->url->link($this->_route . '/' . $this->_moduleSysName() . '/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName() . '/deleteGifts', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$filter_data = array(
			'sort' => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$this->load->model('tool/' . $this->_moduleSysName());
		$gifts_total = $this->{'model_tool_' . $this->_moduleSysName()}->getGiftsTotal();
		$gifts = $this->{'model_tool_' . $this->_moduleSysName()}->getGifts($filter_data);

		foreach ($gifts as $key => $value) {
			$gifts[$key]['edit'] = $this->url->link($this->_route . '/' . $this->_moduleSysName() . '/edit', 'token=' . $this->session->data['token'] . '&gift_id=' . $value['gift_id'] . $url, 'SSL');
			$gifts[$key]['delete'] = $this->url->link($this->_route . '/' . $this->_moduleSysName() . '/deleteGift', 'token=' . $this->session->data['token'] . '&gift_id=' . $value['gift_id'] . $url, 'SSL');
			$gifts[$key]['min_price'] = $this->currency->format($gifts[$key]['min_price']);
		}
		$data['gifts'] = $gifts;

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		$url .= '#tab-gifts';

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$data['sort_name'] = $this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$data['sort_min_price'] = $this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . '&sort=min_price' . $url, 'SSL');
		$data['sort_status'] = $this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . '&sort=status' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		$url .= '#tab-gifts';

		$pagination = new Pagination();
		$pagination->total = $gifts_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . '&page={page}' . $url, 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($gifts_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($gifts_total - $this->config->get('config_limit_admin'))) ? $gifts_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $gifts_total, ceil($gifts_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		return $data;
	}

	private function getForm($data)
	{
		$data['text_form'] = !isset($this->request->get['gift_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		$this->load->model($this->_route . '/' . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{'model_' . $this->_route . '_' . $this->_moduleSysName()}->params, $data);

		$this->load->model('customer/customer_group');
		$customer_groups_info = $this->model_customer_customer_group->getCustomerGroups();
		$customer_groups = array();
		foreach ($customer_groups_info as $item) {
			$customer_groups[$item['customer_group_id']] = $item['name'];
		}
		$data['customer_groups'] = $customer_groups;

		$data['stores'] = array();

		$data['stores'][0] = $this->config->get('config_name') . $this->language->get('text_default');

		$this->load->model('setting/store');
		$results = $this->model_setting_store->getStores();

		foreach ($results as $result) {
			$data['stores'][$result['store_id']] = $result['name'];
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		$url = '#tab-gifts';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (!isset($this->request->get['gift_id'])) {
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName() . '/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName() . '/edit', 'token=' . $this->session->data['token'] . '&gift_id=' . $this->request->get['gift_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['gift_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$this->load->model('tool/' . $this->_moduleSysName());
			$gift_info = $this->model_tool_neoseo_cart_gift->getGift($this->request->get['gift_id']);
			$gift_customer_groups = $this->model_tool_neoseo_cart_gift->getGiftCustomerGroups($this->request->get['gift_id']);
			$gift_customer_stores = $this->model_tool_neoseo_cart_gift->getGiftStores($this->request->get['gift_id']);
			$gift_products = $this->model_tool_neoseo_cart_gift->getGiftProducts($this->request->get['gift_id']);
		}

		$data['token'] = $this->session->data['token'];

		if (isset($this->request->post[$this->_moduleSysName() . '_gift_name'])) {
			$data[$this->_moduleSysName() . '_gift_name'] = $this->request->post[$this->_moduleSysName() . '_gift_name'];
		} elseif (isset($gift_info['name']) && $gift_info['name'])  {
			$data[$this->_moduleSysName() . '_gift_name'] = $gift_info['name'];
		} else {
			$data[$this->_moduleSysName() . '_gift_name'] = '';
		}

		if (isset($this->request->post[$this->_moduleSysName() . '_min_price'])) {
			$data[$this->_moduleSysName() . '_min_price'] = $this->request->post[$this->_moduleSysName() . '_min_price'];
		} elseif (isset($gift_info['min_price']) && $gift_info['min_price']) {
			$data[$this->_moduleSysName() . '_min_price'] = $gift_info['min_price'];
		} else {
			$data[$this->_moduleSysName() . '_min_price'] = 0;
		}

		if (isset($this->request->post[$this->_moduleSysName() . '_gift_status'])) {
			$data[$this->_moduleSysName() . '_gift_status'] = $this->request->post[$this->_moduleSysName() . '_gift_status'];
		} elseif (isset($gift_info['status'])) {
			$data[$this->_moduleSysName() . '_gift_status'] = $gift_info['status'];
		} else {
			$data[$this->_moduleSysName() . '_gift_status'] = 1;
		}

		if (isset($this->request->post[$this->_moduleSysName() . '_customer_groups'])) {
			$data[$this->_moduleSysName() . '_customer_groups'] = $this->request->post[$this->_moduleSysName() . '_customer_groups'];
		} elseif (isset($gift_customer_groups)) {
			$data[$this->_moduleSysName() . '_customer_groups'] = $gift_customer_groups;
		} else {
			$data[$this->_moduleSysName()  .'_customer_groups'] = array($this->config->get('config_customer_group_id'));
		}

		if (isset($this->request->post[$this->_moduleSysName() . '_stores'])) {
			$data[$this->_moduleSysName() . '_stores'] = $this->request->post[$this->_moduleSysName() . '_stores'];
		} elseif (isset($gift_customer_stores)) {
			$data[$this->_moduleSysName() . '_stores'] = $gift_customer_stores;
		} else {
			$data[$this->_moduleSysName() . '_stores'] = array(0);
		}

		if (isset($this->request->post['product'])) {
			$data['products'] = $this->request->post['product'];
		} elseif (isset($gift_products) && $gift_products) {
			$data['products'] = $gift_products;
		} else {
			$data['products'] = array();
		}

		$data['filter_stock_status'] = implode(',', $this->config->get($this->_moduleSysName() . '_product_statuses'));

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() . '_form.tpl', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName())) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if ((utf8_strlen($this->request->post[$this->_moduleSysName() .'_gift_name']) < 3) || (utf8_strlen($this->request->post[$this->_moduleSysName() .'_gift_name']) > 32)) {
			$this->error['name'] = $this->language->get('error_name');
		}
		return !$this->error;
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
