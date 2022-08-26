<?php
class ControllerCommonMenu extends Controller {
	public function index() {
		$this->load->language('common/menu');

		$data['text_analytics'] = $this->language->get('text_analytics');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_api'] = $this->language->get('text_api');
		$data['text_attribute'] = $this->language->get('text_attribute');
		$data['text_attribute_group'] = $this->language->get('text_attribute_group');
		$data['text_backup'] = $this->language->get('text_backup');
		$data['text_banner'] = $this->language->get('text_banner');
		$data['text_captcha'] = $this->language->get('text_captcha');
		$data['text_catalog'] = $this->language->get('text_catalog');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_confirm'] = $this->language->get('text_confirm');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_country'] = $this->language->get('text_country');
		$data['text_coupon'] = $this->language->get('text_coupon');
		$data['text_currency'] = $this->language->get('text_currency');
		$data['text_customer'] = $this->language->get('text_customer');
		$data['text_customer_group'] = $this->language->get('text_customer_group');
		$data['text_customer_field'] = $this->language->get('text_customer_field');
		$data['text_custom_field'] = $this->language->get('text_custom_field');
		$data['text_sale'] = $this->language->get('text_sale');
		$data['text_paypal'] = $this->language->get('text_paypal');
		$data['text_paypal_search'] = $this->language->get('text_paypal_search');
		$data['text_design'] = $this->language->get('text_design');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_error_log'] = $this->language->get('text_error_log');
		$data['text_extension'] = $this->language->get('text_extension');
		$data['text_feed'] = $this->language->get('text_feed');
		$data['text_fraud'] = $this->language->get('text_fraud');
		$data['text_filter'] = $this->language->get('text_filter');
		$data['text_geo_zone'] = $this->language->get('text_geo_zone');
		$data['text_dashboard'] = $this->language->get('text_dashboard');
		$data['text_help'] = $this->language->get('text_help');
		$data['text_information'] = $this->language->get('text_information');
		$data['text_installer'] = $this->language->get('text_installer');
		$data['text_language'] = $this->language->get('text_language');
		$data['text_layout'] = $this->language->get('text_layout');
		$data['text_localisation'] = $this->language->get('text_localisation');
		$data['text_location'] = $this->language->get('text_location');
		$data['text_marketing'] = $this->language->get('text_marketing');
		$data['text_modification'] = $this->language->get('text_modification');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_module'] = $this->language->get('text_module');
		$data['text_option'] = $this->language->get('text_option');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_order_status'] = $this->language->get('text_order_status');
		$data['text_opencart'] = $this->language->get('text_opencart');
		$data['text_payment'] = $this->language->get('text_payment');
		$data['text_product'] = $this->language->get('text_product');
		$data['text_reports'] = $this->language->get('text_reports');
		$data['text_report_sale_order'] = $this->language->get('text_report_sale_order');
		$data['text_report_sale_tax'] = $this->language->get('text_report_sale_tax');
		$data['text_report_sale_shipping'] = $this->language->get('text_report_sale_shipping');
		$data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$data['text_report_sale_coupon'] = $this->language->get('text_report_sale_coupon');
		$data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$data['text_report_product_viewed'] = $this->language->get('text_report_product_viewed');
		$data['text_report_product_purchased'] = $this->language->get('text_report_product_purchased');
		$data['text_report_customer_activity'] = $this->language->get('text_report_customer_activity');
		$data['text_report_customer_online'] = $this->language->get('text_report_customer_online');
		$data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		$data['text_report_customer_reward'] = $this->language->get('text_report_customer_reward');
		$data['text_report_customer_credit'] = $this->language->get('text_report_customer_credit');
		$data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		$data['text_report_affiliate'] = $this->language->get('text_report_affiliate');
		$data['text_report_affiliate_activity'] = $this->language->get('text_report_affiliate_activity');
		$data['text_review'] = $this->language->get('text_review');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_return_action'] = $this->language->get('text_return_action');
		$data['text_return_reason'] = $this->language->get('text_return_reason');
		$data['text_return_status'] = $this->language->get('text_return_status');
		$data['text_shipping'] = $this->language->get('text_shipping');
		$data['text_setting'] = $this->language->get('text_setting');
		$data['text_stock_status'] = $this->language->get('text_stock_status');
		$data['text_system'] = $this->language->get('text_system');
		$data['text_tax'] = $this->language->get('text_tax');
		$data['text_tax_class'] = $this->language->get('text_tax_class');
		$data['text_tax_rate'] = $this->language->get('text_tax_rate');
		$data['text_tools'] = $this->language->get('text_tools');
		$data['text_total'] = $this->language->get('text_total');
		$data['text_upload'] = $this->language->get('text_upload');
		$data['text_tracking'] = $this->language->get('text_tracking');
		$data['text_user'] = $this->language->get('text_user');
		$data['text_user_group'] = $this->language->get('text_user_group');
		$data['text_users'] = $this->language->get('text_users');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_voucher_theme'] = $this->language->get('text_voucher_theme');
		$data['text_weight_class'] = $this->language->get('text_weight_class');
		$data['text_length_class'] = $this->language->get('text_length_class');
		$data['text_zone'] = $this->language->get('text_zone');
		$data['text_recurring'] = $this->language->get('text_recurring');
		$data['text_order_recurring'] = $this->language->get('text_order_recurring');
		$data['text_openbay_extension'] = $this->language->get('text_openbay_extension');
		$data['text_openbay_dashboard'] = $this->language->get('text_openbay_dashboard');
		$data['text_openbay_orders'] = $this->language->get('text_openbay_orders');
		$data['text_openbay_items'] = $this->language->get('text_openbay_items');
		$data['text_openbay_ebay'] = $this->language->get('text_openbay_ebay');
		$data['text_openbay_etsy'] = $this->language->get('text_openbay_etsy');
		$data['text_openbay_amazon'] = $this->language->get('text_openbay_amazon');
		$data['text_openbay_amazonus'] = $this->language->get('text_openbay_amazonus');
		$data['text_openbay_settings'] = $this->language->get('text_openbay_settings');
		$data['text_openbay_links'] = $this->language->get('text_openbay_links');
		$data['text_openbay_report_price'] = $this->language->get('text_openbay_report_price');
		$data['text_openbay_order_import'] = $this->language->get('text_openbay_order_import');

