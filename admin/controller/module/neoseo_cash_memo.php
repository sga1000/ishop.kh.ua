<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoCashMemo extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_cash_memo";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();

		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($this->request->get['close'])) {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
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


		$data = $this->initButtons($data);

		$store_owner = '';
		$config_langdata = $this->config->get('config_langdata');
		if ($config_langdata && isset($config_langdata[$this->config->get('config_language_id')])) {
			$store_owner = $config_langdata[$this->config->get('config_language_id')]['owner'];
		}
		$data = $this->initParamsList(array(
			"unit_option_null",
			"unit_option_one_nine",
			"unit_option_ten_nineteen",
			"tens_option",
			"hundreds_option",
			"money_option_coins",
			"money_option_currency",
			"count_money_option_thousand",
			"count_money_option_millon",
			"count_money_option_billion",
			"unit_option_one_nine_thousand",
			"unit_option_one_nine_millon",
			"unit_option_one_nine_billon",
			"status",
			"status_sale",
			"print_img",
			"print_img_store",
			"print_img_width",
			"print_img_height",
			"print_img",
			"debug",
			"replace_status",
			"supplier_info",
			"customer_info_format",
			"payment_info_format",
			"shipping_info_format",
			"text",
			"invoice_status",
			"client_side",
			"product_order",
			"product_order_client",
			"store_text",
			"store_name",
			"store_logo",
			"store_logo_width",
			"store_logo_height",
			"store_url",
			"store_phone",
			"store_email",
			"show_comment",
			"column_sku_status",
			"column_image_status",
			"column_option_status",
			"sort_product",
			"column_model_status",
			"column_image_width",
			"column_image_height",
			"show_comment",
			"order_date",
			"column_unit_status",
			"column_quantity_field",
		    ), $data);

		$data['sorts'] = array(
			0 => $this->language->get('text_disabled'),
			'name_asc' => $this->language->get('text_name_asc'),
			'name_desc' => $this->language->get('text_name_desc'),
			'model_asc' => $this->language->get('text_model_asc'),
			'model_desc' => $this->language->get('text_model_desc'),
			'sku_asc' => $this->language->get('text_sku_asc'),
			'sku_desc' => $this->language->get('text_sku_desc')
		);

		$this->load->model('tool/image');
		if (file_exists(DIR_IMAGE . $data[$this->_moduleSysName . '_print_img']) && is_file(DIR_IMAGE . $data[$this->_moduleSysName . '_print_img'])) {
			$data[$this->_moduleSysName . '_print_img_logo'] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_print_img'], 100, 100);
		} else {
			$data[$this->_moduleSysName . '_print_img_logo'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		if (file_exists(DIR_IMAGE . $data[$this->_moduleSysName . '_print_img_store']) && is_file(DIR_IMAGE . $data[$this->_moduleSysName . '_print_img_store'])) {
			$data[$this->_moduleSysName . '_print_logo_img_store'] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_print_img_store'], 100, 100);
		} else {
			$data[$this->_moduleSysName . '_print_logo_img_store'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		$data["token"] = $this->session->data['token'];
		$data['fields'] = $this->getFields();
		$data['logs'] = $this->getLogs();
		$data['params'] = $data;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	protected function getFields()
	{
		$result = array();

		$result['order_id'] = $this->language->get("field_desc_order_id");
		$result['invoice_no'] = $this->language->get("field_desc_invoice_no");
		$result['date_added'] = $this->language->get("field_desc_date_added");
		$result['date_modified'] = $this->language->get("field_desc_date_modified");
		$result['date_current'] = $this->language->get("field_desc_date_current");
		$result['store_name'] = $this->language->get("field_desc_store_name");
		$result['store_url'] = $this->language->get("field_desc_store_url");
		$result['store_address'] = $this->language->get("field_desc_store_address");
		$result['store_email'] = $this->language->get("field_desc_store_email");
		$result['store_phone'] = $this->language->get("field_desc_store_phone");
		$result['store_fax'] = $this->language->get("field_desc_store_fax");
		$result['store_owner'] = $this->language->get("field_desc_store_owner");
		$result['text'] = $this->language->get("field_desc_text");
		$result['email'] = $this->language->get("field_desc_email");
		$result['customer_info'] = $this->language->get("field_desc_customer_info");
		$result['firstname'] = $this->language->get("field_desc_firstname");
		$result['lastname'] = $this->language->get("field_desc_lastname");
		$result['telephone'] = $this->language->get("field_desc_telephone");
		$result['shipping_firstname'] = $this->language->get("field_shipping_firstname");
		$result['shipping_lastname'] = $this->language->get("field_shipping_lastname");
		$result['shipping_company'] = $this->language->get("field_desc_shipping_company");
		$result['shipping_address_1'] = $this->language->get("field_desc_shipping_address_1");
		$result['shipping_address_2'] = $this->language->get("field_desc_shipping_address_2");
		$result['shipping_city'] = $this->language->get("field_desc_shipping_city");
		$result['shipping_postcode'] = $this->language->get("field_desc_shipping_postcode");
		$result['shipping_zone'] = $this->language->get("field_desc_shipping_zone");
		$result['shipping_zone_code'] = $this->language->get("field_desc_shipping_zone_code");
		$result['shipping_country'] = $this->language->get("field_desc_shipping_country");
		$result['shipping_info'] = $this->language->get("field_desc_shipping_info");
		$result['shipping_method'] = $this->language->get("field_desc_shipping_method");
		$result['payment_firstname'] = $this->language->get("field_desc_payment_firstname");
		$result['payment_lastname'] = $this->language->get("field_desc_payment_lastname");
		$result['payment_company'] = $this->language->get("field_desc_payment_company");
		$result['payment_address_1'] = $this->language->get("field_desc_payment_address_1");
		$result['payment_address_2'] = $this->language->get("field_desc_payment_address_2");
		$result['payment_city'] = $this->language->get("field_desc_payment_city");
		$result['payment_postcode'] = $this->language->get("field_desc_payment_postcode");
		$result['payment_zone'] = $this->language->get("field_desc_payment_zone");
		$result['payment_zone_code'] = $this->language->get("field_desc_payment_zone_code");
		$result['payment_country'] = $this->language->get("field_desc_payment_country");
		$result['payment_info'] = $this->language->get("field_desc_payment_info");
		$result['payment_method'] = $this->language->get("field_desc_payment_method");
		$result['product'] = $this->language->get("field_desc_product");
		$result['voucher'] = $this->language->get("field_desc_voucher");
		$result['total'] = $this->language->get("field_desc_total");
		$result['total_str'] = $this->language->get("field_desc_total_str");
		$result['total_str_translit'] = $this->language->get("field_desc_total_str_translit");
		$result['comment'] = $this->language->get("field_desc_comment");

		// Инициализируем дополнительными полями
		$simple_tables = array(
			"order_simple_fields" => array(
				"short" => "osf",
				"prefix" => "simple_order",
				"join" => " LEFT JOIN `" . DB_PREFIX . "order_simple_fields` AS osf ON o.order_id = osf.order_id "
			),
		);

		foreach ($simple_tables as $table_name => $table_data) {
			$field_prefix = $table_data['prefix'];

			$query = $this->db->query("SHOW TABLES LIKE '" . DB_PREFIX . "$table_name'");
			if (!$query->num_rows) {
				continue;
			}

			$query = $this->db->query("SHOW COLUMNS FROM `" . DB_PREFIX . "$table_name`");
			if ($query->num_rows > 1) {
				array_shift($query->rows);
			}
			foreach ($query->rows as $row) {
				$field_name = $field_prefix . "_" . strtolower($row['Field']);
				$result[$field_name] = "Поле модуля simple";
			}
		}

		return $result;
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