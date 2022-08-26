<?php
class ControllerProductManufacturer extends Controller {
	public function index() {
		$this->load->language('product/manufacturer');
		/* NeoSeo SEO Pagination - begin */
		$this->language->load('module/neoseo_seo_pagination');
		/* NeoSeo SEO Pagination - end */

		$this->load->model('catalog/manufacturer');

		$this->load->model('tool/image');

		/* NeoSeo Product Labels - begin */
		if (isset($this->request->get['product_label_id'])) {
			$filter_label_id = $this->request->get['product_label_id'];
		} else {
			$filter_label_id = null;
		}
		/* NeoSeo Product Labels - end  */

		$this->document->setTitle($this->language->get('heading_title'));

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_index'] = $this->language->get('text_index');
		$data['text_empty'] = $this->language->get('text_empty');

		$data['button_continue'] = $this->language->get('button_continue');

		$data['breadcrumbs'] = array();


        /* NeoSeo QuickOrder - begin */
        $this->language->load("module/neoseo_quick_order");
        $data['neoseo_quick_order_status'] = $this->config->get('neoseo_quick_order_status');
        $data['button_quick_order'] = $this->language->get('button_quick_order');
        /* NeoSeo QuickOrder - end */

            

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_brand'),
			'href' => $this->url->link('product/manufacturer')
		);

		$data['categories'] = array();

		$results = $this->model_catalog_manufacturer->getManufacturers();

		foreach ($results as $result) {
			$name = $result['name'];

			if (is_numeric(utf8_substr($name, 0, 1))) {
				$key = '0 - 9';
			} else {
				$key = utf8_substr(utf8_strtoupper($name), 0, 1);
			}

			if (!isset($data['categories'][$key])) {
				$data['categories'][$key]['name'] = $key;
			}

			$data['categories'][$key]['manufacturer'][] = array(
				'name' => $name,
				'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $result['manufacturer_id'])
			);
		}

		$breadcrumbs = [
			"@context" => "http://schema.org",
			"@type" => "BreadcrumbList",
			"itemListElement" => []
		];

		foreach ($data['breadcrumbs'] as $key => $breadcrumb) {
			$breadcrumbs['itemListElement'][] = [
				"@type" => "ListItem",
				"position" => $key+1,
				"item" =>  [
					"@id" => $breadcrumb['href'],
					"name" => $breadcrumb['text']
				]
			];

		}