		/* octeam */
		$data['text_octeam_toolset'] = $this->language->get('text_octeam_toolset');

		/* NeoSeo Menu Access - begin */
		//catalog
		$data['catalog_style'] = ($this->user->hasPermission('access','catalog/category') || $this->user->hasPermission('access','catalog/product') || $this->user->hasPermission('access','catalog/recurring') || $this->user->hasPermission('access','catalog/filter') || $this->user->hasPermission('access','catalog/attribute') || $this->user->hasPermission('access','catalog/attribute_group') || $this->user->hasPermission('access','catalog/option') || $this->user->hasPermission('access','catalog/manufacturer') || $this->user->hasPermission('access','catalog/download') || $this->user->hasPermission('access','catalog/review') ||  $this->user->hasPermission('access','catalog/information')) ? "" : " style='display: none' ";
		$data['category_style'] = $this->user->hasPermission('access','catalog/category') ? "" : " style='display: none' ";
		$data['product_style'] = $this->user->hasPermission('access','catalog/product') ? "" : " style='display: none' ";
		$data['recurring_style'] = $this->user->hasPermission('access','catalog/recurring') ? "" : " style='display: none' ";
		$data['filter_style'] = $this->user->hasPermission('access','catalog/filter') ? "" : " style='display: none' ";
		$data['attribute_menu_style'] = ( $this->user->hasPermission('access','catalog/attribute') || $this->user->hasPermission('access','catalog/attribute_group') ) ? "" : " style='display: none' ";
		$data['attribute_style'] = $this->user->hasPermission('access','catalog/attribute') ? "" : " style='display: none' ";
		$data['attribute_group_style'] = $this->user->hasPermission('access','catalog/attribute_group') ? "" : " style='display: none' ";
		$data['option_style'] = $this->user->hasPermission('access','catalog/option') ? "" : " style='display: none' ";
		$data['manufacturer_style'] = $this->user->hasPermission('access','catalog/manufacturer') ? "" : " style='display: none' ";
		$data['download_style'] = $this->user->hasPermission('access','catalog/download') ? "" : " style='display: none' ";
		$data['review_style'] = $this->user->hasPermission('access','catalog/review') ? "" : " style='display: none' ";
		$data['information_style'] = $this->user->hasPermission('access','catalog/information') ? "" : " style='display: none' ";
		
		//extension
		$data['extension_style'] = ($this->user->hasPermission('access','extension/installer') || $this->user->hasPermission('access','extension/modification') || $this->user->hasPermission('access','extension/analytics') || $this->user->hasPermission('access','extension/captcha') || $this->user->hasPermission('access','extension/feed')|| $this->user->hasPermission('access','extension/fraud') || $this->user->hasPermission('access','extension/module') || $this->user->hasPermission('access','extension/payment') || $this->user->hasPermission('access','extension/shipping') || $this->user->hasPermission('access','extension/total') || $this->user->hasPermission('access','extension/openbay') || $this->user->hasPermission('access','extension/openbay/orderlist') || $this->user->hasPermission('access','extension/openbay/items') || $this->user->hasPermission('access','openbay/ebay') || $this->user->hasPermission('access','openbay/ebay/settings') || $this->user->hasPermission('access','openbay/ebay/viewitemlinks') || $this->user->hasPermission('access','openbay/ebay/vieworderimport') || $this->user->hasPermission('access','openbay/amazon') || $this->user->hasPermission('access','openbay/amazon/settings') || $this->user->hasPermission('access','openbay/amazon/itemlinks') || $this->user->hasPermission('access','openbay/amazonus') || $this->user->hasPermission('access','openbay/amazonus/settings') || $this->user->hasPermission('access','openbay/amazonus/itemlinks')) ? "" : " style='display: none' ";
		$data['installer_style'] = $this->user->hasPermission('access','extension/installer') ? "" : " style='display: none' ";
		$data['modification_style'] = $this->user->hasPermission('access','extension/modification') ? "" : " style='display: none' ";
		$data['analytics_style'] = $this->user->hasPermission('access','extension/analytics') ? "" : " style='display: none' ";
		$data['captcha_style'] = $this->user->hasPermission('access','extension/captcha') ? "" : " style='display: none' ";
		$data['feed_style'] = $this->user->hasPermission('access','extension/feed') ? "" : " style='display: none' ";
		$data['fraud_style'] = $this->user->hasPermission('access','extension/fraud') ? "" : " style='display: none' ";
		$data['module_style'] = $this->user->hasPermission('access','extension/module') ? "" : " style='display: none' ";
		$data['payment_style'] = $this->user->hasPermission('access','extension/payment') ? "" : " style='display: none' ";
		$data['shipping_style'] = $this->user->hasPermission('access','extension/shipping') ? "" : " style='display: none' ";
		$data['total_style'] = $this->user->hasPermission('access','extension/total') ? "" : " style='display: none' ";
		$data['openbay_extension_style'] = ($this->user->hasPermission('access','extension/openbay') || $this->user->hasPermission('access','extension/openbay/orderlist') || $this->user->hasPermission('access','extension/openbay/items'))? "" : " style='display: none' ";
		$data['openbay_link_extension_style'] = $this->user->hasPermission('access','extension/openbay') ? "" : " style='display: none' ";
		$data['openbay_link_orders_style'] = $this->user->hasPermission('access','extension/openbay/orderlist') ? "" : " style='display: none' ";
		$data['openbay_link_items_style'] = $this->user->hasPermission('access','extension/openbay/items') ? "" : " style='display: none' ";
		$data['openbay_ebay_style'] = ($this->user->hasPermission('access','openbay/ebay') || $this->user->hasPermission('access','openbay/ebay/settings') || $this->user->hasPermission('access','openbay/ebay/viewitemlinks') || $this->user->hasPermission('access','openbay/ebay/vieworderimport'))? "" : " style='display: none' ";
		$data['openbay_link_ebay_style'] = $this->user->hasPermission('access','openbay/ebay') ? "" : " style='display: none' ";
		$data['openbay_link_ebay_settings_style'] = $this->user->hasPermission('access','openbay/ebay/settings') ? "" : " style='display: none' ";
		$data['openbay_link_ebay_links_style'] = $this->user->hasPermission('access','openbay/ebay/viewitemlinks') ? "" : " style='display: none' ";
		$data['openbay_link_ebay_orderimport_style'] = $this->user->hasPermission('access','openbay/ebay/vieworderimport') ? "" : " style='display: none' ";
		$data['openbay_amazon_style'] = ($this->user->hasPermission('access','openbay/amazon') || $this->user->hasPermission('access','openbay/amazon/settings') || $this->user->hasPermission('access','openbay/amazon/itemlinks')) ? "" : " style='display: none' ";
		$data['openbay_link_amazon_style'] = $this->user->hasPermission('access','openbay/amazon') ? "" : " style='display: none' ";
		$data['openbay_link_amazon_settings_style'] = $this->user->hasPermission('access','openbay/amazon/settings') ? "" : " style='display: none' ";
		$data['openbay_link_amazon_links_style'] = $this->user->hasPermission('access','openbay/amazon/itemlinks') ? "" : " style='display: none' ";
		$data['openbay_amazonus_style'] = ($this->user->hasPermission('access','openbay/amazonus') || $this->user->hasPermission('access','openbay/amazonus/settings') || $this->user->hasPermission('access','openbay/amazonus/itemlinks'))? "" : " style='display: none' ";
		$data['openbay_link_amazonus_style'] = $this->user->hasPermission('access','openbay/amazonus') ? "" : " style='display: none' ";
		$data['openbay_link_amazonus_settings_style'] = $this->user->hasPermission('access','openbay/amazonus/settings') ? "" : " style='display: none' ";
		$data['openbay_link_amazonus_links_style'] = $this->user->hasPermission('access','openbay/amazonus/itemlinks') ? "" : " style='display: none' ";
		$data['openbay_etsy_style'] = ($this->user->hasPermission('access','openbay/etsy') ||  $this->user->hasPermission('access','openbay/etsy/settings') || $this->user->hasPermission('access','openbay/etsy_product/links') ) ? "" : " style='display: none' ";
		$data['openbay_link_etsy_style'] = $this->user->hasPermission('access','openbay/etsy') ? "" : " style='display: none' ";
		$data['openbay_link_etsy_settings_style'] = $this->user->hasPermission('access','openbay/etsy/settings') ? "" : " style='display: none' ";
		$data['openbay_link_etsy_links_style'] = $this->user->hasPermission('access','openbay/etsy_product/links') ? "" : " style='display: none' ";
		
