<?php

require_once( DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerModuleNeoseoBestSeller extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_bestseller";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index($setting)
	{
		static $module = 1;

		if (isset($setting['title'][$this->config->get('config_language_id')])) {
			$data['heading_title'] = $setting['title'][$this->config->get('config_language_id')];
		} else {
			$data['heading_title'] = false;
		}

        $data['limit_p'] = (int)$this->config->get('neoseo_unistor_module_preview_count');
		$data['neoseo_quick_order_status'] = $this->config->get('neoseo_quick_order_status') || $this->config->get('soforp_quickorder_status');
		$colors_status = $this->config->get('neoseo_unistor_colors_status');
		$data['text_one_click_buy'] = $this->language->get('text_one_click_buy');
		$data['text_tax'] = $this->language->get('text_tax');
		$data['text_weight'] = $this->language->get('text_weight');

		$data['button_cart'] = $this->language->get('button_cart');
		$data['button_wishlist'] = $this->language->get('button_wishlist');
		$data['button_compare'] = $this->language->get('button_compare');

		$this->load->model('catalog/product');
		$this->load->model('tool/image');

		$data['md_currency'] = $this->currency->getCode();
		$data['text_quickview'] = $this->language->get('text_quickview');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_compare'] = $this->language->get('text_compare');
		$data['products'] = array();

		$template = 'default';

		if ($setting['template'] != $template && file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/neoseo_latest_' . $setting['template'] . '.tpl')) {
			$template = $setting['template'];
		}

		if ($setting['description_limit'] && $setting['description_limit'] > 0) {
			$description_limit = $setting['description_limit'];
		} else {
			$description_limit = $this->config->get('config_product_description_length');
		}

		if (isset($this->request->get['route']) && $this->request->get['route']) {
			$route = str_replace('/', '_', $this->request->get['route']);
		} else {
			$route = 'common_home';
		}

		$cache_key = $this->_moduleSysName . '_' . $route . '_' . $module . '_' . $this->config->get('config_language_id');
		$data['divider'] = html_entity_decode($this->config->get('neoseo_unistor_product_selected_attributes_custom_divider'));

		/* Neoseo Product Options PRO - begin */
		$data['product_list_status'] = $this->config->get('neoseo_product_options_pro_product_list_status');
		/* Neoseo Product Options PRO - end */

		/* NeoSeo Product Labels - begin */
		if ($this->config->get('neoseo_product_labels_status') == 1) {
			$this->load->model("module/neoseo_product_labels");
		}
		/* NeoSeo Product Labels - end */

		/* NeoSeo Notify When Available - begin */
		$notify_when_available_status = $this->config->get("neoseo_notify_when_available_status");
		if ($notify_when_available_status) {
			$this->language->load("module/neoseo_notify_when_available");
			$this->load->model('module/neoseo_notify_when_available');
			$notify_when_available_stock_statuses = $this->config->get("neoseo_notify_when_available_stock_statuses");
			$data['button_snwa_subscribe'] = $this->language->get('button_subscribe');
			$data['button_snwa_unsubscribe'] = $this->language->get('button_unsubscribe');
			if (isset($this->request->cookie['neoseo_notify_when_available_email'])) {
				$snwa_email = $this->request->cookie['neoseo_notify_when_available_email'];
			}
		}
		/* NeoSeo Notify When Available - end */

        $data['products'] = $this->getCached($this->_moduleSysName . '_' . $route . '_' . $module);
		if (!$data['products']) {
			$results = $this->model_catalog_product->getBestSellerProducts($setting['limit']);

			if ($results) {
				foreach ($results as $result) {
					if ($result['quantity'] > 0) {
						$stock_status_color = $colors_status[0]['font_color'];
					} elseif (isset($colors_status[$result['stock_status_id']])) {
						$stock_status_color = $colors_status[$result['stock_status_id']]['font_color'];
					} else {
						$stock_status_color = '#8c8c8c';
					}
					$description_length = (int)$this->config->get('neoseo_unistor_product_short_description_length');
					if (!$description_length) {
						$description_length = 300;
					}
					if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
						$image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
					} else {
						$image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
					}

					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}

					if ((float) $result['special']) {
						$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}

					if ($this->config->get('config_tax')) {
						$tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price']);
					} else {
						$tax = false;
					}

					if ($this->config->get('config_review_status')) {
						$rating = $result['rating'];
					} else {
						$rating = false;
					}

					$product_images = $this->model_catalog_product->getProductImages($result['product_id']);
					if (isset($product_images[0]) and isset($product_images[0]['image'])) {
						$product_image = $this->model_tool_image->resize($product_images[0]['image'], $setting['width'], $setting['height']);
					} else {
						$product_image = false;
					}

					if ($this->config->get('neoseo_unistor_product_attributes_status')) {
						$additional_attributes = array();
						if ($this->config->get('neoseo_unistor_product_show_manufacturer') && $result['manufacturer']) {
							$additional_attributes[] = array(
								'name' => $this->language->get('text_manufacturer'),
								'text' => $result['manufacturer']);
						}
						if ($this->config->get('neoseo_unistor_product_show_model') && $result['model']) {
							$additional_attributes[] = array(
								'name' => $this->language->get('text_model'),
								'text' => $result['model']);
						}
						if ($this->config->get('neoseo_unistor_product_show_sku') && $result['sku']) {
							$additional_attributes[] = array(
								'name' => $this->language->get('text_sku'),
								'text' => $result['sku']);
						}
						if ($this->config->get('neoseo_unistor_product_show_weight') && $result['weight']) {
							$additional_attributes[] = array(
								'name' => $this->language->get('text_weight'),
								'text' => $result['weight']);
						}
						$attribute_groups = $this->model_catalog_product->getProductAttributes($result['product_id']);
						$product_selected_attributes = $this->config->get('neoseo_unistor_product_selected_attributes');

						if ($attribute_groups && $product_selected_attributes) {
							foreach ($attribute_groups as $attribute_group) {
								foreach ($attribute_group['attribute'] as $attribute) {
									if (in_array($attribute['attribute_id'], $product_selected_attributes)) {
										$additional_attributes[] = array(
											'name' => $attribute['name'] . ":",
											'text' => $attribute['text']
										);
									}
								}
							}
						}
					} else {
						$additional_attributes = array();
					}

					/* Neoseo Product Options PRO - begin */
					$options = array();
					if ($this->config->get('neoseo_product_options_pro_status') && $data['product_list_status'] == 1) {
						foreach ($this->model_catalog_product->getProductOptions($result['product_id']) as $option) {
							$product_option_value_data = array();

							foreach ($option['product_option_value'] as $option_value) {
								if (!$option_value['subtract'] || isset($option_value['quantity'])) {

									$product_option_value_data[] = array(
										'product_option_value_id' => $option_value['product_option_value_id'],
										'option_value_id' => $option_value['option_value_id'],
										'name' => $option_value['name'],
										'image' => $this->model_tool_image->resize($option_value['image'], 50, 50),
										'price' => $price,
										'price_prefix' => $option_value['price_prefix']
									);
								}
							}

							$options[] = array(
								'product_option_id' => $option['product_option_id'],
								'product_option_value' => $product_option_value_data,
								'option_id' => $option['option_id'],
								'name' => $option['name'],
								'type' => $option['type'],
								'value' => $option['value'],
								'required' => $option['required']
							);
						}
					}
					/* Neoseo Product Options PRO - end */

					/* NeoSeo Notify When Available - begin */
					$snwa_status = false;
					$snwa_requested = false;
					if ($result['quantity'] <= 0 && isset($notify_when_available_status) && $notify_when_available_status && in_array($result['stock_status_id'], $notify_when_available_stock_statuses)) {
						$snwa_status = true;
						if (isset($snwa_email)) {
							$snwa_request = $this->model_module_neoseo_notify_when_available->getRequest($snwa_email, $result['product_id']);
							$snwa_requested = ($snwa_request && $snwa_request['status'] );
						}
					}
					/* NeoSeo Notify When Available - end */

					$discounts = $this->model_catalog_product->getProductDiscounts($result['product_id']);
					$product_discounts = array();
					foreach ($discounts as $discount) {
						$product_discounts[] = array(
							'quantity' => $discount['quantity'],
							'price'    => $this->currency->format($this->tax->calculate($discount['price'], $result['tax_class_id'], $this->config->get('config_tax')))
						);
					}

					$data['products'][] = array(
						/* Neoseo Product Options PRO - begin */
						'options' => $options,
						/* NeoSeo Product Labels - begin */
						'labels' => $this->model_module_neoseo_product_labels ? $this->model_module_neoseo_product_labels->getLabel($result) : false,
						/* NeoSeo Product Labels - end */
						'product_id' => $result['product_id'],
						'thumb' => $image,
						'thumb1' => $product_image,
						'name' => $result['name'],
						'minimum' => $result['minimum'],
						'short_description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $description_length) . '..',
						'stock_status' => ($result['quantity'] <= 0) ? $result['stock_status'] : $this->language->get('text_instock'),
						'stock_status_id' => ($result['quantity'] <= 0) ? (int) $result['stock_status_id'] : 0,
						'stock_status_color' => $stock_status_color,
						'md_availability' => $result['status'],
						'md_review_count' => $result['reviews'],
						'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $description_limit) . '..',
						'price' => $price,
						'special' => $special,
						'tax' => $tax,
						'rating' => $rating,
						'additional_attributes' => $additional_attributes,
						'total_attributes' => count($additional_attributes),
						/* NeoSeo Notify When Available - begin */
						'snwa_status' => $snwa_status,
						'snwa_requested' => $snwa_requested,
						/* NeoSeo Notify When Available - end */
						'discounts'       => $product_discounts,
						'mpn'             => $result['mpn'],
						'upc'             => $result['upc'],
						'ean'             => $result['ean'],
						'jan'             => $result['ean'],
						'isbn'            => $result['isbn'],
						'weight'          => $result['weight'],
						'weight_unit'     => $this->weight->getUnit($result['weight_class_id']),
						'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
					);
				}

                $this->setCached($this->_moduleSysName . '_' . $route . '_' . $module, $data['products']);
			}
		}

		$data['module'] = $module++;

		if (!$data['products']) {
			return '';
		}

		$data['use_image'] = $setting['use_image'];
		$data['image_width'] = ($setting['image_width']>0)?$setting['image_width']:400;
		$data['image_height'] = ($setting['image_height']>0)?$setting['image_height']:400;

		if ($setting['image'] && is_file(DIR_IMAGE . $setting['image'])) {
			$data['block_image'] = $this->model_tool_image->resize($setting['image'], $setting['image_width'],  $setting['image_height']);
		} else {
			$data['block_image'] = $this->model_tool_image->resize('no_image.png', $setting['image_width'],  $setting['image_height']);
		}

		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.carousel.css');
		$this->document->addStyle('catalog/view/javascript/jquery/owl-carousel/owl.transitions.css');
		$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/neoseo_bestseller_' . $template . '.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/neoseo_bestseller_' . $template . '.tpl', $data);
		} else {
			return $this->load->view('default/template/module/neoseo_bestseller_' . $template . '.tpl', $data);
		}
	}

}
