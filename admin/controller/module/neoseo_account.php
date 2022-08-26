<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoAccount extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_account";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model('module/' . $this->_moduleSysName);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($this->request->get['close'])) {
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

		$data = $this->initButtons($data);

		$data = $this->initParamsList(array(
			"status",
			'social_status',
			'social_sort',
			'social_title',
			'social_networks',
			"debug",
		    ), $data);

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$data['social_auth_sort'] = array(
			'relevant' => $this->language->get('text_enabled'),
			'default' => $this->language->get('text_disabled'),
		);

		$data['param_social_networks'] = array(
			'facebook' => $this->language->get('text_facebook'),
			'vkontakte' => $this->language->get('text_vkontakte'),
			'odnoklassniki' => $this->language->get('text_odnoklassniki'),
			'googleplus' => $this->language->get('text_googleplus'),
			'twitter' => $this->language->get('text_twitter'),
			'instagram' => $this->language->get('text_instagram'),
			'yandex' => $this->language->get('text_yandex'),
			'mailru' => $this->language->get('text_mailru'),
			'google' => $this->language->get('text_google'),
			'livejournal' => $this->language->get('text_livejournal'),
			'openid' => $this->language->get('text_openid'),
			'lastfm' => $this->language->get('text_lastfm'),
			'linkedin' => $this->language->get('text_linkedin'),
			'liveid' => $this->language->get('text_liveid'),
			'soundcloud' => $this->language->get('text_soundcloud'),
			'steam' => $this->language->get('text_steam'),
			'flickr' => $this->language->get('text_flickr'),
			'uid' => $this->language->get('text_uid'),
			'youtube' => $this->language->get('text_youtube'),
			'webmoney' => $this->language->get('text_webmoney'),
			'foursquare' => $this->language->get('text_foursquare'),
			'dudu' => $this->language->get('text_dudu'),
			'tumblr' => $this->language->get('text_tumblr'),
			'vimeo' => $this->language->get('text_vimeo'),
			'wargaming' => $this->language->get('text_wargaming'),
		);

		$data['params'] = $data;

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

}
