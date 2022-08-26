<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerAccountNeoSeoRegister extends NeoSeoController
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
		if ($this->customer->isLogged()) {
			$this->response->redirect($this->url->link('account/neoseo_account', '', 'SSL'));
		}
		if (isset($this->session->data['error_social_auth'])) {
			$data['social_error'] = $this->session->data['error_social_auth'];
		}
		$data = $this->language->load('account/neoseo_register');


		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addScript('catalog/view/javascript/jquery/jquery.maskedinput.min.js');


		$this->load->model('account/customer');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->load->model('account/neoseo_customer');
			$this->model_account_neoseo_customer->registerCustomer($this->request->post);

			$this->customer->login($this->request->post['email'], $this->request->post['password']);

			unset($this->session->data['guest']);

			$this->response->redirect($this->url->link('account/success'));
			return;
		}

		$data['errors'] = $this->error;

		$data = $this->initBreadcrumbs(array(
			array("account/neoseo_account", "text_account"),
			array("account/neoseo_register", "heading_title")
		    ), $data);

		$data['text_account_already'] = sprintf($this->language->get('text_account_already'), $this->url->link('account/login', '', 'SSL'));
		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

			if ($information_info) {
				$data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
			} else {
				$data['text_agree'] = '';
			}
		} else {
			$data['text_agree'] = '';
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['confirm'])) {
			$data['error_confirm'] = $this->error['confirm'];
		} else {
			$data['error_confirm'] = '';
		}

		$data['action'] = $this->url->link('account/neoseo_register', '', 'SSL');


		if (isset($this->request->post['agree'])) {
			$data['agree'] = $this->request->post['agree'];
		} else {
			$data['agree'] = false;
		}

		if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('contact', (array) $this->config->get('config_captcha_page'))) {
			$data['captcha'] = $this->load->controller('captcha/' . $this->config->get('config_captcha'), $this->error);
		} else {
			$data['captcha'] = '';
		}

		// Выводим поля по клиенту
		if (isset($this->request->post['type'])) {
			$data['type_selected'] = $this->request->post['type'];
		} else {
			$data['type_selected'] = 1;
		}
		/* NeoSeo Social Auth - begin */
		$this->language->load('account/neoseo_account');
		$language_id = $this->config->get('config_language_id');
		$domain = $this->config->get('config_use_ssl') ? HTTPS_SERVER : HTTP_SERVER;
		$data['neoseo_social_auth_status'] = $this->config->get('neoseo_account_social_status');
		$neoseo_social_auth_title = $this->config->get('neoseo_account_social_title');
		$data['social_auth_title'] = isset($neoseo_social_auth_title[$language_id]) ? $neoseo_social_auth_title[$language_id] : '';
		$social_networks = $this->config->get('neoseo_account_social_networks');
		$data['social_networks'] = $social_networks ? implode(',', $social_networks) : '';
		$data['social_auth_sort'] = $this->config->get('neoseo_account_social_sort');
		$data['domain'] = urlencode($domain . "index.php?route=account/neoseo_social_auth");
		/* NeoSeo Social Auth - end */
		$fieldshtml = array();

		if ($this->config->get('neoseo_checkout_customer_fields')) {

			$fieldset = $this->config->get('neoseo_checkout_customer_fields');

			foreach ($fieldset as $type => $fields) {
				$fieldsRegister = array();
				foreach ($fields as $field) {
					$fieldName = $field['name'];

					if (in_array($fieldName, array("register", "comment"))) {
						continue;
					}

					if (in_array($fieldName, array("email", "password", "password2"))) {
						$field['required'] = 1;
					}

					if ("password" == $fieldName) {
						$field['type'] = "password";
					}

					if (isset($this->request->post[$fieldName])) {
						$field['value'] = $this->request->post[$fieldName];
					}

					$fieldsRegister[] = $field;
				}


				$data['fields'] = $fieldsRegister;
				$data['delayScript'] = 1;
				$data['group'] = '_' . $type;
				$data['language_id'] = $this->config->get("config_language_id");
				$data['text_subscribe_on_news'] = $this->language->get("text_subscribe_on_news");

				// Captcha
				if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('register', (array) $this->config->get('config_captcha_page'))) {
					$data['captcha'] = $this->load->controller('captcha/' . $this->config->get('config_captcha'), $this->error);
				} else {
					$data['captcha'] = '';
				}

				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/neoseo_fields.tpl')) {
					$fieldshtml[$type] = $this->load->view($this->config->get('config_template') . '/template/account/neoseo_fields.tpl', $data);
				} else {
					$fieldshtml[$type] = $this->load->view('default/template/account/neoseo_fields.tpl', $data);
				}
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

		

		// Выводим поля по клиенту

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/neoseo_register.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/neoseo_register.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/neoseo_register.tpl', $data));
		}
	}

	protected function validate()
	{

		$this->debug("Данные для регистрации " . print_r($this->request->post, true));
		$this->language->load('account/neoseo_account');

		// Проверяем заполненность обязательных полей
		$fields = $this->config->get('neoseo_checkout_customer_fields');
		$type = (int) $this->request->post['type'];
		if (!isset($fields[$type])) {
			$this->error['agree'] = "Внутренняя ошибка";
			$this->debug("Не найдены поля для группы покупателей '$type'");
			return false;
		}

		foreach ($fields[$type] as $field) {
			$fieldName = $field['name'];
			if ($field['display'] && ( $field['required'] || $fieldName == "email" || $fieldName == "password" || $fieldName == "password2" )) {
				$value = trim($this->request->post[$fieldName]);
				if (utf8_strlen($value) < 1) {
					$this->debug("Регистрация: Не указано значение для обязательного поля '$fieldName'");
					$this->error[$fieldName] = $this->language->get('error_required');
				}
			}
		}

		if (trim($this->request->post['email']) != "" && $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['email'] = $this->language->get('error_exists');
		}

        if(!preg_match($this->config->get('config_mail_regexp'), $this->request->post['email'])){
            $this->error['email'] = $this->language->get('error_email');
        }

		if ($this->request->post['password2'] != $this->request->post['password']) {
			$this->error['password2'] = $this->language->get('error_confirm');
		}

		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));

			if ($information_info && !isset($this->request->post['agree'])) {
				$this->error['agree'] = sprintf($this->language->get('error_agree'), $information_info['title']);
			}
		}

		// Captcha
		if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array('register', (array) $this->config->get('config_captcha_page'))) {
			$captcha = $this->load->controller('captcha/' . $this->config->get('config_captcha') . '/validate');
			if ($captcha) {
				$this->error['captcha'] = $captcha;
			}
		}

		if ($this->error) {
			$this->debug("Регистрация: Обнаружены ошибки заполнения полей: " . print_r($this->error, true));
			$this->error['warning'] = $this->language->get("error_validation");
			return false;
		}

		return true;
	}

}

?>