		//design
		$data['design_style'] = ($this->user->hasPermission('access','design/layout') || $this->user->hasPermission('access','design/banner'))  ? "" : " style='display: none' ";
		$data['layout_style'] = $this->user->hasPermission('access','design/layout') ? "" : " style='display: none' ";
		$data['banner_style'] = $this->user->hasPermission('access','design/banner') ? "" : " style='display: none' ";
		
		//sale
		$data['sale_style'] = ($this->user->hasPermission('access','sale/order') || $this->user->hasPermission('access','sale/recurring') || $this->user->hasPermission('access','sale/return') || $this->user->hasPermission('access','payment/pp_express/search') || $this->user->hasPermission('access','sale/voucher') || $this->user->hasPermission('access','sale/voucher_theme')) ? "" : " style='display: none' ";
		$data['order_style'] = $this->user->hasPermission('access','sale/order') ? "" : " style='display: none' ";
		$data['order_recurring_style'] = $this->user->hasPermission('access','sale/recurring') ? "" : " style='display: none' ";
		$data['return_style'] = $this->user->hasPermission('access','sale/return') ? "" : " style='display: none' ";
		$data['voucher_parent_style'] = ($this->user->hasPermission('access','sale/voucher') || $this->user->hasPermission('access','sale/voucher_theme')) ? "" : " style='display: none' ";
		$data['voucher_style'] = $this->user->hasPermission('access','sale/voucher') ? "" : " style='display: none' ";
		$data['voucher_theme_style'] = $this->user->hasPermission('access','sale/voucher_theme') ? "" : " style='display: none' ";
		$data['paypal_style'] = $this->user->hasPermission('access','payment/pp_express/search') ? "" : " style='display: none' ";
		$data['paypal_search_style'] = $this->user->hasPermission('access','payment/pp_express/search') ? "" : " style='display: none' ";
		
		//customer
		$data['customer_parent_style'] = ($this->user->hasPermission('access','customer/customer') || $this->user->hasPermission('access','customer/customer_group') || $this->user->hasPermission('access','customer/custom_field')) ? "" : " style='display: none' ";
		$data['custom_field_style'] = $this->user->hasPermission('access','customer/custom_field') ? "" : " style='display: none' ";
		$data['customer_style'] = $this->user->hasPermission('access','customer/customer') ? "" : " style='display: none' ";
		$data['customer_group_style'] = $this->user->hasPermission('access','customer/customer_group') ? "" : " style='display: none' ";
		
		//marketing
		$data['marketing_parent_style'] = ($this->user->hasPermission('access','marketing/marketing') || $this->user->hasPermission('access','marketing/affiliate') || $this->user->hasPermission('access','marketing/coupon') || $this->user->hasPermission('access','marketing/contact')) ? "" : " style='display: none' ";
		$data['marketing_style'] = $this->user->hasPermission('access','marketing/marketing') ? "" : " style='display: none' ";
		$data['affiliate_style'] = $this->user->hasPermission('access','marketing/affiliate') ? "" : " style='display: none' ";
		$data['coupon_style'] = $this->user->hasPermission('access','marketing/coupon') ? "" : " style='display: none' ";
		$data['contact_style'] = $this->user->hasPermission('access','marketing/contact') ? "" : " style='display: none' ";
		
