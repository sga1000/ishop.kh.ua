<?php

require_once( DIR_SYSTEM . "/engine/neoseo_model.php");

class ModelModuleNeoSeoUnistor extends NeoSeoModel
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleName = "";
		$this->_moduleSysName = "neoseo_unistor";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;


		$this->load->model('localisation/language');
		$languages = $this->model_localisation_language->getLanguages();
		$work_time = array();
		$delivery = array();
		$guarantee = array();
		$logo = array();
		$top_banner_image = array();
		$top_banner_link = array();
		$footer_sections = array();
		$footer_column_names = array();
		$footer_column_texts = array();
		$recent_search = array();
		$contact_section_names = array();
		$contact_section_texts = array();
		$general_sharing_code = array();
        $header_information = array();
		foreach ($languages as $language) {
			$general_sharing_code[$language['language_id']] = '
				<div id="share" class="share-top"></div>
				<script>
					$("#share").jsSocials({
						showLabel: true,
						shareIn: "popup",
						shares: ["twitter", "facebook", "googleplus"]
					});
				</script>
			';
            $header_information[$language['language_id']] = 'Бесплатная доставка по украине';

			$work_time[$language['language_id']] = 'Пн-Пт: с 9.00 - 19.00, Сб: с 9.00 - 15.00, Вс: выходной';
			$delivery[$language['language_id']] = '<h4><span style="font-size:16px;"><a href="/informatsiya-o-dostavke">Способы доставки:</a></span></h4>
													<ul>
														<li>Самовывоз</li>
														<li>Доставка курьером</li>
														<li><img alt="" src="https://silkworm.com.ua/image/catalog/demo/manufacturers/novaposhta.png" style="width: 28px; height: 28px;" />&nbsp;Нова Пошта</li>
														<li>Доставка Укрпочтой</li>
														<li>Автолюкс</li>
														<li>ИнТайм&nbsp;</li>
													</ul>';

			$payment[$language['language_id']] = '<h4><span style="font-size:16px;"><a href="/informatsiya-o-dostavke">Способы оплаты:</a></span></h4>
													<ul>
														<li>Наличными (только для Киева)</li>
														<li><img alt="" src="https://silkworm.com.ua/image/catalog/demo/manufacturers/privat_bank.jpg" style="width: 26px; height: 26px;" />&nbsp;ПриватБанк</li>
														<li>Наложенный платеж&nbsp;(при получении)</li>
														<li>Оплата банковской картой Visa, Mastercard</li>
														<li>Оплата картой Visa, Mastercard - LiqPay</li>
													</ul>';

			$guarantee[$language['language_id']] = '<p><span style="font-size:16px;"><label for="neoseo_unistor_guarantee">Информация о гарантиях:</label></span></p>
													<ul>
														<li><strong>12 месяцев</strong> официальной гарантии от производителя</li>
														<li>обмен / возврат товара в течение 14 дней</li>
													</ul>';

			$logo[$language['language_id']] = "catalog/" . $this->_moduleSysName . "/neoseo.png";
			$top_banner_image[$language['language_id']] = '';
			$top_banner_link[$language['language_id']] = '';
			$recent_search[$language['language_id']] = '';

			$footer_sections[1][$language['language_id']] = '';
			$footer_sections[2][$language['language_id']] = '';
			$footer_sections[3][$language['language_id']] = '© 2018 SEO-Магазин от NeoSeo <br> Создание Интернет–магазина, раскрутка и продвижение сайта с ❤ в NeoSeo';
			$footer_sections[4][$language['language_id']] = '
 <div class="socials">	  
				<a href="#" class="vk"><i class="fa fa-vk" aria-hidden="true"></i></a>
				<a href="#" class="fk"><i class="fa fa-facebook" aria-hidden="true"></i></a>
				<a href="#" class="yt"><i class="fa fa-youtube-square" aria-hidden="true"></i></a>
				<a href="#" class="tw"><i class="fa fa-twitter" aria-hidden="true"></i></a>
 </div>			
			';
			$footer_sections[5][$language['language_id']] = '
<div class="payments">
	<a href="#" class="visa"></a>
	<a href="#" class="master"></a>
	<a href="#" class="webmoney"></a>
	<a href="#" class="cash"></a>
	<a href="#" class="qiwi"></a>
</div>			
			';

			$footer_column_names[1][$language['language_id']] = 'О компании';
			$footer_column_texts[1][$language['language_id']] = 'Украина, <br>
				г. Львов ул. Кульпарковская, 93 <br>
				+38 067 28 55 238, +38 067 670 76 47, <br>
				+38 050 345 85 65, +38 063 71 707 63 <br>
				г. Киев, ул. Срибнокильская 8а, <br>
				+38 044 39 03 001 <br>
				info@neoseo.com.ua';

			$footer_column_names[2][$language['language_id']] = 'Информация';
			$footer_column_names[3][$language['language_id']] = 'Поддержка';
			$footer_column_names[4][$language['language_id']] = 'Дополнительно';
			$footer_column_names[5][$language['language_id']] = 'Личный кабинет';

			$contact_section_names[0][$language['language_id']] = 'Адрес';
			$contact_section_names[1][$language['language_id']] = 'Телефоны';
			$contact_section_names[2][$language['language_id']] = '';
			$contact_section_names[3][$language['language_id']] = '';

			$contact_section_texts[0][$language['language_id']] = '<b>Магазин 1</b><br>адрес....<br><br><b>Магазин 2</b><br>адрес....';
			$contact_section_texts[1][$language['language_id']] = '<b>Время работы:</b> Понедельник-Пятница с 9-00 до 19-00<br>Телефон 1<br>Телефон 2<br>Телефон 3';
			$contact_section_texts[2][$language['language_id']] = '';
			$contact_section_texts[3][$language['language_id']] = '';

		}

		$footer_column_types = array(
			1 => 0,
			2 => 1,
			3 => 1,
			4 => 1,
			5 => 1
		);

		$footer_column_menu = array(
			2 => 3,
			3 => 4,
			4 => 5,
			5 => 6
		);

		$colors = array(
			7 => array(
				'font_color' => '3c763d',
				'background_color' => 'dff0d8',
				'border_color' => 'd6e9c6',
			),
			5 => array(
				'font_color' => 'a94442',
				'background_color' => 'f2dede',
				'border_color' => 'ebccd1',
			),
			'default' => array(
				'font_color' => 'ef8400',
				'background_color' => 'dff0d8',
				'border_color' => 'd6e9c6',
			),
		);
		$this->load->model('localisation/stock_status');
		foreach ($this->model_localisation_stock_status->getStockStatuses() as $status) {
			$color_statuses[$status['stock_status_id']] = isset($colors[$status['stock_status_id']]) ? $colors[$status['stock_status_id']] : $colors['default'];
		}

		$this->params = array(
			"debug" => 0,

			// Параметры - Основные
			"logo" => $logo,
			"scheme_style" => 'default',
            "body_font" => 'Roboto',
			"general_style" => 0,
			'use_wide_style' => 0,
			'template_prefix' => 'default',
			"general_background_color" => '#f5f5f5',
			"general_background_image" => '',
			"general_sharing_code" => $general_sharing_code,
			"personal_css" => '',

			// Параметры - Модули
            'module_preview_count' => 4,
			'module_title_color' => '#000000',
			'module_background_color' => '#ffffff',
			'module_border_color' => '#eeeeee',
			'module_border_color_hover' => '#1d1d1d',
			'text_color' => '#595959',
			'title_color' => '#000000',


			// Параметры - Кнопки
			'button_color' => '#ef532b',
			'button_color_text' => '#ffffff',
			'button_color_hover' => '#f57b5d',
			'button_color_text_hover' => '#ffffff',

			// Параметры - Кнопки превью товаров
			'preview_button_color' => '#fd0028',
			'preview_button_color_text' => '#fff',
			'preview_button_color_hover' => '#fff',
			'preview_button_color_text_hover' => '#fd0028',
			'product_thumb_icon_color' => '#ef532b',


			// Параметры - Кнопка товаров
			'product_button_color' => '#111',
			'product_button_color_text' => '#fff',
			'product_button_color_hover' => '#333',
			'product_button_color_text_hover' => '#fff',

			// Параметры - Кнопка "наверх"
			'go_top_background' => '#ef532b',
			'go_top_color' => '#ffffff',
			'go_top_background_hover' => '#a32d11',
			'go_top_color_hover' => '#ffffff',

			// Параметры - Пагинация
			'pagination_background' => '#ffffff',
			'pagination_color' => '#f57b5d',
			'pagination_background_hover' => '#f57b5d',
			'pagination_color_hover' => '#ffffff',
			'pagination_background_active' => '#ef532b',
			'pagination_color_active' => '#ffffff',

			// Параметры - Ссылки
			'link_color' => '#3366ff',
			'link_hover_color' => '#3366ff',

			// Параметры - Табы
			'tab_color' => '#ffffff',
			'tab_text_color' => '#2a77b9',
			'tab_color_hover' => '#2a77b9',
			'tab_text_color_hover' => '#ffffff',
			'tab_color_active' => '#f57b5d',
			'tab_text_color_active' => '#ffffff',


			// Шапка - Липкое меню
			"sticky_menu" => 1,
			"sticky_menu_type" => 0,
			"sticky_menu_items" => 1,
			'sticky_menu_color' => '#000000',
			'sticky_menu_background' => '#ffffff',
			"sticky_menu_image" => '',
			'sticky_menu_icon_color' => '#000000',
			'sticky_phones_color' => '#000',
			'sticky_cart_total_color' => '#c97c7c',

			// Шапка - верхний банер
			"top_banner" => 1,
			"top_banner_height" => 52,
			"top_banner_image" => $top_banner_image,
			'top_banner_link' => $top_banner_link,
			'top_banner_background' => '#fff',

			// Шапка - верхнее меню
			"top_menu_items" 		=> 1,
			"top_currency_status" 	=> 0,
			"top_menu_background" => '#404040',
			"top_menu_color" => '#f7f6f6',
			"top_menu_hover_color" => '#ef532b',
			"top_menu_border_color" => '#41c957',
            "top_menu_account_bg" => '#6ba91b',
            "top_menu_account_color" => '#ffffff',
			'top_menu_height' => 50,
			'top_menu_font_size' => 14,
			'top_menu_icon_position' => '',

			// Шапка - верхнее меню - Блок валют
			'currency_bg' => '#000000',
			'currency_color' => '#fff',
			'currency_bg_hover' => '#ef532b',
			'currency_color_hover' => '#ffffff',
			'currency_active_bg' => '#ef532b',
			'currency_active_color' => '#ffffff',
			'currency_active_bg_hover' => '#ffffff',
			'currency_active_color_hover' => '#ffffff',

			// Шапка - верхнее меню - Блок языков
			'language_active_bg' => '#c97c7c',


			// Шапка - Контент
			'top_header_height' => 175,
			'header_type' => "header",
			'header_information' => $header_information,
			'header_checkout_hide' => 0,
			"header_background_color" => "#ffffff",
			"header_background_image" => '',
			"header_icon_color" => '#ef532b',
			"header_phones_color" => '#333',
			'header_worktime_color' => '#333',
			'header_cart_total_color' => '#333',

			"phone1" => "<i class='ns-kyivstar'></i> +38 067 670 76 47",
			"phone2" => "<i class='ns-vodafone'></i> +38 050 345 85 65",
			"phone3" => "<i class='ns-lifecell'></i> +38 063 71 707 63",
			"work_time" => $work_time,
			'header_recent_search' => $recent_search,

			// Шапка - Основное меню
			"menu_main_items" => 2,
			"menu_main_type" => 'menu_hybrid',
			"menu_main_icon_position" => 'right',
			"menu_main_height" => 52,
			'menu_border_color' => '#ef532b',
            'menu_border_link_color' => '#6ba91b',

			'menu_main_bg_color' => '#ef532b',
			"menu_main_text_color" => '#ffffff',
			'menu_main_bg_hover_color' => '#ef532b',
			"menu_main_text_hover_color" => '#ffffff',
			'menu_main_bg_active_color' => '#ffffff',
			"menu_main_text_active_color" => '#ffffff',
			"menu_main_font_family" => 'Open Sans,Helvetica,sans-serif',
			"menu_main_font_size" => 15,
			"menu_main_icon_height" => 34,

			'menu_sub_bg_color' => '#fff',
			'menu_sub_text_color' => '#000000',
			'menu_sub_bg_hover_color' => '#fff',
			'menu_sub_text_hover_color' => '#ef532b',
			'menu_sub_bg_active_color' => '#fff',
			'menu_sub_text_active_color' => '#ef532b',
			"menu_sub_font_size" => 14,
			"menu_sub_icon_height" => 14,
			'menu_sub_font_family' => 'Open Sans,Helvetica,sans-serif',

			// Мобильный вид шапки
            'header_mobile_type'            => 'header_mobile',
			'mobile_header_bg_color'						  => '#333',
			'mobile_header_icon_color'						=> '#fff',
			'mobile_header_total_color'					   => '#fff',
			'mobile_header_menu_currency_color'			   => '#333',
			'mobile_header_menu_currency_active_color'		=> '#333',
			'mobile_header_menu_text_color'				   => '#333',
			'mobile_header_menu_icon_color'				   => '#333',
			'mobile_header_menu_total_color'				  => '#333',

			// Подвал
			"footer_sections" => $footer_sections,
			"footer_column_names" => $footer_column_names,
			"footer_column_texts" => $footer_column_texts,
			"footer_column_menu" => $footer_column_menu,
			"footer_column_types" => $footer_column_types,

			// Подвал - Верхняя часть
			"footer_top_background" => '#404040',
			"footer_top_color" => '#ffffff',
			'footer_top_link_hover_color' => '#ffffff',

			// Подвал - Нижняя часть
			"footer_bottom_background" => '#404040',
			"footer_bottom_color" => '#fff',
			"footer_bottom_link_hover_color" => '#fff600',

			// Контакты - Секции
			"contact_sections_status" => 1,
			"contact_section_names" => $contact_section_names,
			"contact_section_texts" => $contact_section_texts,

			// Контакты - Карта
			"contact_map" => 1,
			"contact_google_api_key" => 'AIzaSyBdnZTnJ70b1xTDwLlCP6A1i3wSjdF1wz8',
			"contact_latitude" => '49.823041',
			"contact_longitude" => '23.989231',

			// Контакты - Форма связи
			"contact_form_status" => 1,

			// Категории
            "category_view_count" => 3,
			"category_view_type" => 'grid',
			"category_description_position" => 0,
			"column_count" => 3,
			'subcategories_show' => 1,
			'subcategories_image_height' => 80,
			'subcategories_image_width' => 80,
			'product_short_description_length' => 40,

			'product_attributes_status' => 1,
			'product_selected_attributes' => array(),
			'product_selected_attributes_custom_divider' => ', ',
			'product_show_manufacturer' => 1,
			'product_show_model' => 1,
			'product_show_sku' => 0,
			'product_show_weight' => 1,

			// Товар
			"prev_next_status" => 1,
			"prev_next_link_status" => 1,
			"hover_image" => 1,
			'product_zoom' => 1,
			"attributes_title" => array(),
			"colors_status" => $color_statuses,
			"delivery" => $delivery,
			"payment" => $payment,
			"guarantee" => $guarantee,


		);


	}

	public function install()
	{
		// Значения параметров по умолчанию
		$this->initParams($this->params);
	}

	public function uninstall()
	{

	}

	public function upgrade()
	{
		// Добавляем недостающие новые параметры
		$this->initParams($this->params);
	}

	public function deleteDemoData()
	{
		$this->db->query("TRUNCATE `" . DB_PREFIX . "actions`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "actions_categories`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "actions_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "actions_products`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "address`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "affiliate`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "affiliate_activity`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "affiliate_login`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "affiliate_transaction`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "attribute`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "attribute_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "attribute_group`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "attribute_group_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_article`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_article_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_article_related_article`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_article_related_product`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_article_to_category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_article_to_layout`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_article_to_store`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_author`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_author_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_category_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_category_path`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_category_to_layout`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_category_to_store`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "blog_comment`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "callback`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "cart`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "category_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "category_filter`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "category_path`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "category_slideshow`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "category_to_blog_article`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "category_to_layout`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "category_to_store`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "coupon`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "coupon_category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "coupon_history`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "coupon_product`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer_activity`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer_history`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer_ip`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer_login`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer_online`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer_reward`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer_scfield`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer_transaction`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "customer_wishlist`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "custom_field`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "custom_field_customer_group`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "custom_field_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "custom_field_value`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "custom_field_value_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "download`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "download_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "dropped_cart`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "dropped_cart_product`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "featured_products_tabs`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "featured_products_to_module`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_cache`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_category_cache`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_group`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_group_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_module_cache`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_option`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_option_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_option_to_category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_option_value`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_option_value_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_option_value_to_product`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_page`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "filter_page_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "loyalty_customer_discount`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "manufacturer`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "manufacturer_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "manufacturer_to_store`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "neoseo_category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "neoseo_category_items`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "neoseo_category_items_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "notfound`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "option`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "option_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "option_value`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "option_value_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_allowed_status`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_custom_field`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_history`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_history_to_user`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_option`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_product`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_recurring`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_recurring_transaction`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_referrer`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_scfield`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_status`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_total`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "order_voucher`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_attribute`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_description`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_discount`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_feed`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_feed_categories`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_feed_categories_path`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_feed_format`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_filter`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_image`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_import`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_labels`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_option`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_option_value`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_option_warehouse`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_recurring`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_related`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_reward`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_similar_category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_similar_product`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_special`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_tab`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_tab_content`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_tab_default`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_tab_name`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_download`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_email`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_feed_category`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_labels`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_layout`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_store`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "product_to_tab`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "redirect`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "referrer`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "referrer_patterns`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "relatedoptions`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "relatedoptions_discount`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "relatedoptions_option`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "relatedoptions_search`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "relatedoptions_special`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "relatedoptions_to_char`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "relatedoptions_variant`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "relatedoptions_variant_option`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "relatedoptions_variant_product`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "return`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "return_action`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "return_history`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "return_reason`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "return_status`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "review`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "subscribe`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "testimonial`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "testimonials`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "url_alias`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "voucher`;");
		$this->db->query("TRUNCATE `" . DB_PREFIX . "voucher_history`;");
		// Модуль меню
		//$this->db->query("TRUNCATE `" . DB_PREFIX . "neoseo_menu`;");
		//$this->db->query("TRUNCATE `" . DB_PREFIX . "neoseo_menu_items`;");
		//$this->db->query("TRUNCATE `" . DB_PREFIX . "neoseo_menu_items_description`;");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "neoseo_menu_items` WHERE menu_id in (2,12);");
		$this->db->query("DELETE FROM `" . DB_PREFIX . "neoseo_menu_items_description` WHERE menu_id in (2,12);");

		//catalog/information
		$this->db->query("UPDATE `" . DB_PREFIX . "information_description` SET description = '';");


		$this->log("Демо-данные очищены");
		$sql = "INSERT INTO `" . DB_PREFIX . "url_alias` (`url_alias_id`, `query`, `keyword`, `seo_mod`) VALUES
			(null, 'account/voucher', 'vouchers', 0),
			(null, 'account/wishlist', 'wishlist', 0),
			(null, 'account/account', 'my-account', 0),
			(null, 'checkout/cart', 'cart', 0),
			(null, 'checkout/checkout', 'checkout', 0),
			(null, 'account/login', 'login', 0),
			(null, 'account/logout', 'logout', 0),
			(null, 'account/order', 'order-history', 0),
			(null, 'account/newsletter', 'newsletter', 0),
			(null, 'product/special', 'specials', 0),
			(null, 'affiliate/account', 'affiliates', 0),
			(null, 'checkout/voucher', 'gift-vouchers', 0),
			(null, 'product/manufacturer', 'brands', 0),
			(null, 'information/contact', 'contact-us', 0),
			(null, 'account/return/insert', 'request-return', 0),
			(null, 'information/sitemap', 'sitemap', 0),
			(null, 'account/forgotten', 'forgot-password', 0),
			(null, 'account/download', 'downloads', 0),
			(null, 'account/return', 'returns', 0),
			(null, 'account/transaction', 'transactions', 0),
			(null, 'account/register', 'create-account', 0),
			(null, 'product/compare', 'compare-products', 0),
			(null, 'product/search', 'search', 0),
			(null, 'account/edit', 'edit-account', 0),
			(null, 'account/password', 'change-password', 0),
			(null, 'account/address', 'address-book', 0),
			(null, 'account/reward', 'reward-points', 0),
			(null, 'affiliate/edit', 'edit-affiliate-account', 0),
			(null, 'affiliate/password', 'change-affiliate-password', 0),
			(null, 'affiliate/payment', 'affiliate-payment-options', 0),
			(null, 'affiliate/tracking', 'affiliate-tracking-code', 0),
			(null, 'affiliate/transaction', 'affiliate-transactions', 0),
			(null, 'affiliate/logout', 'affiliate-logout', 0),
			(null, 'affiliate/forgotten', 'affiliate-forgot-password', 0),
			(null, 'affiliate/register', 'create-affiliate-account', 0),
			(null, 'affiliate/login', 'affiliate-login', 0),
			(null, 'account/return/add', 'add-return', 0),
			(null, 'common/home', '', 0);
		";
		$this->log("Добавлены стартовые SEO-url");
		//echo $sql;exit;
		$this->db->query($sql);
		//echo "<pre>";print_r($r);exit;
	}

}
