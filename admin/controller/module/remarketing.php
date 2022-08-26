<?php
class ControllerModuleRemarketing extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/remarketing');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('remarketing', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'] . '&type=module', true));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_id'] = $this->language->get('text_id');
		$data['text_model'] = $this->language->get('text_model');
		$data['text_identifier'] = $this->language->get('text_identifier');
		$data['text_events'] = $this->language->get('text_events');
		$data['text_events_help'] = $this->language->get('text_events_help');
		$data['text_google_remarketing'] = $this->language->get('text_google_remarketing');
		$data['text_facebook_remarketing'] = $this->language->get('text_facebook_remarketing');
		$data['text_mytarget_remarketing'] = $this->language->get('text_mytarget_remarketing'); 
		$data['text_vk_remarketing'] = $this->language->get('text_vk_remarketing');
		$data['text_google_reviews'] = $this->language->get('text_google_reviews');
		$data['text_ecommerce'] = $this->language->get('text_ecommerce');
		$data['text_ecommerce_ga4'] = $this->language->get('text_ecommerce_ga4');
		$data['text_ecommerce_measurement'] = $this->language->get('text_ecommerce_measurement');
		$data['text_counters'] = $this->language->get('text_counters');
		$data['text_to_be_continued'] = $this->language->get('text_to_be_continued');
		$data['text_help'] = $this->language->get('text_help');
		$data['text_credits'] = $this->language->get('text_credits');
		$data['text_instruction'] = $this->language->get('text_instruction');
		$data['text_instructions'] = $this->language->get('text_instructions');
		$data['text_summary'] = $this->language->get('text_summary');
		
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_google_identifier'] = $this->language->get('entry_google_identifier');
		$data['entry_google_ads_identifier'] = $this->language->get('entry_google_ads_identifier');
		$data['entry_facebook_identifier'] = $this->language->get('entry_facebook_identifier');
		$data['entry_mytarget_identifier'] = $this->language->get('entry_mytarget_identifier');
		$data['entry_vk_identifier'] = $this->language->get('entry_vk_identifier');
		$data['entry_google_code'] = $this->language->get('entry_google_code');
		$data['entry_facebook_code'] = $this->language->get('entry_facebook_code');
		$data['entry_facebook_token'] = $this->language->get('entry_facebook_token');
		$data['entry_server_side'] = $this->language->get('entry_server_side');
		$data['entry_mytarget_code'] = $this->language->get('entry_mytarget_code');
		$data['entry_feed_status'] = $this->language->get('entry_feed_status');
		$data['entry_feed_link'] = $this->language->get('entry_feed_link');
		$data['entry_currency'] = $this->language->get('entry_currency');
		$data['entry_google_merchant_identifier'] = $this->language->get('entry_google_merchant_identifier');
		$data['entry_reviews_date'] = $this->language->get('entry_reviews_date');
		$data['entry_reviews_country'] = $this->language->get('entry_reviews_country');
		$data['entry_events_cart'] = $this->language->get('entry_events_cart');
		$data['entry_events_cart_add'] = $this->language->get('entry_events_cart_add');
		$data['entry_events_purchase'] = $this->language->get('entry_events_purchase');
		$data['entry_events_wishlist'] = $this->language->get('entry_events_wishlist');
		$data['entry_ecommerce_selector'] = $this->language->get('entry_ecommerce_selector');
		$data['entry_ecommerce_analytics_id'] = $this->language->get('entry_ecommerce_analytics_id');
		$data['entry_counter1'] = $this->language->get('entry_counter1');
		$data['entry_counter2'] = $this->language->get('entry_counter2');
		$data['entry_counter3'] = $this->language->get('entry_counter3');
 
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['ru'] = ($this->config->get('config_admin_language') == 'ru' || $this->config->get('config_admin_language') == 'russian') ? true : false;
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'] . '&type=module', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/remarketing', 'token=' . $this->session->data['token'], true)
		);

		$data['action'] = $this->url->link('module/remarketing', 'token=' . $this->session->data['token'], true);

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'] . '&type=module', true);

		if (isset($this->request->post['remarketing_status'])) {
			$data['remarketing_status'] = $this->request->post['remarketing_status'];
		} else {
			$data['remarketing_status'] = $this->config->get('remarketing_status');
		}

		if (isset($this->request->post['remarketing_google_status'])) {
			$data['remarketing_google_status'] = $this->request->post['remarketing_google_status'];
		} else {
			$data['remarketing_google_status'] = $this->config->get('remarketing_google_status');
		}

		if (isset($this->request->post['remarketing_facebook_status'])) {
			$data['remarketing_facebook_status'] = $this->request->post['remarketing_facebook_status'];
		} else {
			$data['remarketing_facebook_status'] = $this->config->get('remarketing_facebook_status');
		}

		if (isset($this->request->post['remarketing_mytarget_status'])) {
			$data['remarketing_mytarget_status'] = $this->request->post['remarketing_mytarget_status'];
		} else {
			$data['remarketing_mytarget_status'] = $this->config->get('remarketing_mytarget_status');
		} 

		if (isset($this->request->post['remarketing_vk_status'])) {
			$data['remarketing_vk_status'] = $this->request->post['remarketing_vk_status'];
		} else {
			$data['remarketing_vk_status'] = $this->config->get('remarketing_vk_status');
		} 

		if (isset($this->request->post['remarketing_google_identifier'])) {
			$data['remarketing_google_identifier'] = $this->request->post['remarketing_google_identifier'];
		} else {
			$data['remarketing_google_identifier'] = $this->config->get('remarketing_google_identifier');
		}

		if (isset($this->request->post['remarketing_google_ads_identifier'])) {
			$data['remarketing_google_ads_identifier'] = $this->request->post['remarketing_google_ads_identifier'];
		} else {
			$data['remarketing_google_ads_identifier'] = $this->config->get('remarketing_google_ads_identifier');
		}

		if (isset($this->request->post['remarketing_facebook_identifier'])) {
			$data['remarketing_facebook_identifier'] = $this->request->post['remarketing_facebook_identifier'];
		} else {
			$data['remarketing_facebook_identifier'] = $this->config->get('remarketing_facebook_identifier');
		}

		if (isset($this->request->post['remarketing_mytarget_identifier'])) {
			$data['remarketing_mytarget_identifier'] = $this->request->post['remarketing_mytarget_identifier'];
		} else {
			$data['remarketing_mytarget_identifier'] = $this->config->get('remarketing_mytarget_identifier');
		}

		if (isset($this->request->post['remarketing_vk_identifier'])) {
			$data['remarketing_vk_identifier'] = $this->request->post['remarketing_vk_identifier'];
		} else {
			$data['remarketing_vk_identifier'] = $this->config->get('remarketing_vk_identifier');
		}

		if (isset($this->request->post['remarketing_google_id'])) {
			$data['remarketing_google_id'] = $this->request->post['remarketing_google_id'];
		} else {
			$data['remarketing_google_id'] = $this->config->get('remarketing_google_id');
		}

		if (isset($this->request->post['remarketing_facebook_id'])) {
			$data['remarketing_facebook_id'] = $this->request->post['remarketing_facebook_id'];
		} else {
			$data['remarketing_facebook_id'] = $this->config->get('remarketing_facebook_id');
		}
		
		if (isset($this->request->post['remarketing_facebook_server_side'])) {
			$data['remarketing_facebook_server_side'] = $this->request->post['remarketing_facebook_server_side'];
		} else {
			$data['remarketing_facebook_server_side'] = $this->config->get('remarketing_facebook_server_side');
		}

		if (isset($this->request->post['remarketing_facebook_token'])) {
			$data['remarketing_facebook_token'] = $this->request->post['remarketing_facebook_token'];
		} else {
			$data['remarketing_facebook_token'] = $this->config->get('remarketing_facebook_token');
		}
		
		if (isset($this->request->post['remarketing_mytarget_id'])) {
			$data['remarketing_mytarget_id'] = $this->request->post['remarketing_mytarget_id'];
		} else {
			$data['remarketing_mytarget_id'] = $this->config->get('remarketing_mytarget_id');
		}

		if (isset($this->request->post['remarketing_vk_id'])) {
			$data['remarketing_vk_id'] = $this->request->post['remarketing_vk_id'];
		} else {
			$data['remarketing_vk_id'] = $this->config->get('remarketing_vk_id');
		}

		if (isset($this->request->post['remarketing_yandex_feed_status'])) {
			$data['remarketing_yandex_feed_status'] = $this->request->post['remarketing_yandex_feed_status'];
		} else {
			$data['remarketing_yandex_feed_status'] = $this->config->get('remarketing_yandex_feed_status');
		}
		
		if (isset($this->request->post['remarketing_facebook_feed_status'])) {
			$data['remarketing_facebook_feed_status'] = $this->request->post['remarketing_facebook_feed_status'];
		} else {
			$data['remarketing_facebook_feed_status'] = $this->config->get('remarketing_facebook_feed_status');
		}

		if (isset($this->request->post['remarketing_google_feed_status'])) {
			$data['remarketing_google_feed_status'] = $this->request->post['remarketing_google_feed_status'];
		} else {
			$data['remarketing_google_feed_status'] = $this->config->get('remarketing_google_feed_status');
		}
		
		$this->load->model('localisation/currency');
		
		$currencies = $this->model_localisation_currency->getCurrencies();
		
		$data['currencies'] = $currencies;
		
		if (isset($this->request->post['remarketing_google_currency'])) {
			$data['remarketing_google_currency'] = $this->request->post['remarketing_google_currency'];
		} else {
			$data['remarketing_google_currency'] = $this->config->get('remarketing_google_currency');
		}
		 
		if (isset($this->request->post['remarketing_facebook_currency'])) {
			$data['remarketing_facebook_currency'] = $this->request->post['remarketing_facebook_currency'];
		} else {
			$data['remarketing_facebook_currency'] = $this->config->get('remarketing_facebook_currency');
		}
		
		if (isset($this->request->post['remarketing_yml_currency'])) {
			$data['remarketing_yml_currency'] = $this->request->post['remarketing_yml_currency'];
		} else {
			$data['remarketing_yml_currency'] = $this->config->get('remarketing_yml_currency');
		}

		if (isset($this->request->post['remarketing_ecommerce_currency'])) {
			$data['remarketing_ecommerce_currency'] = $this->request->post['remarketing_ecommerce_currency'];
		} else {
			$data['remarketing_ecommerce_currency'] = $this->config->get('remarketing_ecommerce_currency');
		}

		if (isset($this->request->post['remarketing_reviews_status'])) {
			$data['remarketing_reviews_status'] = $this->request->post['remarketing_reviews_status'];
		} else {
			$data['remarketing_reviews_status'] = $this->config->get('remarketing_reviews_status');
		}

		if (isset($this->request->post['remarketing_google_merchant_identifier'])) {
			$data['remarketing_google_merchant_identifier'] = $this->request->post['remarketing_google_merchant_identifier'];
		} else {
			$data['remarketing_google_merchant_identifier'] = $this->config->get('remarketing_google_merchant_identifier');
		}
		
		if (isset($this->request->post['remarketing_reviews_feed_status'])) {
			$data['remarketing_reviews_feed_status'] = $this->request->post['remarketing_reviews_feed_status'];
		} else {
			$data['remarketing_reviews_feed_status'] = $this->config->get('remarketing_reviews_feed_status');
		}

		if (isset($this->request->post['remarketing_reviews_date'])) {
			$data['remarketing_reviews_date'] = $this->request->post['remarketing_reviews_date'];
		} else {
			$data['remarketing_reviews_date'] = $this->config->get('remarketing_reviews_date');
		}

		if (isset($this->request->post['remarketing_reviews_country'])) {
			$data['remarketing_reviews_country'] = $this->request->post['remarketing_reviews_country'];
		} else {
			$data['remarketing_reviews_country'] = $this->config->get('remarketing_reviews_country');
		}

		if (isset($this->request->post['remarketing_events_cart'])) {
			$data['remarketing_events_cart'] = $this->request->post['remarketing_events_cart'];
		} else {
			$data['remarketing_events_cart'] = $this->config->get('remarketing_events_cart');
		}

		if (isset($this->request->post['remarketing_events_cart_add'])) {
			$data['remarketing_events_cart_add'] = $this->request->post['remarketing_events_cart_add'];
		} else {
			$data['remarketing_events_cart_add'] = $this->config->get('remarketing_events_cart_add');
		}

		if (isset($this->request->post['remarketing_events_purchase'])) {
			$data['remarketing_events_purchase'] = $this->request->post['remarketing_events_purchase'];
		} else {
			$data['remarketing_events_purchase'] = $this->config->get('remarketing_events_purchase');
		}

		if (isset($this->request->post['remarketing_events_wishlist'])) {
			$data['remarketing_events_wishlist'] = $this->request->post['remarketing_events_wishlist'];
		} else {
			$data['remarketing_events_wishlist'] = $this->config->get('remarketing_events_wishlist');
		}

		if (isset($this->request->post['remarketing_ecommerce_status'])) {
			$data['remarketing_ecommerce_status'] = $this->request->post['remarketing_ecommerce_status'];
		} else {
			$data['remarketing_ecommerce_status'] = $this->config->get('remarketing_ecommerce_status');
		}
		
		if (isset($this->request->post['remarketing_ecommerce_ga4_status'])) {
			$data['remarketing_ecommerce_ga4_status'] = $this->request->post['remarketing_ecommerce_ga4_status'];
		} else {
			$data['remarketing_ecommerce_ga4_status'] = $this->config->get('remarketing_ecommerce_ga4_status');
		}

		if (isset($this->request->post['remarketing_ecommerce_measurement_status'])) {
			$data['remarketing_ecommerce_measurement_status'] = $this->request->post['remarketing_ecommerce_measurement_status'];
		} else {
			$data['remarketing_ecommerce_measurement_status'] = $this->config->get('remarketing_ecommerce_measurement_status');
		}

		if (isset($this->request->post['remarketing_ecommerce_selector'])) {
			$data['remarketing_ecommerce_selector'] = $this->request->post['remarketing_ecommerce_selector'];
		} elseif ($this->config->get('remarketing_ecommerce_selector')) {
			$data['remarketing_ecommerce_selector'] = $this->config->get('remarketing_ecommerce_selector');
		} else {
			$data['remarketing_ecommerce_selector'] = '.product-thumb';
		}
		
		if (isset($this->request->post['remarketing_ecommerce_ga4_selector'])) {
			$data['remarketing_ecommerce_ga4_selector'] = $this->request->post['remarketing_ecommerce_ga4_selector'];
		} elseif ($this->config->get('remarketing_ecommerce_ga4_selector')) {
			$data['remarketing_ecommerce_ga4_selector'] = $this->config->get('remarketing_ecommerce_ga4_selector');
		} else {
			$data['remarketing_ecommerce_ga4_selector'] = '.product-thumb';
		}
		
		if (isset($this->request->post['remarketing_ecommerce_measurement_selector'])) {
			$data['remarketing_ecommerce_measurement_selector'] = $this->request->post['remarketing_ecommerce_measurement_selector'];
		} elseif ($this->config->get('remarketing_ecommerce_measurement_selector')) {
			$data['remarketing_ecommerce_measurement_selector'] = $this->config->get('remarketing_ecommerce_measurement_selector');
		} else {
			$data['remarketing_ecommerce_measurement_selector'] = '.product-thumb';
		}

		if (isset($this->request->post['remarketing_ecommerce_id'])) {
			$data['remarketing_ecommerce_id'] = $this->request->post['remarketing_ecommerce_id'];
		} else {
			$data['remarketing_ecommerce_id'] = $this->config->get('remarketing_ecommerce_id');
		}
		
		if (isset($this->request->post['remarketing_ecommerce_ga4_id'])) {
			$data['remarketing_ecommerce_ga4_id'] = $this->request->post['remarketing_ecommerce_ga4_id'];
		} else {
			$data['remarketing_ecommerce_ga4_id'] = $this->config->get('remarketing_ecommerce_ga4_id');
		}
		
		if (isset($this->request->post['remarketing_ecommerce_measurement_id'])) {
			$data['remarketing_ecommerce_measurement_id'] = $this->request->post['remarketing_ecommerce_measurement_id'];
		} else {
			$data['remarketing_ecommerce_measurement_id'] = $this->config->get('remarketing_ecommerce_measurement_id');
		}

		if (isset($this->request->post['remarketing_ecommerce_analytics_id'])) {
			$data['remarketing_ecommerce_analytics_id'] = $this->request->post['remarketing_ecommerce_analytics_id'];
		} else {
			$data['remarketing_ecommerce_analytics_id'] = $this->config->get('remarketing_ecommerce_analytics_id');
		}

		if (isset($this->request->post['remarketing_counter1'])) {
			$data['remarketing_counter1'] = $this->request->post['remarketing_counter1'];
		} else {
			$data['remarketing_counter1'] = $this->config->get('remarketing_counter1');
		}

		if (isset($this->request->post['remarketing_counter2'])) {
			$data['remarketing_counter2'] = $this->request->post['remarketing_counter2'];
		} else {
			$data['remarketing_counter2'] = $this->config->get('remarketing_counter2');
		}

		if (isset($this->request->post['remarketing_counter3'])) {
			$data['remarketing_counter3'] = $this->request->post['remarketing_counter3'];
		} else {
			$data['remarketing_counter3'] = $this->config->get('remarketing_counter3');
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/remarketing.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/remarketing')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}