		//system
		$data['system_style'] = ($this->user->hasPermission('access','setting/store') || $this->user->hasPermission('access','user/user') || $this->user->hasPermission('access','user/user_permission') || $this->user->hasPermission('access','user/api') || $this->user->hasPermission('access','localisation/location') || $this->user->hasPermission('access','localisation/language') || $this->user->hasPermission('access','localisation/currency') || $this->user->hasPermission('access','localisation/stock_status') || $this->user->hasPermission('access','localisation/order_status') || $this->user->hasPermission('access','localisation/return_status') || $this->user->hasPermission('access','localisation/return_action') || $this->user->hasPermission('access','localisation/return_reason') || $this->user->hasPermission('access','localisation/country') || $this->user->hasPermission('access','localisation/zone') || $this->user->hasPermission('access','localisation/geo_zone') || $this->user->hasPermission('access','localisation/tax_class') || $this->user->hasPermission('access','localisation/tax_rate') || $this->user->hasPermission('access','localisation/length_class') || $this->user->hasPermission('access','localisation/weight_class') || $this->user->hasPermission('access','tool/upload') || $this->user->hasPermission('access','tool/backup') || $this->user->hasPermission('access','tool/error_log') || $this->user->hasPermission('access','octeam/toolset')) ? "" : " style='display: none' ";
		$data['setting_style'] = $this->user->hasPermission('access','setting/store') ? "" : " style='display: none' ";
		$data['user_parent_style'] = ($this->user->hasPermission('access','user/user') || $this->user->hasPermission('access','user/user_permission') || $this->user->hasPermission('access','user/api')) ? "" : " style='display: none' ";
		$data['user_style'] = $this->user->hasPermission('access','user/user') ? "" : " style='display: none' ";
		$data['user_group_style'] = $this->user->hasPermission('access','user/user_permission') ? "" : " style='display: none' ";
		$data['api_style'] = $this->user->hasPermission('access','user/api') ? "" : " style='display: none' ";
		$data['localisation_parent_style'] = ($this->user->hasPermission('access','localisation/location') || $this->user->hasPermission('access','localisation/language') || $this->user->hasPermission('access','localisation/currency') || $this->user->hasPermission('access','localisation/stock_status') || $this->user->hasPermission('access','localisation/order_status')) ? "" : " style='display: none' ";
		$data['location_style'] = $this->user->hasPermission('access','localisation/location') ? "" : " style='display: none' ";
		$data['language_style'] = $this->user->hasPermission('access','localisation/language') ? "" : " style='display: none' ";
		$data['currency_style'] = $this->user->hasPermission('access','localisation/currency') ? "" : " style='display: none' ";
		$data['stock_status_style'] = $this->user->hasPermission('access','localisation/stock_status') ? "" : " style='display: none' ";
		$data['order_status_style'] = $this->user->hasPermission('access','localisation/order_status') ? "" : " style='display: none' ";
		$data['return_style'] = ($this->user->hasPermission('access','localisation/return_status') || $this->user->hasPermission('access','localisation/return_action') || $this->user->hasPermission('access','localisation/return_reason')) ? "" : " style='display: none' ";
		$data['return_status_style'] = $this->user->hasPermission('access','localisation/return_status') ? "" : " style='display: none' ";
		$data['return_action_style'] = $this->user->hasPermission('access','localisation/return_action') ? "" : " style='display: none' ";
		$data['return_reason_style'] = $this->user->hasPermission('access','localisation/return_reason') ? "" : " style='display: none' ";$data['location_style'] = $this->user->hasPermission('access','openbay/etsy_product/links') ? "" : " style='display: none' ";
		$data['country_style'] = $this->user->hasPermission('access','localisation/country') ? "" : " style='display: none' ";
		$data['zone_style'] = $this->user->hasPermission('access','localisation/zone') ? "" : " style='display: none' ";
		$data['geo_zone_style'] = $this->user->hasPermission('access','localisation/geo_zone') ? "" : " style='display: none' ";
		$data['tax_style'] = ($this->user->hasPermission('access','localisation/tax_class') || $this->user->hasPermission('access','localisation/tax_rate')) ? "" : " style='display: none' ";
		$data['tax_class_style'] = $this->user->hasPermission('access','localisation/tax_class') ? "" : " style='display: none' ";
		$data['tax_rate_style'] = $this->user->hasPermission('access','localisation/tax_rate') ? "" : " style='display: none' ";
		$data['length_class_style'] = $this->user->hasPermission('access','localisation/length_class') ? "" : " style='display: none' ";
		$data['weight_class_style'] = $this->user->hasPermission('access','localisation/weight_class') ? "" : " style='display: none' ";
		$data['tools_style'] = ($this->user->hasPermission('access','tool/upload') || $this->user->hasPermission('access','tool/backup') || $this->user->hasPermission('access','tool/error_log') || $this->user->hasPermission('access','octeam/toolset')) ? "" : " style='display: none' ";
		$data['upload_style'] = $this->user->hasPermission('access','tool/upload') ? "" : " style='display: none' ";
		$data['backup_style'] = $this->user->hasPermission('access','tool/backup') ? "" : " style='display: none' ";
		$data['error_log_style'] = $this->user->hasPermission('access','tool/error_log') ? "" : " style='display: none' ";
		$data['octeam_toolset_style'] = $this->user->hasPermission('access','octeam/toolset') ? "" : " style='display: none' ";
		
