<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerLocalisationNeoSeoAddress extends NeoSeoController
{

	private $error = array();

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

		$this->getList();
	}

	private function getCities()
	{
		// Справочник областей
		$areas = array(
			"CR" => "71508128-9b87-11de-822f-000c2965ae0e", // АРК
			"VI" => "71508129-9b87-11de-822f-000c2965ae0e", // Вінницька
			"VO" => "7150812a-9b87-11de-822f-000c2965ae0e", // Волинська
			"DN" => "7150812b-9b87-11de-822f-000c2965ae0e", // Дніпропетровська
			"DO" => "7150812c-9b87-11de-822f-000c2965ae0e", // Донецька
			"ZH" => "7150812d-9b87-11de-822f-000c2965ae0e", // Житомирська
			"ZK" => "7150812e-9b87-11de-822f-000c2965ae0e", // Закарпатська
			"ZA" => "7150812f-9b87-11de-822f-000c2965ae0e", // Запорізька
			"IV" => "71508130-9b87-11de-822f-000c2965ae0e", // Івано-Франківська
			"KV" => "71508131-9b87-11de-822f-000c2965ae0e", // Київська
			"KY" => "8d5a980d-391c-11dd-90d9-001a92567626", // Київ
			"KR" => "71508132-9b87-11de-822f-000c2965ae0e", // Кіровоградська
			"LU" => "71508133-9b87-11de-822f-000c2965ae0e", // Луганська
			"LV" => "71508134-9b87-11de-822f-000c2965ae0e", // Львівська
			"MY" => "71508135-9b87-11de-822f-000c2965ae0e", // Миколаївська
			"OD" => "71508136-9b87-11de-822f-000c2965ae0e", // Одеська
			"PO" => "71508137-9b87-11de-822f-000c2965ae0e", // Полтавська
			"RI" => "71508138-9b87-11de-822f-000c2965ae0e", // Рівненська
			"SU" => "71508139-9b87-11de-822f-000c2965ae0e", // Сумська
			"TE" => "7150813a-9b87-11de-822f-000c2965ae0e", // Тернопільська
			"KH" => "7150813b-9b87-11de-822f-000c2965ae0e", // Харківська
			"KE" => "7150813c-9b87-11de-822f-000c2965ae0e", // Херсонська
			"KM" => "7150813d-9b87-11de-822f-000c2965ae0e", // Хмельницька
			"CK" => "7150813e-9b87-11de-822f-000c2965ae0e", // Черкаська
			"CV" => "7150813f-9b87-11de-822f-000c2965ae0e", // Чернівецька
			"CH" => "71508140-9b87-11de-822f-000c2965ae0e", // Чернігівська
		);

		$this->load->model('localisation/zone');
		$zones_by_area = array();
		foreach ($this->model_localisation_zone->getZones() as $zone) {
			if (!isset($areas[$zone['code']])) {
				continue;
			}
			$zones_by_area[$areas[$zone['code']]] = $zone['zone_id'];
		}

		// Справочник городов
		$curl = curl_init();
		if (!$curl) {
			return $this->response->redirect($this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$api_key = $this->config->get($this->_moduleSysName . '_api_key');

		$data_string = '
		{
			"modelName": "Address", 
			"calledMethod": "getCities",
			"apiKey": "' . $api_key . '"
		}';
		$url = 'https://api.novaposhta.ua/v2.0/json/AddressGeneral/getWarehouses';
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_HTTPHEADER, array(
			'Content-Type: application/json',
			'Content-Length: ' . strlen($data_string)
		));
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
		curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
		$response_raw = curl_exec($curl);
		curl_close($curl);

		$result = array();
		$response = json_decode($response_raw);
		foreach ($response->data as $city) {
			if (isset($zones_by_area[$city->Ref])) {
				// Киев это отдельная область
				$result[$city->Ref] = $zones_by_area[$city->Ref];
				continue;
			}

			if (isset($zones_by_area[$city->Area])) {
				$result[$city->Ref] = $zones_by_area[$city->Area];
				continue;
			}
		}


		return $result;
	}

	public function refresh()
	{
		// Справочник городов
		$cities = $this->getCities();
		if (!$cities) {
			return $this->response->redirect($this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'], 'SSL'));
		}

		// Обновляем адреса согласно новой почте
		$curl = curl_init();
		if (!$curl) {
			return $this->response->redirect($this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$api_key = $this->config->get($this->_moduleSysName . '_api_key');

		$data_string = '
		{
			"modelName": "AddressGeneral", 
			"calledMethod": "getWarehouses", 
			"apiKey": "' . $api_key . '"
		}';
		$url = 'https://api.novaposhta.ua/v2.0/json/AddressGeneral/getWarehouses';
		curl_setopt($curl, CURLOPT_URL, $url);
		curl_setopt($curl, CURLOPT_HTTPHEADER, array(
			'Content-Type: application/json',
			'Content-Length: ' . strlen($data_string)
		));
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "POST");
		curl_setopt($curl, CURLOPT_POSTFIELDS, $data_string);
		$response_raw = curl_exec($curl);
		curl_close($curl);

		if (!$response_raw) {
			return $this->response->redirect($this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'], 'SSL'));
		}
		$shipping_methods = $this->config->get('neoseo_checkout_shipping_novaposhta');
		if (!is_array($shipping_methods)) {
			$shipping_methods = array($shipping_methods);
		}

		// Интеллектуальный детект языков
		$russian_language_id = 2;
		$ukrainian_language_id = 3;
		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();
		foreach ($languages as $language) {
			if ($language['code'] == "ru") {
				$russian_language_id = $language['language_id'];
			} else if ($language['code'] == "ua" || $language['code'] == "uk") {
				$ukrainian_language_id = $language['language_id'];
			}
		}

		$this->load->model('localisation/neoseo_address');
		foreach ($shipping_methods as $shipping_method) {


			$this->model_localisation_neoseo_address->clearAddresses($shipping_method);
			$response = json_decode($response_raw);
			foreach ($response->data as $address) {
				if ($address->TypeOfWarehouse != "841339c7-591a-42e2-8233-7a0a00f0ed6f" &&
				    $address->TypeOfWarehouse != "9a68df70-0267-42a8-bb5c-37f427e36ee4"
				) {
					continue;
				}
				// "6f8c7162-4b72-4b0a-88e5-906948c6a92f" - "Parcel Shop"
				// "841339c7-591a-42e2-8233-7a0a00f0ed6f" - "Поштове відділення"
				// "95dc212d-479c-4ffb-a8ab-8c1b9073d0bc" - "Поштомат приват банку"
				// "9a68df70-0267-42a8-bb5c-37f427e36ee4" - "Вантажне відділення"
				// "cab18137-df1b-472d-8737-22dd1d18b51d" - "Поштомат InPost"
				// "f9316480-5f2d-425d-bc2c-ac7cd29decf0" - "Поштомат"

				$data = array();
				$data['name'] = htmlspecialchars($address->DescriptionRu);
				$zone_id = 0;
				if (isset($cities[$address->CityRef])) {
					$zone_id = $cities[$address->CityRef];
				}
				$data['zone_id'] = $zone_id;
				$data['cities'] = array(
					$russian_language_id => htmlspecialchars(trim(preg_replace('/([\(][\s.\W]*[\)]?)/', '', $address->CityDescriptionRu))),
					$ukrainian_language_id => htmlspecialchars(trim(preg_replace('/([\(][\s.\W]*[\)]?)/', '', $address->CityDescription))),
				);
				$data['shipping_method'] = $shipping_method;
				$data['names'] = array(
					$russian_language_id => htmlspecialchars($address->DescriptionRu),
					$ukrainian_language_id => htmlspecialchars($address->Description),
				);

				$this->model_localisation_neoseo_address->addAddress($data);
			}
		}
		return $this->response->redirect($this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function add()
	{
		$this->load->language('localisation/neoseo_address');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/neoseo_address');

		$this->load->model('localisation/language');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_neoseo_address->addAddress($this->request->post);

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

			$this->response->redirect($this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit()
	{
		$this->load->language('localisation/neoseo_address');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/neoseo_address');

		$this->load->model('localisation/language');


		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_neoseo_address->editAddress($this->request->get['address_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete()
	{
		$this->load->language('localisation/neoseo_address');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/neoseo_address');

		$this->load->model('localisation/language');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $address_id) {
				$this->model_localisation_neoseo_address->deleteAddress($address_id);
			}

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

			$this->response->redirect($this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		} elseif ($this->validateDelete() && isset($this->request->get['delete_all']) && $this->request->get['delete_all'] == 1) {
			$this->model_localisation_neoseo_address->deleteAllAddresses();
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

			$this->response->redirect($this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList()
	{
		$this->load->language('localisation/neoseo_address');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/neoseo_address');

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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('localisation/neoseo_address/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('localisation/neoseo_address/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete_all'] = $this->url->link('localisation/neoseo_address/delete', 'token=' . $this->session->data['token'] . '&delete_all=1' . $url, 'SSL');
		$data['refresh'] = $this->url->link('localisation/neoseo_address/refresh', 'token=' . $this->session->data['token'] . $url, 'SSL');


		$data['countries'] = array();

		$filter_data = array(
			'sort' => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		if (isset($this->request->get['filter']) && is_array($this->request->get['filter'])) {
			$filter_data['filter'] = $this->request->get['filter'];
			$data['filter'] = $filter_data['filter'];
		}

		$address_total = $this->model_localisation_neoseo_address->getTotalAddresses($filter_data);

		$results = $this->model_localisation_neoseo_address->getAddresses($filter_data);

		$data['addresses'] = '';

		foreach ($results as $result) {

			$data['addresses'][] = array(
				'address_id' => $result['address_id'],
				'zone_id' => $result['zone_id'],
				'zone' => $result['zone'],
				'name' => $result['name'],
				'city' => $result['city'],
				'shipping_method' => $result['shipping_method'],
				'edit' => $this->url->link('localisation/neoseo_address/edit', 'token=' . $this->session->data['token'] . '&address_id=' . $result['address_id'] . $url, 'SSL')
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');
		$data['text_confirm_all'] = $this->language->get('text_confirm_all');

		$data['column_name'] = $this->language->get('column_name');
		$data['column_zone'] = $this->language->get('column_zone');
		$data['column_city'] = $this->language->get('column_city');
		$data['column_shipping_method'] = $this->language->get('column_shipping_method');
		$data['column_action'] = $this->language->get('column_action');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_zone'] = $this->language->get('entry_zone');
		$data['entry_city'] = $this->language->get('entry_city');
		$data['entry_shipping_method'] = $this->language->get('entry_shipping_method');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_delete_all'] = $this->language->get('button_delete_all');
		$data['button_refresh'] = $this->language->get('button_refresh');
		$data['button_filter'] = $this->language->get('button_filter');

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
			$data['selected'] = (array) $this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['filter']) && is_array($this->request->get['filter'])) {
			foreach ($this->request->get['filter'] as $k => $v)
				$url .= '&filter[' . $k . ']=' . urlencode(html_entity_decode($v, ENT_QUOTES, 'UTF-8'));
		}

		$data['sort_name'] = $this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$data['sort_zone'] = $this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . '&sort=zone' . $url, 'SSL');
		$data['sort_city'] = $this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . '&sort=city' . $url, 'SSL');
		$data['sort_shipping_method'] = $this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . '&sort=shipping_method' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['filter']) && is_array($this->request->get['filter'])) {
			foreach ($this->request->get['filter'] as $k => $v)
				$url .= '&filter[' . $k . ']=' . urlencode(html_entity_decode($v, ENT_QUOTES, 'UTF-8'));
		}

		// Shipping Methods
		$config_language_id = $this->config->get('config_language_id');
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
			}

			if ($extension == "neoseo_shippingplus") {
				$this->load->model("tool/neoseo_shippingplus");
				$methods = $this->model_tool_neoseo_shippingplus->getShippings();
				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'neoseo_shippingplus.neoseo_shippingplus' . $id,
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

		$pagination = new Pagination();
		$pagination->total = $address_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($address_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($address_total - $this->config->get('config_limit_admin'))) ? $address_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $address_total, ceil($address_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$data['token'] = $this->session->data['token'];
		$this->response->setOutput($this->load->view('localisation/neoseo_address_list.tpl', $data));
	}

	protected function getForm()
	{
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['country_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_language_id'] = $this->language->get('entry_language_id');
		$data['entry_zone'] = $this->language->get('entry_zone');
		$data['entry_city'] = $this->language->get('entry_city');
		$data['entry_postcode_required'] = $this->language->get('entry_postcode_required');
		$data['entry_shipping_method'] = $this->language->get('entry_shipping_method');

		$data['column_language_id'] = $this->language->get('column_language_id');
		$data['languages'] = $this->model_localisation_language->getLanguages();

//todo
		$data['help_address_format'] = $this->language->get('help_address_format');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');


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

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['address_id'])) {
			$data['action'] = $this->url->link('localisation/neoseo_address/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('localisation/neoseo_address/edit', 'token=' . $this->session->data['token'] . '&address_id=' . $this->request->get['address_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['address_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$address_info = $this->model_localisation_neoseo_address->getAddress($this->request->get['address_id']);
		}

		if (isset($this->request->post['address_id'])) {
			$data['address_id'] = $this->request->post['address_id'];
		} elseif (!empty($address_info)) {
			$data['address_id'] = $address_info['address_id'];
		} else {
			$data['address_id'] = '';
		}

		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (!empty($address_info)) {
			$data['name'] = $address_info['name'];
		} else {
			$data['name'] = '';
		}

		if (isset($this->request->post['zone_id'])) {
			$data['zone_id'] = $this->request->post['zone_id'];
		} elseif (!empty($address_info)) {
			$data['zone_id'] = $address_info['zone_id'];
		} else {
			$data['zone_id'] = '';
		}

		if (isset($this->request->post['zone'])) {
			$data['zone'] = $this->request->post['zone'];
		} elseif (!empty($address_info)) {
			$data['zone'] = $address_info['zone'];
		} else {
			$data['zone'] = '';
		}

		if (isset($this->request->post['city'])) {
			$data['cities'] = $this->request->post['city'];
		} elseif (!empty($address_info)) {
			$data['cities'] = array();
			$descriptions = $this->model_localisation_neoseo_address->getAddressDescriptions($this->request->get['address_id']);
			foreach ($descriptions as $description) {
				$data['cities'][$description['language_id']] = $description['city'];
			}
		} else {
			$data['cities'] = array();
			foreach ($data['languages'] as $language) {
				$data['cities'][$language['language_id']] = '';
			}
		}

		if (isset($this->request->post['shipping_method'])) {
			$data['shipping_method'] = $this->request->post['shipping_method'];
		} elseif (!empty($address_info)) {
			$data['shipping_method'] = $address_info['shipping_method'];
		} else {
			$data['shipping_method'] = '';
		}

// Localisation
		if (isset($this->request->post['names'])) {
			$data['names'] = $this->request->post['names'];
		} elseif (!empty($address_info)) {
			$data['names'] = array();
			$descriptions = $this->model_localisation_neoseo_address->getAddressDescriptions($this->request->get['address_id']);
			foreach ($descriptions as $description) {
				$data['names'][$description['language_id']] = $description['name'];
			}
		} else {
			$data['names'] = array();
			foreach ($data['languages'] as $language) {
				$data['names'][$language['language_id']] = '';
			}
		}


// Shipping Methods
		$config_language_id = $this->config->get('config_language_id');
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
			}


			if ($extension == "neoseo_shippingplus") {
				$this->load->model("tool/neoseo_shippingplus");
				$methods = $this->model_tool_neoseo_shippingplus->getShippings();
				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'neoseo_shippingplus.neoseo_shippingplus' . $id,
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

		$data['shipping_methods'] = array();
		foreach ($method_data as $item) {
			$data['shipping_methods'][$item['code']] = $item['name'];
		}


		$this->load->model('localisation/zone');
		$zones = $this->model_localisation_zone->getZones();
		$data['zones'] = array();
		foreach ($zones as $zone) {
			$data['zones'][$zone['zone_id']] = $zone['name'];
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('localisation/neoseo_address_form.tpl', $data));
	}

	protected function validateForm()
	{
		if (!$this->user->hasPermission('modify', 'localisation/neoseo_address')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 128)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		return !$this->error;
	}

	protected function validateDelete()
	{
		if (!$this->user->hasPermission('modify', 'localisation/neoseo_address')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	//todo
	public function address()
	{
		$json = array();

		$this->load->model('localisation/neoseo_address');

		$address_info = $this->model_localisation_neoseo_address->getAddress($this->request->get['address_id']);

		if ($address_info) {
			$this->load->model('localisation/zone');

			$json = array(
				'country_id' => $address_info['country_id'],
				'name' => $address_info['name'],
				'iso_code_2' => $address_info['iso_code_2'],
				'iso_code_3' => $address_info['iso_code_3'],
				'address_format' => $address_info['address_format'],
				'postcode_required' => $address_info['postcode_required'],
				'zone' => $this->model_localisation_zone->getZonesByCountryId($this->request->get['country_id']),
				'status' => $address_info['status']
			);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

}
