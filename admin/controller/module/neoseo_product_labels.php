<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoProductLabels extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_product_labels";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));
		$this->document->addStyle('view/javascript/jquery/jpicker/css/jpicker-1.1.6.min.css');
		$this->document->addStyle('view/javascript/jquery/jpicker/css/jpicker.css');
		$this->document->addScript('view/javascript/jquery/jpicker/jpicker-1.1.6.js');

		$this->load->model('setting/setting');
		$this->load->model('tool/' . $this->_moduleSysName);
		$this->load->model('catalog/product');
		$this->load->model('localisation/language');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->cache->delete('product.labels');
			if (isset($this->request->post["labels"])) {
				$this->model_tool_neoseo_product_labels->saveLabel($this->request->post["labels"]);
				unset($this->request->post['labels']);
			}
			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
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
		$data['delete'] = $this->url->link('module/' . $this->_moduleSysName . '/delete', 'token=' . $this->session->data['token'], 'SSL');

		$data['config_language_id'] = $this->config->get('config_language_id');

		$labels = array();
		$listLabels = $this->model_tool_neoseo_product_labels->getListLabels();
		foreach ($listLabels as $label_id => $label) {
			$label['name'] = unserialize($label['name']);
			$label['stores'] = unserialize($label['store_ids']);
			$labels[$label["label_id"]] = $label;
			$products = $this->model_tool_neoseo_product_labels->getLabelProducts($label["label_id"]);
			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);
				if ($product_info) {
					$labels[$label["label_id"]]['prod'][$product_info['product_id']] = $product_info['name'];
				}
			}
			$data["max_id"] = $label["label_id"] + 1;
		}
		$data['active_sale_status'] = $this->config->get($this->_moduleSysName . '_special_type');
		$label_products = $this->config->get($this->_moduleSysName . '_special_label_products');
		if ($label_products) {
			foreach ($label_products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);
				if ($product_info) {
					$data['products'][$product_info['product_id']] = $product_info['name'];
				}
			}
		}
		$data["labels"] = $labels;

		$data['token'] = $this->session->data['token'];
		$data['languages'] = $this->model_localisation_language->getLanguages();
		$data['array_params'] = array(
			0 => $this->language->get('params_type_hands'),
			1 => $this->language->get('params_type_new'),
			2 => $this->language->get('params_type_popular'),
			3 => $this->language->get('params_type_hit'),
			4 => $this->language->get('params_type_stock'),
			5 => $this->language->get('params_type_instock'),
		);
		$data['array_position'] = array(
			'label-top-left' => $this->language->get('params_position_top_left'),
			'label-top-right' => $this->language->get('params_position_top_right'),
			'label-bottom-left' => $this->language->get('params_position_bottom_left'),
			'label-bottom-right' => $this->language->get('params_position_bottom_right'),
		);
		$data['array_type_label'] = array(
			'type-1' 	=> $this->language->get('params_type_label_type_1'),
			'type-2' 	=> $this->language->get('params_type_label_type_2'),

			'corner' 	=> $this->language->get('params_type_label_corner'),
			'b-ribbon' 	=> $this->language->get('params_type_label_flag'),
			'stripes' 	=> $this->language->get('params_type_label_stripes'),
			'sticker' 	=> $this->language->get('params_type_label_sticker'),
			'chip'   	=> $this->language->get('params_type_label_chip'),
			'tally'		=> $this->language->get('params_type_label_tally')
		);


		$special_title = array();

		foreach ($data['languages'] as $language) {
			if ($language['language_id'] == $data['config_language_id']) {
				$new_name[$language ['language_id']] = 'new-label-name';
			}
			$special_title[$language['language_id']] = $this->language->get('text_special');
		}

		$data = $this->initParamsList(array(
			'status',
			'debug',
			'special_title',
			'special_status',
			'special_label_type',
			'special_position',
			'special_class',
			'special_style',
			'special_priority',
			'special_color'
		), $data);

		if (!isset($data['max_id']))
			$data['max_id'] = 1;
		$this->load->model('setting/store');
		$data['stores'] = $this->model_setting_store->getStores();

		/*if (isset($this->request->post['product_store'])) {
			$data['product_store'] = $this->request->post['product_store'];
		} elseif (isset($this->request->get['product_id'])) {
			$data['product_store'] = $this->model_catalog_product->getProductStores($this->request->get['product_id']);
		} else {
			$data['product_store'] = array(0);
		*/

		$labels[$data["max_id"]] = array(
			'label_id' => $data["max_id"],
			'name' => $new_name,
			'label_type' => 'corner',
			'class' => '',
			'style' => '',
			'color' => 'f12717',
			'position' => 'label-top-left',
			'type' => 1,
			'products' => '',
			'priority' => 0,
			'stores' => '',
			'status' => 0,
			'days' => 0,
			'viewes' => 0,
			'sold' => 0,
			'product_limit' => 10,
		);
		$data["labels"] = $labels;

		$data['params'] = $data;
		$data["label_form"] = str_replace(array("\n", "\r", "'"), "", $this->load->view('module/' . $this->_moduleSysName . '_form.tpl', $data));

		array_pop($data ["labels"]); //  элемент больше не нужен

		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function delete()
	{

		$data = $this->language->load('module/' . $this->_moduleSysName);
		$data['params'] = $data;
		$this->load->model('tool/' . $this->_moduleSysName);

		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName)) {
			$data['error_warning'] = $this->language->get('error_permission');

			$this->template = 'module/' . $this->_moduleSysName . '.tpl';
			$this->children = array(
				'common/header',
				'common/footer'
			);

			$data['post'] = $this->request->post;
			$this->response->setOutput($this->
			render(), $this->config->get('config_compression'));
			return;
		} else {

			if (isset($this->request->get["label_id"])) {
				$this->model_tool_neoseo_product_labels->deleteLabel($this->request->get);

				$this->session->data['success'] = $this->language->get('text_success_delete');
			}

			header("location:" . str_replace('&amp;', '&', $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL')));
		}
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

}

?>
