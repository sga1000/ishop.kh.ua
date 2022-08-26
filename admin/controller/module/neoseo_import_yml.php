<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoImportYml extends NeoSeoController
{

	private $error=array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName="neoseo_import_yml";
		$this->_logFile=$this->_moduleSysName . ".log";
		$this->debug=$this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data=$this->language->load($this->_route . '/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model('tool/' . $this->_moduleSysName);
		$this->load->model($this->_route . "/" . $this->_moduleSysName);

		if(($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$settings_array=array();
			$settings_array[$this->_moduleSysName . '_status']=$this->request->post[$this->_moduleSysName . '_status'];
			$settings_array[$this->_moduleSysName . '_debug']=$this->request->post[$this->_moduleSysName . '_debug'];
			$settings_array[$this->_moduleSysName . '_sql_before']=$this->request->post[$this->_moduleSysName . '_sql_before'];
			$settings_array[$this->_moduleSysName . '_sql_after']=$this->request->post[$this->_moduleSysName . '_sql_after'];
			$this->model_setting_setting->editSetting($this->_moduleSysName, $settings_array);
			if(isset($this->request->post["imports"]))
				$this->model_tool_neoseo_import_yml->saveImportYML($this->request->post["imports"]);
			$this->session->data['success']=$this->language->get('text_success');

			if($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if(isset($this->error['warning'])) {
			$data['error_warning']=$this->error['warning'];
		} else {
			$data['error_warning']='';
		}
		if(isset($this->session->data['success'])) {
			$data['success']=$this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data=$this->initBreadcrumbs(array(
			array("extension/" . $this->_route, "text_module"),
			array($this->_route . "/" . $this->_moduleSysName, "heading_title_raw")
		), $data);

		$data=$this->initButtons($data);

		$data['delete']=$this->url->link($this->_route . '/' . $this->_moduleSysName . '/delete', 'token=' . $this->session->data['token'], 'SSL');
		$data[$this->_moduleSysName . "_cron"]="php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		$data['imports_all']=$this->url->link($this->_route . '/' . $this->_moduleSysName . '/imports_all', 'token=' . $this->session->data['token'], 'SSL');
		$data['import_one']=$this->url->link($this->_route . '/' . $this->_moduleSysName . '/import', 'token=' . $this->session->data['token'], 'SSL');
		$data['clear_database']=$this->url->link($this->_route . '/' . $this->_moduleSysName . '/clear_database', 'token=' . $this->session->data['token'], 'SSL');

		$imports = array();
		$listImmports = array();
		$listImmports = $this->model_tool_neoseo_import_yml->getListImports();

		foreach($listImmports as $id=>$import) {
			if(isset($import['import_params']) && $import['import_params'] != ""){
				$import_params = unserialize($import['import_params']);
				$import_params["import_id"] = $import["import_id"];
			}else{
				$import_params = $import;
			}

			$imports[$import["import_id"]] = $import_params;
			$data["max_id"]=$import["import_id"] + 1;
		}

		$data["imports"]=$imports;
		$data['token']=$this->session->data['token'];

		$this->load->model($this->_route . "/" . $this->_moduleSysName);
		$data=$this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		if(!isset($data['max_id']))
			$data['max_id']=1;

		$this->load->model('catalog/category');

		$filter_data=array(
			'sort'=>'name',
			'order'=>'ASC'
		);

		$catFullData=$this->model_catalog_category->getCategories($filter_data);

		$data['categories'][0]=$data['entry_top_category_level'];
		foreach($catFullData as $row) {
			$data['categories'][$row['category_id']]=$row['name'];
		}

		$this->load->model('localisation/currency');
		$currencies=$this->model_localisation_currency->getCurrencies($filter_data);

		$data['currencies'][0]=$data['entry_no_currency'];
		foreach($currencies as $row) {
			$data['currencies'][$row['currency_id']]=$row['title'];
		}

		$this->load->model('localisation/stock_status');
		$stock_statuses = $this->model_localisation_stock_status->getStockStatuses($filter_data);

		foreach ($stock_statuses as $row) {
			$data['stock_statuses'][$row['stock_status_id']] = $row['name'];
		}

		$default_import=array(
			"import_id"=>$data["max_id"],
			"import_name"=>"new-import-name",
			"import_status"=>0,
			"import_url"=>'',
			"stock_status_true"=>7,
			"stock_status_false"=>8,
			"update_name"=>0,
			"name_tag"=>'',
			"update_description"=>0,
			"description_tag"=>'',
			"update_attribute"=>0,
			"update_image"=>0,
			"update_manufacturer"=>0,
			"update_price"=>0,
			"create_discount_price"=>0,
			"discount_price_percent"=>0,
			"update_category"=>0,
			"add_category"=>0,
			"update_category_skip"=>0,
			"update_model"=>0,
			"update_meta_tag"=>0,
			"import_categories"=>'',
			"parent_category"=>0,
			"price_charge"=>0,
			"price_tag"=>'',
			"use_quantity"=>0,
			"available_control"=>0,
			"exclude_by_name"=>'',
			"price_gradation"=>'',
			"generate_url"=>0,
			"only_update_product"=>0,
			"import_currency"=>'',
			"import_convert_currency"=>'',
			"sku_tag"=>'vendorCode',
			'fill_parent_categories' => 0,
			"ignore_attributes" => '',
			"route_attributes" => '',
			"update_additions" => 1,
			"sku_prefix" => '',
			"import_ftp_server" => '',
			"import_ftp_login" => '',
			"import_ftp_password" => '',
			"import_ftp_path" => '',
			"create_price_action" => '',
			"available_status_via_stock" => '',
			"reload_image" => 0,
			"main_tag" => 'offers',
			"item_tag" => 'offer',
			"use_quantity_tag" => '',
			"inner_tag" => 0,
			"set_miss_quantity" => 0,
			"switch_category " => 0,
			"field_sync" => 'sku',
		);

		$imports[$data["max_id"]] = $default_import;

		// пересобираем массив настроек - если есть не достающие параметры = заменяем их на по умолчанию
		foreach ($imports as $re_imp_id => $re_import){
			$import_differnce = array();
			$import_differnce = array_diff_key($default_import,$re_import);
			if(count($import_differnce)){
				$imports[$re_imp_id] = array_merge($import_differnce, $re_import);
			}
		}

		$data["imports"]=$imports;
		$data['params']=$data;
		$data["import_form"]=str_replace(array("\n", "\r", "'"), "", $this->load->view('module/' . $this->_moduleSysName . '_form.tpl', $data));

		array_pop($data["imports"]); //  элемент больше не нужен

		$data['params']=$data;
		$data['logs']=$this->getLogs();

		$data['header']=$this->load->controller('common/header');
		$data['column_left']=$this->load->controller('common/column_left');
		$data['footer']=$this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function delete()
	{

		$data=$this->language->load($this->_route . '/' . $this->_moduleSysName);
		$data['params']=$data;
		$this->load->model('tool/' . $this->_moduleSysName);

		if(!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName)) {
			$data['error_warning']=$this->language->get('error_permission');

			$this->template=$this->_route . '/' . $this->_moduleSysName . '.tpl';
			$this->children=array(
				'common/header',
				'common/footer'
			);

			$data['post']=$this->request->post;

			$this->response->setOutput($this->render(), $this->config->get('config_compression'));
			return;
		} else {

			if(isset($this->request->get["import_id"])) {
				$this->model_tool_neoseo_import_yml->deleteImport(
					$this->request->get
				);

				$this->session->data['success']=$this->language->get('text_success_delete');
			}

			header("location:" . str_replace('&amp;', '&', $this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL')));
		}
	}

	public function imports_all()
	{
		$this->load->model('tool/' . $this->_moduleSysName);
		$result=$this->model_tool_neoseo_import_yml->imports();
		$data=$this->load->language($this->_route . '/' . $this->_moduleSysName);
		if($result) {
			$message=$this->language->get('text_success_imports');
		} else {
			$message=$this->language->get('text_error_imports');
		}
		$this->session->data['success']=$message;
		$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function import()
	{

		$this->load->model('tool/' . $this->_moduleSysName);
		if(isset($this->request->get["import_id"])) {

			$result=$this->model_tool_neoseo_import_yml->import($this->request->get["import_id"]);
		}
		$data=$this->load->language($this->_route . '/' . $this->_moduleSysName);
		if($result) {
			$message=$this->language->get('text_success_import');
		} else {
			$message=$this->language->get('text_error_import');
		}
		$this->session->data['success']=$message;
		$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function clear_database()
	{
		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_import_yml->clearDatabase();
		$data=$this->load->language($this->_route . '/' . $this->_moduleSysName);
		$this->session->data['success']=$this->language->get('text_success_database_clear');
		$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
	}

	private function validate()
	{
		if(!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName)) {
			$this->error['warning']=$this->language->get('error_permission');
		}

		if(!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

}