		$data['continue'] = $this->url->link('common/home');

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/manufacturer_list.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/manufacturer_list.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/product/manufacturer_list.tpl', $data));
		}
	}

	public function info() {
		$this->load->language('product/manufacturer');
		/* NeoSeo SEO Pagination - begin */
		$this->language->load('module/neoseo_seo_pagination');
		/* NeoSeo SEO Pagination - end */

		$this->load->model('catalog/manufacturer');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		/* NeoSeo Product Labels - begin */
		if (isset($this->request->get['product_label_id'])) {
			$filter_label_id = $this->request->get['product_label_id'];
		} else {
			$filter_label_id = null;
		}
		/* NeoSeo Product Labels - end  */

		if (isset($this->request->get['manufacturer_id'])) {
			$manufacturer_id = (int)$this->request->get['manufacturer_id'];
		} else {
			$manufacturer_id = 0;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.sort_order';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = (int)$this->config->get('config_product_limit');
		}

		$data['breadcrumbs'] = array();


        /* NeoSeo QuickOrder - begin */
        $this->language->load("module/neoseo_quick_order");
        $data['neoseo_quick_order_status'] = $this->config->get('neoseo_quick_order_status');
        $data['button_quick_order'] = $this->language->get('button_quick_order');
        /* NeoSeo QuickOrder - end */

            

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_brand'),
			'href' => $this->url->link('product/manufacturer')
		);

		$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($manufacturer_id);

        /* NeoSeo Product Link - begin */
        $this->user = new User($this->registry);
        if ( $this->user->isLogged() ) {
            $data['edit_link'] = '/admin/index.php?route=catalog/manufacturer/edit&token=' . $this->session->data['token'] . '&manufacturer_id=' . $manufacturer_id;
        }
        /* NeoSeo Product Link - end */

		if ($manufacturer_info) {
			$this->document->setTitle($manufacturer_info['name']);

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			/* NeoSeo Product Labels - begin */
			if (isset($this->request->get['product_label_id'])) {
				$url .= '&product_label_id=' . $this->request->get['product_label_id'];
			}
			/* NeoSeo Product Labels - end */
			

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $manufacturer_info['name'],
				'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
			);

			if ($manufacturer_info['meta_title']) {
				$this->document->setTitle($manufacturer_info['meta_title']);
				/* NeoSeo SEO Pagination - begin */
				if( $page > 1 ) {
					$meta_title = sprintf($this->language->get("manufacturer_meta_title"),
						$manufacturer_info['meta_title'], $page );
					$this->document->setTitle($meta_title);
				}
				/* NeoSeo SEO Pagination - end */
			} else {
				$this->document->setTitle($manufacturer_info['name']);
			}

			$this->document->setDescription($manufacturer_info['meta_description']);
			/* NeoSeo SEO Pagination - begin */
			if( $page > 1 && trim($manufacturer_info['meta_description']) ) {
				$meta_description = sprintf($this->language->get("manufacturer_meta_description"),
					$manufacturer_info['meta_description'], $page );
				$this->document->setDescription($meta_description);
			}
			/* NeoSeo SEO Pagination - end */
			$this->document->setKeywords($manufacturer_info['meta_keyword']);
			/* NeoSeo SEO Pagination - begin */
			if( $page > 1 && trim($manufacturer_info['meta_keyword']) ) {
				$meta_keywords = sprintf($this->language->get("manufacturer_meta_keywords"),
					$manufacturer_info['meta_keyword'], $page );
				$this->document->setKeywords($meta_keywords);
			}
			/* NeoSeo SEO Pagination - end */

			if ($manufacturer_info['meta_h1']) {
				$data['heading_title'] = $manufacturer_info['meta_h1'];
				/* NeoSeo SEO Pagination - begin */
				if( $page > 1 ) {
					$data['heading_title'] = sprintf($this->language->get("manufacturer_meta_h1"),
						$manufacturer_info['meta_h1'], $page );
				}
				/* NeoSeo SEO Pagination - end */
			} else {
				$data['heading_title'] = $manufacturer_info['name'];
				/* NeoSeo SEO Pagination - begin */
				if( $page > 1 ) {
					$data['heading_title'] = sprintf($this->language->get("manufacturer_meta_h1"),
						$manufacturer_info['name'], $page );
				}
				/* NeoSeo SEO Pagination - end */
			}

			if ($manufacturer_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($manufacturer_info['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
				$this->document->setOgImage($data['thumb']);
			} else {
				$data['thumb'] = '';
			}

			$data['description'] = html_entity_decode($manufacturer_info['description'], ENT_QUOTES, 'UTF-8');

				/* NeoSeo SEO Pagination - begin */
				if( $page > 1 && trim($data['description']) ) {
					$description = sprintf($this->language->get("manufacturer_description"),
						$data['description'], $page );
					$data['description'] = $description;
				}
				/* NeoSeo SEO Pagination - end */

			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');
				/* NeoSeo Unistor - begin */
				$data['text_read_more'] = $this->language->get('text_read_more');
				$data['text_read_less'] = $this->language->get('text_read_less');
				$sharing_codes = $this->config->get('neoseo_unistor_general_sharing_code');
				$sharing_code = $sharing_codes[(int)$this->config->get('config_language_id')];
				$data['sharing_code'] = html_entity_decode($sharing_code);
				/* NeoSeo Unistor  - end */

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');

			$data['compare'] = $this->url->link('product/compare');

			$data['products'] = array();

			/* NeoSeo UniSTOR - begin */

			$colors_status = $this->config->get('neoseo_unistor_colors_status');

			/* NeoSeo UniSTOR - end */
				

			$filter_data = array(
				'filter_manufacturer_id' => $manufacturer_id,
				/* NeoSeo Product Labels - begin */
				'filter_label_id' => $filter_label_id,
			        /* NeoSeo Product Labels - end */
				'sort'                   => $sort,
				'order'                  => $order,
				'start'                  => ($page - 1) * $limit,
				'limit'                  => $limit
			);

			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

			/* NeoSeo Bad Pages - begin */
			if((count($results) == 0) && isset($this->request->get['page']) ){
				$this->response->redirect($this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id']),301);
			}
			/* NeoSeo Bad Pages - end */
				
			/* NeoSeo Product Labels - begin */
			$this->load->model("module/neoseo_product_labels");
			/* NeoSeo Product Labels - end */

			foreach ($results as $result) {

				/* NeoSeo UniSTOR - begin */
				if ($result['quantity'] > 0) {
					$stock_status_color = $colors_status[0]['font_color'];
				} elseif (isset($colors_status[$result['stock_status_id']]) ) {
					$stock_status_color = $colors_status[$result['stock_status_id']]['font_color'];
				} else {
					$stock_status_color = '#8c8c8c';
				}
				 $description_length = (int)$this->config->get('neoseo_unistor_product_short_description_length');
				if (!$description_length) {
					 $description_length = 300;
				 }
				$product_images = $this->model_catalog_product->getProductImages($result['product_id']);
				if (isset($product_images[0]) and isset($product_images[0]['image'])) {
					$product_image = $this->model_tool_image->resize($product_images[0]['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
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
					if  ($this->config->get('neoseo_unistor_product_show_sku') && $result['sku']) {
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

					if ($attribute_groups) {
						foreach ($attribute_groups as $attribute_group) {
							foreach ($attribute_group['attribute'] as $attribute) {
								if (in_array($attribute['attribute_id'], $product_selected_attributes)) {
										$additional_attributes[] = array(
											'name' => $attribute['name'].":",
											'text' => $attribute['text']
										);
								}
							}
						}
					}
				} else {
					$additional_attributes = array();
				}
				/* NeoSeo UniSTOR - end */
				
				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
				}

				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}

				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}

				$data['products'][] = array(
					/* NeoSeo UniSTOR - start */
					'thumb1'	  => $product_image,
					'stock_status_id' => ( $result['quantity'] > 0 ? 0 : $result['stock_status_id'] ),
					'stock_status'	=> ( $result['quantity'] > 0 ? $this->language->get('text_instock') : $result['stock_status'] ),
					'stock_status_color' => $stock_status_color,
					'md_availability' => $result['status'],
					'short_description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $description_length) . '..',
					'additional_attributes' => $additional_attributes,
					'total_attributes' => count($additional_attributes),
					'md_review_count' => $result['reviews'],
					/* NeoSeo UniSTOR - end */
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					/* NeoSeo Product Labels - begin */
					'labels'        => $this->model_module_neoseo_product_labels->getLabel($result),
					/* NeoSeo Product Labels - end */
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $result['rating'],
					'href'        => $this->url->link('product/product', 'manufacturer_id=' . $result['manufacturer_id'] . '&product_id=' . $result['product_id'] . $url)
				);
			}

			$url = '';

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();
			/* NeoSeo Product Labels - begin */
			$this->load->model("module/neoseo_product_labels");
			$labels = $this->model_module_neoseo_product_labels->getLabels();
			$language_id = $this->config->get('config_language_id');
			$discount_title = $this->config->get('neoseo_product_labels_special_title');
            $data['sorts'][0] = array(
                'text'  => isset($discount_title[$language_id]) ? $discount_title[$language_id] : 'Discount',
                'value' => 'label-0-DESC',
                'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] .'&sort=label-0&order=DESC&product_label_id=0'. $url)
            );
			foreach($labels as $label){
				$name = unserialize($label['name']);
				$data['sorts'][$label['label_id']] = array(
                    'text'  => $name[$language_id],
                    'value' => 'label-'.$label['label_id'].'-DESC',
                    'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] .'&sort=label-'.$label['label_id'].'&order=DESC&product_label_id='.$label['label_id']. $url)
                );
            }
			/* NeoSeo Product Labels - end */
			

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_default'),
				'value' => 'p.sort_order-ASC',
				'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=p.sort_order&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_asc'),
				'value' => 'pd.name-ASC',
				'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=pd.name&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_name_desc'),
				'value' => 'pd.name-DESC',
				'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=pd.name&order=DESC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=p.price&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=p.price&order=DESC' . $url)
			);

			if ($this->config->get('config_review_status')) {
				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=rating&order=DESC' . $url)
				);

				$data['sorts'][] = array(
					'text'  => $this->language->get('text_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=rating&order=ASC' . $url)
				);
			}

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_asc'),
				'value' => 'p.model-ASC',
				'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=p.model&order=ASC' . $url)
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_model_desc'),
				'value' => 'p.model-DESC',
				'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&sort=p.model&order=DESC' . $url)
			);

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			/* NeoSeo Product Labels - begin */
			if (isset($this->request->get['product_label_id'])) {
				$url .= '&product_label_id=' . $this->request->get['product_label_id'];
			}
			/* NeoSeo Product Labels - end */
			

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get('config_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url . '&limit=' . $value)
				);
			}

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			/* NeoSeo Product Labels - begin */
			if (isset($this->request->get['product_label_id'])) {
				$url .= '&product_label_id=' . $this->request->get['product_label_id'];
			}
			/* NeoSeo Product Labels - end */
			

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] .  $url . '&page={page}');
			/* NeoSeo UniSTOR - begin */
			$next_url = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . '&page=' . ($page + 1), 'SSL');
			$prev_url = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] .  '&page=' . ($page - 1), 'SSL');
			$data['desc_position'] = $this->config->get('neoseo_unistor_category_description_position');
			if ($page == 1) {
				$this->document->addLink($next_url, "next");
			} elseif ($page == ceil($pagination->total / $pagination->limit)) {
				$this->document->addLink($prev_url, "prev");
			} else {
				$this->document->addLink($next_url, "next");
				$this->document->addLink($prev_url, "prev");
			}
			$data['md_currency'] = $this->currency->getCode();
			$this->load->language('module/neoseo_unistor');
			$data['text_quickview'] = $this->language->get('text_quickview');
			$data['text_wishlist'] = $this->language->get('text_wishlist');
			$data['text_one_click_buy'] = $this->language->get('text_one_click_buy');
			$data['divider'] = html_entity_decode($this->config->get('neoseo_unistor_product_selected_attributes_custom_divider'));
			$data['button_table'] = $this->language->get('button_table');
			$data['colors_status'] = $this->config->get('neoseo_unistor_colors_status');
			$data['category_view_type'] = $this->config->get('neoseo_unistor_category_view_type');
			$sharing_codes = $this->config->get('neoseo_unistor_general_sharing_code');
			$sharing_code = $sharing_codes[(int)$this->config->get('config_language_id')];
			$data['sharing_code'] = html_entity_decode($sharing_code);
			/* NeoSeo UniSTOR - end */

			$data['pagination'] = $pagination->render();

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
			    $this->document->addLink($this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'], 'SSL'), 'canonical');
			} elseif ($page == 2) {
			    $this->document->addLink($this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'], 'SSL'), 'prev');
			} else {
			    $this->document->addLink($this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url . '&page='. ($page - 1), 'SSL'), 'prev');
			}

			if ($limit && ceil($product_total / $limit) > $page) {
			    $this->document->addLink($this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url . '&page='. ($page + 1), 'SSL'), 'next');
			}

			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

			$breadcrumbs = [
				"@context" => "http://schema.org",
				"@type" => "BreadcrumbList",
				"itemListElement" => []
			];

			foreach ($data['breadcrumbs'] as $key => $breadcrumb) {
				$breadcrumbs['itemListElement'][] = [
					"@type" => "ListItem",
					"position" => $key+1,
					"item" =>  [
						"@id" => $breadcrumb['href'],
						"name" => $breadcrumb['text']
					]
				];

			}


            $data['limit_p'] = (int)$this->config->get('neoseo_unistor_module_preview_count');
			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/manufacturer_info.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/manufacturer_info.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/product/manufacturer_info.tpl', $data));
			}
		} else {
			$url = '';

			if (isset($this->request->get['manufacturer_id'])) {
				$url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			/* NeoSeo Product Labels - begin */
			if (isset($this->request->get['product_label_id'])) {
				$url .= '&product_label_id=' . $this->request->get['product_label_id'];
			}
			/* NeoSeo Product Labels - end */
			

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('product/manufacturer/info', $url)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$breadcrumbs = [
				"@context" => "http://schema.org",
				"@type" => "BreadcrumbList",
				"itemListElement" => []
			];

			foreach ($data['breadcrumbs'] as $key => $breadcrumb) {
				$breadcrumbs['itemListElement'][] = [
					"@type" => "ListItem",
					"position" => $key+1,
					"item" =>  [
						"@id" => $breadcrumb['href'],
						"name" => $breadcrumb['text']
					]
				];

			}

			

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['header'] = $this->load->controller('common/header');
			$data['footer'] = $this->load->controller('common/footer');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}
}
