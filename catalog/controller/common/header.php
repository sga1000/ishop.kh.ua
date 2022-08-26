<?php

class ControllerCommonHeader extends Controller
{

	public function index() {
		// Analytics
		$this->load->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('analytics/' . $analytic['code']);
			}
		}

		if ($this->request->server['HTTPS']) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
		}

		/* NeoSeo SEO Languages - begin */
		if( !$this->model_module_neoseo_seo_languages ) {
			$this->load->model("module/neoseo_seo_languages");
		}
		$data = $this->model_module_neoseo_seo_languages->processCommonHeader($data);
		/* NeoSeo SEO Languages - end */

		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();


		/* NeoSeo Callback - begin */
		if (!file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/neoseo_callback.scss')) {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/neoseo_callback.css')) {
				$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/neoseo_callback.css');
			} else {
				$this->document->addStyle('catalog/view/theme/default/stylesheet/neoseo_callback.css');
			}
		}
		$data['neoseo_callback_status'] = $this->config->get('neoseo_callback_status');
		/* NeoSeo Callback - end */


		/* NeoSeo Product Labels - begin */
		if (!file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/neoseo_product_labels.scss')) {
			if (file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/neoseo_product_labels.css')) {
				$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/neoseo_product_labels.css');
			} else {
				$this->document->addStyle('catalog/view/theme/default/stylesheet/neoseo_product_labels.css');
			}
		}
		/* NeoSeo Product Labels - end */


		/* NeoSeo Product QuickView - begin */

		if (!file_exists('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/neoseo_product_quickview.scss')) {
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/neoseo_product_quickview.css')) {
				$this->document->addStyle('catalog/view/theme/' . $this->config->get('config_template') . '/stylesheet/neoseo_product_quickview.css');
			} else {
				$this->document->addStyle('catalog/view/theme/default/stylesheet/neoseo_product_quickview.css');
			}
		}
		/* NeoSeo Product QuickView - end */

		/* NeoSeo QuickOrder - begin */
		if (!file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/stylesheet/neoseo_quick_order.scss')) {
			$this->document->addStyle('catalog/view/theme/default/stylesheet/neoseo_quick_order.css');
		}
		/* NeoSeo QuickOrder - end */


		$data['styles'] = $this->document->getStyles();

		/* NeoSeo Callback - begin */
		$this->document->addScript('catalog/view/javascript/neoseo_callback.js');
		/* NeoSeo Callback - end */


		/* NeoSeo Popup Cart - begin */
		$this->document->addScript('catalog/view/javascript/neoseo_popup_cart.js');
		/* NeoSeo Popup Cart - end */


		/* NeoSeo Popup Compare - begin */
		if ($this->config->get('neoseo_popup_compare_status') == 1) {
			$this->document->addScript('catalog/view/javascript/neoseo_popup_compare.js');
		}
		/* NeoSeo Popup Compare - end */

		/* NeoSeo Popup Wishlist - begin */
		if ($this->config->get('neoseo_popup_wishlist_status') == 1) {
			$this->document->addScript('catalog/view/javascript/neoseo_popup_wishlist.js');
		}
		/* NeoSeo Popup Wishlist - end */

		/* NeoSeo Product QuickView - begin */
		if ($this->config->get('neoseo_product_quickview_status') == 1) {
			$this->document->addScript('catalog/view/javascript/neoseo_product_quickview.js');
		}
		/* NeoSeo Product QuickView - end */

		/* NeoSeo QuickOrder - begin */
		$this->document->addScript('catalog/view/javascript/neoseo_quick_order.js');
		$this->document->addScript('catalog/view/javascript/jquery/jquery.validation/jquery.validate.min.js');
		$this->document->addScript('catalog/view/javascript/jquery/jquery.maskedinput.min.js');
		$this->document->addScript('catalog/view/javascript/jquery/jquery.validation/additional-methods.min.js');
		if ($this->config->get('config_language') === 'en' || $this->config->get('config_language') === 'en-gb') {
			$this->document->addScript('catalog/view/javascript/jquery/jquery.validation/localization/messages_en.js');
		} elseif ($this->config->get('config_language') === 'ua' || $this->config->get('config_language') === 'uk') {
			$this->document->addScript('catalog/view/javascript/jquery/jquery.validation/localization/messages_uk.js');
		} else {
			$this->document->addScript('catalog/view/javascript/jquery/jquery.validation/localization/messages_ru.js');
		}
		/* NeoSeo QuickOrder - end */
		$data['scripts'] = $this->document->getScripts();
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');

		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo_sizes'] = getimagesize(DIR_IMAGE . $this->config->get('config_logo'));
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo_sizes'] = array(0,0);
			$data['logo'] = '';
		}

		$this->load->language('common/header');
		$data['og_url'] = (isset($this->request->server['HTTPS']) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI']) - 1));
		$data['og_image'] = $this->document->getOgImage();

		$data['text_home'] = $this->language->get('text_home');

		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');

			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
		} else {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		}

		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));

		if ($this->customer->isLogged()) {
			$data['text_please_login'] = sprintf($this->language->get('text_please_logined'), $this->customer->getFirstName());
		} else {
			$data['text_please_login'] = $this->language->get('text_please_login');
		}


		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');
		$data['text_page'] = $this->language->get('text_page');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');
		$data['text_menu'] = $this->language->get('text_menu');
		$data['text_all_categories'] = $this->language->get('text_all_categories');
		$data['text_hide'] = $this->language->get('text_hide');
		$data['text_fonts'] = $this->language->get('text_fonts');
		$data['text_contact_phones'] = $this->language->get('text_contact_phones');
		$data['text_contact_worktime'] = $this->language->get('text_contact_worktime');
		$data['text_call_center'] = $this->language->get('text_call_center');
		$data['text_catalog'] = $this->language->get('text_catalog');

		// Text mobile
		$data['text_currency_mobile'] = $this->language->get('text_currency_mobile');
		$data['text_wishlist_mobile'] = $this->language->get('text_wishlist_mobile');
		$data['text_compare_mobile'] = $this->language->get('text_compare_mobile');
		$data['text_cart_mobile'] = $this->language->get('text_cart_mobile');
		$data['text_callback_2'] = $this->language->get('text_callback_2');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', 'SSL');
		$data['register'] = $this->url->link('account/register', '', 'SSL');
		$data['login'] = $this->url->link('account/login', '', 'SSL');
		$data['order'] = $this->url->link('account/order', '', 'SSL');
		$data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$data['download'] = $this->url->link('account/download', '', 'SSL');
		$data['logout'] = $this->url->link('account/logout', '', 'SSL');
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] = $this->config->get('config_telephone');


		$status = true;

		if (isset($this->request->server['HTTP_USER_AGENT'])) {
			$robots = explode("\n", str_replace(array("\r\n", "\r"), "\n", trim($this->config->get('config_robots'))));

			foreach ($robots as $robot) {
				if ($robot && strpos($this->request->server['HTTP_USER_AGENT'], trim($robot)) !== false) {
					$status = false;

					break;
				}
			}
		}

		// Menu
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = array(); // $this->model_catalog_category->getCategories(0); /* By NeoSeo UniSTOR */;

		$data['language'] = $this->load->controller('common/language');
		/* NeoSeo UniSTOR - begin */
		$this->load->model('module/neoseo_unistor');
		$data = $this->model_module_neoseo_unistor->processHeaderData($data);
		/* NeoSeo UniSTOR - end */
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');

		// For page specific css
		$data['is_home']= false;
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} else {
				$class = '';
				if ($this->request->get['route'] == 'common/home') {
					$data['is_home']= true;
				}
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
			$data['is_home']= true;
		}

		/* NeoSeo Informative Message - begin */
		$data['neoseo_informative_message_status'] = $this->config->get('neoseo_informative_message_status');
		$data['neoseo_informative_message_show_close_button'] = $this->config->get('neoseo_informative_message_show_close_button');
		$neoseo_informative_message = $this->config->get('neoseo_informative_message_text');
		$neoseo_informative_message_button = $this->config->get('neoseo_informative_message_close_button_text');
		$config_language_id = $this->config->get('config_language_id') ? $this->config->get('config_language_id') : 1;
		$data['neoseo_informative_message_bg_color'] = $this->config->get('neoseo_informative_message_color_background');
		$data['neoseo_informative_message_close_btn_color'] = $this->config->get('neoseo_informative_message_color_close_button');
		if (!isset($this->session->data['neoseo_informative_message'])) {
			$data['neoseo_informative_message'] = html_entity_decode($neoseo_informative_message[$config_language_id]);
		} else {
			$data['neoseo_informative_message'] = '';
		}
		$data['neoseo_informative_message_button'] = html_entity_decode($neoseo_informative_message_button[$config_language_id]);
		/* NeoSeo Informative Message - end */

		$this->load->language('module/neoseo_menu');
		$data['button_cart'] = $this->language->get('button_cart');

		/* Wide screen style BEGIN */
		$data['use_wide_style'] = $this->config->get("neoseo_unistor_use_wide_style");
		/* Wide screen style ENd */		/* Wide screen style ENd */

		$data['currency_status'] = $this->config->get('neoseo_unistor_top_currency_status');

		// Шаблон хедера
		$template = $this->config->get('neoseo_unistor_header_type');
		$data['type_header'] = $this->config->get('neoseo_unistor_header_type');

		// Вытягиваем информацию из ЮниСТОРА
		$data['text_header_information'] = '';
		$header_information = $this->config->get('neoseo_unistor_header_information');
		foreach ($header_information as $key => $value) {
			if ((int)$key !== (int)$this->config->get('config_language_id')) continue;
			$data['text_header_information']  = $value;
		}

		$data['menu_class_type'] = 'main-menu';
		if ($this->config->get('neoseo_unistor_header_type') === 'header.type-2') {
            $data['menu_class_type'] = 'menu-type-2';
        }

        $data['menu_type'] = $this->config->get("neoseo_unistor_menu_main_type");
		
        $data['sticky'] = $this->load->view($this->config->get('config_template').'/template/common/'.$this->config->get("neoseo_unistor_sticky_menu_type"). '.tpl', $data);
        $data['menu'] = $this->load->view($this->config->get('config_template').'/template/common/'.$this->config->get("neoseo_unistor_menu_main_type"). '.tpl', $data);
        $data['mobile_header'] = $this->load->view($this->config->get('config_template') . '/template/common/'.$this->config->get("neoseo_unistor_header_mobile_type").'.tpl', $data);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/' . $template . '.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/' . $template . '.tpl', $data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $data);
		}
	}

}

