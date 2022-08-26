<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoSeoUnistor extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->registry = $registry;
		$this->_moduleName = "NeoSeo ЮниСТОР";
		$this->_moduleSysName = "neoseo_unistor";
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

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {

			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			if (!$this->saveVars($this->request->post)) {
				$this->session->data['error_warning'] = 'Не удалось сохранить файл настроек темы';
			} else {
				$this->session->data['success'] = $this->language->get('text_success');
			}

			if (isset($this->request->get['close'])) {
				$this->response->redirect($this->url->link('extension/' . $this->_route, 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link($this->_route . '/neoseo_unistor', 'token=' . $this->session->data['token'], 'SSL'));
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
			array("extension/" . $this->_route, "text_module"),
			array($this->_route . "/" . $this->_moduleSysName, "heading_title_raw")
		), $data);

		$data = $this->initButtons($data);


		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();
		$data['languages'] = $languages;

		$data[$this->_moduleSysName . '_products'] = array();
		$data[$this->_moduleSysName . '_categories'] = array();
		$data[$this->_moduleSysName . '_manufacturers'] = array();
		$data[$this->_moduleSysName . '_articles'] = array();

		$this->load->model($this->_route . "/" . $this->_moduleSysName);
		$data = $this->initParamsListEx($this->{"model_" . $this->_route . "_" . $this->_moduleSysName}->params, $data);

		$data['db'] = $this->db;
		$this->load->model('tool/image');
		$data['placeholder'] = $this->model_tool_image->resize('placeholder.png', 100, 100);
		if (file_exists(DIR_IMAGE . $data[$this->_moduleSysName . '_general_background_image']) && is_file(DIR_IMAGE . $data[$this->_moduleSysName . '_general_background_image'])) {
			$data['general_background_image_thumb'] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_general_background_image'], 100, 100);
		} else {
			$data['general_background_image_thumb'] = $this->model_tool_image->resize('placeholder.png', 100, 100);
		}

		if (file_exists(DIR_IMAGE . $data[$this->_moduleSysName . '_header_background_image']) && is_file(DIR_IMAGE . $data[$this->_moduleSysName . '_header_background_image'])) {
			$data['header_background_thumb'] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_header_background_image'], 100, 100);
		} else {
			$data['header_background_thumb'] = $this->model_tool_image->resize('placeholder.png', 100, 100);
		}

		if (file_exists(DIR_IMAGE . $data[$this->_moduleSysName . '_sticky_menu_image']) && is_file(DIR_IMAGE . $data[$this->_moduleSysName . '_sticky_menu_image'])) {
			$data['sticky_box_background_thumb'] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_sticky_menu_image'], 100, 100);
		} else {
			$data['sticky_box_background_thumb'] = $this->model_tool_image->resize('placeholder.png', 100, 100);
		}

		$this->load->model('catalog/category');
		$data['categories'] = $this->model_catalog_category->getCategories(0);

		$this->load->model('catalog/manufacturer');
		$results = $this->model_catalog_manufacturer->getManufacturers();
		$data['manufacturers'] = array();
		foreach ($results as $result) {
			$data['manufacturers'][] = array(
				'id' => $result['manufacturer_id'],
				'name' => $result['name']
			);
		}

		$this->load->model('catalog/information');
		$results_info = $this->model_catalog_information->getInformations();
		$data['informations'] = array();
		foreach ($results_info as $result) {
			$data['informations'][] = array(
				'id' => $result['information_id'],
				'title' => $result['title']
			);
		}

		$this->load->model('catalog/attribute');
		$attributes = $this->model_catalog_attribute->getAttributes();
		$data['attributes'] = array();
		foreach ($attributes as $attribute) {
			$data['attributes'][$attribute['attribute_id']] = $attribute['name'];
		}

		if ($this->config->get('neoseo_menu_status')) {
			$this->load->model('module/neoseo_menu');
			$menus = $this->model_module_neoseo_menu->getMenus();
			if ($menus) {
				foreach ($menus as $menu) {
					$data['menus'][$menu['menu_id']] = $menu['title'];
				}
			}
		} else {
			$data['menus'] = array( $this->language->get('text_default') );
		}


		$data['maps'] = array(
			'none' => $this->language->get('text_disabled'),
			'google' => $this->language->get('text_google'),
			'yandex' => $this->language->get('text_yandex'),
		);


		$data[$this->_moduleSysName . '_attributes_title'] = $data[$this->_moduleSysName . '_attributes_title'] ? $data[$this->_moduleSysName . '_attributes_title'] : array();
		$data[$this->_moduleSysName . '_colors_status'] = $data[$this->_moduleSysName . '_colors_status'] ? $data[$this->_moduleSysName . '_colors_status'] : $colors_status;


		$data['token'] = $this->session->data['token'];

		$data["logs"] = $this->getLogs();

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('localisation/stock_status');
		$stock_statuses = $this->model_localisation_stock_status->getStockStatuses();
		$data['stock_statuses'] = array();
		foreach ($stock_statuses as $status) {
			$data['stock_statuses'][$status['stock_status_id']] = $status['name'];
		}

		$data['current_lang'] = (int) $this->config->get('config_language_id');

		$data['header_type'] = array (
			'header' => $this->language->get('entry_header_type_1'),
			'header.type-2' => $this->language->get('entry_header_type_2')
		);

		$data['fonts'] = array (
			'Roboto' => 'Roboto',
			'OpenSans' => 'OpenSans',
			'Montserrat' => 'Montserrat',
			'RobotoCondensed' => 'RobotoCondensed',
			'RobotoSlab' => 'RobotoSlab',
			'SourceSansPro' => 'SourceSansPro',
			'Merriweather' => 'Merriweather',
			'Oswald' => 'Oswald',
			'Yanone' => 'Yanone',
		);

		$data['schemes'] = array (
			'default' => $this->language->get('text_default'),
			'yellow' => $this->language->get('text_scheme_1'),
			'red' => $this->language->get('text_scheme_2'),
			'orange' => $this->language->get('text_scheme_3'),
			'green' => $this->language->get('text_scheme_4'),
			'purple' => $this->language->get('text_scheme_5'),
			'indigo' => $this->language->get('text_scheme_6'),
			'blue' => $this->language->get('text_scheme_7'),
			'black' => $this->language->get('text_scheme_8')
		);

		$data['menus_type'] = array (
			'menu_horizontal'           => $this->language->get('text_horizontal'),
			'menu_vertical'             => $this->language->get('text_vertical'),
			'menu_hybrid'               => $this->language->get('text_hybrid'),
		);

		$data['header_mobile_types'] = array (
			'header_mobile'           => $this->language->get('entry_header_type_1'),
			'header_mobile.type-2'    => $this->language->get('entry_header_type_2'),
		);

		$this->load->model('tool/image');
		foreach ($languages as $language) {
			if (file_exists(DIR_IMAGE . $data[$this->_moduleSysName . '_logo'][$language['language_id']]) && is_file(DIR_IMAGE . $data[$this->_moduleSysName . '_logo'][$language['language_id']])) {
				$data[$this->_moduleSysName . '_logo_img'][$language['language_id']] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_logo'][$language['language_id']], 100, 100);
			} else {
				$data[$this->_moduleSysName . '_logo_img'][$language['language_id']] = $this->model_tool_image->resize('no_image.png', 100, 100);
			}
		}

		$data[$this->_moduleSysName . '_banner'] = $this->config->get($this->_moduleSysName . '_top_banner_image');
		foreach ($languages as $language) {
			if (isset($data[$this->_moduleSysName . '_banner'][$language['language_id']]) && file_exists(DIR_IMAGE . $data[$this->_moduleSysName . '_banner'][$language['language_id']]) && is_file(DIR_IMAGE . $data[$this->_moduleSysName . '_banner'][$language['language_id']])) {
				$data[$this->_moduleSysName . '_banner_img'][$language['language_id']] = $this->model_tool_image->resize($data[$this->_moduleSysName . '_banner'][$language['language_id']], 1114, 30);
			} else {
				$data[$this->_moduleSysName . '_banner_img'][$language['language_id']] = $this->model_tool_image->resize('no_image.png', 1114, 30); // @todo:поставить нормальные размеры
			}
		}
		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		$this->document->addScript('view/javascript/bootstrap-colorpicker/js/bootstrap-colorpicker.js');
		$this->document->addStyle('view/javascript/bootstrap-colorpicker/css/bootstrap-colorpicker.css');
		$this->document->addScript('view/javascript/jquery/coloring-pick/jquery.coloring-pick.min.js');
		$this->document->addStyle('view/javascript/jquery/coloring-pick/jquery.coloring-pick.min.js.css');

		$data['ckeditor'] = $this->config->get('config_editor_default');
		if ($this->config->get('config_editor_default')) {
			$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
			$this->document->addScript('view/javascript/ckeditor/ckeditor_init.js');
		}
		$this->load->model('tool/neoseo_unistor');
		$data['template_prefix'] = $this->model_tool_neoseo_unistor->getTemplatePrefixes();
		$data['params'] = $data;
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view($this->_route . '/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function saveVars($params)
	{
		$scssStyleSheetVars = DIR_CATALOG . 'view/theme/neoseo_unistor/stylesheet/neoseo_unistor_parameters.scss';
		$content = file_get_contents($scssStyleSheetVars);
		$coloursNameVars = array(
			'checkbox_color' => 'checkbox-color',
			'footer_bottom_background' => 'footer-bottom-background-color',
			'footer_bottom_color' => 'footer-bottom-color',
			'footer_bottom_link_hover_color' => 'footer-bottom-links-hover-color',
			'footer_top_background' => 'footer-background-color',
			'footer_top_color' => 'footer-main-color',
			'color_footer_links' => 'footer-links-color',
			'footer_top_link_hover_color' => 'footer-links-hover-color',
			'color_headers' => 'header-color',
			'link_color' => 'a-color',
			'link_hover_color' => 'a-hover-color',
			'color_main' => 'body-color',
			'general_background_color' => 'body-background-color',
			'title_color' => 'title-color',
			'text_color' => 'text-color',
			'header_icon_color' => 'header-icon-color',
			'header_phones_color' => 'header_phones_color',
			'header_worktime_color' => 'header_worktime_color',
			'header_cart_total_color' => 'header_cart_total_color',
			'sticky_menu_icon_color' => 'sticky-icon-color',
			'menu_main_text_color' => 'menu-nav-color',
			'menu_main_text_hover_color' => 'menu-nav-hover-color',
			'menu_main_text_active_color' => 'menu-nav-color-active',
			'color_required' => 'required-color',
			'button_color' => 'button-color',
			'top_banner_background' => 'top-banner-color',
			'top_menu_background' => 'top-menu-background-color',
			'top_menu_hover_color' => 'top-menu-hover-color',
			'module_title_color' => 'module-title-color',
			'module_border_color' => 'module-border-color',
			'module_border_color_hover' => 'module-border-color-hover',
			'comments_bg_color' => 'comments-background-color',
			'comments_reply_color' => 'comment-reply-color',
			'currency_color' => 'currency-color',
			'currency_color_hover' => 'currency-hover-color',
			'currency_active_color' => 'currency-active-color',
			'currency_active_color_hover' => 'currency-active-hover-color',
			'currency_bg' => 'currency-background',
			'currency_bg_hover' => 'currency-hover-background',
			'currency_active_bg_hover' => 'currency-active-hover-background',
			'currency_active_bg' => 'currency-active-background',
			'entry_meta_a_color' => 'entry-meta-a-color',
			'go_to_top_color' => 'go-top-color',
			'gradient_top_color' => 'gradient-top-color',
			'gradient_bottom_color' => 'gradient-bottom-color',
			'language_active_bg' => 'language-active-background',
			'left_menu_bg_color' => 'left-menu-background-color',
			'left_menu_links_color' => 'left-menu-links-color',
			'left_menu_links_hover_color' => 'left-menu-links-hover-color',
			'main_menu_height' => 'menu-height',
			'menu_main_bg_color' => 'main-background-color',
			'menu_main_bg_hover_color' => 'menu-nav-background-hover-color',
			'menu_main_bg_active_color' => 'main-background-color-active',
			'menu_border_color' => 'menu_border_color',
			'menu_border_link_color' => 'menu_border_link_color',
			'price_color' => 'price-color',
			'price_new_color' => 'price-new-color',
			'price_old_color' => 'price-old-color',
			'price_tax_color' => 'price-tax-color',
			'product_border_color' => 'product-border-color',
			'ocfilter_optname_color' => 'ocfilter-optname-color',
			'ocfilter_select_options_color' => 'ocfilter-select-options-color',
			'ocfilter_head_color' => 'ocfilter-head-color',
			'read_more_color' => 'read-more-color',
			'read_more_hover_color' => 'read-more-hover-color',
			'search_item_price_color' => 'search-item-price-color',
			'search_footer_color' => 'search-footer-color',
			'tab_bg_color' => 'tab-background-color',
			'tab_border_color' => 'tab-border-color',
			'top_menu_border_color' => 'top-menu-border-color',
			'top_menu_account_bg' => 'top-menu-account-bg',
			'top_menu_account_color' => 'top-menu-account-color',
			'top_menu_color' => 'top-menu-color',
			'header_background_color' => 'header_background_color',
			'sticky_menu_background' => 'sticky_menu_background',
			'sticky_menu_color' => 'sticky-box-font-color',
			'sticky_phones_color' => 'sticky_phones_color',
			'sticky_cart_total_color' => 'sticky_cart_total_color',
			'product_title_height' => 'product-title-height',
			'module_background_color' => 'module-background-color',
			'button_color_hover' => 'button-color-hover',
			'tab_color_active' => 'tab-color-active',
			'tab_color_hover' => 'tab-color-hover',
			'tab_text_color_hover' => 'tab-text-color-hover',
			'tab_text_color_active' => 'tab-text-color-active',
			'button_color_text' => 'button-color-text',
			'product_thumb_icon_color' => 'product-thumb-icon-color',

			'preview_button_color' => 'preview_button_color',
			'preview_button_color_text' => 'preview_button_color_text',
			'preview_button_color_hover' => 'preview_button_color_hover',
			'preview_button_color_text_hover' => 'preview_button_color_text_hover',

			'product_button_color' => 'product_button_color',
			'product_button_color_text' => 'product_button_color_text',
			'product_button_color_hover' => 'product_button_color_hover',
			'product_button_color_text_hover' => 'product_button_color_text_hover',

			'body_font' => 'body-font',

			'button_color_text_hover' => 'button-color-text-hover',
			'go_top_background' => 'go-top-background',
			'go_top_color' => 'go-top-color',
			'pagination_background' => 'pagination-background',
			'pagination_background_hover' => 'pagination-background-hover',
			'pagination_color' => 'pagination-color',
			'pagination_color_hover' => 'pagination-color-hover',
			'pagination_background_active' => 'pagination-background-active',
			'pagination_color_active' => 'pagination-color-active',
			'go_top_background_hover' => 'go-top-background-hover',
			'go_top_color_hover' => 'go-top-color-hover',
			'tab_color' => 'tab-color',
			'tab_text_color' => 'tab-text-color',
			'menu_sub_bg_color' => 'menu-sub-background-color',
			'menu_sub_bg_hover_color' => 'menu-sub-background-hover-color',
			'menu_sub_bg_active_color' => 'menu-sub-background-color-active',
			'menu_sub_text_color' => 'menu-sub-nav-color',
			'menu_sub_text_hover_color' => 'menu-sub-nav-hover-color',
			'menu_sub_text_active_color' => 'menu-sub-text-color-active',

			'mobile_header_bg_color'						  => 'mobile-header-bg-color',
			'mobile_header_icon_color'						=> 'mobile-header-icon-color',
			'mobile_header_total_color'					   => 'mobile-header-total-color',
			'mobile_header_menu_currency_color'			   => 'mobile-header-menu-currency-color',
			'mobile_header_menu_currency_active_color'		=> 'mobile-header-menu-currency-active-color',
			'mobile_header_menu_text_color'				   => 'mobile-header-menu-text-color',
			'mobile_header_menu_icon_color'				   => 'mobile-header-menu-icon-color',
			'mobile_header_menu_total_color'				  => 'mobile-header-menu-total-color'
		);

		$this->load->model($this->_route . '/' . $this->_moduleSysName);
		foreach ($coloursNameVars as $param => $name) {
			if (!empty($params[$this->_moduleSysName . '_' . $param])) {
				$param_value = $params[$this->_moduleSysName . '_' . $param];
			} else {
				continue;
			}

			$patt = '~\$' . $name . ':[\s]*[#\w]*;~us';
			$content = preg_replace($patt, '$' . $name . ': ' . $param_value . ';', $content);
		}

		// ищем повторно цвета, только теперь в rgb
		foreach ($coloursNameVars as $param => $name) {
			if (!empty($params[$this->_moduleSysName . '_' . $param])) {
				$param_value = $params[$this->_moduleSysName . '_' . $param];
			} else {
				continue;
			}

			$patt = '~\$' . $name . ':[\s]*[rgb(\w)\((\d{1,3}),(\d{1,3}),(\d{1,3}))\)]*;~us';
			$content = preg_replace($patt, '$' . $name . ': ' . $param_value . ';', $content);

			$patt_rgba = '~\$' . $name . ':[\s]*[rgba(\w)\((\d{1,3}),(\d{1,3}),(\d{1,3}),(\d{1,3.}))\)]*;~us';
			$content = preg_replace($patt_rgba, '$' . $name . ': ' . $param_value . ';', $content);
		}


		// ищем повторно цвета, только теперь в gradient
		foreach ($coloursNameVars as $param => $name) {
			if (!empty($params[$this->_moduleSysName . '_' . $param])) {
				$param_value = $params[$this->_moduleSysName . '_' . $param];
			} else {
				continue;
			}

			$patt_gradient = '~\$' . $name . ':[\s]*linear-gradient\(([^;]*)\);~us';
			$content = preg_replace($patt_gradient, '$' . $name . ': ' . $param_value . ';', $content);

		}

		$sizes = array(
			'body_font_size' => 'body-font-size',
			'top_banner_height' => 'top-banner-height',
			"top_header_height" => 'top-header-height',
			'top_menu_height' => 'top-menu-height',
			'top_menu_font_size' => 'top-menu-font-size',
			'breadcrumbs_font_size' => 'breadcrumbs-font-size',
			"menu_main_height" => 'menu_height',
			"menu_main_font_size" => 'menu-main-font-size',
			"menu_sub_font_size" => 'menu-sub-font-size',
			"menu_main_icon_height" => 'menu-main-icon-height',
			"menu_sub_icon_height" => 'menu-sub-icon-height',
			'left_menu_root_font_size' => 'left-menu-root-font-size',
			'product_grid_title' => 'product-grid-title',
			'product_list_title' => 'product-list-title',
			'product_list_image_width' => 'product-list-image-width',
			'product_list_description_font_size' => 'product-list-description-size',
			'product_label_font_size' => 'product-label-font-size',
			'entry_meta_font_size' => 'entry-meta-font-size',
			'entry_meta_fa_font_size' => 'entry-meta-fa-font-size',
			'comment_author_font_size' => 'comment-author-font-size',
			'comment_date_font_size' => 'comment-date-font-size',
			'search_item_price_font_size' => 'search-item-price-font-size',
			'search_item_description_font_size' => 'search-item-description',
		);

		foreach ($sizes as $param => $size) {
			if (!empty($params[$this->_moduleSysName . '_' . $param])) {
				$param_value = $params[$this->_moduleSysName . '_' . $param];
			} elseif (empty($params_defaults[$param])) {
				continue;
			} else {
				$param_value = $params_defaults[$param];
			}

			$content = preg_replace('~\$' . $size . ':[\s]*[\w]*px;~us', '$' . $size . ': ' . $param_value . "px;", $content);
		}

		$other_params = array(
			'menu_main_font_family' => 'menu-main-font-family',
			'menu_sub_font_family' => 'menu-sub-font-family',
			'breadcrumbs_font_style' => 'breadcrumbs-font-style'
		);

		foreach ($other_params as $param => $var) {
			if (!empty($params[$this->_moduleSysName . '_' . $param])) {
				$param_value = $params[$this->_moduleSysName . '_' . $param];
			} elseif (empty($params_defaults[$param])) {
				continue;
			} else {
				$param_value = $params_defaults[$param];
			}

			$content = preg_replace('~\$' . $var . ':[\s]*[\w.,]*;~us', '$' . $var . ': ' . $param_value . ";", $content);
		}

		if ($params['neoseo_unistor_general_style'] == 2) {
			$content = preg_replace('~\$type:[\s]*[\w]*;~us', '$type: gradient;', $content);
		} else if ($params['neoseo_unistor_general_style'] == 0) {
			$content = preg_replace('~\$type:[\s]*[\w]*;~us', '$type: flat;', $content);
		} else {
			$content = preg_replace('~\$type:[\s]*[\w]*;~us', '$type: 3d;', $content);
		}


		if ($params["neoseo_unistor_general_background_image"]!="") {
			$general_background_image = "/image/" . $params["neoseo_unistor_general_background_image"];
			$content = preg_replace('~\$background_image:[\s]*\'[^\']*\';~us', '$' . "background_image: '$general_background_image';", $content);

		} else {
			$bg_search = "background-image: url(" . "$" . "background_image);";
			$content = str_replace($bg_search, "", $content);
		}

		if ($params["neoseo_unistor_header_background_image"]) {
			$header_background_image = "/image/" . $params["neoseo_unistor_header_background_image"];
			$content = preg_replace('~\$header_background_image:[\s]*\'[^\']*\';~us', '$' . "header_background_image: '$header_background_image';", $content);
		} else {
			$bg_search = "background-image: url(" . "$" . "header_background_image);";
			$content = str_replace($bg_search, "", $content);
		}

		if ($params["neoseo_unistor_sticky_menu_image"]) {
			$sticky_menu_image = "/image/" . $params["neoseo_unistor_sticky_menu_image"];
			$content = preg_replace('~\$sticky_menu_image:[\s]*\'[^\']*\';~us', '$' . "sticky_menu_image: '$sticky_menu_image';", $content);
		} else {
			$bg_search = "background-image: url(" . "$" . "sticky_menu_image);";
			$content = str_replace($bg_search, "", $content);
		}

		if (!file_put_contents($scssStyleSheetVars, $content)) {
			$this->log("Не удалось сохранить файл с параметрами стилей: $scssStyleSheetVars");
			return false;
		}


		//собираем все файлы scss
		$mask = DIR_CATALOG . 'view/theme/neoseo_unistor/stylesheet/*.scss';
		$additional = glob($mask);
		$main_scss = array(
			'neoseo_unistor.scss',
			'neoseo_unistor_parameters.scss',
			'neoseo_unistor_header.scss',
			'neoseo_unistor_footer.scss',
			'neoseo_unistor_main_menu.scss',
			'neoseo_unistor_checkboxes.scss',
			'neoseo_unistor_sticky_menu.scss',
			'neoseo_unistor_additional.scss',
		);

		$contentAdditionalStyle = '// Neoseo Modules Styles' . "\n";

		foreach ($additional as $scss_file) {
			$scss_file = basename($scss_file);
			if (!in_array($scss_file, $main_scss)) {
				$contentAdditionalStyle .= '@import "' . $scss_file . '";' . "\n";
			}
		}

		$scssAdditionalStyle = DIR_CATALOG . 'view/theme/neoseo_unistor/stylesheet/neoseo_unistor_additional.scss';
		if (!file_put_contents($scssAdditionalStyle, $contentAdditionalStyle)) {
			$this->log("Не удалось сохранить файл со списком стилей: $scssAdditionalStyle");
			return false;
		}



		$mask = DIR_CATALOG . 'view/theme/neoseo_unistor/stylesheet/stylesheet-*.css';
		array_map('unlink', glob($mask));

		// Альтернатива с поддержкой source-map
		// https://github.com/leafo/scssphp/tree/wip/source-maps
		$file = DIR_CATALOG . 'view/theme/neoseo_unistor/stylesheet/stylesheet-' . time() . '.css';
		$scss = new Scssc();
		$scss->setImportPaths(DIR_CATALOG . 'view/theme/neoseo_unistor/stylesheet/');
		try {
			$output = $scss->compile('@import "neoseo_unistor.scss"');
		} catch (Exception $e) {
			$this->log("Не удалось выполнить компиляцию: " . $e->getMessage());
			return false;
		}
		$output = preg_replace('/\/\*.*?\*\//ms', '', $output);
		if (!file_put_contents($file, $output)) {
			$this->log("Не удалось сохранить скомпилированный файл стиля: $file");
			return false;
		}

		if ($params[$this->_moduleSysName . '_personal_css']) {
			if (!file_put_contents($file, $params[$this->_moduleSysName . '_personal_css'], FILE_APPEND)) {
				$this->log("Не удалось записать персональный стиль в файл: $file");
				return false;
			}
		}

		return true;
	}



	private function validate()
	{
		if (!$this->user->hasPermission('modify', $this->_route . '/neoseo_unistor')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}

	public function deleteDemoData()
	{
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('is_demo_data', array('is_demo_data_removed' => 1));

		$this->load->model('module/'.$this->_moduleSysName());
		$this->{'model_module_'.$this->_moduleSysName()}->deleteDemoData();

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode(array('msg' => 'ok')));
	}

	public function muteDemoData()
	{
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('is_demo_data', array('is_demo_data_removed' => 1));
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode(array('msg' => 'ok')));

	}

}
