<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerTotalNeoseoLoyaltySystem extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_loyalty_system";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{

		$this->checkLicense();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model($this->_route . '/' . $this->_moduleSysName);

		$this->model_total_neoseo_loyalty_system->upgrade();

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
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

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$data[$this->_moduleSysName . '_excluded_categories'] = $this->config->get($this->_moduleSysName . '_excluded_categories') ? $this->config->get($this->_moduleSysName . '_excluded_categories'): array(); 
		$data[$this->_moduleSysName . '_excluded_manufacturers'] = $this->config->get($this->_moduleSysName . '_excluded_manufacturers') ? $this->config->get($this->_moduleSysName . '_excluded_manufacturers'): array(); 

		$data['params'] = $data;
		$this->load->model('catalog/category');
		$this->load->model('catalog/manufacturer');
		$this->load->model('catalog/product');

		$data['stores'] = $this->{'model_total_' . $this->_moduleSysName}->getStores();

		foreach($data['stores'] as $store){
			$data['products'][$store['store_id']] = array();
			if( !empty($this->config->get($this->_moduleSysName . '_excluded_products')[$store['store_id']]) ){
				foreach($this->config->get($this->_moduleSysName . '_excluded_products')[$store['store_id']] as $product_id){
					$product_info = $this->model_catalog_product->getProduct($product_id);
					if(!$product_info)
						continue;
					$data['products'][$store['store_id']][$product_id] = $product_info['name'];
				}
				
			}
		}

		$data['categories'] = array();
		$filter_data['sort'] = 'name';
		foreach ($this->model_catalog_category->getCategories($filter_data) as $category) {
			$data['categories'][$category['category_id']] = $category['name'];
		}

		$data['manufacturers'] = array();
		foreach ($this->model_catalog_manufacturer->getManufacturers($filter_data) as $manufacturer) {
			$data['manufacturers'][$manufacturer['manufacturer_id']] = $manufacturer['name'];
		}

		$this->load->model($this->_route . "/" . $this->_moduleSysName);
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		$data = $this->initBreadcrumbs(array(
			array('extension/' . $this->_route, "text_module"),
			array($this->_route . '/' . $this->_moduleSysName, "heading_title_raw")
				), $data);

		$data = $this->initButtons($data);

		$this->load->model('localisation/language');
		$data['full_languages'] = $this->model_localisation_language->getLanguages();

		$widgets = new NeoSeoWidgets($this->_moduleSysName . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['logs'] = $this->getLogs();

		$data['token'] = $this->session->data['token'];

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '.tpl', $data));
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

}

?>
