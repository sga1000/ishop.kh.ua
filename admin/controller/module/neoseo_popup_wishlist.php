<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

$shutdown_redirect = "";

function neoseo_popup_wishlist_shutdown()
{
	global $shutdown_redirect;
	if ($shutdown_redirect)
		header("location: " . $shutdown_redirect);
}

class ControllerModuleNeoseoPopupWishlist extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleName = "";
		$this->_moduleSysName = "neoseo_popup_wishlist";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_status") == 1;
	}

	public function index()
	{
		global $shutdown_redirect;

		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($_GET['close'])) {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
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


		$data['save'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
		$data['save_and_close'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
		$data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['clear'] = $this->url->link('module/' . $this->_moduleSysName . '/clear', 'token=' . $this->session->data['token'], 'SSL');

		$data = $this->initParams(array(
			array($this->_moduleSysName . "_status", 1),
			array($this->_moduleSysName . "_debug", 0),
		    ), $data);


		if (!function_exists('ioncube_file_info')) {
			$this->redirect($this->url->link('module/' . $this->_moduleSysName . '/ioncube', 'token=' . $this->session->data['token'], 'SSL'));
			return;
		} else {
			$shutdown_redirect = str_replace("&amp;", "&", $this->url->link('module/' . $this->_moduleSysName . '/license', 'token=' . $this->session->data['token'], 'SSL'));
			register_shutdown_function($this->_moduleSysName . '_shutdown');
			require_once(DIR_APPLICATION . "controller/tool/" . $this->_moduleSysName . ".php" );
			$shutdown_redirect = "";
		}

		if (is_file(DIR_LOGS . $this->_logFile))
			$data["logs"] = substr(file_get_contents(DIR_LOGS . $this->_logFile), -10000);
		else
			$data["logs"] = "";

		$data['params'] = $data;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function clear()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName);

		if (is_file(DIR_LOGS . $this->_logFile)) {
			$f = fopen(DIR_LOGS . $this->_logFile, "w");
			fclose($f);
			$this->session->data['success'] = $this->language->get('text_success_clear');
		} else {
			$f = fopen(DIR_LOGS . $this->_logFile, "w");
			fclose($f);
		}

		$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function license()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);


		$data['error_warning'] = "";

		$data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['recheck'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		$data['license_error'] = $this->language->get('error_license_missing');
		$data['params'] = $data;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function ioncube()
	{
		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$data = $this->initBreadcrumbs(array(
			array("extension/module", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data['error_warning'] = "";

		$data['close'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['recheck'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		$data['license_error'] = $this->language->get('error_ioncube_missing');
		$data['params'] = $data;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function install()
	{
		$this->load->model("module/" . $this->_moduleSysName);
		$this->registry->get("model_module_" . $this->_moduleSysName)->install();
	}

	public function uninstall()
	{
		$this->load->model("module/" . $this->_moduleSysName);
		$this->registry->get("model_module_" . $this->_moduleSysName)->uninstall();
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

}

?>