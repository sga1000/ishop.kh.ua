<?php

require_once(DIR_SYSTEM . '/engine/neoseo_controller.php');
require_once(DIR_SYSTEM . '/engine/neoseo_view.php');

class ControllerFeedNeoSeoGoogleFeed extends NeoSeoController
{

	private $error = array();

	private $feed_types
		= array(
			1 => 'all_category',
			2 => 'category',
			3 => 'all_seo',
			4 => 'seo',
		);

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo/google_feed";
		$this->_modulePostfix = ""; // Постфикс для разных типов модуля, поэтому переходим на испольлзование $this->_moduleSysName()
		$this->_logFile = $this->_moduleSysName() . ".log";
		$this->debug = $this->config->get($this->_moduleSysName() . "_debug") == 1;
	}

	public function index()
	{
		$this->response->redirect($this->url->link('feed/neoseo_feeds', 'token=' . $this->session->data['token'], 'SSL'));
	}

	public function edit()
	{
		$this->upgrade();

		$data = $this->language->load($this->_route . '/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting($this->_moduleSysName(), $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if ($this->request->post['action'] == "save") {
				$this->response->redirect($this->url->link($this->_route . '_' . $this->_moduleSysName(), 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			if (isset($this->session->data['error_warning'])) {
				$data['error_warning'] = $this->session->data['error_warning'];
				unset($this->session->data['error_warning']);
			} else {
				$data['error_warning'] = '';
			}
		}
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(
			array(
				array('extension/' . $this->_route, 'text_module'),
				array($this->_route . '/' . $this->_moduleSysName(), "heading_title_raw"),
			), $data
		);

		$data = $this->initButtons($data);

		$this->load->model($this->_route . "/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_neoseo_google_feed"}->params, $data);

		$data["token"] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;

		$data["logs"] = $this->getLogs();

		$widgets = new NeoSeoWidgets($this->_moduleSysName() . '_', $data);
		$widgets->text_select_all = $this->language->get('text_select_all');
		$widgets->text_unselect_all = $this->language->get('text_unselect_all');
		$data['widgets'] = $widgets;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName() . '.tpl', $data));
	}

	public function getName()
	{
		return 'Google Merchant';
	}

	public function getProductPlace()
	{
		return 'Google Merchant';
	}

	public function getWidgetCategory($category_id)
	{
		$data = $this->language->load('feed/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			if (isset($this->session->data['error_warning'])) {
				$data['error_warning'] = $this->session->data['error_warning'];
				unset($this->session->data['error_warning']);
			} else {
				$data['error_warning'] = '';
			}
		}

		$this->load->model("feed/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_feed_neoseo_google_feed"}->params, $data);

		$category = $this->model_feed_neoseo_google_feed->getCategoryByCategory($category_id);

		if (isset($category['category_id'])) {
			$data['google_category_id'] = $category['category_id'];
			$data['google_category_name'] = $category['name'];
			$data['google_feeded'] = $category['google_feed'];
		} else {
			$data['google_category_id'] = 0;
			$data['google_category_name'] = '';
			$data['google_feeded'] = 0;
		}

		$data["token"] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;

		return $this->load->view('feed/' . $this->_moduleSysName() . '_category.tpl', $data);
	}

	public function getWidgetSeofilter($params)
	{
		$data = $this->language->load('feed/' . $this->_moduleSysName());

		$this->document->setTitle($this->language->get('heading_title_raw'));

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			if (isset($this->session->data['error_warning'])) {
				$data['error_warning'] = $this->session->data['error_warning'];
				unset($this->session->data['error_warning']);
			} else {
				$data['error_warning'] = '';
			}
		}

		$this->load->model("feed/" . $this->_moduleSysName());
		$data = $this->initParamsListEx($this->{"model_feed_neoseo_google_feed"}->params, $data);

		$page = $this->model_feed_neoseo_google_feed->getCategoryByFilter($params['page_id']);

		if (isset($page['category_id'])) {
			$data['google_category_id'] = $page['google_category_id'];
			$data['google_feeded'] = $page['google_feed'];
		} else {
			$data['google_category_used'] = 0;
			$data['google_feeded'] = 0;
		}

		$data["token"] = $this->session->data['token'];
		$data['config_language_id'] = $this->config->get('config_language_id');
		$data['params'] = $data;

		return $this->load->view('feed/' . $this->_moduleSysName() . '_seofilter.tpl', $data);
	}

	public function autocomplete()
	{
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model("feed/" . $this->_moduleSysName());

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'limit'       => 5,
			);

			$results = $this->model_feed_neoseo_google_feed->getCategory($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'category_id' => $result['category_id'],
					'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
				);
			}
		}

		$sort_order = array();

		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getDoExport()
	{
		$data = $this->language->load('feed/' . $this->_moduleSysName());

		$data['list_feeds'] = array();
		if (count($this->config->get($this->_moduleSysName() . '_list_feeds'))) {
			foreach ($this->config->get($this->_moduleSysName() . '_list_feeds') as $feed) {
				$data['list_feeds'][$feed['feed_id']] = array(
					'feed_id'          => $feed['feed_id'],
					'name'             => $feed['store_name'],
					'store_name'       => $feed['store_name'],
					'full_store_name'  => $feed['full_store_name'],
					'currency'         => $feed['currency'],
					'category'         => $feed['type'],
					'product_category' => $feed['feed_category'],
					'product_page'     => $feed['feed_page'],
					'filename'         => ($this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG) . 'system/storage/download/'
						. str_replace('/', '_', $this->_moduleSysName()) . '_' . $feed['feed_id'] . '_feed.xml',
				);
			}
		}

		$data['json_list_feeds'] = json_encode($data['list_feeds'], true);

		$data['store_name'] = '';
		$data['full_store_name'] = '';
		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/currency');
		$data['currencies'] = $this->model_localisation_currency->getCurrencies();

		$this->load->model('catalog/category');
		$data['categories'] = $this->model_catalog_category->getCategories();
		$data['product_category'] = array();

		$data['pages'] = array();
		$data['product_page'] = array();

		$this->load->model('feed/' . $this->_moduleSysName());
		if ($this->model_feed_neoseo_google_feed->hasNeoseoFilter()) {
			$this->load->model('catalog/neoseo_filter_pages');
			$pages = $this->model_catalog_neoseo_filter_pages->getFilterPages();
			foreach ($pages as $page) {
				$data['pages'][] = array(
					'page_id' => $page['page_id'],
					'name'    => $page['title'],
				);
			}
		}

		$data['select_type'] = array(
			'1' => $data['entry_category_type_select'],
			'2' => $data['entry_page_type_select'],
		);

		$json["popup-export"] = $this->renderTemplate('neoseo/google_feed_popup.tpl', $data);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	protected function renderTemplate($template, $data)
	{
		extract($data);

		ob_start();
		if (file_exists(DIR_TEMPLATE . '/feed/' . $template)) {
			$template_file = '/feed/' . $template;
		}
		require(DIR_TEMPLATE . $template_file);
		$result = ob_get_contents();
		ob_end_clean();

		return $result;
	}

	public function generate()
	{
		$data = $this->language->load('feed/' . $this->_moduleSysName());

		if (isset($this->request->post['feed_id']) && $this->request->post['feed_id'] != 0) {
			$feeds_info = $this->config->get($this->_moduleSysName() . '_list_feeds')[$this->request->post['feed_id']];
		} else {
			return true;
		}

		$this->load->model('localisation/currency');
		$currencies = $this->model_localisation_currency->getCurrencies();

		$currency_code = $this->session->data['currency'];;
		foreach ($currencies as $currency) {
			if ($currency['currency_id'] == $feeds_info['currency']) {
				$currency_code = $currency['code'];
			}
		}

		$data['products'] = array();
		$filter_data = array();
		$filename = str_replace('/', '_', $this->_moduleSysName()) . '_' . $this->request->post['feed_id'] . '_feed';

		$this->load->model("feed/" . $this->_moduleSysName());
		if ($feeds_info['type'] == 1) {
			$filter_data['filter_categories'] = $feeds_info['feed_category'];
			$results = $this->model_feed_neoseo_google_feed->getProducts($filter_data);
			$this->getFeedContentProduct($results, $currency_code, $filename, $feeds_info);
		} else {
			$filter_data['filter_page'] = $feeds_info['feed_page'];
			$pages = $this->model_feed_neoseo_google_feed->getPages($filter_data);
			$results = array();
			foreach ($pages as $page) {
				$filter_data['filter_nsf'] = $this->model_feed_neoseo_google_feed->getProductIdsByFilter($page['options'], $page['category_id']);
				$page_products = $this->model_feed_neoseo_google_feed->getProducts($filter_data);

				$results = array_merge($results, $page_products);
			}
			$this->getFeedContentProduct($results, $currency_code, $filename, $feeds_info);
		}

		$xml_link = ($this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG) . 'system/storage/download/' . $filename . '.xml';
		$json['xml_link'] = '<a href="' . $xml_link . '" target="_blank">' . $xml_link . '</a>';

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	private function getFeedContentProduct($results, $currency_code, $filename, $feed_info)
	{
		$this->load->model('tool/image');
		$xml = new DomDocument('1.0', 'utf-8');
		$rss = $xml->appendChild($xml->createElement('rss'));
		$rss->setAttribute('version', '2.0');
		$rss->setAttribute('xmlns:g', 'http://base.google.com/ns/1.0');
		$main_title = $rss->appendChild($xml->createElement('title'));
		$main_title->appendChild($xml->createTextNode($feed_info['store_name']));
		$main_desc = $rss->appendChild($xml->createElement('description'));
		$main_desc->appendChild($xml->createTextNode($feed_info['full_store_name']));
		$items = $rss->appendChild($xml->createElement('channel'));

		foreach ($results as $result) {
			if ($result['image']) {
				$image = $this->model_tool_image->resize(
					$result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height')
				);
			} else {
				$image = $this->model_tool_image->resize(
					'placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height')
				);
			}
			
			$price = $this->currency->format($result['price'], $currency_code);
			
			$url_product = $this->model_feed_neoseo_google_feed->getProductSeoUrl($result);

			$product_description = strip_tags(html_entity_decode($result['description']));

			$item = $items->appendChild($xml->createElement('item'));
			$id = $item->appendChild($xml->createElement('g:id'));
			$id->appendChild($xml->createTextNode($result['product_id']));
			$title = $item->appendChild($xml->createElement('g:title'));
			$title->appendChild($xml->createTextNode($result['name']));
			$condition = $item->appendChild($xml->createElement('g:condition'));
			$condition->appendChild($xml->createTextNode('new'));
			$url = $item->appendChild($xml->createElement('g:url'));
			$url->appendChild($xml->createTextNode($url_product));
			$price_item = $item->appendChild($xml->createElement('g:price'));
			$price_item->appendChild($xml->createTextNode($price));
			$image_link = $item->appendChild($xml->createElement('g:image_link'));
			$image_link->appendChild($xml->createTextNode($image));
			
			
			$description = $item->appendChild($xml->createElement('g:description'));
			$description->appendChild($xml->createTextNode($product_description));
			$availability = $item->appendChild($xml->createElement('g:availability'));
			$availability->appendChild($xml->createTextNode('in stock'));
			$model = $item->appendChild($xml->createElement('g:mpn'));
			$model->appendChild($xml->createTextNode($result['model']));
			
			
			$brand = $item->appendChild($xml->createElement('g:brand'));
			$brand->appendChild($xml->createTextNode($result['brand']));
			$google_categoryq = $item->appendChild($xml->createElement('g:google_product_category'));
			$google_categoryq->appendChild($xml->createTextNode($result['google_category']));
		}

		$result = $xml->save(DIR_DOWNLOAD . $filename . '.xml');
		return $result;
	}

	private function getFeedContentPage($results, $currency_code, $filename, $feed_info)
	{
		$this->load->model('tool/image');
		$xml = new DomDocument('1.0', 'utf-8');
		$rss = $xml->appendChild($xml->createElement('rss'));
		$rss->setAttribute('version', '2.0');
		$rss->setAttribute('xmlns:g', 'http://base.google.com/ns/1.0');
		$main_title = $rss->appendChild($xml->createElement('title'));
		$main_title->appendChild($xml->createTextNode($feed_info['store_name']));
		$main_desc = $rss->appendChild($xml->createElement('description'));
		$main_desc->appendChild($xml->createTextNode($feed_info['full_store_name']));
		$items = $rss->appendChild($xml->createElement('channel'));

		foreach ($results as $result) {
			$url_page = $this->model_feed_neoseo_google_feed->getPageSeoUrl($result);
			$page_description = strip_tags(html_entity_decode($result['description']));

			$item = $items->appendChild($xml->createElement('item'));
			$id = $item->appendChild($xml->createElement('g:id'));
			$id->appendChild($xml->createTextNode('seo-' . $result['page_id']));
			$title = $item->appendChild($xml->createElement('g:title'));
			$title->appendChild($xml->createTextNode($result['name']));
			$condition = $item->appendChild($xml->createElement('g:condition'));
			$condition->appendChild($xml->createTextNode('new'));
			$url = $item->appendChild($xml->createElement('g:url'));
			$url->appendChild($xml->createTextNode($url_page));

			
			$description = $item->appendChild($xml->createElement('g:description'));
			$description->appendChild($xml->createTextNode($page_description));
			$availability = $item->appendChild($xml->createElement('g:availability'));
			$availability->appendChild($xml->createTextNode('in stock'));

			$google_categoryq = $item->appendChild($xml->createElement('g:google_product_category'));
			$google_categoryq->appendChild($xml->createTextNode($result['google_category']));
		}

		$result = $xml->save(DIR_DOWNLOAD . '/' . $filename . '.xml');
		return $result;
	}

	private static function getRandomFileName($path, $extension = '')
	{
		$extension = $extension ? '.' . $extension : '';
		$path = $path ? $path . '/' : '';

		do {
			$name = md5(microtime() . rand(0, 9999));
			$file = $path . $name . $extension;
		} while (file_exists($file));

		return $name;
	}

	public function saveFeed()
	{
		$data = $this->language->load('feed/neoseo/google_feed');

		$json = array();
		$post = $this->request->post;

		if (isset($post['popup_store_name']) && $post['popup_store_name'] != '') {
			$json['success'] = sprintf($this->language->get('text_save_export'), '[' . $post['popup_store_name'] . ']');

			$this->load->model('setting/setting');
			$settings = $this->model_setting_setting->getSetting($this->_moduleSysName());
			if (isset($post['feed_id']) && $post['feed_id'] == 0) {
				$feed_id = 0;
				foreach ($settings[$this->_moduleSysName() . '_list_feeds'] as $feed) {
					$feed_id = ($feed_id > (int)$feed['feed_id']) ? $feed_id : (int)$feed['feed_id'];
				}
				$this->request->post['feed_id'] = $feed_id + 1;
			}

			$settings[$this->_moduleSysName() . '_list_feeds'][$this->request->post['feed_id']] = array(
				'feed_id'         => $this->request->post['feed_id'],
				'store_name'      => $this->request->post['popup_store_name'],
				'full_store_name' => isset($this->request->post['popup_full_store_name']) ? $this->request->post['popup_full_store_name'] : '',
				'currency'        => $this->request->post['popup_currency_id'],
				'type'            => $this->request->post['popup_category_type'],
				'feed_category'   => isset($this->request->post['product_category']) ? $this->request->post['product_category'] : array(),
				'feed_page'       => isset($this->request->post['product_page']) ? $this->request->post['product_page'] : array(),
			);
			$this->model_setting_setting->editSetting($this->_moduleSysName(), $settings);
		} else {
			$json['success'] = '';
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function refreshFeeds()
	{
		$json = array();

		$data = $this->language->load('feed/' . $this->_moduleSysName());

		if (count($this->config->get($this->_moduleSysName() . '_list_feeds'))) {
			foreach ($this->config->get($this->_moduleSysName() . '_list_feeds') as $feed) {
				$json[] = array(
					'feed_id'          => (int)$feed['feed_id'],
					'name'             => $feed['store_name'],
					'store_name'       => $feed['store_name'],
					'full_store_name'  => $feed['full_store_name'],
					'currency'         => $feed['currency'],
					'category'         => $feed['type'],
					'product_category' => $feed['feed_category'],
					'product_page'     => $feed['feed_page'],
					'filename'         => ($this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG) . 'system/storage/download/'
						. str_replace('/', '_', $this->_moduleSysName()) . '_' . $feed['feed_id'] . '_feed.xml',
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getFeed()
	{
		$json = array();
		$data = $this->language->load('feed/' . $this->_moduleSysName());

		if ($this->request->post['feed_id']) {
			if (count($this->config->get($this->_moduleSysName() . '_list_feeds'))) {
				$feed = $this->config->get($this->_moduleSysName() . '_list_feeds')[$this->request->post['feed_id']];
				$json = array(
					'feed_id'          => (int)$feed['feed_id'],
					'name'             => $feed['store_name'],
					'store_name'       => $feed['store_name'],
					'full_store_name'  => $feed['full_store_name'],
					'currency'         => $feed['currency'],
					'category'         => $feed['type'],
					'product_category' => $feed['feed_category'],
					'product_page'     => $feed['feed_page'],
					'filename'         => ($this->config->get('config_secure') ? HTTPS_CATALOG : HTTP_CATALOG) . 'system/storage/download/'
						. str_replace('/', '_', $this->_moduleSysName()) . '_' . $feed['feed_id'] . '_feed.xml',
				);
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function deleteFeed()
	{
		$json = array();
		$data = $this->language->load('feed/' . $this->_moduleSysName());

		$this->load->model('setting/setting');
		$settings = $this->model_setting_setting->getSetting($this->_moduleSysName());

		if (isset($settings[$this->_moduleSysName() . '_list_feeds'][$this->request->post['feed_id']])) {
			unset($settings[$this->_moduleSysName() . '_list_feeds'][$this->request->post['feed_id']]);
			$this->model_setting_setting->editSetting($this->_moduleSysName(), $settings);
			$json['success'] = $this->language->get('text_delete');
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	private function getProductSeoUrl()
	{
	}

}