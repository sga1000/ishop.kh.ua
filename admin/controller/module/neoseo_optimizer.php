<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");
require_once( DIR_SYSTEM . '/engine/neoseo_view.php' );

class ControllerModuleNeoseoOptimizer extends NeoseoController {
	const PROFILER_FILE = 'profile.log';

	private $error = array();

	public function __construct($registry) {
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_optimizer";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index() {
		$this->checkLicense();
		$this->upgrade();

		$data = $this->language->load('module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');
		$this->load->model('module/'. $this->_moduleSysName);
		
		$save_settings = true;

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate() && ($save_settings = $this->{'model_module_' . $this->_moduleSysName}->saveSettings($this->request->post)) !== false) {
			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($this->request->get['close'])) {
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('module/'.$this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} elseif ($save_settings === false) {
			$data['error_warning'] = $this->language->get('error_save_settings');
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
		
		$data['clear_profiler'] = $this->url->link('module/' . $this->_moduleSysName . '/clear_profiler', 'token=' . $this->session->data['token'], 'SSL');
		$data['download_profiler'] = $this->url->link('module/' . $this->_moduleSysName . '/download_profiler', 'token=' . $this->session->data['token'], 'SSL');

		$data = $this->initParamsList(array(
			'minify_css',
			'minify_js',
			'minify_html',
			"status",
			"jpg_driver",
			"png_driver",
			"png_to_webp",
			"webp_converter",
			"png_compress",
			"image_dir_list",
			"compress_level",
			'profile',
			"debug",
			"page_to_cache",
			"cache_url_limit",
			"expire_cache",
			"js_tag",
			"js_untag_list",
			"js_defer",
			"js_undefer",
			"js_async_list",
			"js_defer_page_list",
			"js_unpack_list",
			"js_footer_list",
			"css_unpack_list",
			"css_footer_list",
			"css_tag",
			"css_untag_list",
			"img_lazy_load",
			"img_unlazy_load",
			"img_lazy_src",
			"use_layout_cache",
			"cache_exclude_modules",
			"cache_need_path",
		), $data);

		$data[$this->_moduleSysName . "_cron"] = "php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		if (PHP_VERSION_ID < 50300) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php52/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 50400) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php53/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 50500) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php54/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 50600) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php55/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 50700) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php56/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 70100) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php70/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else if (PHP_VERSION_ID < 70200) {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php71/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		} else {
			$data[$this->_moduleSysName . "_cron_cpanel"] = "/opt/cpanel/ea-php72/root/usr/bin/php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");
		}
		// /opt/cpanel/ea-php56/root/usr/bin/php -f /home/prokreat/public_html/cron/neoseo_class365.php
		$data[$this->_moduleSysName . "_sync_link"] = ((!empty($_SERVER['HTTPS']) ? 'https://' : 'http://').$_SERVER['SERVER_NAME'].'/'). "cron/" . $this->_moduleSysName . ".php";

		$data['clear_page_cache'] = $this->url->link('module/neoseo_optimizer/purge', 'token=' . $this->session->data['token'], 'SSL');

		$data['params'] = $data;

		$data["logs"] = $this->getLogs();
		$data['profiler'] = $this->getProfiler();

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/' . $this->_moduleSysName . '.tpl', $data));
	}
	
	public function clear_profiler() {
		$this->language->load('module/' . $this->_moduleSysName);

		if (is_file(DIR_LOGS . self::PROFILER_FILE)) {
			$f = fopen(DIR_LOGS . self::PROFILER_FILE, "w");
			fclose($f);
		}

		$this->session->data['success'] = $this->language->get('text_success_clear');

		$this->response->redirect($this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . '#tab-profiler', 'SSL'));
	}

	public function download_profiler()
	{
		$this->language->load($this->_route . '/' . $this->_moduleSysName);
		if (is_file(DIR_LOGS . self::PROFILER_FILE) && file_get_contents(DIR_LOGS . self::PROFILER_FILE)) {
			$this->response->addheader('Pragma: public');
			$this->response->addheader('Expires: 0');
			$this->response->addheader('Content-Description: File Transfer');
			$this->response->addheader('Content-Type: application/octet-stream');
			$this->response->addheader('Content-Disposition: attachment; filename=' . $this->language->get('heading_title_raw') . '_profile_' . date('Y-m-d_H-i-s', time()) . '.log');
			$this->response->addheader('Content-Transfer-Encoding: binary');
			$this->response->setOutput(file_get_contents(DIR_LOGS . self::PROFILER_FILE, FILE_USE_INCLUDE_PATH, null));
		} else {
			$this->session->data['error_warning'] = $this->language->get('error_download_logs');
			$this->response->redirect($this->url->link($this->_route . '/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
		}
	}

	private function getProfiler($limit = 100000) {
		$result = "";
		if (is_file(DIR_LOGS . self::PROFILER_FILE)) {
			$file = fopen(DIR_LOGS . self::PROFILER_FILE, "r");
			fseek($file, -$limit, SEEK_END);
			$result = fread($file, $limit);
			fclose($file);
		}
		return $result;
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function purge() {
		$this->language->load('module/'.$this->_moduleSysName);
		$which = $this->request->post['which'];
		if ($which != "all" && $which != "expired") {
			$this->response->setOutput(json_encode(
				array('message' => 'invalid value for which')
			));
			return;
		}

		$expire=$this->config->get($this->_moduleSysName . "_expire_cache");
		$range=array( '0','1','2','3','4','5','6','7',
			'8','9','a','b','c','d','e','f');
		$count=0;
		foreach ($range as $f) {
			foreach ($range as $s) {
				$dname=DIR_CACHE.'neoseo_page_cache/'. $f . '/' . $s;
				if (is_dir($dname) && @$dir=opendir($dname)) {
					while (false !== ($file = readdir($dir))) {
						// only purge files that end in .cache
						if (substr($file,-6) == '.cache') {
							$fpath=$dname . '/' . $file;
							if ($which == 'all') {
								unlink($fpath);
								$count++;
							} elseif ($which == 'expired') {
								if (filectime($fpath)+$expire < time()) {
									unlink($fpath);
									$count++;
								}
							}
						}
					}
				}
			}
		}
		$message=sprintf($this->language->get('text_purged'),$count);
		$this->response->setOutput(json_encode(
			array('message' => $message)
		));
	}

}
