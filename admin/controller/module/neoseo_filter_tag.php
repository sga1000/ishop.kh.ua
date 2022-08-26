<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoFilterTag extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_filter_tag";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$moduleData = array();
			foreach ($this->request->post as $key => $value) {
				$shortKey = str_replace($this->_moduleSysName . "_", "", $key);
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

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, "module_id=" . $module_id . '&token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
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
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data = $this->initButtons($data);

		if (!isset($this->request->get['module_id'])) {
			$data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
			$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
			$data['exist_module'] = false;
		} else {
			$data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'module_id=' . $this->request->get['module_id'] . '&token=' . $this->session->data['token'], 'SSL');
			$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'module_id=' . $this->request->get['module_id'] . '&token=' . $this->session->data['token'] . "&close=1", 'SSL');
			$data['exist_module'] = true;
		}

		$data['modules'] = array();

		$this->load->model('localisation/language');
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

		$data['types'] = array(
			'hand' => $this->language->get('param_hand_type'),
			'filter_pages' => $this->language->get('param_filter_pages_type'),
		);

		$data = $this->initModuleParams(array(
			array($this->_moduleSysName . '_status', 1),
			array($this->_moduleSysName . '_name', ''),
			array($this->_moduleSysName . '_title', $defaultTitle),
			array($this->_moduleSysName . '_limit', 20),
			array($this->_moduleSysName . '_type', 'filter_pages'),
			array($this->_moduleSysName . '_filter_pages', array()),
		    ), $data, $this->_moduleSysName);

		if ($this->config->get($this->_moduleSysName . '_debug')) {
			$data[$this->_moduleSysName . '_debug'] = 1;
		}

		$config_language_id = $this->config->get('config_language_id');

		$this->load->model('catalog/neoseo_filter_pages');

		$data['filter_pages'] = array();

		foreach ($data[$this->_moduleSysName . '_filter_pages'] as $page_id) {
			$page_info = $this->model_catalog_neoseo_filter_pages->getPage($page_id);

			if ($page_info) {
				$data['filter_pages'][] = array(
					'page_id' => $page_info['page_id'],
					'tag_name' => isset($page_info['tag_name'][$config_language_id]) ? $page_info['tag_name'][$config_language_id] : $page_info['tag_name'][0],
				);
			}
		}

		$data['params'] = $data;
		$data['token'] = $this->session->data['token'];
		$data['logs'] = $this->getLogs();

		$widgets = new NeoSeoWidgets($this->_moduleSysName . '_', $data);
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	public function autocomplete()
	{
		$json = array();

		if (isset($this->request->get['tag_name'])) {

			$this->load->model('catalog/neoseo_filter_pages');

			$filters = array(
				'status' => 1,
				'filter_tag_name' => $this->request->get['tag_name'],
				'start' => 0,
				'limit' => 10,
			);

			$filter_pages = $this->model_catalog_neoseo_filter_pages->getFilterPages($filters);

			foreach ($filter_pages as $page) {
				if ($page['is_tag'] != 1)
					continue;

				$json[] = array(
					'page_id' => $page['page_id'],
					'tag_name' => $page['tag_name'],
				);
			}
		}

		$sort_order = array();

		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['tag_name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

}

?>
