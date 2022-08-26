<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoCheckout extends NeoSeoController
{

	private $error = array();
	private $field_fields = array(
		"firstname" => "Имя",
		"lastname" => "Фамилия",
		"email" => "Электронный адрес",
		"telephone" => "Телефон",
		"fax" => "Факс",
		"tax_id" => "ИНН",
		"company" => "Компания",
		"company_id" => "ОКПО",
		"address_1" => "Адрес 1",
		"address_2" => "Адрес 2",
		"postcode" => "Индекс",
		"password" => "Пароль",
		"password2" => "Подтверждение пароля",
		"comment" => "Комментарий",
		"custom" => "Дополнительное поле",
		"discount" => "Номер дисконта",
	);
	private $field_types = array(
		"input" => "Текст",
		"textarea" => "Многострочный текст",
		"select" => "Список",
		"radio" => "Переключатель",
		"checkbox" => "Флажок",
		"password" => "Пароль",
		"html" => "HTML",
		"file" => "Файл",
	);

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleName = "";
		$this->_moduleSysName = "neoseo_checkout";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;
	}

	public function index()
	{
		//$this->checkLicese();
		$this->upgrade();
		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('text_title'));

		$this->document->addStyle('view/stylesheet/' . $this->_moduleSysName . '.css');
		$this->document->addStyle('view/javascript/jquery/jquery-ui.min.css');
		$this->document->addScript('view/javascript/jquery/jquery-ui.min.js');
		$this->document->addScript('view/javascript/' . $this->_moduleSysName . '.js');
		$this->document->addScript('view/javascript/jsrender/jsrender.js');

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
		} else {
			$data['success'] = '';
		}

		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data['token'] = $this->session->data['token'];
		$data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
		$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
		$data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['clear'] = $this->url->link('module/' . $this->_moduleSysName . '/clear', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('sale/neoseo_dropped_cart');

		$data['dropped_cart_template'] = array();
		$dropped_cart_template_path = $this->model_sale_neoseo_dropped_cart->getEmailTemplatePath();

		foreach (glob($dropped_cart_template_path . '*.tpl') as $template) {
			$data['dropped_cart_template'][$template] = basename($template);
		}

		$this->load->model($this->_route . '/' . $this->_moduleSysName);

		// Значения по умолчанию для полей.
		$data = $this->initParamsList(array(
			"status",
			"debug",
			"compact",
			"agreement_id",
			"agreement_default",
			"agreement_text",
			"amount_control",
			"stock_control",
			"customer_fields",
			"payment_fields",
			"shipping_fields",
			"use_shipping_type",
			"shipping_type",
			"shipping_title",
			"payment_logo",
			"payment_control",
			"payment_reloads_cart",
			"shipping_reloads_cart",
			"dependency_type",
			"shipping_control",
			"shipping_city_select",
			"shipping_country_select",
			"shipping_country_default",
			"shipping_zone_default",
			"shipping_city_default",
			"shipping_novaposhta_city_default",
			"novaposhta_city_name",
			"shipping_novaposhta",
			"warehouse_types",
			"customer_group_register",
			"dropped_cart_template",
			"dropped_cart_email_subject",
			"min_amount",
			"onestep",
			"cart_redirect",
			"hide_menu",
			"hide_footer",
			"api_key",
			"use_international_phone_mask",
			'aways_show_delivery_block',
			'shipping_require_city',
		    ), $data);

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
		$data['config_language_id'] = $this->config->get('config_language_id');

		$this->load->model('localisation/country');
		$countries = $this->model_localisation_country->getCountries();
		$data['countries'] = array();
		foreach ($countries as $country) {
			$data['countries'][$country['country_id']] = $country['name'];
		}

		$this->load->model('catalog/information');
		$data['information'] = array(
			0 => $this->language->get("text_disabled")
		);
		foreach ($this->model_catalog_information->getInformations() as $information) {
			if ($information['status'] == 1)
				$data['information'][$information['information_id']] = $information['title'];
		}


		$this->load->model('customer/customer_group');
		$items = $this->model_customer_customer_group->getCustomerGroups(array('sort' => 'cg.sort_order'));
		$customer_groups = array();
		foreach ($items as $item) {
			$customer_groups[$item['customer_group_id']] = $item['name'];
		}
		$data['customer_groups'] = $customer_groups;

		$data['field_fields'] = $this->field_fields;
		$data['field_types'] = $this->field_types;
		$config_language_id = $this->config->get("config_language_id");

		// Payment Methods
		$files = glob(DIR_APPLICATION . 'controller/payment/*.php');
		$method_data = array();
		foreach ($files as $file) {
			$extension = basename($file, '.php');
			if (1 != $this->config->get($extension . '_status'))
				continue;

			if ($extension == "transfer_plus") {
				$methods = $this->config->get("transfer_plus_module");
				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'transfer_plus.' . $id,
						'name' => isset($data1['title'][$config_language_id]) ? $data1['title'][$config_language_id] : $data1['title'][key($data1['title'])],
						'sort_order' => $data1['sort_order'],
					);
				}
				continue;
			} elseif ($extension == "neoseo_paymentplus") {
				$this->load->model('tool/neoseo_paymentplus');
				$methods = $this->model_tool_neoseo_paymentplus->getAllPayments();

				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'neoseo_paymentplus.neoseo_paymentplus' . $id,
						'name' => $data1['name'],
						'sort_order' => $data1['sort_order'],
					);
				}
				continue;
			}


			$this->language->load('payment/' . $extension);

			$method_data[] = array(
				'code' => $extension,
				'name' => $this->language->get('heading_title'),
				'sort_order' => $this->config->get($extension . '_sort_order'),
			);
		}
		$sort_order = array();

		foreach ($method_data as $key => $value) {
			$sort_order[$key] = $value['sort_order'];
		}

		array_multisort($sort_order, SORT_ASC, $method_data);


		$data['payment_methods'] = $method_data;

		// Shipping Methods
		$files = glob(DIR_APPLICATION . 'controller/shipping/*.php');
		$method_data = array();
		foreach ($files as $file) {

			$extension = basename($file, '.php');
			if (1 != $this->config->get($extension . '_status'))
				continue;

			if ($extension == "dostavkaplus") {
				$methods = $this->config->get("dostavkaplus_module");
				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'dostavkaplus.sh' . $id,
						'name' => isset($data1['title'][$config_language_id]) ? $data1['title'][$config_language_id] : $data1['title'][key($data1['title'])],
						'sort_order' => $data1['sort_order'],
					);
				}
				continue;
			} elseif ($extension == "neoseo_shippingplus") {
				$this->load->model('tool/neoseo_shippingplus');
				$methods = $this->model_tool_neoseo_shippingplus->getAllShippings();
				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'neoseo_shippingplus.neoseo_shippingplus' . $id,
						'name' => $data1['name'],
						'sort_order' => $data1['sort_order'],
					);
				}
				continue;
			}elseif ($extension == "neoseo_novaposhta") {
				$this->load->model('tool/neoseo_novaposhta');
				$methods = $this->model_tool_neoseo_novaposhta->getAllShippings();
				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'neoseo_novaposhta.' . $id,
						'name' => $data1['name'],
						'sort_order' => $data1['sort_order'],
					);
				}
				continue;
			}


			$this->language->load('shipping/' . $extension);
			$extended_info = $this->language->get('text_' . $extension . '_methods');
			if ($extended_info && is_array($extended_info)) {
				foreach ($extended_info as $id => $name) {
					$method_data[] = array(
						'code' => $extension . '.' . $id,
						'name' => $name,
						'sort_order' => $this->config->get($extension . '_sort_order'),
					);
				}
			} else {
				$method_data[] = array(
					'code' => $extension,
					'name' => $this->language->get('heading_title'),
					'sort_order' => $this->config->get($extension . '_sort_order'),
				);
			}
		}
		$sort_order = array();

		foreach ($method_data as $key => $value) {
			$sort_order[$key] = $value['sort_order'];
		}

		array_multisort($sort_order, SORT_ASC, $method_data);

		$data['shipping_methods'] = $method_data;

		$data['shipping_methods_list'] = array();
		foreach ($method_data as $item) {
			$data['shipping_methods_list'][$item['code']] = $item['name'];
		}

		$data['warehouse_types'] = $this->getWarehouseTypes();

		// Dependencies for shipping
		$payment_for_shipping = $this->config->get($this->_moduleSysName . '_payment_for_shipping');
		$data[$this->_moduleSysName . '_payment_for_shipping'] = array();
		foreach ($data['shipping_methods'] as $smethod) {
			$pmethods = array();
			foreach ($data['payment_methods'] as $pmethod) {
				$pmethods[$pmethod['code']] = isset($payment_for_shipping[$smethod['code']][$pmethod['code']]);
			}
			$data[$this->_moduleSysName . '_payment_for_shipping'][$smethod['code']] = $pmethods;
		}
		//$this->log("payment_for_shipping:" . print_r($data[$this->_moduleSysName . '_payment_for_shipping'], true));

		// Dependencies for payment
		$shipping_for_payment = $this->config->get($this->_moduleSysName . '_shipping_for_payment');
		$data[$this->_moduleSysName . '_shipping_for_payment'] = array();
		foreach ($data['payment_methods'] as $pmethod) {
			$smethods = array();
			foreach ($data['shipping_methods'] as $smethod) {
				$smethods[$smethod['code']] = isset($shipping_for_payment[$pmethod['code']][$smethod['code']]);
			}
			$data[$this->_moduleSysName . '_shipping_for_payment'][$pmethod['code']] = $smethods;
		}
		//$this->log("shipping_for_payment:" . print_r($data[$this->_moduleSysName . '_shipping_for_payment'], true));

		$data["params"] = $data;

		if (is_file(DIR_LOGS . $this->_logFile))
			$data["logs"] = substr(file_get_contents(DIR_LOGS . $this->_logFile), -100000);
		else
			$data["logs"] = "";

		if($this->config->get('neoseo_novaposhta_status') == 1){
			/* В системе установлен модуль от новой почты с автоматическим формированием накладных
			Надо выбрать город для него
			 */
			$data['novaposhtan_need_city'] = true;
			$this->load->model('tool/neoseo_novaposhta');
			$current_np_city = $this->model_tool_neoseo_novaposhta->getCityBuId($this->config->get($this->_moduleSysName . '_shipping_novaposhta_city_default'));
			$data[$this->_moduleSysName . '_novaposhta_city_name'] = isset($current_np_city['descriptionru'])?$current_np_city['descriptionru']:"";
			$data[$this->_moduleSysName . '_shipping_novaposhta_city_default'] = isset($current_np_city['ref'])?$current_np_city['ref']:"";

		} else {
			$data['novaposhtan_need_city'] = false;
		}
		$data['module_sysname'] = $this->_moduleSysName();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function clear()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName);

		if (is_file(DIR_LOGS . $this->_logFile)) {
			$f = fopen(DIR_LOGS . $this->_logFile, "w");
			fclose($f);
			$this->session->data['success'] = $this->language->get('text_success_clear');
		} else {
			
		}

		$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function license()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data['error_warning'] = "";

		$data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['recheck'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		$data['license_error'] = $this->language->get('error_license_missing');

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function ioncube()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data['error_warning'] = "";

		$data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['recheck'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		$data['license_error'] = $this->language->get('error_ioncube_missing');

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function error()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data['error_warning'] = "";

		$data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['recheck'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		$data['license_error'] = $this->language->get('error_other_errors');

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


		if (isset($this->request->post[$this->_moduleSysName . '_customer_fields'])) {
			foreach ($this->request->post[$this->_moduleSysName . '_customer_fields'] as $type => $fields) {
				foreach ($fields as $key => $value) {
					if ($value['field'] == "comment") {
						$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['type'] = "textarea";
						$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['name'] = $value["field"];
					} else if ($value['field'] != "custom") {
						$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['type'] = "input";
						$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['name'] = $value["field"];
					}
					//$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['display'] = ( isset($value['display']) ? 1 : 0 );
					//$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['required'] = ( isset($value['required']) ? 1 : 0 );
				}
			}
		}

		if (isset($this->request->post[$this->_moduleSysName . '_payment_fields'])) {
			foreach ($this->request->post[$this->_moduleSysName . '_payment_fields'] as $code => $payment_fields) {
				foreach ($payment_fields as $key => $value) {
					if ($value['field'] == "comment") {
						$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['type'] = "textarea";
						$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['name'] = $value["field"];
					} else if ($value['field'] != "custom") {
						$this->request->post[$this->_moduleSysName . '_payment_fields'][$code][$key]['type'] = "input";
						$this->request->post[$this->_moduleSysName . '_payment_fields'][$code][$key]['name'] = $value["field"];
					}
					//$this->request->post[$this->_moduleSysName . '_payment_fields'][$code][$key]['display'] = ( isset($value['display']) ? 1 : 0 );
					//$this->request->post[$this->_moduleSysName . '_payment_fields'][$code][$key]['required'] = ( isset($value['required']) ? 1 : 0 );
				}
			}
		}

		if (isset($this->request->post[$this->_moduleSysName . '_shipping_fields'])) {
			foreach ($this->request->post[$this->_moduleSysName . '_shipping_fields'] as $code => $shipping_fields) {
				foreach ($shipping_fields as $key => $value) {
					if ($value['field'] == "comment") {
						$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['type'] = "textarea";
						$this->request->post[$this->_moduleSysName . '_customer_fields'][$type][$key]['name'] = $value["field"];
					} else if ($value['field'] != "custom") {
						$this->request->post[$this->_moduleSysName . '_shipping_fields'][$code][$key]['type'] = "input";
						$this->request->post[$this->_moduleSysName . '_shipping_fields'][$code][$key]['name'] = $value["field"];
					}
					//$this->request->post[$this->_moduleSysName . '_shipping_fields'][$code][$key]['display'] = ( isset($value['display']) ? 1 : 0 );
					//$this->request->post[$this->_moduleSysName . '_shipping_fields'][$code][$key]['required'] = ( isset($value['required']) ? 1 : 0 );
				}
			}
		}

		if (isset($this->request->post[$this->_moduleSysName . '_payment_for_shipping'])) {
			//$this->log("save payment_for_shipping:" . print_r($this->request->post[$this->_moduleSysName . '_payment_for_shipping'] ,true));
			foreach ($this->request->post[$this->_moduleSysName . '_payment_for_shipping'] as $code => $methods) {
				foreach ($methods as $key => $value) {
					$this->request->post[$this->_moduleSysName . '_payment_for_shipping'][$code][$key] = ( isset($value) ? 1 : 0 );
				}
			}
			$this->debug("updated payment_for_shipping:" . print_r($this->request->post[$this->_moduleSysName . '_payment_for_shipping'], true));
		}

		if (isset($this->request->post[$this->_moduleSysName . '_shipping_for_payment'])) {
			//$this->log("save shipping_for_payment:" . print_r($this->request->post[$this->_moduleSysName . '_shipping_for_payment'] ,true));
			foreach ($this->request->post[$this->_moduleSysName . '_shipping_for_payment'] as $code => $methods) {
				foreach ($methods as $key => $value) {
					$this->request->post[$this->_moduleSysName . '_shipping_for_payment'][$code][$key] = ( isset($value) ? 1 : 0 );
				}
			}
			$this->debug("updated shipping_for_payment:" . print_r($this->request->post[$this->_moduleSysName . '_shipping_for_payment'], true));
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function install()
	{
		$this->load->model("module/" . $this->_moduleSysName);
		$this->registry->get("model_module_" . $this->_moduleSysName)->install();
	}

	public function uninstall()
	{
		$this->load->model("module/" . $this->_moduleSysName);
		$this->registry->get("model_module_" . $this->_moduleSysName)->uninstall();
	}

	public function getWarehouseTypes() {
		// Справочник типов отделений
		$curl = curl_init();
		if (!$curl) {
			$this->log->write("Curl initialization error! Function getWarehouseTypes canseled.");
		} else {
			$api_key = $this->config->get($this->_moduleSysName . '_api_key');
			if (!$api_key){
				$this->log->write("Api key is empty! Function getWarehouseTypes canseled.");
				return false;
			}
			$data_string = '
			{
				"modelName": "Address", 
				"calledMethod": "getWarehouseTypes",
				"methodProperties": {
						"Language": "ru"
					},
				"apiKey": "' . $api_key . '"
			}';

			//$url = 'https://api.novaposhta.ua/v2.0/json/AddressGeneral/getWarehouses';
			$url = 'https://api.novaposhta.ua/v2.0/json/';
			curl_setopt($curl, CURLOPT_URL, $url);
			curl_setopt($curl, CURLOPT_HTTPHEADER, array(
				'Content-Type: application/json',
				'Content-Length: ' . strlen($data_string)
			));
			curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
			curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
			$response_raw = curl_exec($curl);
			$err = curl_error($curl);
			curl_close($curl);

			if ($err) {
				$this->log->write("getWarehouseTypes faled. cURL Error #: ". $err);
				return false;
			} else {
				$result = array();
				$response = json_decode($response_raw);
				foreach ($response->data as $war_type) {
					$result[$war_type->Ref] = $war_type->Description;
				}
				return $result;
			}
		}


	}

}

?>