<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerAccountNeoSeoAccount extends NeoSeoController
{

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
			$this->session->data['redirect'] = $this->url->link('account/neoseo_account', '', 'SSL');

			$this->response->redirect($this->url->link('account/neoseo_login', '', 'SSL'));
		}

		$data = $this->load->language('account/neoseo_account');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/neoseo_account', '', 'SSL')
		);

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		$this->load->model('account/address');

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_subtitle'] = $this->language->get('text_name');
		$data['text_name'] = $this->language->get('text_name');
		$data['text_phone'] = $this->language->get('text_phone');
		$data['text_email'] = $this->language->get('text_email');
		$data['text_password'] = $this->language->get('text_password');
		$data['text_shipping'] = $this->language->get('text_shipping');
		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_reward'] = $this->language->get('text_reward');
		$data['text_newsletter'] = $this->language->get('text_newsletter');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');

		$data['edit'] = $this->url->link('account/neoseo_edit', '', 'SSL');
		$data['password'] = $this->url->link('account/neoseo_password', '', 'SSL');
		$data['address'] = $this->url->link('account/neoseo_address', '', 'SSL');
		$data['wishlist'] = $this->url->link('account/neoseo_wishlist');
		$data['order'] = $this->url->link('account/neoseo_order', '', 'SSL');
		$data['download'] = $this->url->link('account/neoseo_download', '', 'SSL');
		$data['return'] = $this->url->link('account/neoseo_return', '', 'SSL');
		$data['transaction'] = $this->url->link('account/neoseo_transaction', '', 'SSL');
		$data['newsletter'] = $this->url->link('account/neoseo_newsletter', '', 'SSL');
		$data['recurring'] = $this->url->link('account/neoseo_recurring', '', 'SSL');

		if ($this->config->get('reward_status')) {
			$data['reward'] = $this->url->link('account/neoseo_reward', '', 'SSL');
		} else {
			$data['reward'] = '';
		}
		$addressData = $this->model_account_address->getAddress($this->customer->getAddressId());
		$data['addressData'] = "{$addressData['country']}, {$addressData['zone']}, {$addressData['city']}, {$addressData['address_1']}";
		$data['customerData'] = array(
			'name' => $this->customer->getFirstName() . ' ' . $this->customer->getLastName(),
			'email' => $this->customer->getEmail(),
			'telephone' => $this->customer->getTelephone(),
			'newsletter' => $this->customer->getNewsletter(),
			'reward' => $this->customer->getRewardPoints()
		);

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

		// Получает пользовательские поля
		$fieldset = $this->config->get('neoseo_checkout_customer_fields');

		if(isset( $fieldset[$this->config->get('config_customer_group_id')] ) ){
			$fieldset = $fieldset[$this->config->get('config_customer_group_id')];
		} else {
			$fieldset = array();
		}

		$fieldshtml = array();
		$fields_data = array();
		if(is_array($fieldset) && count($fieldset) > 0){
			$this->load->model('checkout/neoseo_checkout');
			$fields_data = $this->model_checkout_neoseo_checkout->getCustomerData($this->customer->getId());
		}

		foreach ($fieldset as $field) {
			if (in_array($field['name'], array("name", "email", "telephone", "newsletter"))) {
				continue;
			}
			if(isset($fields_data[$field['name']]) && $field['display'] == 1 && $field['only_register'] == 1 && $field['type'] != 'password'){
				$field['value'] = $fields_data[$field['name']];
				$fieldshtml[] = $field;
			}
		}

		$data['custom_fields'] = $fieldshtml;
		$data['language_id'] = $this->config->get("config_language_id");

		

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/neoseo_account.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/neoseo_account.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/neoseo_account.tpl', $data));
		}
	}

	public function country()
	{
		$json = array();

		$this->load->model('localisation/country');

		$country_info = $this->model_localisation_country->getCountry($this->request->get['country_id']);

		if ($country_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id' => $country_info['country_id'],
				'name' => $country_info['name'],
				'iso_code_2' => $country_info['iso_code_2'],
				'iso_code_3' => $country_info['iso_code_3'],
				'address_format' => $country_info['address_format'],
				'postcode_required' => $country_info['postcode_required'],
				'zone' => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status' => $country_info['status']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

}