		//reports
		$data['reports_style'] = ($this->user->hasPermission('access','report/sale_order') || $this->user->hasPermission('access','report/sale_tax') || $this->user->hasPermission('access','report/sale_shipping') || $this->user->hasPermission('access','report/sale_return') || $this->user->hasPermission('access','report/sale_coupon') || $this->user->hasPermission('access','report/product_viewed') || $this->user->hasPermission('access','report/product_purchased') || $this->user->hasPermission('access','report/customer_online') || $this->user->hasPermission('access','report/customer_activity') || $this->user->hasPermission('access','report/customer_order') || $this->user->hasPermission('access','report/customer_reward') || $this->user->hasPermission('access','report/customer_credit') || $this->user->hasPermission('access','report/marketing') || $this->user->hasPermission('access','report/affiliate') || $this->user->hasPermission('access','report/affiliate_activity')) ? "" : " style='display: none' ";
		$data['report_sale_style'] = ($this->user->hasPermission('access','report/sale_order') || $this->user->hasPermission('access','report/sale_tax') || $this->user->hasPermission('access','report/sale_shipping') || $this->user->hasPermission('access','report/sale_return') || $this->user->hasPermission('access','report/sale_coupon'))? "" : " style='display: none' ";
		$data['report_sale_order_style'] = $this->user->hasPermission('access','report/sale_order') ? "" : " style='display: none' ";
		$data['report_sale_tax_style'] = $this->user->hasPermission('access','report/sale_tax') ? "" : " style='display: none' ";
		$data['report_sale_shipping_style'] = $this->user->hasPermission('access','report/sale_shipping') ? "" : " style='display: none' ";
		$data['report_sale_return_style'] = $this->user->hasPermission('access','report/sale_return') ? "" : " style='display: none' ";
		$data['report_sale_coupon_style'] = $this->user->hasPermission('access','report/sale_coupon') ? "" : " style='display: none' ";
		$data['report_product_style'] = ($this->user->hasPermission('access','report/product_viewed') || $this->user->hasPermission('access','report/product_purchased')) ? "" : " style='display: none' ";
		$data['report_product_viewed_style'] = $this->user->hasPermission('access','report/product_viewed') ? "" : " style='display: none' ";
		$data['report_product_purchased_style'] = $this->user->hasPermission('access','report/product_purchased') ? "" : " style='display: none' ";
		$data['report_customer_style'] = ($this->user->hasPermission('access','report/customer_online') || $this->user->hasPermission('access','report/customer_activity') || $this->user->hasPermission('access','report/customer_order') || $this->user->hasPermission('access','report/customer_reward') || $this->user->hasPermission('access','report/customer_credit')) ? "" : " style='display: none' ";
		$data['report_customer_online_style'] = $this->user->hasPermission('access','report/customer_online') ? "" : " style='display: none' ";
		$data['report_customer_activity_style'] = $this->user->hasPermission('access','report/customer_activity') ? "" : " style='display: none' ";
		$data['report_customer_order_style'] = $this->user->hasPermission('access','report/customer_order') ? "" : " style='display: none' ";
		$data['report_customer_reward_style'] = $this->user->hasPermission('access','report/customer_reward') ? "" : " style='display: none' ";
		$data['report_customer_credit_style'] = $this->user->hasPermission('access','report/customer_credit') ? "" : " style='display: none' ";
		$data['report_parent_marketing_style'] =($this->user->hasPermission('access','report/marketing') || $this->user->hasPermission('access','report/affiliate') || $this->user->hasPermission('access','report/affiliate_activity')) ? "" : " style='display: none' ";
		$data['report_marketing_style'] = $this->user->hasPermission('access','report/marketing') ? "" : " style='display: none' ";
		$data['report_affiliate_style'] = $this->user->hasPermission('access','report/affiliate') ? "" : " style='display: none' ";
		$data['report_affiliate_activity_style'] = $this->user->hasPermission('access','report/affiliate_activity') ? "" : " style='display: none' ";
		/* NeoSeo Menu Access - begin */

		$data['analytics'] = $this->url->link('extension/analytics', 'token=' . $this->session->data['token'], 'SSL');
		$data['home'] = $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL');
		$data['affiliate'] = $this->url->link('marketing/affiliate', 'token=' . $this->session->data['token'], 'SSL');
		$data['api'] = $this->url->link('user/api', 'token=' . $this->session->data['token'], 'SSL');
		$data['attribute'] = $this->url->link('catalog/attribute', 'token=' . $this->session->data['token'], 'SSL');
		$data['attribute_group'] = $this->url->link('catalog/attribute_group', 'token=' . $this->session->data['token'], 'SSL');
		$data['backup'] = $this->url->link('tool/backup', 'token=' . $this->session->data['token'], 'SSL');

		/* NeoSeo Unistor - begin */
		$data['neoseo_unistor'] = false;
		if( isset($this->session->data['token']) ) {
			if( $this->user->hasPermission('access','module/neoseo_unistor')){
				$this->language->load("module/neoseo_unistor");
				$data['text_neoseo_unistor'] = $this->language->get("text_neoseo_unistor");
				$data['neoseo_unistor'] = $this->url->link('module/neoseo_unistor', 'token=' .$this->session->data['token'], 'SSL');
			}
		}
		/* NeoSeo Unistor  - end */

		/* NeoSeo Route Manager - begin */
		$data['neoseo_route_manager'] = false;
		if( isset($this->session->data['token']) ) {
			if( $this->user->hasPermission('access','tool/neoseo_route_manager') && $this->config->get("neoseo_route_manager_status") ){
				$data['neoseo_route_manager_status'] = $this->config->get("neoseo_route_manager_status");
				$this->language->load("tool/neoseo_route_manager");
				$data['text_neoseo_route_manager'] = $this->language->get("text_neoseo_route_manager");
				$data['neoseo_route_manager'] = $this->url->link('tool/neoseo_route_manager', 'token=' . $this->session->data['token'], 'SSL');
			}
		}
		/* NeoSeo Route Manager - begin */

		/* NeoSeo Robots Generator - begin */
		if( $this->user->hasPermission('access','tool/neoseo_robots_generator') && isset($this->session->data['token']) ) {
		    $this->language->load("tool/neoseo_robots_generator");
			if( $this->config->get("neoseo_robots_generator_status") ) {
				$data['neoseo_robots_generator_status'] = $this->config->get("neoseo_robots_generator_status");
				$data['text_neoseo_robots_generator'] = $this->language->get("text_neoseo_robots_generator");
				$data['neoseo_robots_generator'] = $this->url->link('tool/neoseo_robots_generator', 'token=' . $this->session->data['token'], 'SSL');
			}
		}
		/* NeoSeo Robots Generator - begin */

