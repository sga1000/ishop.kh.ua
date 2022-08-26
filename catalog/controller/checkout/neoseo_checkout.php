<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerCheckoutNeoSeoCheckout extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleName = "";
		$this->_moduleSysName = "neoseo_checkout";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{

		$data = $this->language->load('checkout/' . $this->_moduleSysName);

		$this->document->addScript('catalog/view/javascript/jquery/jquery.maskedinput.min.js');

		$this->document->addScript('catalog/view/javascript/neoseo_checkout.js');
		if ($this->config->get("neoseo_checkout_dependency_type") == 'payment_for_shipping') {
			$this->document->addScript('catalog/view/javascript/neoseo_checkout_p4s.js');
		} else if ($this->config->get("neoseo_checkout_dependency_type") == 'shipping_for_payment') {
			$this->document->addScript('catalog/view/javascript/neoseo_checkout_s4p.js');
		} else {
			$this->document->addScript('catalog/view/javascript/neoseo_checkout_neutral.js');
		}
		if (!file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/neoseo_checkout.scss')) {
			$this->addThemeStyle('neoseo_checkout.css');
		}

		if ($this->config->get($this->_moduleSysName . "_use_international_phone_mask") == 1) {
			$this->document->addScript('catalog/view/javascript/intl-tel-input/js/intlTelInput.min.js');
			$this->document->addScript('catalog/view/javascript/intl-tel-input/libphonenumber/utils.js');
			$this->document->addStyle('catalog/view/javascript/intl-tel-input/css/intlTelInput.css');
		}

		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->cart->hasStock() && $this->config->get($this->_moduleSysName . "_stock_control") == 1)) {
			$this->response->redirect($this->url->link('checkout/cart'));
		}

		// Validate minimum quantity requirements.
		$products = $this->cart->getProducts();

		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			if ($product['minimum'] > $product_total && $this->config->get($this->_moduleSysName . "_stock_control") == 1) {
				$this->response->redirect($this->url->link('checkout/cart'));
			}
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$data = $this->initBreadcrumbs(array(
			array($this->_moduleSysName . "/checkout", "heading_title")
		    ), $data);

		$data['logged'] = $this->customer->isLogged();
		$data['shipping_required'] = true; //$this->cart->hasShipping();

		$data['agreement_text'] = $this->config->get($this->_moduleSysName . "_agreement_text") == 1;
		$data['hide_menu'] = $this->config->get($this->_moduleSysName . "_hide_menu");
		$data['hide_footer'] = $this->config->get($this->_moduleSysName . "_hide_footer");

		$data['text_agree'] = '';
		$data['description_agree'] = '';
		$agreement_id = $this->config->get($this->_moduleSysName . '_agreement_id');
		if ($agreement_id) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($agreement_id);
			if ($information_info) {
				if ($data['agreement_text']) {
					$data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information', 'information_id=' . $agreement_id, 'SSL'), $information_info['title'], $information_info['title']);
					;
					$data['description_agree'] = $information_info['description'];
				} else {
					$data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information', 'information_id=' . $agreement_id, 'SSL'), $information_info['title'], $information_info['title']);
				}
			}
		}

		if( $this->config->get($this->_moduleSysName . '_shipping_zone_default') > 0 && !$this->customer->isLogged() && $this->config->get($this->_moduleSysName . "_shipping_country_default") > 0) {
			$this->initCity($this->config->get($this->_moduleSysName . '_shipping_city_default'), $this->config->get($this->_moduleSysName . '_shipping_zone_default'), $this->config->get($this->_moduleSysName . "_shipping_country_default"));
			$this->session->data['neoseo_novaposhta']['city'] = $this->config->get($this->_moduleSysName . '_shipping_novaposhta_city_default');
		}

		if (!isset($this->session->data['guest']['payment']['city']) && $this->customer->isLogged()) {
			// Если кастомер залогинен, то данные о городе можно заполнить автоматически
			$this->load->model('account/address');
			$address = $this->model_account_address->getAddress($this->customer->getAddressId());
			if ($address['city']) {
				$this->initCity($address['city'], $address['zone_id'], $address['country_id']);
			}
		}

		$no_shipping_address = $this->config->get('neoseo_checkout_shipping_city_select') == 'disabled';
		if ($no_shipping_address) {
			$this->initCity('Киев', 3491, 220);
		}

		$data = $this->initSessionParams(array(
			array('agree', 'agree', $this->config->get($this->_moduleSysName . "_agreement_default")),
		    ), $data);

		$data['agreement_required'] = $this->config->get($this->_moduleSysName . "_agreement_required") == 1;

		// Validate min amount
		$data['min_amount'] = $this->config->get($this->_moduleSysName . "_min_amount");
		$data['subtotal'] = $this->cart->getSubTotal();
		if ($data['min_amount'] > 0 && $data['min_amount'] > $data['subtotal']) {
			$this->response->redirect($this->url->link('checkout/cart'));
		}

		$data = $this->initConfigParams(array(
			$this->_moduleSysName . '_debug',
			$this->_moduleSysName . '_dependency_type',
			$this->_moduleSysName . '_shipping_for_payment',
			$this->_moduleSysName . '_payment_for_shipping',
			$this->_moduleSysName . '_shipping_control',
			$this->_moduleSysName . '_min_amount',
			$this->_moduleSysName . '_agreement_text',
			$this->_moduleSysName . '_shipping_city_select',
			$this->_moduleSysName . '_shipping_country_select',
			$this->_moduleSysName . '_shipping_country_default',
		    ), $data);

		$data['country_id'] = $data[$this->_moduleSysName . '_shipping_country_default'];
		if (isset($this->session->data['guest']['payment']['country_id']) && $this->session->data['guest']['payment']['country_id']) {
			$data['country_id'] = $this->session->data['guest']['payment']['country_id'];
		}
		$data['zone_id'] = isset($this->session->data['guest']['payment']['zone_id']) ? $this->session->data['guest']['payment']['zone_id'] : '';
		$data['city'] = isset($this->session->data['guest']['payment']['city']) ? $this->session->data['guest']['payment']['city'] : '';

		$this->load->model('localisation/country');

		// localization
		/* Страна по умолчанию */
		$data['config_country'] = $this->model_localisation_country->getCountry($this->config->get('config_country_id'));
		/* Страна по умолчанию */

		$countries = $this->model_localisation_country->getCountries();
		$data['countries'] = array();
		foreach ($countries as $country) {
			$data['countries'][] = array(
				"country_id" => $country['country_id'],
				"name" => $country['name']
			);
		}
		$this->load->model('localisation/zone');
		$zones = $this->model_localisation_zone->getZonesByCountryId($data['country_id']);
		$data['zones'] = array(array(
				'zone_id' => 0,
				"name" => $this->language->get('text_select')
		));
		foreach ($zones as $zone) {
			$data['zones'][] = array(
				"zone_id" => $zone['zone_id'],
				"name" => $zone['name']
			);
		}

		/* akcenter - begin */
		$data['cart'] = $this->url->link('checkout/cart', '', 'SSL');
		$data['watched'] = $this->url->link('account/watched', '', 'SSL');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['orders'] = $this->url->link('account/orders', '', 'SSL');
		$data['favorite'] = $this->url->link('account/favorite', '', 'SSL');
		/* akcenter - end */

		if ($this->config->get('neoseo_checkout_shipping_city_select') == 'disabled') {
			$data['country_id'] = '220';
			$data['zone_id'] = '3491';
			$data['city'] = 'Киев';
		}

		$data['language_id'] = $this->config->get('config_language_id');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if ($this->config->get($this->_moduleSysName . '_onestep')) {
			$template = "neoseo_checkout_onestep.tpl";
		} else {
			$template = "neoseo_checkout.tpl";
		}

		$data['aways_show_delivery_block'] = $this->config->get($this->_moduleSysName . "_aways_show_delivery_block");
		$data['shipping_require_city'] = $this->config->get($this->_moduleSysName . "_shipping_require_city");
		//echo "<pre>";print_r($data['shipping_require_city']);exit;
		if(isset($this->session->data['shipping_method']['code']) && !in_array($this->session->data['shipping_method']['code'],$data['shipping_require_city']) && $data['aways_show_delivery_block'] == 1){
			$data['hide_city_block'] = true;
		} else {
			$data['hide_city_block'] = false;
		}

		$data['header_hide'] = $this->config->get('neoseo_unistor_header_checkout_hide');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/' . $template)) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/' . $template, $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/checkout/' . $template, $data));
		}
	}

	public function country()
	{
		//$this->log( get_class($this) . "->" . __FUNCTION__ . "(): session: " . print_r($this->session->data,true) );
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

		$this->outputJson($json);
	}

	protected function initCity($city, $zone, $countryId = 220)
	{
		$this->log("initCity($city, $zone, $countryId)");

		// Страна
		$this->load->model('localisation/country');
		$country_info = $this->model_localisation_country->getCountry($countryId);
		if ($country_info) {
			$this->session->data['guest']['payment']['country_id'] = $countryId;
			$this->session->data['guest']['payment']['country'] = $country_info['name'];
			$this->session->data['guest']['payment']['iso_code_2'] = $country_info['iso_code_2'];
			$this->session->data['guest']['payment']['iso_code_3'] = $country_info['iso_code_3'];
			$this->session->data['guest']['payment']['address_format'] = $country_info['address_format'];

			$this->session->data['guest']['shipping']['country_id'] = $countryId;
			$this->session->data['guest']['shipping']['country'] = $country_info['name'];
			$this->session->data['guest']['shipping']['iso_code_2'] = $country_info['iso_code_2'];
			$this->session->data['guest']['shipping']['iso_code_3'] = $country_info['iso_code_3'];
			$this->session->data['guest']['shipping']['address_format'] = $country_info['address_format'];
		} else {
			$this->log("Country not found: $countryId");
			$this->session->data['guest']['payment']['country_id'] = 0;
			$this->session->data['guest']['payment']['country'] = '';
			$this->session->data['guest']['payment']['iso_code_2'] = '';
			$this->session->data['guest']['payment']['iso_code_3'] = '';
			$this->session->data['guest']['payment']['address_format'] = '';

			$this->session->data['guest']['shipping']['country_id'] = 0;
			$this->session->data['guest']['shipping']['country'] = '';
			$this->session->data['guest']['shipping']['iso_code_2'] = '';
			$this->session->data['guest']['shipping']['iso_code_3'] = '';
			$this->session->data['guest']['shipping']['address_format'] = '';
		}

		// Регион
		$this->load->model('checkout/' . $this->_moduleSysName);

		$zoneId = $zone;
		$this->load->model('localisation/zone');

		$zone_info = $this->model_localisation_zone->getZone($zoneId);
		if ($zone_info) {
			$this->session->data['guest']['payment']['zone_id'] = $zoneId;
			$this->session->data['guest']['payment']['zone'] = $zone_info['name'];
			$this->session->data['guest']['payment']['zone_code'] = $zone_info['code'];

			$this->session->data['guest']['shipping']['zone_id'] = $zoneId;
			$this->session->data['guest']['shipping']['zone'] = $zone_info['name'];
			$this->session->data['guest']['shipping']['zone_code'] = $zone_info['code'];
		} else {
			$this->log("Zone not found: $zoneId");
			$this->session->data['guest']['payment']['zone_id'] = 0;
			$this->session->data['guest']['payment']['zone'] = '';
			$this->session->data['guest']['payment']['zone_code'] = '';

			$this->session->data['guest']['shipping']['zone_id'] = 0;
			$this->session->data['guest']['shipping']['zone'] = '';
			$this->session->data['guest']['shipping']['zone_code'] = '';
		}

		// Город
		$this->session->data['guest']['payment']['city'] = $city;
		$this->session->data['guest']['shipping']['city'] = $city;
		$this->session->data['guest']['shipping']['cityselect'] = $city;

		$this->log("Session: " . print_r($this->session->data['guest'], true));
	}

	public function city()
	{
		$json = array();

		$city = trim($this->request->get['city']);
		$zone = trim($this->request->get['zone']);
		$country_id = trim($this->request->get['country']);
		if (!$country_id) {
			$country_id = $this->config->get($this->_moduleSysName . "_shipping_country_default");
		}

		$this->initCity($city, $zone, $country_id);

		$json['zone_id'] = $this->session->data['guest']['payment']['zone_id'];
		$json['country_id'] = $this->session->data['guest']['payment']['country_id'];

		$this->outputJson($json);
	}

	public function validate()
	{
		// проверяем что галочка установлена

		$this->language->load('checkout/' . $this->_moduleSysName);

		$json = array();

		if ($this->config->get($this->_moduleSysName . '_agreement_id')) {
			$this->load->model('catalog/information');

			$information_info = $this->model_catalog_information->getInformation($this->config->get($this->_moduleSysName . '_agreement_id'));

			if ($information_info && !isset($this->request->post['agree'])) {
				$json['error']['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
			}
		}
		$this->event->trigger('post.checkout.validate', $json);
		$this->outputJson($json);
	}

	public function login()
	{
		$data = $this->language->load('checkout/' . $this->_moduleSysName);

		$data['guest_checkout'] = ($this->config->get('config_guest_checkout') && !$this->config->get('config_customer_price') && !$this->cart->hasDownload());

		if (isset($this->session->data['account'])) {
			$data['account'] = $this->session->data['account'];
		} else {
			$data['account'] = 'register';
		}

		$data['text_forgotten'] = $this->language->get('text_forgotten');
		$data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/neoseo_popup_login.tpl')) {
			$json['html'] = $this->load->view($this->config->get('config_template') . '/template/checkout/neoseo_popup_login.tpl', $data);
		} else {
			$json['html'] = $this->load->view('default/template/checkout/neoseo_popup_login.tpl', $data);
		}
		$this->event->trigger('post.checkout.login', $json);
		$this->outputJson($json);
	}

	public function validateLogin()
	{
		$this->language->load('checkout/checkout');

		$json = array();

		if ($this->customer->isLogged()) {
			$json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');
		}

		if (!$json) {
			if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
				$json['error']['warning'] = $this->language->get('error_login');
			}

			$this->load->model('account/customer');

			$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);

			if ($customer_info && !$customer_info['approved']) {
				$json['error']['warning'] = $this->language->get('error_approved');
			}
		}

		if (!$json) {
			unset($this->session->data['guest']);

			// Default Addresses
			$this->load->model('account/address');

			$address_info = $this->model_account_address->getAddress($this->customer->getAddressId());

			if ($address_info) {
				if ($this->config->get('config_tax_customer') == 'shipping') {
					$this->session->data['shipping_country_id'] = $address_info['country_id'];
					$this->session->data['shipping_zone_id'] = $address_info['zone_id'];
					$this->session->data['shipping_postcode'] = $address_info['postcode'];
				}

				if ($this->config->get('config_tax_customer') == 'payment') {
					$this->session->data['payment_country_id'] = $address_info['country_id'];
					$this->session->data['payment_zone_id'] = $address_info['zone_id'];
				}
			} else {
				unset($this->session->data['shipping_country_id']);
				unset($this->session->data['shipping_zone_id']);
				unset($this->session->data['shipping_postcode']);
				unset($this->session->data['payment_country_id']);
				unset($this->session->data['payment_zone_id']);
			}

			$json['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');
		}
		$this->event->trigger('post.checkout.validateLogin', $json);
		$this->response->setOutput(json_encode($json));
	}

	public function confirm()
	{

		$json = array();

		$this->load->model('checkout/' . $this->_moduleSysName);
		//$this->log("Данные confirm: " . print_r($this->session->data,true) );

		if (!$this->customer->isLogged() && isset($this->session->data['guest']['register']) && $this->session->data['guest']['register']) {
			$customerData = $this->session->data['guest'];
			$customerData['city'] = $this->session->data['guest']['shipping']['city'];
			$customerData['zone_id'] = $this->session->data['guest']['shipping']['zone_id'];
			$customerData['country_id'] = $this->session->data['guest']['shipping']['country_id'];
			$customerData['postcode'] = isset($this->session->data['guest']['shipping']['postcode']) ? $this->session->data['guest']['shipping']['postcode'] : '';
			$customerData['address_1'] = isset($this->session->data['guest']['shipping']['address_1']) ? $this->session->data['guest']['shipping']['address_1'] : '';
			$customerData['address_2'] = isset($this->session->data['guest']['shipping']['address_2']) ? $this->session->data['guest']['shipping']['address_2'] : '';
			$this->model_checkout_neoseo_checkout->registerCustomer($customerData, $this->session->data['guest']['shipping']);
			$this->customer->login($this->session->data['guest']['email'], $this->session->data['guest']['password']);
			// Фиксим корзину, иначе выбросит на страничку с корзиной
			$this->db->query("UPDATE " . DB_PREFIX . "cart SET customer_id = '" . (int) $this->customer->getId() . "' WHERE session_id = '" . $this->db->escape($this->session->getId()) . "'");
		}

		/* if ($this->cart->hasShipping()) { */
		// Validate if shipping address has been set.
		$this->load->model('account/address');

		$shipping_address = $this->session->data['guest']['shipping'];
		if (empty($shipping_address)) {
			$json['error'] = 'Не указан адрес доставки';
		}

		// Validate if shipping method has been set.
		if (!isset($this->session->data['shipping_method'])) {
			$json['error'] = 'Не указан метод доставки';
		}
		/* } else {
		  unset($this->session->data['shipping_method']);
		  unset($this->session->data['shipping_methods']);
		  } */

		// Validate if payment address has been set.
		$this->load->model('account/address');
		$payment_address = $this->session->data['guest']['payment'];
		if (empty($payment_address)) {
			$json['error'] = 'Не указан платежный адрес';
		}

		// Validate if payment method has been set.
		if (!isset($this->session->data['payment_method'])) {
			$json['error'] = 'Не указан платежный метод';
		}

		// Validate cart has products and has stock.
		if ((!$this->cart->hasProducts() && empty($this->session->data['vouchers']))) {
			$this->log('Корзина пустая');
			$json['redirect'] = $this->url->link('checkout/cart');
		}
		if ((!$this->cart->hasStock() && $this->config->get($this->_moduleSysName . '_stock_control') == 1)) {
			$this->log('Товары из корзины отсутствуют в наличии');
			$json['redirect'] = $this->url->link('checkout/cart');
		}

		// Validate minimum quantity requirements.
		$products = $this->cart->getProducts();
		foreach ($products as $product) {
			$product_total = 0;

			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}

			if ($product['minimum'] > $product_total && $this->config->get($this->_moduleSysName . "_stock_control") == 1) {
				$this->log('Количество товаров меньше минимального заказа');
				$json['redirect'] = $this->url->link('checkout/cart');
				break;
			}
		}

		if (!isset($json['error']) && !isset($json['redirect'])) {
			$total_data = array();
			$total = 0;
			$taxes = $this->cart->getTaxes();

			$this->load->model('extension/extension');

			$sort_order = array();

			$results = $this->model_extension_extension->getExtensions('total');

			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}

			array_multisort($sort_order, SORT_ASC, $results);

			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('total/' . $result['code']);

					$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
				}
			}

			$sort_order = array();

			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}

			array_multisort($sort_order, SORT_ASC, $total_data);

			$this->language->load('checkout/' . $this->_moduleSysName);

			$data['button_back'] = $this->language->get('button_back');
			$data['back'] = $this->url->link($this->_moduleSysName . '/checkout');

			$data = array();

			$data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
			$data['store_id'] = $this->config->get('config_store_id');
			$data['store_name'] = $this->config->get('config_name');

			if ($data['store_id']) {
				$data['store_url'] = $this->config->get('config_url');
			} else {
				$data['store_url'] = HTTP_SERVER;
			}

			if ($this->customer->isLogged()) {
				$data['customer_id'] = $this->customer->getId();
				$data['customer_group_id'] = $this->customer->getGroupId();
			} elseif (isset($this->session->data['guest'])) {
				$data['customer_id'] = 0;
				$data['customer_group_id'] = (int) $this->config->get('config_customer_group_id');
			}
			foreach (array('firstname', 'lastname', 'email', 'telephone', 'fax') as $fieldName) {
				$data[$fieldName] = isset($this->session->data['guest'][$fieldName]) ? $this->session->data['guest'][$fieldName] : '';
			}

			$payment_address = $this->session->data['guest']['payment'];
			foreach (array('firstname', 'lastname', 'company', 'company_id', 'tax_id', 'address_1', 'address_2', 'city', 'postcode', 'zone', 'zone_id', 'country', 'country_id', 'address_format') as $fieldName) {
				$data['payment_' . $fieldName] = isset($payment_address[$fieldName]) ? $payment_address[$fieldName] : '';
			}

			if (isset($this->session->data['payment_method']['title'])) {
				$data['payment_method'] = $this->session->data['payment_method']['title'];
			} else {
				$data['payment_method'] = '';
			}

			if (isset($this->session->data['payment_method']['code'])) {
				$data['payment_code'] = $this->session->data['payment_method']['code'];
			} else {
				$data['payment_code'] = '';
			}

			/* if ($this->cart->hasShipping()) { */
			$shipping_address = $this->session->data['guest']['shipping'];
			foreach (array('firstname', 'lastname', 'company', 'address_1', 'address_2', 'city', 'postcode', 'zone', 'zone_id', 'country', 'country_id', 'address_format') as $fieldName) {
				$data['shipping_' . $fieldName] = isset($shipping_address[$fieldName]) ? $shipping_address[$fieldName] : '';
			}

			if (isset($this->session->data['shipping_method']['title'])) {
				$data['shipping_method'] = $this->session->data['shipping_method']['title'];
			} else {
				$data['shipping_method'] = '';
			}

			if (isset($this->session->data['shipping_method']['code'])) {
				$data['shipping_code'] = $this->session->data['shipping_method']['code'];
			} else {
				$data['shipping_code'] = '';
			}
			/* } else {
			  $data['shipping_firstname'] = '';
			  $data['shipping_lastname'] = '';
			  $data['shipping_company'] = '';
			  $data['shipping_address_1'] = '';
			  $data['shipping_address_2'] = '';
			  $data['shipping_city'] = '';
			  $data['shipping_postcode'] = '';
			  $data['shipping_zone'] = '';
			  $data['shipping_zone_id'] = '';
			  $data['shipping_country'] = '';
			  $data['shipping_country_id'] = '';
			  $data['shipping_address_format'] = '';
			  $data['shipping_method'] = '';
			  $data['shipping_code'] = '';
			  } */

			$product_data = array();

			foreach ($this->cart->getProducts() as $product) {
				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$value = $this->encryption->decrypt($option['value']);
					}

					$option_data[] = array(
						'product_option_id' => $option['product_option_id'],
						'product_option_value_id' => $option['product_option_value_id'],
						'option_id' => $option['option_id'],
						'option_value_id' => $option['option_value_id'],
						'name' => $option['name'],
						'value' => $value,
						'type' => $option['type']
					);
				}

				$query = $this->db->query("select sku from `" . DB_PREFIX . "product` where product_id=" . (int) $product['product_id']);
				if (!$query->num_rows) {
					$sku = '';
				} else {
					$sku = $query->row['sku'];
				}
				$product_data[] = array(
					'product_id' => $product['product_id'],
					'name' => $product['name'],
					'model' => $product['model'],
					'sku' => $sku,
					'option' => $option_data,
					'download' => $product['download'],
					'quantity' => $product['quantity'],
					'subtract' => $product['subtract'],
					'price' => $product['price'],
					'total' => $product['total'],
					'tax' => $this->tax->getTax($product['price'], $product['tax_class_id']),
					'reward' => $product['reward']
				);
			}

			// Gift Voucher
			$voucher_data = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $voucher) {
					$voucher_data[] = array(
						'description' => $voucher['description'],
						'code' => substr(md5(mt_rand()), 0, 10),
						'to_name' => $voucher['to_name'],
						'to_email' => $voucher['to_email'],
						'from_name' => $voucher['from_name'],
						'from_email' => $voucher['from_email'],
						'voucher_theme_id' => $voucher['voucher_theme_id'],
						'message' => $voucher['message'],
						'amount' => $voucher['amount']
					);
				}
			}

			$data['products'] = $product_data;
			$data['vouchers'] = $voucher_data;
			$data['totals'] = $total_data;
			$data['comment'] = $this->session->data['comment'];
			$data['total'] = $total;

			if (isset($this->request->cookie['tracking'])) {
				$data['tracking'] = $this->request->cookie['tracking'];
				$this->load->model('affiliate/affiliate');

				$affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);

				if ($affiliate_info) {
					$data['affiliate_id'] = $affiliate_info['affiliate_id'];
					$data['commission'] = ($total / 100) * $affiliate_info['commission'];
				} else {
					$data['affiliate_id'] = 0;
					$data['commission'] = 0;
				}

				// Marketing
				$this->load->model('checkout/marketing');

				$marketing_info = $this->model_checkout_marketing->getMarketingByCode($this->request->cookie['tracking']);

				if ($marketing_info) {
					$order_data['marketing_id'] = $marketing_info['marketing_id'];
				} else {
					$order_data['marketing_id'] = 0;
				}
			} else {
				$data['affiliate_id'] = 0;
				$data['commission'] = 0;
				$data['tracking'] = '';
				$data['marketing_id'] = 0;
			}

			$data['language_id'] = $this->config->get('config_language_id');
			$data['currency_id'] = $this->currency->getId();
			$data['currency_code'] = $this->currency->getCode();
			$data['currency_value'] = $this->currency->getValue($this->currency->getCode());
			$data['ip'] = $this->request->server['REMOTE_ADDR'];

			if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
				$data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];
			} elseif (!empty($this->request->server['HTTP_CLIENT_IP'])) {
				$data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];
			} else {
				$data['forwarded_ip'] = '';
			}

			if (isset($this->request->server['HTTP_USER_AGENT'])) {
				$data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];
			} else {
				$data['user_agent'] = '';
			}

			if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
				$data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];
			} else {
				$data['accept_language'] = '';
			}

			$this->load->model('checkout/order');

			/* NeoSeo Order Referrer - begin */
			if (!isset($this->request->cookie['first_referrer'])) {
				$data['first_referrer'] = 'Not set';
			} else {
				$data['first_referrer'] = $this->request->cookie['first_referrer'];
			}
			if (!isset($this->request->cookie['last_referrer'])) {
				$data['last_referrer'] = 'Not set';
			} else {
				$data['last_referrer'] = $this->request->cookie['last_referrer'];
			}
			/* NeoSeo Order Referrer - end */

			//$this->log("session data:" . print_r($this->session->data,true));
			//$this->log("order data:" . print_r($data,true));
			$data['order_id'] = $this->model_checkout_order->addOrder($data);
			if ($this->customer->isLogged()) {
				$addresses = $this->model_account_address->getAddresses();
				$address = array();
				if (sizeof($addresses) > 0) {
					$address = array_pop($addresses);
				} else {
					$address['customer_id'] = $this->customer->getId();
					$address['firstname'] = $this->customer->getFirstName();
					$address['lastname'] = $this->customer->getLastName();
					$address['company'] = '';
				}
				$address['country_id'] = $shipping_address['country_id'];
				$address['postcode'] = isset($shipping_address['postcode']) ? $shipping_address['postcode'] : '';
				$address['zone_id'] = $shipping_address['zone_id'];
				$address['city'] = $shipping_address['city'];
				$address['address_1'] = isset($shipping_address['address_1']) ? $shipping_address['address_1'] : '';
				$address['address_2'] = isset($shipping_address['address_2']) ? $shipping_address['address_2'] : '';
				if (isset($address['address_id']))
					$this->model_account_address->editAddress($address['address_id'], $address);
				else
					$this->model_account_address->addAddress($address);
			}
			$this->session->data['order_id'] = $data['order_id'];
			if ($this->config->get("neoseo_google_analytics_ecommerce") || $this->config->get("neoseo_yandex_metrica_ecommerce")) {
				$json['order_data'] = $data;
			}
			if (isset($this->session->data['guest']['files']))
				$this->uploadFiles($this->session->data['guest']['files']);

			$this->model_checkout_neoseo_checkout->saveOrderData($this->session->data['order_id'], $this->session->data['guest']);
		}

		// Вот тут payment и юзаем
		$controllers = explode(".", $this->session->data['payment_method']['code']);
		$payment_controller = $controllers[0];
		$json['payment'] = $this->load->controller('payment/' . $payment_controller);

		$this->outputJson($json);
	}

	public function autocomplete()
	{

		if (isset($this->request->get['term'])) {
			$filter = trim($this->request->get['term']);
		} else if (isset($this->request->post['term'])) {
			$filter = trim($this->request->post['term']);
		}

		if (!$filter) {
			$this->response->setOutput(json_encode(array()));
			return;
		}

		if ($this->config->get($this->_moduleSysName . "_shipping_country_select")) {
			$country_id = $this->config->get($this->_moduleSysName . "_shipping_country_default");
		} else {
			$country_id = 0;
		}
		$this->load->model("localisation/neoseo_city");
		$cities = $this->model_localisation_neoseo_city->lookup($filter);

		$result = array();
		foreach ($cities as $city) {
			$value = $city['city'];

			if ($city['zone'] != $city['city'])
				$value .= ", " . $city['zone'];

			if ($country_id != 0)
				$value .= ", " . $city['country'];

			$item = array(
				"value" => $value,
				'city' => $city['city'],
				'zone' => $city['zone'],
				'zone_id' => $city['zone_id'],
				'country' => $city['country'],
				'country_id' => $city['country_id']
			);
			$result[] = $item;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($result));
	}

	public function autocomplete_city()
	{

		if (isset($this->request->get['name'])) {
			$city = trim($this->request->get['name']);
		} else if (isset($this->request->post['name'])) {
			$city = trim($this->request->post['name']);
		}

		if (!$city) {
			$this->response->setOutput(json_encode(array()));
			return;
		}

		if (isset($this->request->get['country_id'])) {
			$country_id = trim($this->request->get['country_id']);
		} else if (isset($this->request->post['country_id'])) {
			$country_id = trim($this->request->post['country_id']);
		} else if ($this->config->get($this->_moduleSysName . "_shipping_country_select")) {
			$country_id = $this->config->get($this->_moduleSysName . "_shipping_country_default");
		} else {
			$country_id = 0;
		}

		if (isset($this->request->get['zone_id'])) {
			$zone_id = trim($this->request->get['zone_id']);
		} else if (isset($this->request->post['zone_id'])) {
			$zone_id = trim($this->request->post['zone_id']);
		} else {
			$zone_id = 0;
		}

		$this->load->model("localisation/neoseo_city");
		$cities = $this->model_localisation_neoseo_city->lookup_city($city, $zone_id, $country_id);

		$result = array();
		foreach ($cities as $city) {
			$value = $city['city'];

			$item = array(
				"value" => $value,
				'city' => $city['city'],
				'zone_id' => $city['zone_id'],
				'country_id' => $city['country_id']
			);
			$result[] = $item;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($result));
	}

	public function save()
	{
		if (!isset($this->request->post['data']) && (!isset($this->request->post['name']) || !$this->request->post['name'])) {
			$this->log('Не указано название поля для сохранения');
			return;
		}
		$data = array();
		if (isset($this->request->post['data'])) {
			$data = $this->request->post['data'];
		} else {
			$name = $this->request->post['name'];
			if (!isset($this->request->post['value'])) {
				$this->log('Не указано значение поля для сохранения');
				return;
			}
			$value = $this->request->post['value'];
			$data[$name] = $value;
		}

		foreach ($data as $name => $value) {
			//$this->log("Сохраняем: $name => '$value'");
			if ($name != 'shipping' && $name != 'payment') {
				$this->session->data['guest'][$name] = $value;
			}
			$this->session->data['guest']['shipping'][$name] = $value;
			$this->session->data['guest']['payment'][$name] = $value;
		}
		$this->event->trigger('post.checkout.save');
		//$this->log("Сессия: " . print_r($this->session->data['guest'],true));
	}

	public function uploadFiles($files)
	{
		foreach ($files as $file) {
			copy(DIR_CACHE . $file['name'], DIR_DOWNLOAD . $file['name']);
			unlink(DIR_CACHE . $file['name']);
		}
		return true;
	}

}
