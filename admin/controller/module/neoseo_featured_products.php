<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoseoFeaturedProducts extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = 'neoseo_featured_products';
		$this->_logFile = $this->_moduleSysName . '.log';
		$this->debug = $this->config->get($this->_moduleSysName . '_debug');
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('extension/' . $this->_route);
		$this->load->model('localisation/language');
		$this->load->model('setting/setting');
		$this->load->model('catalog/product');
		$this->load->model($this->_route . '/' . $this->_moduleSysName);
		$this->load->model('tool/' . $this->_moduleSysName);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$globalModuleData[$this->_moduleSysName . '_debug'] = $this->request->post[$this->_moduleSysName . '_debug'];
			$this->model_setting_setting->editSetting($this->_moduleSysName, $globalModuleData);

			$moduleData = array();
			foreach ($this->request->post as $key => $value) {
				$shortKey = str_replace($this->_moduleSysName . '_', '', $key);
				if (in_array($shortKey, array('action', 'debug', 'tabs', 'tab_product'))) {
					continue;
				}
				$moduleData[$shortKey] = $value;
			}
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule($this->_moduleSysName, $moduleData);
				$module_id = $this->db->getLastId();
				//Добавляем module_id, чтобы в катологе при выводе получить список табов
				$moduleData['mod_id'] = $module_id;
				$this->model_extension_module->editModule($module_id, $moduleData);
			} else {
				$module_id = $this->request->get['module_id'];
				$moduleData['mod_id'] = $module_id;
				$this->model_extension_module->editModule($this->request->get['module_id'], $moduleData);
			}
			if (isset($this->request->post['tabs'])) {
				$this->model_tool_neoseo_featured_products->saveTabs($this->request->post['tabs'], $module_id);
				unset($this->request->post['tabs']);
			}
			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == 'save') {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . '&module_id=' . $module_id, 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			}


			$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
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
			array($this->_route . '/' . $this->_moduleSysName, 'heading_title_raw')
		    ), $data);

		$data = $this->initButtons($data);

		$url = isset($this->request->get['module_id']) ? '&module_id=' . $this->request->get['module_id'] : '';
		$data['delete'] = $this->url->link($this->_route . '/' . $this->_moduleSysName . '/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		$data['templates'] = array();
		$template_files = glob(DIR_CATALOG . 'view/theme/default/template/module/' . $this->_moduleSysName . '*.tpl');
		if ($template_files) {
			foreach ($template_files as $template_file) {
				$template_file_name = str_replace($this->_moduleSysName . '_', '', basename($template_file, '.tpl'));
				$data['templates'][$template_file_name] = $this->language->get('text_template') . ' - ' . $template_file_name;
			}
		}

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['language_id'] = $this->config->get('config_language_id');

		if (isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $module_info['name'],
				'href' => $this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
			);
		}
		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}

		$tabs = array();

		if (isset($this->request->get['module_id']) && !empty($module_info)) {

			foreach ($module_info as $key => $value) {
				$data[$this->_moduleSysName . '_' . $key] = $value;
			}

			$list_tabs = $this->model_tool_neoseo_featured_products->getListTabs($this->request->get['module_id']);
			foreach ($list_tabs as $id => $tab) {
				$tab['name'] = unserialize($tab['name']);
				$tabs[$tab['tab_id']] = $tab;
				if ($tab['products']) {
					$array_products = explode(',', $tab['products']);
					foreach ($array_products as $product_id) {
						$product_info = $this->model_catalog_product->getProduct($product_id);
						if ($product_info) {
							$tabs[$tab['tab_id']]['prod'][$product_info['product_id']] = $product_info['name'];
						}
					}
				}
				$data['max_id'] = $tab['tab_id'] + 1;
			}
		}


		foreach ($data['languages'] as $language) {
			if ($language['language_id'] == $data['language_id']) {
				$new_name[$language ['language_id']] = 'new-tab-name';
			}
		}
		if (!isset($data['max_id']))
			$data['max_id'] = 1;

		$modules[$data['max_id']] = array(
			'id' => $data['max_id'],
			'name' => $new_name,
			'limit' => 5,
			'width' => 200,
			'height' => 200,
			'status' => 0,
			'order' => 0,
			'url'=>'',
			'utl_text'=>''
		);

		$data['tabs'] = $modules;
		$data['params'] = $data;
		$data['moduleName'] = $this->_moduleSysName . '_';
		$data['tab_form'] = str_replace(array("\n", "\r", "'"), '', $this->load->view($this->_route . '/' . $this->_moduleSysName . '_form.tpl', $data));

		array_pop($data['tabs']); //  элемент больше не нужен
		$data['tabs'] = $tabs;

		$data['params_use_related'] = array(
			0 => $this->language->get('text_disabled'),
			1 => $this->language->get('param_in_product'),
			2 => $this->language->get('param_in_category'),
		);
		
		$data['params'] = $data;

		$data['logs'] = $this->getLogs();

		$widgets = new NeoSeoWidgets($this->_moduleSysName . '_',$data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['token'] = $this->session->data['token'];
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function delete()
	{
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName);
		$data['params'] = $data;
		$this->load->model('tool/' . $this->_moduleSysName);

		if (!$this->user->hasPermission('modify', $this->_route . '/' . $this->_moduleSysName)) {
			$data['error_warning'] = $this->language->get('error_permission');

			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');

			$data['post'] = $this->request->post;
			$this->response->setOutput($this->render(), $this->config->get('config_compression'));
			return;
		} else {
			if (isset($this->request->get['tab_id'])) {
				$this->model_tool_neoseo_featured_products->deleteTab(
				    $this->request->get
				);

				$this->session->data['success'] = $this->language->get('text_success_delete');
			}

			header('location:' . str_replace('&amp;', '&', $this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')));
		}
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