		/* NeoSeo Order Referrer - begin */
		$data['neoseo_order_referrer'] = false;
		if( isset($this->session->data['token']) ) {
			if( $this->user->hasPermission('access','tool/neoseo_order_referrer') && $this->config->get("neoseo_order_referrer_status") ){
				$this->language->load("tool/neoseo_order_referrer");
				$data['text_neoseo_order_referrer'] = $this->language->get("text_neoseo_order_referrer");
				$data['neoseo_order_referrer'] = $this->url->link('tool/neoseo_order_referrer', 'token=' .$this->session->data['token'], 'SSL');
			}
		}
		/* NeoSeo Order Referrer - begin */

		/* NeoSeo Checkout - begin */
		if( $this->user->hasPermission('access','localisation/neoseo_address') && isset($this->session->data['token']) ) {
			$this->language->load("localisation/neoseo_address");
			if( $this->config->get("neoseo_checkout_status") ) {
				$data['text_address'] = $this->language->get("text_address");
				$data['address'] = $this->url->link('localisation/neoseo_address', 'token=' . $this->session->data['token'], 'SSL');
			}
		}
		if( $this->user->hasPermission('access','localisation/neoseo_city') && isset($this->session->data['token']) ) {
			$this->language->load("localisation/neoseo_city");
			if( $this->config->get("neoseo_checkout_status") ) {
				$data['text_city'] = $this->language->get("text_city");
				$data['city'] = $this->url->link('localisation/neoseo_city', 'token=' . $this->session->data['token'], 'SSL');
			}
		}
		if( $this->user->hasPermission('access','sale/neoseo_dropped_cart') && isset($this->session->data['token']) ) {
			$this->language->load("sale/neoseo_dropped_cart");
			if( $this->config->get("neoseo_checkout_status") ) {
				$data['text_dropped_cart'] = $this->language->get("text_dropped_cart");
				$data['dropped_cart'] = $this->url->link('sale/neoseo_dropped_cart', 'token=' . $this->session->data['token'], 'SSL');
			}
		}
		/* NeoSeo Checkout - end */

		/* NeoSeo Improvement - begin */
		$this->language->load("marketing/neoseo_improvement_menu");
		$data['text_main_page'] = $this->language->get("text_main_page");
		$data['text_category_page'] = $this->language->get("text_category_page");
		$data['text_product_page'] = $this->language->get("text_product_page");
		$data['text_checkout_page'] = $this->language->get("text_checkout_page");
		$data['text_account_page'] = $this->language->get("text_account_page");
		$data['text_admin_home_page'] = $this->language->get("text_admin_home_page");
		$data['text_integration_services'] = $this->language->get("text_integration_services");
		$data['text_adding_products'] = $this->language->get("text_adding_products");
		$data['text_technical_modules'] = $this->language->get("text_technical_modules");
		$data['text_advancement'] = $this->language->get("text_advancement");
		$data['text_improvement'] = $this->language->get("text_improvement");

