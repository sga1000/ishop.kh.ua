<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoSeoGeoip extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_geoip";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model("tool/" . $this->_moduleSysName);

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			if( isset ($this->request->post['zone_to_group'])) {
				$this->{'model_tool_' . $this->_moduleSysName()}->saveGroups($this->request->post['zone_to_group']);
			} else {
				$this->{'model_tool_' . $this->_moduleSysName()}->saveGroups(array());
			}

			if( isset ($this->request->post['zone_to_localization'])) {
				$this->{'model_tool_' . $this->_moduleSysName()}->saveLocalization($this->request->post['zone_to_localization']);
			} else {
				$this->{'model_tool_' . $this->_moduleSysName()}->saveLocalization(array());
			}

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
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
			array('extension/module', 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName, "heading_title_raw")
			), $data);

		$data = $this->initButtons($data);

		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		$data["token"] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;
		$data["logs"] = $this->getLogs();

		$this->load->model('customer/customer_group');
		$data['customer_groups'] = $this->model_customer_customer_group->getCustomerGroups();

		// Получаем страны из геоайпи базы
		$data['geoip_countries'] = $this->{'model_tool_' . $this->_moduleSysName()}->getGeoipCountries();

		// Получаем страны и регионы из базы опенкарта
		$this->load->model('localisation/country');
		$data['countries'] = $this->model_localisation_country->getCountries();

		// Загрузим языки
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		//Загрузим валюты 
		$this->load->model('localisation/currency');
		$data['currencies'] = $this->model_localisation_currency->getCurrencies();
		
		//Загрузим настройки локализации
		$data['localization_map'] = $this->{'model_tool_' . $this->_moduleSysName()}->getLocalizationMapping();

		// Загрузим соответсвия
		$data['mapping'] = $this->{'model_tool_' . $this->_moduleSysName()}->getGeoipMapping();
		$data['groups_mapping'] = $this->{'model_tool_' . $this->_moduleSysName()}->getGroupsMapping();

		if($this->config->get($this->_moduleSysName().'_api_key') == ''){
			$data['error_warning'] = $data['text_no_api_key'];
		}

		$data['update_link'] = $this->url->link($this->_route . '/' . $this->_moduleSysName . '/updategeoip', 'token=' . $this->session->data['token'].'', 'SSL');

		$widgets = new NeoSeoWidgets($this->_moduleSysName . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function editMaps()
	{
		$this->checkLicense();
		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName);
		$this->load->model('tool/'.$this->_moduleSysName);
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			if( isset ($this->request->post['zone_to_geo_zone']) && isset($this->request->post['country'])) {
				$this->{'model_tool_' . $this->_moduleSysName()}->saveMapping($this->request->post['country'],$this->request->post['zone_to_geo_zone']);
			}
			$this->session->data['success'] = $this->language->get('text_success');
			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if(!isset($this->request->get['country']) || $this->request->get['country'] == "")
		{
			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			return 0;
		}
		$data["token"] = $this->session->data['token'];
		$country = $this->request->get['country'];
		$data['country'] = $country;
		$this->document->setTitle($this->language->get('heading_title_raw'));
		// Получаем страны из геоайпи базы
		$data['geoip_countries'] = $this->{'model_tool_' . $this->_moduleSysName()}->getGeoipCountries($country);
		$data['mapping'] = $this->{'model_tool_' . $this->_moduleSysName()}->getGeoipMapping($country);

		// Получаем страны и регионы из базы опенкарта
		$this->load->model('localisation/country');
		$data['countries'] = $this->model_localisation_country->getCountries();

		$data = $this->initButtons($data);
		$data['close'] = $this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'].'#tab-mapping', 'SSL');
		$data['save'] = $this->url->link($this->_route . '/' . $this->_moduleSysName.'/editmaps', 'token=' . $this->session->data['token'].'#tab-mapping', 'SSL');
		$data = $this->initBreadcrumbs(array(
			array('extension/module', 'text_module'),
			array($this->_route . '/' . $this->_moduleSysName, "heading_title_raw"),
			array($this->_route . '/' . $this->_moduleSysName.'/editmaps&country='.$country, "heading_title_edit")
		), $data);
		$data['add_title'] = $this->language->get('heading_title_edit') ." \"". $data['geoip_countries'][$country]['name']."\"";
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '_mapform.tpl', $data));
	}

	public function updateGeoip()
	{
		$api_key = $this->config->get($this->_moduleSysName().'_api_key');
		$this->load->model('tool/'.$this->_moduleSysName);
		$update_config = $this->{'model_tool_' . $this->_moduleSysName()}->getUpdateConfig($api_key);
		$update_url = $update_config['update_url'];
		$target_file = $update_config['target_file'];
		$update_dir = $update_config['update_dir'];
		$update_file = $update_config['update_file'];
		$inarchive_file = $update_config['inarchive_file'];
		$this->language->load($this->_route . '/' . $this->_moduleSysName);

		$fp = fopen($update_file, 'w');
		$ch = curl_init($update_url);
		curl_setopt($ch, CURLOPT_FILE, $fp);
		$data = curl_exec($ch);
		curl_close($ch);
		fclose($fp);
		if(!$data){
			@unlink($update_file);
			$this->session->data['error_warning'] = $this->language->get('error_download');
			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
		}

		try {
			$archive = new PharData($update_file);
			foreach($archive as $file) {
				if($file->isDir()){
					$new_dir = $file->getBasename();
				}
			}
			$archive->extractTo($update_dir,$new_dir.'/'.$inarchive_file,true);
		} catch (Exception $e) {
			@unlink($update_file);
			$this->session->data['error_warning'] = $this->language->get('error_key');
			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
		}

		try {
			@rename($update_dir . '/' . $new_dir . '/' . $inarchive_file, $target_file);
			@rmdir($update_dir . '/' . $new_dir);
			@unlink($update_file);
		}catch (Exception $e) {
			$this->session->data['error_warning'] = $this->language->get('error_move') . 'library/maxmind-db/base/';
			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->session->data['success'] = $this->language->get('text_geoip_update');
		$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function zone() {
		$output = '<option value="0">' . $this->language->get('text_all_zones') . '</option>';

		$this->load->model("tool/" . $this->_moduleSysName);

		$results = $this->{'model_tool_' . $this->_moduleSysName()}->getGeoipRegions($this->request->get['country_id']);

		foreach ($results as $result) {
			$output .= '<option value="' . $result['zone_id'] . '"';
			if ($this->request->get['zone_id'] == $result['zone_id']) {
				$output .= ' selected="selected"';
			}
			$output .= '>' . $result['name'] . '</option>';
		}
		$this->response->setOutput($output);
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
