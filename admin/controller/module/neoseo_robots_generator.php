<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoseoRobotsGenerator extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_robots_generator";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{

		$this->checkLicense();

		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

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
			array("extension/module", "text_feed"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data = $this->initButtons($data);

		$data['url'] = HTTP_CATALOG . 'sitemap.xml';

		$data = $this->initParams(array(
			array($this->_moduleSysName . "_status", 1),
			array($this->_moduleSysName . "_debug", 0),
		    ), $data);

		$sql = "show tables like 'search_adress%'";
		$query = $this->db->query($sql);
		$data["hasAddresses"] = ( $query->num_rows > 0);

		$data['params'] = $data;

		$data['logs'] = $this->getLogs();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function install()
	{
		$this->load->model("module/" . $this->_moduleSysName);
		$this->model_module_neoseo_robots_generator->install();
	}

	public function uninstall()
	{
		$this->load->model("module/" . $this->_moduleSysName);
		$this->model_module_neoseo_robots_generator->uninstall();
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
