<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoseoCatchContacts extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_catch_contacts';
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('localisation/language');
		$this->load->model('catalog/product');
		$this->load->model('extension/module');
		$this->load->model($this->_route . '/' . $this->_moduleSysName());
		$this->load->model('tool/image');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$moduleData = array();
			foreach ($this->request->post as $key => $value) {
				$shortKey = str_replace($this->_moduleSysName() . '_', '', $key);
				if (in_array($shortKey, array('action', 'debug', 'tabs', 'tab_product'))) {
					continue;
				}
				$moduleData[$shortKey] = $value;
			}

			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule($this->_moduleSysName(), $moduleData);
				$module_id = $this->db->getLastId();
			} else {
				$module_id = $this->request->get['module_id'];
				$this->model_extension_module->editModule($this->request->get['module_id'], $moduleData);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == 'save') {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . '&module_id=' . $module_id, 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
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

		$data = $this->initBreadcrumbs(array(
			array('extension/' . $this->_route, 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName(), 'heading_title_raw')
				), $data);

		$data = $this->initButtons($data);

		$this->load->model($this->_route . "/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params, $data);
		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$url = '&module_id=' . $this->request->get['module_id'];
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . $url, 'SSL');
			$data['delete'] = $this->url->link($this->_route . '/' . $this->_moduleSysName() . '/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
			if (!empty($module_info)) {
				foreach ($module_info as $key => $value) {
					$data[$this->_moduleSysName() . '_' . $key] = $value;
				}
				$data['breadcrumbs'][] = array(
					'text' => $module_info['name'],
					'href' => $this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . $url, 'SSL')
				);
			}
		}

		$languages = $this->model_localisation_language->getLanguages();
		$data['languages'] = $languages;

		$title = array();
		$titleForm = array();
		foreach ($languages as $language) {
			$title[$language['language_id']] = $this->language->get('text_title');
			$titleForm[$language['language_id']] = $this->language->get('text_title_form');
			$text_subscribe[$language['language_id']] = $this->language->get('param_subscribe_text');
			$subject[$language['language_id']] = $this->language->get('param_subscribe_subject');
			$message[$language['language_id']] = $this->language->get('param_subscribe_message');
		}

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

		if (file_exists(DIR_IMAGE . $data[$this->_moduleSysName() . '_background']) && is_file(DIR_IMAGE . $data[$this->_moduleSysName() . '_background'])) {
			$data[$this->_moduleSysName() . '_background_logo'] = $this->model_tool_image->resize($data[$this->_moduleSysName() . '_background'], 100, 100);
		} else {
			$data[$this->_moduleSysName() . '_background_logo'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$data['position_form'] = array(
			'position_top' => $this->language->get('text_position_top'),
			'position_bottom' => $this->language->get('text_position_bottom'),
			'position_left' => $this->language->get('text_position_left'),
			'position_right' => $this->language->get('text_position_right'),
		);

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$data["token"] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;

		$data['logs'] = $this->getLogs();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() . '.tpl', $data));
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

}
