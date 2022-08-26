<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerLocalisationNeoSeoCity extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleName = "";
		$this->_moduleSysName = "neoseo_checkout";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;
	}

	private $error = array();

	public function index()
	{
		$this->load->language('localisation/neoseo_city');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/neoseo_city');

		$this->getList();
	}

	public function getCities($page = 1)
	{
		$curl = curl_init();
		if (!$curl) {
			$this->log('не удалось инициализировать curl');
			return $this->response->redirect($this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data_string = '
		{
			"modelName": "Address", 
			"calledMethod": "getSettlements",
			"methodProperties": {
				"Page": "' . $page . '"
			},
			"apiKey": "' . $this->config->get($this->_moduleSysName . '_api_key') . '"
		}';

		$url = 'https://api.novaposhta.ua/v2.0/json/AddressGeneral/getSettlements';
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
			return array();
		}

		$response = json_decode($response_raw);
		if( !$response->success) {
			$this->log("Ошибка API новой почты: " . implode(",", $response->errors) );
			return $this->response->redirect($this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'], 'SSL'));
		}

		return $response->data;
	}

	public function refresh()
	{
		// Обновляем адреса согласно новой почте
		$areas = array(
			//"CR" => "71508128-9b87-11de-822f-000c2965ae0e", // АРК
			"VI" => "Винницкая область", // Вінницька
			"VO" => "Волынская область", // Волинська
			"DN" => "Днепропетровская область", // Дніпропетровська
			"DO" => "Донецкая область", // Донецька
			"ZH" => "Житомирская область", // Житомирська
			"ZK" => "Закарпатская область", // Закарпатська
			"ZA" => "Запорожская область", // Запорізька
			"IV" => "Ивано-Франковская область", // Івано-Франківська
			"KV" => "Киевская область", // Київська
			"KY" => "Киев", // Київ
			"KR" => "Кировоградская область", // Кіровоградська
			"LU" => "Луганская область", // Луганська
			"LV" => "Львовская область", // Львівська
			"MY" => "Николаевская область", // Миколаївська
			"OD" => "Одесская область", // Одеська
			"PO" => "Полтавская область", // Полтавська
			"RI" => "Ровенская область", // Рівненська
			"SU" => "Сумская область", // Сумська
			"TE" => "Тернопольская область", // Тернопільська
			"KH" => "Харьковская область", // Харківська
			"KE" => "Херсонская область", // Херсонська
			"KM" => "Хмельницкая область", // Хмельницька
			"CK" => "Черкасская область", // Черкаська
			"CV" => "Черновицкая область", // Чернівецька
			"CH" => "Черниговская область", // Чернігівська
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

		$this->load->model('localisation/neoseo_city');


		$this->model_localisation_neoseo_city->deleteAllCities();
		$page = 1;
		while ($cities = $this->getCities($page)) {
			$page = $page + 1;
			foreach ($cities as $city) {
				$item = array();
				$item['status'] = 1;
				$item['country_id'] = 220;
				if (isset($zones_by_area[$city->AreaDescriptionRu])) {
					$item['zone_id'] = $zones_by_area[$city->AreaDescriptionRu];
				}
				if ($city->DescriptionRu == "Киев") {
					$item['zone_id'] = $zones_by_area['Киев'];
				}

				$item['name'] = array(
					$russian_language_id => htmlspecialchars($city->DescriptionRu),
					$ukrainian_language_id => htmlspecialchars($city->Description),
				);

				$this->model_localisation_neoseo_city->addCity($item);
			}
		}

		return $this->response->redirect($this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function add()
	{
		$this->load->language('localisation/neoseo_city');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/neoseo_city');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_neoseo_city->addCity($this->request->post);

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

			$this->response->redirect($this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit()
	{
		$this->load->language('localisation/neoseo_city');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/neoseo_city');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_neoseo_city->editCity($this->request->get['city_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete()
	{
		$this->load->language('localisation/neoseo_city');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('localisation/neoseo_city');
		//@todo: почистить дублирующийся код ниже
		if (isset($this->request->get['city_id']) && $this->validateDelete()) {
			$this->model_localisation_neoseo_city->deleteCity($this->request->get['city_id']);
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
			$this->response->redirect($this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		} else {
			if (isset($this->request->post['selected']) && $this->validateDelete()) {
				foreach ($this->request->post['selected'] as $city_id) {
					$this->model_localisation_neoseo_city->deleteCity($city_id);
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

				$this->response->redirect($this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
		}

		$this->getList();
	}


	protected function getList()
	{
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = "";
		}

		if (isset($this->request->get['filter_country'])) {
			$filter_country = $this->request->get['filter_country'];
		} else {
			$filter_country = null;
		}


		if (isset($this->request->get['filter_zone'])) {
			$filter_zone = $this->request->get['filter_zone'];
		} else {
			$filter_zone = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'ct.name';
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

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}
		if (isset($this->request->get['filter_country'])) {
			$url .= '&filter_country=' . $this->request->get['filter_country'];
		}
		if (isset($this->request->get['filter_zone'])) {
			$url .= '&filter_zone=' . $this->request->get['filter_zone'];
		}

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
			'href' => $this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('localisation/neoseo_city/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('localisation/neoseo_city/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['refresh'] = $this->url->link('localisation/neoseo_city/refresh', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data['cities'] = array();

		$filter_data = array(
			'filter_name' => $filter_name,
			'filter_country' => $filter_country,
			'filter_zone' => $filter_zone,
			'sort' => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$city_total = $this->model_localisation_neoseo_city->getTotalCities($filter_data);
		$results = $this->model_localisation_neoseo_city->getCities($filter_data);

		foreach ($results as $result) {
			$data['cities'][] = array(
				'city_id' => $result['city_id'],
				'country' => $result['country'],
				'name' => $result['name'],
				'zone' => $result['zone_name'],
				'edit' => $this->url->link('localisation/neoseo_city/edit', 'token=' . $this->session->data['token'] . '&city_id=' . $result['city_id'] . $url, 'SSL'),
				'delete' => $this->url->link('localisation/neoseo_city/delete', 'token=' . $this->session->data['token'] . '&city_id=' . $result['city_id'] . $url, 'SSL'),
			);
		}



		$data['heading_title'] = $this->language->get('heading_title');

		$data['button_refresh'] = $this->language->get('button_refresh');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['entry_name'] = $this->language->get('entry_name');

		$data['column_country'] = $this->language->get('column_country');
		$data['column_name'] = $this->language->get('column_name');
		$data['column_zone'] = $this->language->get('column_zone');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');
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

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}
		if (isset($this->request->get['filter_country'])) {
			$url .= '&filter_country=' . $this->request->get['filter_country'];
		}
		if (isset($this->request->get['filter_zone'])) {
			$url .= '&filter_zone=' . $this->request->get['filter_zone'];
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_country'] = $this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . '&sort=c.name' . $url, 'SSL');
		$data['sort_zone'] = $this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . '&sort=z.name' . $url, 'SSL');
		$data['sort_name'] = $this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . '&sort=cd.name' . $url, 'SSL');

		$url = '';
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}
		if (isset($this->request->get['filter_country'])) {
			$url .= '&filter_country=' . $this->request->get['filter_country'];
		}
		if (isset($this->request->get['filter_zone'])) {
			$url .= '&filter_zone=' . $this->request->get['filter_zone'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $city_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($city_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($city_total - $this->config->get('config_limit_admin'))) ? $city_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $city_total, ceil($city_total / $this->config->get('config_limit_admin')));
		$data['filter_name'] = $filter_name;
		$data['filter_country'] = $filter_country;
		$data['filter_zone'] = $filter_zone;
		$data['sort'] = $sort;
		$data['order'] = $order;
		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/country');
		$this->load->model('localisation/zone');

		$countries = $this->model_localisation_country->getCountries();

		foreach ($countries as $country) {
			$data['countries'][] = array(
				'country_id' => $country['country_id'],
				'name' => $country['name']
			    //   'city_count' => $this->model_localisation_neoseo_city->getTotalCitiesByCountryId($country['country_id'])
			);
		}

		if ($data['filter_country']) {
			$zones = $this->model_localisation_zone->getZonesByCountryId($data['filter_country']);
			foreach ($zones as $zone) {
				$data['zones'][] = array(
					'zone_id' => $zone['zone_id'],
					'name' => $zone['name'],
				    //    'city_count' => $this->model_localisation_neoseo_city->getTotalCitiesByZoneId($zone['zone_id'])
				);
			}
		} else {
			$zones = $this->model_localisation_zone->getZones();
			foreach ($zones as $zone) {
				$data['zones'][] = array(
					'zone_id' => $zone['zone_id'],
					'name' => $zone['name'],
				    // 'city_count' => $this->model_localisation_neoseo_city->getTotalCitiesByZoneId($zone['zone_id'])
				);
			}
		}


		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('localisation/neoseo_city_list.tpl', $data));
	}

	protected function getForm()
	{
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['city_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_zone'] = $this->language->get('entry_zone');
		$data['entry_country'] = $this->language->get('entry_country');

		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

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
			'href' => $this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['city_id'])) {
			$data['action'] = $this->url->link('localisation/neoseo_city/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('localisation/neoseo_city/edit', 'token=' . $this->session->data['token'] . '&city_id=' . $this->request->get['city_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['city_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$city_info = $this->model_localisation_neoseo_city->getCity($this->request->get['city_id']);
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($city_info)) {
			$data['status'] = $city_info['status'];
		} else {
			$data['status'] = '1';
		}

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('localisation/neoseo_city');
		if (isset($this->request->post['name'])) {
			$data['name'] = $this->request->post['name'];
		} elseif (isset($this->request->get['city_id'])) {
			$data['name'] = $this->model_localisation_neoseo_city->getCityDescriptions($this->request->get['city_id']);
		} else {
			$data['name'] = array();
		}

		if (isset($this->request->post['zone_id'])) {
			$data['zone_id'] = $this->request->post['zone_id'];
		} elseif (!empty($city_info)) {
			$data['zone_id'] = $city_info['zone_id'];
		} else {
			$data['zone_id'] = '';
		}

		if (isset($this->request->post['country_id'])) {
			$data['country_id'] = $this->request->post['country_id'];
		} elseif (!empty($city_info)) {
			$data['country_id'] = $city_info['country_id'];
		} else {
			$data['country_id'] = '';
		}

		$this->load->model('localisation/country');
		$this->load->model('localisation/zone');
		$data['countries'] = $this->model_localisation_country->getCountries();
		if ($data['country_id']) {
			$data['zones'] = $this->model_localisation_zone->getZonesByCountryId($data['country_id']);
		} else {
			$data['zones'] = $this->model_localisation_zone->getZones();
		}
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('localisation/neoseo_city_form.tpl', $data));
	}

	public function reloadZones()
	{
		$this->load->model('localisation/zone');
		$this->load->model('localisation/neoseo_city');
		if (isset($this->request->post['country_id'])) {
			$data['country_id'] = $this->request->post['country_id'];
		} elseif (!empty($city_info)) {
			$data['country_id'] = $city_info['country_id'];
		} else {
			$data['country_id'] = '';
		}
		if (isset($this->request->post['zone_id'])) {
			$data['zone_id'] = $this->request->post['zone_id'];
		} elseif (!empty($city_info)) {
			$data['zone_id'] = $city_info['zone_id'];
		} else {
			$data['zone_id'] = '';
		}

		/* if (isset($this->request->post['fromlist'])) {
		  $data['fromlist'] = true;
		  } else { */
		$data['fromlist'] = false;
		//}

		if ($data['country_id']) {
			$zones = $this->model_localisation_zone->getZonesByCountryId($data['country_id']);
			foreach ($zones as $zone) {
				$data['zones'][] = array(
					'zone_id' => $zone['zone_id'],
					'name' => $zone['name'],
				    //'city_count' => $this->model_localisation_neoseo_city->getTotalCitiesByZoneId($zone['zone_id']) // Если отключить подсчет, то будет отображать все регионы, а не те в которых есть города
				);
			}
		} else {
			$zones = $this->model_localisation_zone->getZones();
			foreach ($zones as $zone) {
				$data['zones'][] = array(
					'zone_id' => $zone['zone_id'],
					'name' => $zone['name'],
				    //      'city_count' => $this->model_localisation_neoseo_city->getTotalCitiesByZoneId($zone['zone_id']) // Если отключить подсчет, то будет отображать все регионы, а не те в которых есть города
				);
			}
		}




		$this->response->setOutput($this->load->view('localisation/neoseo_city_zones.tpl', $data));
	}

	protected function validateForm()
	{
		if (!$this->user->hasPermission('modify', 'localisation/neoseo_city')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['name'] as $language_id => $name) {
			if ((utf8_strlen($name) < 2) || (utf8_strlen($name) > 64)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}

		return !$this->error;
	}

	protected function validateDelete()
	{
		if (!$this->user->hasPermission('modify', 'localisation/neoseo_city')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		// @todo:в зависимости от того к чему будут относится адреса нужно добавить проверки на привязки к магазину, адресам и т.п.
		return !$this->error;
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
}
