<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoWatermark extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_watermark";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));
		$this->document->addStyle('view/javascript/' . $this->_moduleSysName . '/jquery-ui.css');
		$this->document->addScript('view/javascript/' . $this->_moduleSysName . '/jquery-ui.js');
		$this->document->addStyle('view/stylesheet/' . $this->_moduleSysName . '.css');
		$this->document->addScript('view/javascript/' . $this->_moduleSysName . '/jquery.ui.rotatable.js');
		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success_options');

			if (isset($this->request->post['action']) && $this->request->post['action'] == "save") {
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
			array('module/' . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data['clean'] = $this->url->link('module/' . $this->_moduleSysName . '/clean', 'token=' . $this->session->data['token'], 'SSL');
		$data['recheck'] = $this->url->link("module/" . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
		$data['action'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['clear'] = $this->url->link('module/' . $this->_moduleSysName . '/clear', 'token=' . $this->session->data['token'], 'SSL');
		$data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
		$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
		$data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');


		$data['image_directories'] = $this->getWatermarkDirectories(DIR_IMAGE . 'catalog', array());

		$this->load->model('setting/store');
		$stores = array();
		$stores[0] = array(
			"name" => $this->config->get('config_name') . $this->language->get('text_default'),
			"url" => rtrim($this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG, "/") . "/");
		foreach ($this->model_setting_store->getStores() as $store) {
			$stores[$store['store_id']] = array(
				"name" => $store['name'],
				"url" => rtrim($store["url"], "/") . "/");
		}

		$this->load->model("tool/image");
		$this->load->model($this->_route . "/" . $this->_moduleSysName);
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		foreach ($stores as $store_id => $store_data) {
			$savedImage = $this->config->get($this->_moduleSysName . "_image_${store_id}");
			if ($savedImage && file_exists(DIR_IMAGE . $savedImage) && is_file(DIR_IMAGE . $savedImage)) {
				$data[$this->_moduleSysName . "_image_${store_id}"] = $savedImage;
			} else {
				$data[$this->_moduleSysName . "_image_${store_id}"] = "catalog/" . $this->_moduleSysName . "/watermark.png";
			}
			$data[$this->_moduleSysName . "_default_image_${store_id}"] = "catalog/" . $this->_moduleSysName . "/watermark.png";

			$sizes = getimagesize(DIR_IMAGE . $data[$this->_moduleSysName . "_default_image_${store_id}"]);
			$data[$this->_moduleSysName . "_default_image_width_${store_id}"] = 40;
			$data[$this->_moduleSysName . "_default_image_height_${store_id}"] = ceil($sizes[1] * (40 / $sizes[0]));
			$data[$this->_moduleSysName . "_default_image_left_${store_id}"] = 50;
			$data[$this->_moduleSysName . "_default_image_top_${store_id}"] = 90 - $data[$this->_moduleSysName . "_default_image_height_${store_id}"];
			$data[$this->_moduleSysName . "_default_image_angle_${store_id}"] = 0;
			$data[$this->_moduleSysName . "_product_image_${store_id}"] = "catalog/" . $this->_moduleSysName . "/product.jpg";
			$data[$this->_moduleSysName . "_product_image_thumb_${store_id}"] = $this->model_tool_image->resize($data[$this->_moduleSysName . "_product_image_${store_id}"], 300, 300);
			$data[$this->_moduleSysName . "_image_root_${store_id}"] = $store_data['url'];
		}

		$data['stores'] = $stores;

		$data['params'] = $data;
		$data['token'] = $this->session->data['token'];

		$data["logs"] = $this->getLogs();

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
			return true;
		} else {
			return false;
		}
	}

	protected function getWatermarkDirectories($dir, $result, $level = 1)
	{
		if ($level > 3) {
			// Врядли кому-то надо будет исключить каталог /p/1/2/3/1/2/3,
			// а вот сканирование такого количества каталогов может быть
			// очень и очень долгим процессом. Поэтому - ограничимся
			// первым уровнем
			return $result;
		}

		$items = glob($dir . '/*', GLOB_ONLYDIR);
		if (!empty($items)) {
			foreach ($items as $entry) {
				if ($entry == '.' || $entry == '..')
					continue;

				$result[] = array(
					'text' => substr($entry, strlen(DIR_IMAGE . 'catalog/')),
					'value' => $entry
				);

				$result = $this->getWatermarkDirectories($entry, $result, $level + 1);
			}
		}

		return $result;
	}

	private function deldir($dirname)
	{
		if (file_exists($dirname)) {
			if (is_dir($dirname)) {
				$dir = opendir($dirname);
				while ($filename = readdir($dir)) {
					if ($filename != "." && $filename != "..") {
						$file = $dirname . "/" . $filename;
						$this->deldir($file);
					}
				}
				closedir($dir);
				rmdir($dirname);
			} else {
				@unlink($dirname);
			}
		}
	}

	public function image()
	{
		$this->load->model('tool/image');

		if (isset($this->request->get['image'])) {
			$this->response->setOutput($this->model_tool_image->resize(html_entity_decode($this->request->get['image'], ENT_QUOTES, 'UTF-8'), 200, 200));
		}
	}

	public function getImgSize()
	{
		$json = array();
		$json['success'] = false;

		$isfile = file_exists(DIR_IMAGE . $this->request->post["src"]);


		if (!$isfile)
			return;

		$size = getimagesize(DIR_IMAGE . $this->request->post["src"]);

		if ($size) {
			$json["size"] = $size;
			$json['success'] = true;
		}

		$this->response->setOutput(json_encode($json));
	}

	public function clean()
	{

		if ($this->validate()) {
			$dirs = glob(DIR_IMAGE . 'cache/*');
			foreach ($dirs as $dir) {
				$this->deldir($dir);
			}

			$this->language->load('module/' . $this->_moduleSysName);
			$this->session->data['success'] = $this->language->get('text_success_clean');
		}

		if (isset($_SERVER['HTTP_REFERER'])) {
			$this->response->redirect($_SERVER['HTTP_REFERER']);
		} else {
			$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

}

?>