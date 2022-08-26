<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoActionManagerList extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_action_manager";
		$this->_modulePostfix = "_list"; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());
		$data = array_merge($data, $this->language->load($this->_route . '/' . $this->_moduleSysName));
		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$globalModuleData[$this->_moduleSysName() . '_debug'] = $this->request->post[$this->_moduleSysName() . '_debug'];
			$this->model_setting_setting->editSetting($this->_moduleSysName(), $globalModuleData);

			$moduleData = array();
			foreach ($this->request->post as $key => $value) {
				$shortKey = str_replace($this->_moduleSysName() . "_", "", $key);
				if (in_array($shortKey, array("action", "debug"))) {
					continue;
				}
				$moduleData[$shortKey] = $value;
			}
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule($this->_moduleSysName(), $moduleData);
				$module_id = $this->db->getLastId();
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $moduleData);
				$module_id = $this->request->get['module_id'];
			}

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName(), "module_id=" . $module_id . '&token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		if (isset($this->error['image'])) {
			$data['error_image'] = $this->error['image'];
		} else {
			$data['error_image'] = array();
		}
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(array(
			array("extension/" . $this->_route, "text_module"),
			array($this->_route . '/' . $this->_moduleSysName(), "heading_title_raw")
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
			$this->load->model('extension/module');
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
			if (!empty($module_info)) {
				foreach ($module_info as $key => $value) {
					$data[$this->_moduleSysName() . '_' . $key] = $value;
					//$this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params[$key] = $value;
				}
				$data['breadcrumbs'][] = array(
					'text' => $module_info['name'],
					'href' => $this->url->link($this->_route . '/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'] . $url, 'SSL')
				);
			}
		}

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$this->load->model('localisation/language');
		$lang_data = $this->model_localisation_language->getLanguages();
		$data['full_languages'] = $lang_data;
		$languages = array();
		foreach ($lang_data as $language) {
			$languages[$language['language_id']] = $language['name'];
		}
		$data['languages'] = $languages;

		$data['templates'] = array();
		$template_files = glob(DIR_CATALOG . 'view/theme/default/template/module/' . $this->_moduleSysName() . '_*.tpl');
		if ($template_files) {
			foreach ($template_files as $template_file) {
				$template_file_name = str_replace($this->_moduleSysName() . "_", "", basename($template_file, '.tpl'));
				$data['templates'][$template_file_name] = $this->language->get('text_template') . " - " . $template_file_name;
			}
		}

		$data['token'] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;
		$data["logs"] = $this->getLogs();


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
		if (isset($this->request->post[$this->_moduleSysName() . '_module'])) {
			foreach ($this->request->post[$this->_moduleSysName() . '_module'] as $key => $value) {
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
