<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerFeedNeoseoFastSitemap extends NeoseoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_fast_sitemap";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		$this->checkLicense();

		$data = $this->language->load('feed/neoseo_fast_sitemap');

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting('neoseo_fast_sitemap', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (!isset($_GET["close"])) {
				$this->response->redirect($this->url->link('feed/neoseo_fast_sitemap', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL'));
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
			array("extension/feed", "text_feed"),
			array("feed/neoseo_fast_sitemap", "heading_title_raw")
		    ), $data);


		$data['save'] = $this->url->link('feed/neoseo_fast_sitemap', 'token=' . $this->session->data['token'], 'SSL');
		$data['save_and_close'] = $this->url->link('feed/neoseo_fast_sitemap', 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
		$data['clear'] = $this->url->link('feed/neoseo_fast_sitemap/clear', 'token=' . $this->session->data['token'], 'SSL');
		$data['close'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');

		$data['neoseo_fast_sitemap_url'] = HTTP_CATALOG . 'sitemap.xml';

		$data = $this->initParams(array(
			array($this->_moduleSysName . "_status", 1),
			array($this->_moduleSysName . "_debug", 1),
			array($this->_moduleSysName . "_image_status", 0),
			array($this->_moduleSysName . "_seo_status", 1),
			array($this->_moduleSysName . "_seo_url_include_path", 0),
			array($this->_moduleSysName . "_addresses_status", 0),
			array($this->_moduleSysName . "_gzip_status", 0),
			array($this->_moduleSysName . "_seo_lang_status", 0),
			array($this->_moduleSysName . "_partition_status", 1),
			array($this->_moduleSysName . "_partition_volume", 50000),
			array($this->_moduleSysName . "_multistore_status", 0),
			array($this->_moduleSysName . "_category_status", 1),
			array($this->_moduleSysName . "_category_brand_status", 0),
			array($this->_moduleSysName . "_filterpro_seo_status", 0),
			array($this->_moduleSysName . "_filtervier_seo_status", 0),
			array($this->_moduleSysName . "_ocfilter_seo_status", 0),
			array($this->_moduleSysName . "_mfilter_seo_status", 0),
			array($this->_moduleSysName . "_filter_seo_status", 0),
			array($this->_moduleSysName . "_category_url_date", 1),
			array($this->_moduleSysName . "_category_url_frequency", "weekly"),
			array($this->_moduleSysName . "_category_url_priority", "0.7"),
			array($this->_moduleSysName . "_manufacturer_status", 1),
			array($this->_moduleSysName . "_manufacturer_line_by_tima", 0),
			array($this->_moduleSysName . "_manufacturer_url_frequency", "weekly"),
			array($this->_moduleSysName . "_manufacturer_url_priority", "0.7"),
			array($this->_moduleSysName . "_product_status", 1),
			array($this->_moduleSysName . "_product_url_date", 1),
			array($this->_moduleSysName . "_product_url_frequency", "weekly"),
			array($this->_moduleSysName . "_product_url_priority", "1"),
			array($this->_moduleSysName . "_information_status", 1),
			array($this->_moduleSysName . "_information_url_frequency", "weekly"),
			array($this->_moduleSysName . "_information_url_priority", "1"),
			array($this->_moduleSysName . "_blog_freecart_status", 0),
			array($this->_moduleSysName . "_blog_pavo_status", 0),
			array($this->_moduleSysName . "_blog_seocms_status", 0),
			array($this->_moduleSysName . "_blog_blogmanager_status", 0),
			array($this->_moduleSysName . "_blog_category_status", 1),
			array($this->_moduleSysName . "_blog_category_url_date", 1),
			array($this->_moduleSysName . "_blog_category_url_frequency", "weekly"),
			array($this->_moduleSysName . "_blog_category_url_priority", "0.7"),
			array($this->_moduleSysName . "_blog_author_status", 1),
			array($this->_moduleSysName . "_blog_author_url_date", 1),
			array($this->_moduleSysName . "_blog_author_url_frequency", "weekly"),
			array($this->_moduleSysName . "_blog_author_url_priority", "0.7"),
			array($this->_moduleSysName . "_blog_article_status", 1),
			array($this->_moduleSysName . "_blog_article_url_date", 1),
			array($this->_moduleSysName . "_blog_article_url_frequency", "weekly"),
			array($this->_moduleSysName . "_blog_article_url_priority", "0.7"),
		    ), $data);

		$sql = "show tables like 'search_adress%'";
		$query = $this->db->query($sql);
		$data["hasAddresses"] = ( $query->num_rows > 0);

		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('feed/neoseo_fast_sitemap.tpl', $data));
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', 'feed/neoseo_fast_sitemap')) {
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
