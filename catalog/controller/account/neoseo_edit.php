<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerAccountNeoSeoEdit extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_account";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/neoseo_edit', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$data = $this->language->load('account/neoseo_edit');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('account/customer');
		$this->load->model('account/neoseo_customer');
		$this->load->model("account/address");

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$data = $this->request->post;
			if (!isset($data['fax'])) {
				$data['fax'] = '';
			}
			$this->model_account_customer->editCustomer($data);
			$newsletter = isset($this->request->post['newsletter']) && $this->request->post['newsletter'] == 'on' ? 1 : 0;
			$this->model_account_customer->editNewsletter($newsletter);
			$this->model_account_neoseo_customer->updateCustomerData($this->request->post);
			$this->model_account_neoseo_customer->updateCustomerAddress($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('account/account', '', 'SSL'));
		}

		$data['errors'] = $this->error;

		$data = $this->initBreadcrumbs(array(
			array("account/neoseo_account", "text_account"),
			array("account/neoseo_edit", "text_edit")
		    ), $data);


		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['action'] = $this->url->link('account/neoseo_edit', '', 'SSL');

		// Выводим поля по клиенту

		$customerData = $this->model_account_neoseo_customer->getCustomerData($this->customer->getId());
		$customerData['firstname'] = $this->customer->getFirstName();
		$customerData['lastname'] = $this->customer->getLastName();
		$customerData['email'] = $this->customer->getEmail();
		$customerData['telephone'] = $this->customer->getTelephone();
		$customerData['fax'] = $this->customer->getFax();
		$address = $this->model_account_address->getAddress($this->customer->getAddressId());
		if ($address) {
			$customerData['company'] = $address['company'];
			//$customerData['company_id'] = $address['company_id'];
			//$customerData['tax_id'] = $address['tax_id'];
		}


		$fieldset = $this->config->get('neoseo_checkout_customer_fields');
		$fieldshtml = array();
		$fields_data = array();
		if(is_array($fieldset) && count($fieldset) > 0){
			$this->load->model('checkout/neoseo_checkout');
			$fields_data = $this->model_checkout_neoseo_checkout->getCustomerData($this->customer->getId());
		}
		foreach ($fieldset as $type => $fields) {
			$fieldsRegister = array();
			foreach ($fields as $field) {
				$fieldName = $field['name'];

				if (in_array($fieldName, array("register", "comment", "password", "password2"))) {
					continue;
				}

				if (in_array($fieldName, array("email"))) {
					$field['required'] = 1;
				}

				if ("password" == $fieldName) {
					$field['type'] = "password";
				}

				if (isset($this->request->post[$fieldName])) {
					$field['value'] = $this->request->post[$fieldName];
				} else if ($this->customer->isLogged() && isset($customerData[$fieldName])) {
					$field['value'] = $customerData[$fieldName];
				}
				if(isset($fields_data[$field['name']])){
					$field['value'] = $fields_data[$field['name']];
				}
				$fieldsRegister[] = $field;
			}
			$data['fields'] = $fieldsRegister;
			$data['delayScript'] = 1;
			$data['group'] = '_' . $type;
			$data['language_id'] = $this->config->get("config_language_id");

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/neoseo_fields.tpl')) {
				$fieldshtml[$type] = $this->load->view($this->config->get('config_template') . '/template/account/neoseo_fields.tpl', $data);
			} else {
				$fieldshtml[$type] = $this->load->view('default/template/account/neoseo_fields.tpl', $data);
			}
		}
		$data['fieldset'] = $fieldshtml;

		$this->load->model('account/customer_group');
		$displayed_customer_groups = $this->config->get('config_customer_group_display');
		if (!$displayed_customer_groups) {
			$displayed_customer_groups = array();
		}
		$items = $this->model_account_customer_group->getCustomerGroups();
		$customer_groups = array();
		foreach ($items as $item) {
			if (!in_array($item['customer_group_id'], $displayed_customer_groups)) {
				continue;
			}
			$customer_groups[$item['customer_group_id']] = $item['name'];
		}
		$data['customer_groups'] = $customer_groups;
		$data['types'] = $customer_groups;

		if (isset($this->request->post['type'])) {
			$data['type_selected'] = $this->request->post['type'];
		} else if (isset($customerData['type'])) {
			$data['type_selected'] = $customerData['type'];
		} else {
			reset($customer_groups);
			$data['type_selected'] = key($customer_groups);
		}

		// Выводим поля по клиенту

		$breadcrumbs = [
			"@context" => "http://schema.org",
			"@type" => "BreadcrumbList",
			"itemListElement" => []
		];

		foreach ($data['breadcrumbs'] as $key => $breadcrumb) {
			$breadcrumbs['itemListElement'][] = [
				"@type" => "ListItem",
				"position" => $key+1,
				"item" =>  [
					"@id" => $breadcrumb['href'],
					"name" => $breadcrumb['text']
				]
			];

		}

		

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/neoseo_edit.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/neoseo_edit.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/neoseo_edit.tpl', $data));
		}
	}

	protected function validate()
	{
		$this->debug("Редактирование персональных данных " . print_r($this->request->post, true));
		$data = $this->language->load('account/neoseo_edit');

		// Проверяем заполненность обязательных полей
		$fields = $this->config->get('neoseo_checkout_customer_fields');
		$type = (int) $this->request->post['type'];
		if (!isset($fields[$type])) {
			$this->error['agree'] = "Внутренняя ошибка";
			return false;
		}

		foreach ($fields[$type] as $field) {
			$fieldName = $field['name'];
			if (in_array($fieldName, array("register", "comment", "password", "password2"))) {
				continue;
			}

			if ($field['display'] && ( $field['required'] || $fieldName == "email" || $fieldName == "password" || $fieldName == "password2" )) {
				$value = trim($this->request->post[$fieldName]);
				if (utf8_strlen($value) < 1) {
					$this->debug("Редактирование персональных данных: Не указано значение для обязательного поля '$fieldName'");
					$this->error[$fieldName] = $this->language->get('error_required');
				}
			}
		}

		if (trim($this->request->post['email']) != $this->customer->getEmail() && $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_exists');
		}


		if (!$this->error) {
			$this->debug("Редактирование персональных данных: валидация выполнена успешно");
			return true;
		} else {
			return false;
		}
	}

}

?>