		$data['main_page'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=main_page', 'SSL');
		$data['category_page'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=category_page', 'SSL');
		$data['product_page'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=product_page', 'SSL');
		$data['checkout_page'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=checkout_page', 'SSL');
		$data['account_page'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=account_page', 'SSL');
		$data['admin_home_page'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=admin_home_page', 'SSL');
		$data['integration_services'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=integration_services', 'SSL');
		$data['adding_products'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=adding_products', 'SSL');
		$data['technical_modules'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=technical_modules', 'SSL');
		$data['advancement'] = $this->url->link('marketing/neoseo_improvement', 'token=' . $this->session->data['token'].'&type=seo_structure,seo_tuning,seo_blog,product_feed,manager_actions', 'SSL');
		/* NeoSeo Improvement - end */
		
		$data['banner'] = $this->url->link('design/banner', 'token=' . $this->session->data['token'], 'SSL');
		$data['captcha'] = $this->url->link('extension/captcha', 'token=' . $this->session->data['token'], 'SSL');
		$data['category'] = $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL');
		$data['country'] = $this->url->link('localisation/country', 'token=' . $this->session->data['token'], 'SSL');
		$data['contact'] = $this->url->link('marketing/contact', 'token=' . $this->session->data['token'], 'SSL');
		$data['coupon'] = $this->url->link('marketing/coupon', 'token=' . $this->session->data['token'], 'SSL');
		$data['currency'] = $this->url->link('localisation/currency', 'token=' . $this->session->data['token'], 'SSL');
		$data['customer'] = $this->url->link('customer/customer', 'token=' . $this->session->data['token'], 'SSL');

		/* NeoSeo Subscribe - begin */
		$data['neoseo_subscribe'] = false;
		if( isset($this->session->data['token']) ) {
			if( $this->user->hasPermission('access','customer/neoseo_subscribe') && $this->config->get("neoseo_subscribe_status")){
				$this->language->load("customer/neoseo_subscribe");
				$data['neoseo_subscribe_status'] = $this->config->get("neoseo_subscribe_status");
				$data['text_neoseo_subscribe'] = $this->language->get("text_neoseo_subscribe");
				$data['neoseo_subscribe'] = $this->url->link('customer/neoseo_subscribe', 'token=' .$this->session->data['token'], 'SSL');
			}
		}
		/* NeoSeo Subscribe  - end */

		$data['customer_fields'] = $this->url->link('customer/customer_field', 'token=' . $this->session->data['token'], 'SSL');
		$data['customer_group'] = $this->url->link('customer/customer_group', 'token=' . $this->session->data['token'], 'SSL');
		$data['custom_field'] = $this->url->link('customer/custom_field', 'token=' . $this->session->data['token'], 'SSL');
		$data['download'] = $this->url->link('catalog/download', 'token=' . $this->session->data['token'], 'SSL');
		$data['error_log'] = $this->url->link('tool/error_log', 'token=' . $this->session->data['token'], 'SSL');
		$data['feed'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');
		$data['filter'] = $this->url->link('catalog/filter', 'token=' . $this->session->data['token'], 'SSL');
		$data['fraud'] = $this->url->link('extension/fraud', 'token=' . $this->session->data['token'], 'SSL');
		$data['geo_zone'] = $this->url->link('localisation/geo_zone', 'token=' . $this->session->data['token'], 'SSL');
		$data['information'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'], 'SSL');

		/* NeoSeo Testimonials - begin */
		$data['neoseo_testimonials'] = false;
		if( isset($this->session->data['token']) ) {
			$this->load->model('setting/setting');
			$neoseo_testimonial_code=$this->model_setting_setting->getSetting('neoseo_testimonials');
			if( $this->user->hasPermission('access','catalog/neoseo_testimonials')&& $neoseo_testimonial_code) {
				$this->language->load("catalog/neoseo_testimonials");
				$data['text_neoseo_testimonials'] = $this->language->get("text_neoseo_testimonials");
				$data['neoseo_testimonials'] = $this->url->link('catalog/neoseo_testimonials', 'token=' .$this->session->data['token'], 'SSL');
			}
		}
		/* NeoSeo NeoSeo Testimonials- begin */

		/* NeoSeo Action Manager - begin */
		$data['neoseo_action_manager'] = false;
		if( isset($this->session->data['token']) ) {
			$this->load->model('setting/setting');
			$neoseo_action_manager_code=$this->model_setting_setting->getSetting('neoseo_action_manager');
			if( $this->user->hasPermission('access','catalog/neoseo_action_manager')&& $neoseo_action_manager_code) {
				$this->language->load("catalog/neoseo_action_manager");
				$data['text_neoseo_action_manager'] = $this->language->get("text_neoseo_action_manager");
				$data['neoseo_action_manager'] = $this->url->link('catalog/neoseo_action_manager', 'token=' .$this->session->data['token'], 'SSL');
			}
		}
		/* NeoSeo Action Manager - end */

		$data['installer'] = $this->url->link('extension/installer', 'token=' . $this->session->data['token'], 'SSL');
		$data['language'] = $this->url->link('localisation/language', 'token=' . $this->session->data['token'], 'SSL');
		$data['layout'] = $this->url->link('design/layout', 'token=' . $this->session->data['token'], 'SSL');
		$data['location'] = $this->url->link('localisation/location', 'token=' . $this->session->data['token'], 'SSL');
		$data['modification'] = $this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL');
		$data['manufacturer'] = $this->url->link('catalog/manufacturer', 'token=' . $this->session->data['token'], 'SSL');
		$data['marketing'] = $this->url->link('marketing/marketing', 'token=' . $this->session->data['token'], 'SSL');
		$data['module'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['option'] = $this->url->link('catalog/option', 'token=' . $this->session->data['token'], 'SSL');

		/* NeoSeo Callback - begin */
		$data['neoseo_callback'] = false;
		if( isset($this->session->data['token']) ) {
			if( $this->user->hasPermission('access','sale/neoseo_callback') && $this->config->get("neoseo_callback_status") ){
				$this->language->load("sale/neoseo_callback");
				$data['text_neoseo_callback'] = $this->language->get("text_neoseo_callback");
				$data['neoseo_callback'] = $this->url->link('sale/neoseo_callback', 'token=' .$this->session->data['token'], 'SSL');
			}
		}
		/* NeoSeo Callback  - end */

		$data['order'] = $this->url->link('sale/order', 'token=' . $this->session->data['token'], 'SSL');
		$data['order_status'] = $this->url->link('localisation/order_status', 'token=' . $this->session->data['token'], 'SSL');
		$data['payment'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
		$data['paypal_search'] = $this->url->link('payment/pp_express/search', 'token=' . $this->session->data['token'], 'SSL');
		$data['product'] = $this->url->link('catalog/product', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_sale_order'] = $this->url->link('report/sale_order', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_sale_tax'] = $this->url->link('report/sale_tax', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_sale_shipping'] = $this->url->link('report/sale_shipping', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_sale_return'] = $this->url->link('report/sale_return', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_sale_coupon'] = $this->url->link('report/sale_coupon', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_product_viewed'] = $this->url->link('report/product_viewed', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_product_purchased'] = $this->url->link('report/product_purchased', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_customer_activity'] = $this->url->link('report/customer_activity', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_customer_online'] = $this->url->link('report/customer_online', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_customer_order'] = $this->url->link('report/customer_order', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_customer_reward'] = $this->url->link('report/customer_reward', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_customer_credit'] = $this->url->link('report/customer_credit', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_marketing'] = $this->url->link('report/marketing', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_affiliate'] = $this->url->link('report/affiliate', 'token=' . $this->session->data['token'], 'SSL');
		$data['report_affiliate_activity'] = $this->url->link('report/affiliate_activity', 'token=' . $this->session->data['token'], 'SSL');
		$data['review'] = $this->url->link('catalog/review', 'token=' . $this->session->data['token'], 'SSL');
		$data['return'] = $this->url->link('sale/return', 'token=' . $this->session->data['token'], 'SSL');
		$data['return_action'] = $this->url->link('localisation/return_action', 'token=' . $this->session->data['token'], 'SSL');
		$data['return_reason'] = $this->url->link('localisation/return_reason', 'token=' . $this->session->data['token'], 'SSL');
		$data['return_status'] = $this->url->link('localisation/return_status', 'token=' . $this->session->data['token'], 'SSL');
		$data['shipping'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
		$data['setting'] = $this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL');
		$data['stock_status'] = $this->url->link('localisation/stock_status', 'token=' . $this->session->data['token'], 'SSL');
		$data['tax_class'] = $this->url->link('localisation/tax_class', 'token=' . $this->session->data['token'], 'SSL');
		$data['tax_rate'] = $this->url->link('localisation/tax_rate', 'token=' . $this->session->data['token'], 'SSL');
		$data['total'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');
		$data['upload'] = $this->url->link('tool/upload', 'token=' . $this->session->data['token'], 'SSL');
		$data['user'] = $this->url->link('user/user', 'token=' . $this->session->data['token'], 'SSL');
		$data['user_group'] = $this->url->link('user/user_permission', 'token=' . $this->session->data['token'], 'SSL');
		$data['voucher'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'], 'SSL');
		$data['voucher_theme'] = $this->url->link('sale/voucher_theme', 'token=' . $this->session->data['token'], 'SSL');
		$data['weight_class'] = $this->url->link('localisation/weight_class', 'token=' . $this->session->data['token'], 'SSL');
		$data['length_class'] = $this->url->link('localisation/length_class', 'token=' . $this->session->data['token'], 'SSL');
		$data['zone'] = $this->url->link('localisation/zone', 'token=' . $this->session->data['token'], 'SSL');

		/* NeoSeo Blog - begin */
		$this->load->language('blog/neoseo_blog_link');

		$data['text_blogs'] = $this->language->get('text_blogs');
		$data['text_blog_author'] = $this->language->get('text_blog_author');
		$data['text_blog_category'] = $this->language->get('text_blog_category');
		$data['text_blog_article'] = $this->language->get('text_blog_article');
		$data['text_blog_comment'] = $this->language->get('text_blog_comment');
		$data['text_blog_report'] = $this->language->get('text_blog_report');

		$data['blog_author'] = $this->url->link('blog/neoseo_blog_author', 'token=' . $this->session->data['token'], 'SSL');
		$data['blog_category'] = $this->url->link('blog/neoseo_blog_category', 'token=' . $this->session->data['token'], 'SSL');
		$data['blog_article'] = $this->url->link('blog/neoseo_blog_article', 'token=' . $this->session->data['token'], 'SSL');
		$data['blog_comment'] = $this->url->link('blog/neoseo_blog_comment', 'token=' . $this->session->data['token'], 'SSL');
		$data['blog_report'] = $this->url->link('blog/neoseo_blog_report', 'token=' . $this->session->data['token'], 'SSL');
		
		//access menu blog
		$data['blog_style'] = ($this->user->hasPermission('access','blog/neoseo_blog_article') || $this->user->hasPermission('access','blog/category') || $this->user->hasPermission('access','blog/author') || $this->user->hasPermission('access','blog/comment') || $this->user->hasPermission('access','blog/report') ) ? "" : " style='display: none' ";
		$data['blog_article_style'] = $this->user->hasPermission('access','blog/neoseo_blog_article') ? "" : " style='display: none' ";
		$data['blog_category_style'] = $this->user->hasPermission('access','blog/neoseo_blog_category') ? "" : " style='display: none' ";
		$data['blog_author_style'] = $this->user->hasPermission('access','blog/neoseo_blog_author') ? "" : " style='display: none' ";
		$data['blog_comment_style'] = $this->user->hasPermission('access','blog/neoseo_blog_comment') ? "" : " style='display: none' ";
		$data['blog_report_style'] = $this->user->hasPermission('access','blog/neoseo_blog_report') ? "" : " style='display: none' ";
		/* NeoSeo Blog - end */
			
		$data['recurring'] = $this->url->link('catalog/recurring', 'token=' . $this->session->data['token'], 'SSL');
		$data['order_recurring'] = $this->url->link('sale/recurring', 'token=' . $this->session->data['token'], 'SSL');

		$data['openbay_show_menu'] = $this->config->get('openbaypro_menu');
		$data['openbay_link_extension'] = $this->url->link('extension/openbay', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_orders'] = $this->url->link('extension/openbay/orderlist', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_items'] = $this->url->link('extension/openbay/items', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_ebay'] = $this->url->link('openbay/ebay', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_ebay_settings'] = $this->url->link('openbay/ebay/settings', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_ebay_links'] = $this->url->link('openbay/ebay/viewitemlinks', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_etsy'] = $this->url->link('openbay/etsy', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_etsy_settings'] = $this->url->link('openbay/etsy/settings', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_etsy_links'] = $this->url->link('openbay/etsy_product/links', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_ebay_orderimport'] = $this->url->link('openbay/ebay/vieworderimport', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_amazon'] = $this->url->link('openbay/amazon', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_amazon_settings'] = $this->url->link('openbay/amazon/settings', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_amazon_links'] = $this->url->link('openbay/amazon/itemlinks', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_amazonus'] = $this->url->link('openbay/amazonus', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_amazonus_settings'] = $this->url->link('openbay/amazonus/settings', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_link_amazonus_links'] = $this->url->link('openbay/amazonus/itemlinks', 'token=' . $this->session->data['token'], 'SSL');
		$data['openbay_markets'] = array(
			'ebay' => $this->config->get('ebay_status'),
			'amazon' => $this->config->get('openbay_amazon_status'),
			'amazonus' => $this->config->get('openbay_amazonus_status'),
			'etsy' => $this->config->get('etsy_status'),
		);

        /* NeoSeo Quick Setup */
        // V1
        $data['text_qs'] = $this->language->get('text_qs');
        $data['text_qs_rocket'] = $this->language->get('text_qs_rocket');
        $data['neoseo_qs_link'] = $this->url->link('module/neoseo_quick_setup', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');
        // V2
        $this->load->language('module/neoseo_quick_setup');
        $data['neoseo_qs'][1] = $this->url->link('module/neoseo_quick_setup', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');
        $data['neoseo_qs'][2] = $this->url->link('module/neoseo_quick_setup/master2', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');
        $data['neoseo_qs'][3] = $this->url->link('module/neoseo_quick_setup/master3', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');
        $data['neoseo_qs'][4] = $this->url->link('module/neoseo_quick_setup/master4', 'token=' . $this->session->data['token'] . '&slider=1', 'SSL');

        $data['complete2'] = $this->config->get('neoseo_quick_setup_complete2');
        $data['complete3'] = $this->config->get('neoseo_quick_setup_complete3');
        $data['complete4'] = $this->config->get('neoseo_quick_setup_complete4');
        $data['complete1'] = $this->config->get('neoseo_quick_setup_complete');
        $data['current_step'] = 1;
        //echo $data['complete2'];exit;
        if($data['complete4']==1)$data['current_step'] = 4;
        elseif($data['complete3']==1)$data['current_step'] = 4;
        elseif($data['complete2']==1)$data['current_step'] = 3;
        elseif($data['complete1']==1)$data['current_step'] = 2;

        $data['qs_stepped_link'] = $data['neoseo_qs'][$data['current_step']];

        /* NeoSeo Quick Setup */

        /* octeam */
		$data['octeam_toolset'] = $this->url->link('octeam/toolset', 'token=' . $this->session->data['token'], 'SSL');

		return $this->load->view('common/menu.tpl', $data);
	}
}
