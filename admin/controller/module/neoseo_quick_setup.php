<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoQuickSetup extends NeoSeoController
{

	private $error = array();
	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_quick_setup";
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();
		$this->load->model('tool/'.$this->_moduleSysName());

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$post_data[$this->_moduleSysName().'_status'] = 1;
			$post_data[$this->_moduleSysName().'_debug'] = 0;
			$post_data[$this->_moduleSysName().'_complete2'] = $this->config->get($this->_moduleSysName().'_complete2');
			$post_data[$this->_moduleSysName().'_complete3'] = $this->config->get($this->_moduleSysName().'_complete3');
			$post_data[$this->_moduleSysName().'_complete4'] = $this->config->get($this->_moduleSysName().'_complete4');
			$post_data[$this->_moduleSysName().'_complete'] = $this->config->get($this->_moduleSysName().'_complete');


			if(isset($this->request->post['master1'])){
				if($this->request->post['action'] == "complete"){
					$post_data[$this->_moduleSysName().'_complete'] = 1;
				}
				$this->{'model_tool_'.$this->_moduleSysName()}->saveVars($this->request->post);
				if(!isset($this->request->get['quick_save'])){
					$this->{'model_tool_'.$this->_moduleSysName()}->saveUnistor();
				}
			}

			if(isset($this->request->post['master2'])){
				//echo "<pre>";print_r($this->request->post);exit;
				if($this->request->post['action'] == "complete"){
					$post_data[$this->_moduleSysName().'_complete2'] = 1;
				}
			}

			if(isset($this->request->post['master3'])){
				if($this->request->post['action'] == "complete"){
					if(isset($this->request->post['links'])){
						$this->{'model_tool_'.$this->_moduleSysName()}->setParam('neoseo_checkout_payment_for_shipping',$this->request->post['links']);
					}
					$post_data[$this->_moduleSysName().'_complete3'] = 1;
				}
			}

			if(isset($this->request->post['master4'])){
				$this->{'model_tool_'.$this->_moduleSysName()}->saveVars($this->request->post);
				if($this->request->post['action'] == "complete"){
					$post_data[$this->_moduleSysName().'_complete4'] = 1;
					$this->session->data['completem4'] = true;
				}
			}
			//echo "<pre>";print_r($post_data);exit;
			$this->model_setting_setting->editSetting($this->_moduleSysName(), $post_data);

			if($this->config->get('config_license_to') !== ''){
				$now = new DateTime(); // текущее время на сервере
				$date = DateTime::createFromFormat("Y-m-d", $this->config->get('config_license_to'));
				$interval = $now->diff($date); // получаем разницу в виде объекта DateInterval
				if(!$interval->invert){
					$this->{'model_tool_'.$this->_moduleSysName()}->setParam('config_maintenance',0);
				}
			}

			//$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'], 'SSL'));
			} else if($this->request->post['action'] == "close" || $this->request->post['action'] == "complete") {
				$this->response->redirect($this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}
		if(isset($this->request->get['slider'] )){
			$useSlider = true;
		} else {
			$useSlider = false;
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
			array($this->_route . '/' . $this->_moduleSysName(), "heading_title_raw")
			), $data);


		$data = $this->initButtons($data);

		if(isset($this->request->get['store_id'])){
			$store_id = $this->request->get['store_id'];
		} else {
			$store_id = 0;
		}
		$multistore_options = $this->{'model_module_'.$this->_moduleSysName()}->getMultistoreOptions();
		$this->load->model($this->_route . "/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params, $data);
		$data['params_arr'] = $this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params;
		foreach ($data['params_arr'] as $a_name => $attr){
			if(in_array($a_name,array('status','debug'))) continue;
			//echo "$a_name <hr>".print_r($this->{'model_tool_'.$this->_moduleSysName()}->getParam($a_name),true)."<hr>";
			$data[$this->_moduleSysName.'_'.$a_name] = $this->{'model_tool_'.$this->_moduleSysName()}->getParam($a_name);
			if(in_array($a_name, $multistore_options )){
				$data[$this->_moduleSysName.'_'.$a_name] = $data[$this->_moduleSysName.'_'.$a_name][$store_id];
			}
		}

		$config_langdata_db = $this->{'model_tool_'.$this->_moduleSysName()}->getParam('config_langdata');
		foreach ($config_langdata_db as $l => $l_data){
			foreach ($l_data as $p_name => $p_val){
				$data[$this->_moduleSysName().'_config_'.$p_name][$l] = $p_val;
			}
		}
		//echo "<pre>";print_r($data[$this->_moduleSysName."_".'config_meta_title']);exit;
		//echo "<pre>";print_r($data);exit;

		$data["token"] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
		$languages = $data['languages'] ;
		// Языки и валюты для 0 шага
		$data[$this->_moduleSysName()."_need_languages"] = array();
		$data[$this->_moduleSysName()."_need_currencies"] = array();

		$this->language->load('module/neoseo_unistor');
		$data['schemes'] = array (
			'default' => $this->language->get('text_default'),
			'yellow' => $this->language->get('text_scheme_1'),
			'red' => $this->language->get('text_scheme_2'),
			'orange' => $this->language->get('text_scheme_3'),
			'green' => $this->language->get('text_scheme_4'),
			'purple' => $this->language->get('text_scheme_5'),
			'indigo' => $this->language->get('text_scheme_6'),
			'blue' => $this->language->get('text_scheme_7'),
			'black' => $this->language->get('text_scheme_8'),
		);

		$data['maps'] = array(
			'none' => $this->language->get('text_disabled'),
			'google' => $this->language->get('text_google'),
			'yandex' => $this->language->get('text_yandex'),
		);

		$data['menu_types'] = array (
			'menu_horizontal'           => $this->language->get('text_horizontal'),
			'menu_vertical'             => $this->language->get('text_vertical'),
			'menu_hybrid'               => $this->language->get('text_hybrid'),
		);

		$this->load->model('tool/image');
		foreach ($languages as $language) {
			$data['languages_c'][$language['code']] = $language['name'];
			$data[$this->_moduleSysName()."_need_languages"][] = $language['code'];
			if (file_exists(DIR_IMAGE . $data[$this->_moduleSysName . '_neoseo_unistor_logo'][$language['language_id']]) && is_file(DIR_IMAGE . $data[$this->_moduleSysName . '_neoseo_unistor_logo'][$language['language_id']])) {
				$data[$this->_moduleSysName . '_neoseo_unistor_logo_img'][$language['language_id']] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_neoseo_unistor_logo'][$language['language_id']], 100, 100);
			} else {
				$data[$this->_moduleSysName . '_neoseo_unistor_logo_img'][$language['language_id']] = $this->model_tool_image->resize('no_image.png', 100, 100);
			}
		}

		if (file_exists(DIR_IMAGE . $data[$this->_moduleSysName . '_config_icon']) && is_file(DIR_IMAGE . $data[$this->_moduleSysName . '_config_icon'])) {
			$data[$this->_moduleSysName . '_config_icon_img'] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_config_icon'], 100, 100);
		} else {
			$data[$this->_moduleSysName . '_config_icon_img'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		// Slides
		$slides = $this->{'model_tool_'.$this->_moduleSysName()}->getSlides();
		$data['big_slides'] = array();//$slides['big_banners'];
		$data['small_slides'] = array();//$slides['small_banners'];
		foreach ($slides['big_banners'] as $bid){
			$bi = array_shift($bid['banner_image_description']);

			if (file_exists(DIR_IMAGE .  $bi['image']) && is_file(DIR_IMAGE .  $bi['image'])) {
				$th = $this->model_tool_image->resize( $bi['image'], 150, 100);
			} else {
				$th = $this->model_tool_image->resize('no_image.png', 100, 100);
			}
			$data['big_slides'][] = array(
				'image' =>  $bi['image'],
				'thumb' => $th,
			);
		}

		foreach ($slides['small_banners'] as $bid){
			$bi = array_shift($bid['banner_image_description']);
			if (file_exists(DIR_IMAGE .  $bi['image']) && is_file(DIR_IMAGE .  $bi['image'])) {
				$th = $this->model_tool_image->resize( $bi['image'], 150, 100);
			} else {
				$th = $this->model_tool_image->resize('no_image.png', 100, 100);
			}
			$data['small_slides'][] = array(
				'image' =>  $bi['image'],
				'thumb' => $th,
			);
		}
		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		$data['no_image'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		//echo "<pre>";print_r($data[$this->_moduleSysName().'_big_slides']);exit;
		$this->load->model('localisation/currency');
		foreach ($this->model_localisation_currency->getCurrencies() as $c){
			$data['currencies'][$c['code']] = $c['title'];
			$data[$this->_moduleSysName()."_need_currencies"][] = $c['code'];
		}
		$data['ml_update_link'] = html_entity_decode($this->url->link($this->_route . '/' . $this->_moduleSysName().'/updateMl', 'token=' . $this->session->data['token'], 'SSL'));

		$this->load->model('localisation/country');
		$data['countries'] = array(0 => $this->language->get('text_select'));
		$countries = $this->model_localisation_country->getCountries();
		foreach ($countries as $country) {
			$data['countries'][$country['country_id']] = $country['name'];
		}
		$this->load->model('localisation/zone');
		$data['zones'] = array(0 => $this->language->get('text_select'));
		foreach ($this->model_localisation_zone->getZones() as $zone) {
			$data['zones'][$zone['zone_id']] = $zone['name'];
		}

		$data['general_styles'] = array( 0 => $this->language->get('text_style_flat'), 1 => $this->language->get('text_style_3d'));

		$data['ckeditor'] = $this->config->get('config_editor_default');
		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init_qs.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init_qs.js');
		}
		//echo "<pre>";print_r($data);exit;
		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['master_status'] = $this->{'model_tool_'.$this->_moduleSysName()}->getMasterStatus();
		$data['master_links'] = $this->{'model_tool_'.$this->_moduleSysName()}->getMastersLinks();
		//echo "<pre>";print_r($data['master_status']);exit;
		$data['start_page'] = 0;
		if(isset($this->session->data['MlUpdated']) && $this->session->data['MlUpdated'] === true ){
			$data['start_page'] = 1;
			$this->session->data['MlUpdated'] = false;
		}

		$this->document->addScript('view/javascript/tooltipster/tooltipster.bundle.min.js');
		$this->document->addStyle('view/stylesheet/tooltipster/tooltipster.bundle.min.css');

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$data['neoseo_m1_title'] = $this->language->get('heading_title_topmenu');
		$data['neoseo_m1_link'] = $this->url->link('module/neoseo_quick_setup', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m2_title'] = $this->language->get('neoseo_m2_title');
		$data['neoseo_m2_link'] = $this->url->link('module/neoseo_quick_setup/master2', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m3_title'] = $this->language->get('neoseo_m3_title');
		$data['neoseo_m3_link'] = $this->url->link('module/neoseo_quick_setup/master3', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m4_title'] = $this->language->get('neoseo_m4_title');
		$data['neoseo_m4_link'] = $this->url->link('module/neoseo_quick_setup/master4', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() .($useSlider?'_slider':''). '.tpl', $data));
	}

	public function master2()
	{
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());
		$this->document->setTitle($this->language->get('heading_title_raw'));
		$data['link_1c'] = HTTPS_CATALOG.'export/exchange1c.php';
		$data['username_1c'] = $this->config->get('neoseo_exchange1c_username');
		$data['password_1c'] = $this->config->get('neoseo_exchange1c_password');
		$data['settings_link_1c'] = $this->url->link('module/neoseo_exchange1c', 'token=' . $this->session->data['token'], 'SSL');

		$data['settings_link_yml'] = $this->url->link('module/neoseo_import_yml', 'token=' . $this->session->data['token'] , 'SSL');

		$this->load->model('tool/'.$this->_moduleSysName());
		$data['master_status'] = $this->{'model_tool_'.$this->_moduleSysName()}->getMasterStatus();
		$data['master_links'] = $this->{'model_tool_'.$this->_moduleSysName()}->getMastersLinks();

		$data['import_excel_tpl'] = html_entity_decode($this->url->link('module/neoseo_simple_excel_exchange/export2Excel', 'token=' . $this->session->data['token'], 'SSL'));
		$data['import_excel_import_link'] = html_entity_decode($this->url->link('module/neoseo_simple_excel_exchange', 'token=' . $this->session->data['token']."&by_iframe=1", 'SSL'));

		$data['manual_category_link'] =  $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL');
		$data['manual_products_link'] =  $this->url->link('catalog/product', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel_link'] = html_entity_decode($this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'));

		$data['demo_delete_demo_link'] = html_entity_decode($this->url->link('module/neoseo_unistor/deleteDemoData', 'token=' . $this->session->data['token'] , 'SSL'));

		$data['save'] = html_entity_decode($this->url->link('module/'.$this->_moduleSysName(), 'token=' . $this->session->data['token'] , 'SSL'));

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$data['neoseo_m1_title'] = $this->language->get('heading_title_topmenu');
		$data['neoseo_m1_link'] = $this->url->link('module/neoseo_quick_setup', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m2_title'] = $this->language->get('neoseo_m2_title');
		$data['neoseo_m2_link'] = $this->url->link('module/neoseo_quick_setup/master2', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m3_title'] = $this->language->get('neoseo_m3_title');
		$data['neoseo_m3_link'] = $this->url->link('module/neoseo_quick_setup/master3', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m4_title'] = $this->language->get('neoseo_m4_title');
		$data['neoseo_m4_link'] = $this->url->link('module/neoseo_quick_setup/master4', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		/* Адаптация под модель А */
		$data['neoseo_exchange1c_status'] = ($this->config->get('neoseo_exchange1c_status') != '')?1:0;
		$data['neoseo_simple_excel_exchange_status'] = (file_exists(DIR_APPLICATION."controller/module/neoseo_simple_excel_exchange.php"))?1:0;
		$data['neoseo_import_yml_status'] = ($this->config->get('neoseo_import_yml_status') != '')?1:0;


		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() ."_master2". '.tpl', $data));

	}

	public function master3()
	{
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());
		$this->document->setTitle($this->language->get('heading_title_raw'));
		$data['shippings'] = $this->getShippings();
		$data['payments'] = $this->getPayments();
		$data['save'] = html_entity_decode($this->url->link('module/'.$this->_moduleSysName(), 'token=' . $this->session->data['token'] , 'SSL'));

        $this->document->addScript('view/javascript/tooltipster/tooltipster.bundle.min.js');
        $this->document->addStyle('view/stylesheet/tooltipster/tooltipster.bundle.min.css');

		$this->load->model('tool/'.$this->_moduleSysName());
		$data['master_status'] = $this->{'model_tool_'.$this->_moduleSysName()}->getMasterStatus();
		$data['master_links'] = $this->{'model_tool_'.$this->_moduleSysName()}->getMastersLinks();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$data['neoseo_m1_title'] = $this->language->get('heading_title_topmenu');
		$data['neoseo_m1_link'] = $this->url->link('module/neoseo_quick_setup', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m2_title'] = $this->language->get('neoseo_m2_title');
		$data['neoseo_m2_link'] = $this->url->link('module/neoseo_quick_setup/master2', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m3_title'] = $this->language->get('neoseo_m3_title');
		$data['neoseo_m3_link'] = $this->url->link('module/neoseo_quick_setup/master3', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m4_title'] = $this->language->get('neoseo_m4_title');
		$data['neoseo_m4_link'] = $this->url->link('module/neoseo_quick_setup/master4', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');
		$data["token"] = $this->session->data['token'];
		$data['payment_shipping_links'] = $this->getPaymentForShipping();

		$data['text_links_shipping_with_payment_desc2'] = sprintf($data['text_links_shipping_with_payment_desc2'],$this->url->link('module/neoseo_checkout', 'token=' . $this->session->data['token'] . '&by_iframe=1&active_tab=links', 'SSL'));
		$data['cancel_link'] = html_entity_decode($this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'));

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() ."_master3". '.tpl', $data));

	}

	public function master3Links()
	{
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());
		$data['payment_shipping_links'] = $this->getPaymentForShipping();
		$data["token"] = $this->session->data['token'];

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() ."_master3_links". '.tpl', $data));

	}

	public function master4()
	{
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());
		$this->document->setTitle($this->language->get('heading_title_raw'));
		$this->load->model('module/'.$this->_moduleSysName());
		$this->load->model('tool/'.$this->_moduleSysName());
		if(isset($this->request->get['store_id'])){
			$store_id = $this->request->get['store_id'];
		} else {
			$store_id = 0;
		}
		$data['save'] = html_entity_decode($this->url->link('module/'.$this->_moduleSysName(), 'token=' . $this->session->data['token'] , 'SSL'));

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

        $this->document->addScript('view/javascript/tooltipster/tooltipster.bundle.min.js');
        $this->document->addStyle('view/stylesheet/tooltipster/tooltipster.bundle.min.css');

		$multistore_options = $this->{'model_module_'.$this->_moduleSysName()}->getMultistoreOptions();
		$data['master_status'] = $this->{'model_tool_'.$this->_moduleSysName()}->getMasterStatus();
		$data['master_links'] = $this->{'model_tool_'.$this->_moduleSysName()}->getMastersLinks();
		$data['cancel_link'] = html_entity_decode($this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'));

		$this->load->model($this->_route . "/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params, $data);
		$data['params_arr'] = $this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params;
		foreach ($data['params_arr'] as $a_name => $attr){
			if(in_array($a_name,array('status','debug'))) continue;
			//echo "$a_name <hr>".print_r($this->{'model_tool_'.$this->_moduleSysName()}->getParam($a_name),true)."<hr>";
			$data[$this->_moduleSysName.'_'.$a_name] = $this->{'model_tool_'.$this->_moduleSysName()}->getParam($a_name);
			if(in_array($a_name, $multistore_options )){
				$data[$this->_moduleSysName.'_'.$a_name] = $data[$this->_moduleSysName.'_'.$a_name][$store_id];
			}
		}
		$config_langdata_db = $this->{'model_tool_'.$this->_moduleSysName()}->getParam('config_langdata');
		foreach ($config_langdata_db as $l => $l_data){
			foreach ($l_data as $p_name => $p_val){
				$data[$this->_moduleSysName().'_config_'.$p_name][$l] = $p_val;
			}
		}
		//echo "<pre>";print_r($data);exit;
		$data['ckeditor'] = $this->config->get('config_editor_default');
		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init_qs.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init_qs.js');
		}

		$data['seogen_iframe'] = html_entity_decode($this->url->link('module/neoseo_seogen', 'token=' . $this->session->data['token'].'&by_iframe=1' , 'SSL'));

		$data['token'] = $this->session->data['token'];
		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$data['neoseo_m1_title'] = $this->language->get('heading_title_topmenu');
		$data['neoseo_m1_link'] = $this->url->link('module/neoseo_quick_setup', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m2_title'] = $this->language->get('neoseo_m2_title');
		$data['neoseo_m2_link'] = $this->url->link('module/neoseo_quick_setup/master2', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m3_title'] = $this->language->get('neoseo_m3_title');
		$data['neoseo_m3_link'] = $this->url->link('module/neoseo_quick_setup/master3', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['neoseo_m4_title'] = $this->language->get('neoseo_m4_title');
		$data['neoseo_m4_link'] = $this->url->link('module/neoseo_quick_setup/master4', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

		$data['sitemap_url_text'] = sprintf($data['text_sitemap_was_gen'],HTTPS_CATALOG."sitemap.xml");

		/* екаем открыт ли роботс или нет */
		$robots_file = rtrim(realpath(DIR_LOCAL_APP . "/../"), '/') . "/robots.txt";
		$data['robots_state'] = 1;
		if (filesize($robots_file) < 200) {
			$data['robots_state'] = 0;
		}

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() ."_master4". '.tpl', $data));

	}

	private function getShippings()
	{
		// Shipping Methods
		$this->load->model('extension/extension');
		$extensions = $this->model_extension_extension->getInstalled('shipping');
		$files = glob(DIR_APPLICATION . 'controller/shipping/*.php');
		//print_r( $files);exit;
		$method_data = array();
		foreach ($files as $file) {
			$extension = basename($file, '.php');
			if (!$this->user->hasPermission('modify', 'shipping/'.$extension ) || !in_array($extension,$extensions)) {
				continue;
			}
			$method_data[$extension] = array(
				'status' => $this->config->get($extension."_status"),
				'link' => $this->url->link('shipping/'.$extension, 'token=' . $this->session->data['token'].'&by_iframe=1', 'SSL'),
			);
		}

		return $method_data;
	}

	private function getPayments()
	{
		// Payment Methods
		$this->load->model('extension/extension');
		$extensions = $this->model_extension_extension->getInstalled('payment');
		$files = glob(DIR_APPLICATION . 'controller/payment/*.php');
		$method_data = array();
		foreach ($files as $file) {
			$extension = basename($file, '.php');
			if (!$this->user->hasPermission('modify', 'payment/'.$extension ) || !in_array($extension,$extensions)) {
				continue;
			}
			$method_data[$extension] = array(
				'status' => $this->config->get($extension."_status"),
				'link' => $this->url->link('payment/'.$extension, 'token=' . $this->session->data['token'].'&by_iframe=1', 'SSL'),
			);
		}
		return $method_data;
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

	public function updateMl()
	{
		$this->session->data['MlUpdated'] = true;
		$data = $this->request->post;
		//echo "<pre>";print_r($data);exit;
		$this->load->model('tool/'.$this->_moduleSysName());
		$this->{'model_tool_'.$this->_moduleSysName()}->clearNeedlessData($data);
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode(array('msg' => 'ok')));
	}

	private function getPaymentForShipping()
	{
		$this->load->model('extension/extension');
		// Почему появился этот метод и зачем делать дубликаты? Потому что надо правильно писать ТЗ сразу!!!!!
		// TODO: Избавиться от дублирующих методов выще и перевести опции на этот.
		$config_language_id = $this->config->get("config_language_id");
		$extensions = $this->model_extension_extension->getInstalled('payment');
		// Payment Methods
		$files = glob(DIR_APPLICATION . 'controller/payment/*.php');
		$method_data = array();
		foreach ($files as $file) {
			$extension = basename($file, '.php');
			if (!$this->user->hasPermission('modify', 'payment/'.$extension ) || !in_array($extension,$extensions)) {
				continue;
			}
			if ($extension == "neoseo_paymentplus") {
				$this->load->model('tool/neoseo_paymentplus');
				$methods = $this->model_tool_neoseo_paymentplus->getAllPayments();

				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'neoseo_paymentplus.neoseo_paymentplus' . $id,
						'name' => $data1['name'],
						'sort_order' => $data1['sort_order'],
						'status' => 1,
					);
				}
				continue;
			}

			$this->language->load('payment/' . $extension);

			$method_data[] = array(
				'code' => $extension,
				'name' => $this->language->get('heading_title'),
				'sort_order' => $this->config->get($extension . '_sort_order'),
				'status' => ($this->config->get($extension . '_status') == 1)?1:0,
			);
		}
		$sort_order = array();

		foreach ($method_data as $key => $value) {
			$sort_order[$key] = $value['sort_order'];
		}

		array_multisort($sort_order, SORT_ASC, $method_data);

		$data['payment_methods'] = $method_data;

		$data['payment_methods_list'] = array();
		foreach ($method_data as $item) {
			$data['payment_methods_list'][$item['code']] =
				[
					'name' => trim(strip_tags($item['name'])),
					'status' => $item['status'],
				];
		}

		// Shipping Methods
		$files = glob(DIR_APPLICATION . 'controller/shipping/*.php');
		$extensions = $this->model_extension_extension->getInstalled('shipping');
		$method_data = array();
		foreach ($files as $file) {
			$extension = basename($file, '.php');
			if (!$this->user->hasPermission('modify', 'shipping/'.$extension ) || !in_array($extension,$extensions)) {
				continue;
			}
			if ($extension == "dostavkaplus") {
				$methods = $this->config->get("dostavkaplus_module");
				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'dostavkaplus.sh' . $id,
						'name' => isset($data1['title'][$config_language_id]) ? $data1['title'][$config_language_id] : $data1['title'][key($data1['title'])],
						'sort_order' => $data1['sort_order'],
						'status' => ($this->config->get($extension . '_status') == 1)?1:0,
					);
				}
				continue;
			} elseif ($extension == "neoseo_shippingplus") {
				$this->load->model('tool/neoseo_shippingplus');
				$methods = $this->model_tool_neoseo_shippingplus->getAllShippings();
				//echo "<pre>".print_r($methods,true)."</pre>";exit;
				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'neoseo_shippingplus.neoseo_shippingplus' . $id,
						'name' => $data1['name'],
						'sort_order' => $data1['sort_order'],
						'status' => $data1['status'],
					);
				}
				continue;
			}elseif ($extension == "neoseo_novaposhta") {
				$this->load->model('tool/neoseo_novaposhta');
				$methods = $this->model_tool_neoseo_novaposhta->getAllShippingsForMaster();
				foreach ($methods as $id => $data1) {
					$method_data[] = array(
						'code' => 'neoseo_novaposhta.' . $id,
						'name' => $data1['name'],
						'sort_order' => $data1['sort_order'],
						'status' => $data1['status'],
					);
				}
				continue;
			}elseif ($extension == "cdek") {
				$cdek_tariff_list = $this->config->get('cdek_custmer_tariff_list');
				foreach($cdek_tariff_list as $cdek_tariff){
					$method_data[] = array(
						'code' => $extension . '.tariff_' . $cdek_tariff['tariff_id'].'_0',
						'name' => $cdek_tariff['title'][$config_language_id],
						'sort_order' => $this->config->get($extension . '_sort_order'),
						'status' => ($this->config->get($extension . '_status') == 1)?1:0,
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
						'status' => ($this->config->get($extension . '_status') == 1)?1:0,
					);
				}
			} else {
				$method_data[] = array(
					'code' => $extension,
					'name' => $this->language->get('heading_title'),
					'sort_order' => $this->config->get($extension . '_sort_order'),
					'status' => ($this->config->get($extension . '_status') == 1)?1:0,
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
			$data['shipping_methods_list'][$item['code']] =
				[
					'name' => $item['name'],
					'status' => $item['status'],
				];
		}

		// Dependencies for shipping
		$payment_for_shipping = $this->config->get('neoseo_checkout_payment_for_shipping');

		$data['payment_for_shipping'] = array();
		foreach ($data['shipping_methods'] as $smethod) {
			$pmethods = array();
			foreach ($data['payment_methods'] as $pmethod) {
				$pmethods[$pmethod['code']] = isset($payment_for_shipping[$smethod['code']][$pmethod['code']]);
			}
			$data['payment_for_shipping'][$smethod['code']] = $pmethods;
		}
		return $data;
	}

}
