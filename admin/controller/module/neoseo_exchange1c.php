<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoExchange1c extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_exchange1c";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load('module/neoseo_exchange1c');
		$this->load->model('tool/image');

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('neoseo_exchange1c', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link('module/neoseo_exchange1c', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
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

		$data['token'] = $this->session->data['token'];
		$data['import'] = $this->url->link('tool/neoseo_exchange1c/import', 'token=' . $this->session->data['token'], 'SSL');
		$data['export'] = $this->url->link('tool/neoseo_exchange1c/export', 'token=' . $this->session->data['token'], 'SSL');
		$data['export_product'] = $this->url->link('tool/neoseo_exchange1c/export_product', 'token=' . $this->session->data['token'], 'SSL');
		$data['check_password'] = $this->url->link('module/neoseo_exchange1c/check_password', 'token=' . $this->session->data['token'], 'SSL');
		$data[$this->_moduleSysName() . '_link'] = rtrim(HTTP_CATALOG, "/") . "/export/neoseo_exchange1c.php";
		$data[$this->_moduleSysName() . "_cron_command"] = "php " . realpath(DIR_SYSTEM . "../export/" . $this->_moduleSysName() . ".php") . " import";
		$data['delete_orders'] = $this->url->link('tool/neoseo_exchange1c/delete_orders', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_export_list_orders'] = $this->url->link('tool/neoseo_exchange1c/deleteExportListOrders', 'token=' . $this->session->data['token'], 'SSL');
		$data['get_orders'] = $this->url->link('tool/neoseo_exchange1c/get_orders', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_categories'] = $this->url->link('tool/neoseo_exchange1c/delete_categories', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_manufacturers'] = $this->url->link('tool/neoseo_exchange1c/delete_manufacturers', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_products'] = $this->url->link('tool/neoseo_exchange1c/delete_products', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_1c_products'] = $this->url->link('tool/neoseo_exchange1c/delete_1c_products', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_products_warehouses'] = $this->url->link('tool/neoseo_exchange1c/delete_products_warehouses', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_attributes'] = $this->url->link('tool/neoseo_exchange1c/delete_attributes', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_options'] = $this->url->link('tool/neoseo_exchange1c/delete_options', 'token=' . $this->session->data['token'], 'SSL');
		$data['delete_links'] = $this->url->link('tool/neoseo_exchange1c/delete_links', 'token=' . $this->session->data['token'], 'SSL');

		$data['counterparties_download'] = $this->url->link('tool/neoseo_exchange1c/exportContragents', 'token=' . $this->session->data['token'], 'SSL');
		$data['counterparties_delete'] = $this->url->link('tool/neoseo_exchange1c/counterpartiesDelete', 'token=' . $this->session->data['token'], 'SSL');
		$data['counterparties_delete_links'] = $this->url->link('tool/neoseo_exchange1c/counterpartiesDeleteLinks', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model($this->_route . "/" . $this->_moduleSysName);
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		if (substr(VERSION, 0, 3) == "2.0") {
			$this->load->model('sale/customer_group');
			$data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();
		} else {
			$this->load->model('customer/customer_group');
			$data['customer_groups'] = $this->model_customer_customer_group->getCustomerGroups();
		}

		$data['customer_groups_special'] = array();

		foreach ($data['customer_groups'] as $customer_group) {
			$data['customer_groups_special'][$customer_group['customer_group_id']] = $customer_group['name'];
		}

		$this->load->model('localisation/stock_status');

		$results = $this->model_localisation_stock_status->getStockStatuses();
		$stock_statuses = array();
		foreach ($results as $result) {
			$stock_statuses[$result['stock_status_id']] = $result['name'];
		}
		$data['stock_statuses'] = $stock_statuses;

		$this->load->model('localisation/order_status');

		$order_statuses = $this->model_localisation_order_status->getOrderStatuses();
		$statuses = array();
		foreach ($order_statuses as $order_status) {
			$statuses[$order_status['order_status_id']] = $order_status['name'];
		}

		$this->load->model('catalog/category');

		$filter_data = array(
			'sort' => 'name',
			'order' => 'ASC'
		);

		$data['categories'] = array();
		$categories = $this->model_catalog_category->getCategories($filter_data);
		foreach ($categories as $category) {
			$data['categories'][$category['category_id']] = $category['name'];
		}

		$data['order_statuses'] = $statuses;

		$this->load->model('localisation/language');

		$languages = $this->model_localisation_language->getLanguages();
		$product_languages = array();
		foreach ($languages as $language) {
			$product_languages[$language['language_id']] = $language['name'];
		}
		$data['product_languages'] = $product_languages;

		//Чтобы обновление с более ранних версий прошло незаметно для Клиента
		if ($data[$this->_moduleSysName . "_disable_missing"] == 1) {
			$data[$this->_moduleSysName . "_disable_missing"] = array(1);
		} elseif ($data[$this->_moduleSysName . "_disable_missing"] == 2) {
			$data[$this->_moduleSysName . "_disable_missing"] = array(1, 2);
		}
		if ($data[$this->_moduleSysName . "_price_special"]) {
			$data[$this->_moduleSysName . "_special_price_type"] = array(array(
					'keyword' => $data[$this->_moduleSysName . "_price_special"],
					'customer_group_id' => $data[$this->_moduleSysName . "_special_group_id"],
					'priority' => 0
			));
		}

		$data['disable_missing'] = array(
			1 => $this->language->get('text_disable_out_of_stock'),
			2 => $this->language->get('text_disable_out_of_stock_null_price'),
			3 => $this->language->get('text_disable_out_of_stock_without_images'),
			4 => $this->language->get('text_disable_null_price'),
			5 => $this->language->get('text_disable_without_images'),
			6 => $this->language->get('text_disable_null_quantity'),
		);

		$data['transaction_statuses'] = array(
			0 => $this->language->get('text_disabled'),
			1 => $this->language->get('text_transaction_always'),
			2 => $this->language->get('text_transaction_change'),
		);

		$data['tax_list'] = array(
			0 => $this->language->get('text_disabled')
		);

		$this->load->model('localisation/tax_rate');
		$tax_data = $this->model_localisation_tax_rate->getTaxRates();
		foreach ($tax_data as $tax) {
			$data['tax_list'][$tax['tax_rate_id']] = $tax['name'];
		}

		$data['filters'] = array(
			0 => $this->language->get('text_disabled'),
			'neoseo_filter' => $this->language->get('text_neoseo_filter'),
			'ocfilter' => $this->language->get('text_ocfilter'),
			'filter' => $this->language->get('text_filter'),
		);

		$pd_columns_query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "product_description`;");

		$pd_columns = array();

		foreach ($pd_columns_query->rows as $column) {
			if ($column['Field'] == 'product_id' || $column['Field'] == 'language_id') {
				continue;
			}

			$pd_columns[$column['Field']] = $column['Field'];
		}

		$data['product_description_columns'] = $pd_columns;

		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		// API login
		$this->load->model('user/api');

		$api_info = $this->model_user_api->getApi($this->config->get('config_api_id'));

		if ($api_info) {
			$data['api_id'] = isset($api_info['api_id']) ? $api_info['api_id'] : '';
			$data['api_key'] = isset($api_info['key']) ? $api_info['key'] : '';
			$data['api_ip'] = $this->request->server['REMOTE_ADDR'];
		} else {
			$data['api_id'] = '';
			$data['api_key'] = '';
			$data['api_ip'] = '';
		}
		$data['isOptionsHasSpecial'] = $this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->isOptionsHasSpecial();

		$data['store'] = $this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/neoseo_exchange1c.tpl', $data));
	}

	private function validate()
	{

		if (!$this->user->hasPermission('modify', 'module/neoseo_exchange1c')) {
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
