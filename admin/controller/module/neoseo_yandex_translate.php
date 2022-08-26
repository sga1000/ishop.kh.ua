<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoYandexTranslate extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_yandex_translate";
		$this->_modulePostfix = "";
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug") == 1;
	}

	public function index()
	{

		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load( 'module/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting($this->_moduleSysName(), $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link('module/' . $this->_moduleSysName(), 'token=' . $this->session->data['token'], 'SSL'));
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
			array('extension/' . $this->_route, 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName(), "heading_title_raw")
		    ), $data);

		$data = $this->initButtons($data);

		$this->load->model($this->_route . "/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName()}->params, $data);

		$data['translate_content'] = array(
			'name' => $this->language->get('text_name'),
			'description' => $this->language->get('text_description'),
			'meta_title' => $this->language->get('text_meta_title'),
			'meta_description' => $this->language->get('text_meta_description'),
			'meta_keyword' => $this->language->get('text_meta_keyword'),
			'meta_h1' => $this->language->get('text_meta_h1'),
			'tag' => $this->language->get('text_tag'),
		);

		$data['translate_content_blog_articles'] = array(
			'name' => $this->language->get('text_name'),
			'description' => $this->language->get('text_description'),
			'teaser' => $this->language->get('text_description_teaser'),
			'meta_title' => $this->language->get('text_meta_title'),
			'meta_h1' => $this->language->get('text_meta_h1'),
			'meta_description' => $this->language->get('text_meta_description'),
			'meta_keyword' => $this->language->get('text_meta_keyword'),
		);

		$data['translate_content_blog_categories'] = array(
			'name' => $this->language->get('text_name'),
			'description' => $this->language->get('text_description'),
			'meta_title' => $this->language->get('text_meta_title'),
			'meta_h1' => $this->language->get('text_meta_h1'),
			'meta_description' => $this->language->get('text_meta_description'),
			'meta_keyword' => $this->language->get('text_meta_keyword'),
		);

		$data['translate_content_blog_authors'] = array(
			'teaser' => $this->language->get('text_description_teaser'),
			'description' => $this->language->get('text_description'),
			'meta_title' => $this->language->get('text_meta_title'),
			'meta_h1' => $this->language->get('text_meta_h1'),
			'meta_description' => $this->language->get('text_meta_description'),
			'meta_keyword' => $this->language->get('text_meta_keyword'),
		);

		$this->load->model('localisation/language');
		$languages = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$languages[$language['language_id']] = $language['name'];
		}
		$data['languages'] = $languages;

		$data['token'] = $this->session->data['token'];

		$data['params'] = $data;

		$data['logs'] = $this->getLogs();

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName() . '.tpl', $data));
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify','module/' . $this->_moduleSysName())) {
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
