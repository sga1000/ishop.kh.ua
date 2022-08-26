<?php
class ControllerCommonFooter extends Controller {
	public function index() {
		$this->load->language('common/footer');

		$data['scripts'] = $this->document->getScripts('footer');


		/* NeoSeo Ajax Search - begin */
		$data['neoseo_smart_search_status'] = $this->config->get("neoseo_smart_search_status");
		$data['neoseo_smart_search_selector'] = $this->config->get("neoseo_smart_search_selector");
		if (!file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/neoseo_smart_search.scss')) {
			if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/neoseo_smart_search.css')) {
				$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/neoseo_smart_search.css');
			} else {
				$this->document->addStyle('catalog/view/theme/default/stylesheet/neoseo_smart_search.css');
			}
		}
		/* NeoSeo Ajax Search - end */

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');
		$data['text_quickview'] = $this->language->get('text_quickview');

		$this->load->model('catalog/information');

		$data['informations'] = array();

		foreach (array() /* $this->model_catalog_information->getInformations() - Disabled By NeoSeo UniSTOR */ as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}

		$data['contact'] = '';/* Disabled By NeoSeo UniSTOR */;
		/* NeoSeo UniSTOR - begin */
		$this->load->model('module/neoseo_unistor');
		$data = $this->model_module_neoseo_unistor->processFooterData($data);
		/* NeoSeo UniSTOR - end */
		
		/* NeoSeo Google Analytics - begin */
		$status = $this->config->get('neoseo_google_analytics_status');

		if ($status[$this->config->get('config_store_id')]) {
			$this->load->model('analytics/neoseo_google_analytics');
			$data['neoseo_google_analytics_remarketing'] = $this->model_analytics_neoseo_google_analytics->getRemarketing();
		} else {
		    $data['neoseo_google_analytics_remarketing'] = false;
		}
		/* NeoSeo Google Analytics - end */
		$data['return'] = $this->url->link('account/return/add', '', 'SSL');
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
		$data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');

		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/footer.tpl', $data);
		} else {
			return $this->load->view('default/template/common/footer.tpl', $data);
		}
	}
}
