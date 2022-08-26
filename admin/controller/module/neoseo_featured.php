<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoFeatured extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_featured";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{

		$data = $this->language->load('module/' . $this->_moduleSysName);
		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model('extension/module');
		$this->load->model('localisation/language');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$globalModuleData[$this->_moduleSysName . '_debug'] = $this->request->post[$this->_moduleSysName . '_debug'];
			$this->model_setting_setting->editSetting($this->_moduleSysName, $globalModuleData);

			$moduleData = array();
			foreach ($this->request->post as $key => $value) {
				$shortKey = str_replace($this->_moduleSysName . "_", "", $key);
				if (in_array($shortKey, array("action", "debug"))) {
					continue;
				}
				$moduleData[$shortKey] = $value;
			}
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule($this->_moduleSysName, $moduleData);
				$module_id = $this->db->getLastId();
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $moduleData);
				$module_id = $this->request->get['module_id'];
			}

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($this->request->get['close'])) {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, "module_id=" . $module_id . '&token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		), $data);

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (!isset($this->request->get['module_id'])) {
			$data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
			$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
		} else {
			$data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'module_id=' . $this->request->get['module_id'] . '&token=' . $this->session->data['token'], 'SSL');
			$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'module_id=' . $this->request->get['module_id'] . '&token=' . $this->session->data['token'] . "&close=1", 'SSL');
		}
		$data['clear'] = $this->url->link('module/' . $this->_moduleSysName . '/clear', 'token=' . $this->session->data['token'], 'SSL');
		$data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$data['token'] = $this->session->data['token'];
		$data['modules'] = array();

		$languages = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$languages[$language['language_id']] = $language['name'];
		}
		$data['languages'] = $languages;
		$data['full_languages'] = $this->model_localisation_language->getLanguages();

		$defaultTitle = array();
		foreach ($data['languages'] as $language_id => $name) {
			$defaultTitle[$language_id] = $this->language->get('text_default_title');
		}

		$data = $this->initModuleParams(array(
			array($this->_moduleSysName . '_name', ""),
			array($this->_moduleSysName . '_title', $defaultTitle),
			array($this->_moduleSysName . '_products', array()),
			array($this->_moduleSysName . '_limit', 4),
			array($this->_moduleSysName . '_description_limit', 80),
			array($this->_moduleSysName . '_height', "200"),
			array($this->_moduleSysName . '_width', "200"),
			array($this->_moduleSysName . '_template', "default"),
			array($this->_moduleSysName . '_status', 1),
			array($this->_moduleSysName . '_debug', 0),
			array($this->_moduleSysName . '_use_banner',0),
			array($this->_moduleSysName . '_banner', ''),
			array($this->_moduleSysName . '_banner_width', 250),
			array($this->_moduleSysName . '_banner_height', 250),
			array($this->_moduleSysName . '_banner_link', ''),
			array($this->_moduleSysName . '_block_description', ''),
		), $data, $this->_moduleSysName);

		$data['ckeditor'] = $this->config->get('config_editor_default');
		//CKEditor
		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
		} else {
			$this->document->addScript('view/javascript/summernote/summernote.js');
			$this->document->addScript('view/javascript/summernote/lang/summernote-' . $this->language->get('lang') . '.js');
			$this->document->addScript('view/javascript/summernote/opencart.js');
			$this->document->addStyle('view/javascript/summernote/summernote.css');
		}

		$data['templates'] = array();

		$template_files = glob(DIR_CATALOG . 'view/theme/neoseo_unistor/template/module/' . $this->_moduleSysName . '_*.tpl');
		if ($template_files) {
			foreach ($template_files as $template_file) {
				$template_file_name = str_replace($this->_moduleSysName . "_", "", basename($template_file, '.tpl'));
				$data['templates'][$template_file_name] = $this->language->get('text_template') . " - " . $template_file_name;
			}
		}

		$this->load->model('catalog/product');

		$data['products'] = array();
		foreach ($data[$this->_moduleSysName . '_products'] as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);

			if ($product_info) {
				$data['products'][] = array(
					'product_id' => $product_info['product_id'],
					'name'       => $product_info['name']
				);
			}
		}
		$this->load->model('tool/image');
		if($data[$this->_moduleSysName . '_banner'] == ''){
			$data['image_banner'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		} else {
			$data['image_banner'] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_banner'], 100, 100);
		}

		$data['sysname'] = $this->_moduleSysName;
		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	protected function validate()
	{
		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (isset($this->request->post[$this->_moduleSysName . '_module'])) {
			foreach ($this->request->post[$this->_moduleSysName . '_module'] as $key => $value) {
				if (!$value['image_width'] || !$value['image_height']) {
					$this->error['image'][$key] = $this->language->get('error_image');
				}
			}
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}
