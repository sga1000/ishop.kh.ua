<?php
class ControllerCheckoutCart extends Controller {


	/* NeoSeo QuickOrder - begin */
	protected function renderTemplate($template, $data)
	{
		extract($data);

		ob_start();
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $template)) {
			$template_file = $this->config->get('config_template') . '/template/' . $template;
		} else {
			$template_file = 'default/template/' . $template;
		}
		require(DIR_TEMPLATE . $template_file);
		$result = ob_get_contents();
		ob_end_clean();

		return $result;
	}
	/* NeoSeo QuickOrder - end */

	public function index() {

		/* NeoSeo Checkout - begin */
		if ($this->cart->hasProducts() && $this->config->get('neoseo_checkout_status') && $this->config->get('neoseo_checkout_cart_redirect')) {
			$this->response->redirect($this->url->link('checkout/checkout', '', 'SSL'));
		}
		/* NeoSeo Checkout - end */

		$this->load->language('checkout/cart');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home')
		);

		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('checkout/cart'),
			'text' => $this->language->get('heading_title')
		);

		if ($this->cart->hasProducts() || !empty($this->session->data['vouchers'])) {
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_recurring_item'] = $this->language->get('text_recurring_item');
			$data['text_next'] = $this->language->get('text_next');
			$data['text_next_choice'] = $this->language->get('text_next_choice');

			/* NeoSeo Checkout - begin */
			$this->load->language('checkout/neoseo_checkout');

			/* NeoSeo Checkout - end */
			$data['column_image'] = $this->language->get('column_image');
			$data['column_name'] = $this->language->get('column_name');
			$data['column_model'] = $this->language->get('column_model');
			$data['column_quantity'] = $this->language->get('column_quantity');
			$data['column_price'] = $this->language->get('column_price');
			$data['column_total'] = $this->language->get('column_total');

			$data['button_update'] = $this->language->get('button_update');
			$data['button_remove'] = $this->language->get('button_remove');
			$data['button_shopping'] = $this->language->get('button_shopping');
			$data['button_checkout'] = $this->language->get('button_checkout');

			if (!$this->cart->hasStock() && (!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning'))) {
				$data['error_warning'] = $this->language->get('error_stock');
			} elseif (isset($this->session->data['error'])) {
				$data['error_warning'] = $this->session->data['error'];

				unset($this->session->data['error']);
			} else {
				$data['error_warning'] = '';
			}

			/* NeoSeo Checkout - begin */
			$min_amount = $this->config->get("neoseo_checkout_min_amount");
			$subtotal = $this->cart->getSubTotal();
			if ($min_amount > 0 && $min_amount > $subtotal ) {
				$this->language->load("neoseo_checkout/checkout");
				$data['error_warning'] = sprintf($this->language->get("error_min_amount"),
					$this->currency->format($min_amount),
					$this->currency->format($subtotal)
				);
			}
			/* NeoSeo Checkout - end */
			if ($this->config->get('config_customer_price') && !$this->customer->isLogged()) {
				$data['attention'] = sprintf($this->language->get('text_login'), $this->url->link('account/login'), $this->url->link('account/register'));
			} else {
				$data['attention'] = '';
			}

			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];

				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}

			$data['action'] = $this->url->link('checkout/cart/edit', '', true);

			if ($this->config->get('config_cart_weight')) {
				$data['weight'] = $this->weight->format($this->cart->getWeight(), $this->config->get('config_weight_class_id'), $this->language->get('decimal_point'), $this->language->get('thousand_point'));
			} else {
				$data['weight'] = '';
			}

			$this->load->model('tool/image');
			$this->load->model('tool/upload');

			$data['products'] = array();

			$products = $this->cart->getProducts();

			/* NeoSeo QuickOrder - begin */
			$this->language->load("module/neoseo_quick_order");
			$data_quick_order['neoseo_quick_order_status'] = $this->config->get('neoseo_quick_order_status');
			$data_quick_order['neoseo_quick_order_status_cart'] = $this->config->get('neoseo_quick_order_status_cart');
			$data_quick_order['button_quick_order'] = $this->language->get('button_quick_order');
			$data_quick_order['text_quick_order'] = $this->language->get('text_quick_order');
			$data_quick_order['text_no_phone'] = $this->language->get('text_no_phone');
			$data_quick_order['quick_order_phone_mask'] = $this->config->get('neoseo_quick_order_phone_mask');
			$sum_quantity = 0;
			$quick_products = array();
			/* NeoSeo QuickOrder - end */

			foreach ($products as $product) {
				$product_total = 0;

				foreach ($products as $product_2) {
					if ($product_2['product_id'] == $product['product_id']) {
						$product_total += $product_2['quantity'];
					}
				}

				if ($product['minimum'] > $product_total) {
					$data['error_warning'] = sprintf($this->language->get('error_minimum'), $product['name'], $product['minimum']);
				}

				if ($product['image']) {
					$image = $this->model_tool_image->resize($product['image'], $this->config->get('config_image_cart_width'), $this->config->get('config_image_cart_height'));
				} else {
					$image = '';
				}

				$option_data = array();

				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['value'];
					} else {
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$value = $upload_info['name'];
						} else {
							$value = '';
						}
					}

					$option_data[] = array(
						'name'  => $option['name'],
						'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
					);
				}

				// Display prices
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
				} else {
					$price = false;
				}

				// Display prices
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$total = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')) * $product['quantity']);
				} else {
					$total = false;
				}

				$recurring = '';

				if ($product['recurring']) {
					$frequencies = array(
						'day'        => $this->language->get('text_day'),
						'week'       => $this->language->get('text_week'),
						'semi_month' => $this->language->get('text_semi_month'),
						'month'      => $this->language->get('text_month'),
						'year'       => $this->language->get('text_year'),
					);

					if ($product['recurring']['trial']) {
						$recurring = sprintf($this->language->get('text_trial_description'), $this->currency->format($this->tax->calculate($product['recurring']['trial_price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['trial_cycle'], $frequencies[$product['recurring']['trial_frequency']], $product['recurring']['trial_duration']) . ' ';
					}

					if ($product['recurring']['duration']) {
						$recurring .= sprintf($this->language->get('text_payment_description'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					} else {
						$recurring .= sprintf($this->language->get('text_payment_cancel'), $this->currency->format($this->tax->calculate($product['recurring']['price'] * $product['quantity'], $product['tax_class_id'], $this->config->get('config_tax'))), $product['recurring']['cycle'], $frequencies[$product['recurring']['frequency']], $product['recurring']['duration']);
					}
				}


				/* NeoSeo QuickOrder - begin */
				if($data_quick_order['neoseo_quick_order_status_cart'] ) {
						$sum_quantity = $sum_quantity + $product['quantity'];
						$quick_products[$product['product_id']] = $product['quantity'] ;
				}
				/* NeoSeo QuickOrder - end */

				$data['products'][] = array(
					'cart_id'   => $product['cart_id'],
					'thumb'     => $image,
					'name'      => $product['name'],
					'model'     => $product['model'],
					'option'    => $option_data,
					'recurring' => $recurring,
					'quantity'  => $product['quantity'],
					'stock'     => $product['stock'] ? true : !(!$this->config->get('config_stock_checkout') || $this->config->get('config_stock_warning')),
					'reward'    => ($product['reward'] ? sprintf($this->language->get('text_points'), $product['reward']) : ''),
					'price'     => $price,
					'total'     => $total,
					'href'      => $this->url->link('product/product', 'product_id=' . $product['product_id'])
				);
			}
			// Gift Voucher

			/* NeoSeo QuickOrder - begin */
			if($data_quick_order['neoseo_quick_order_status_cart'] ) {
					$data_quick_order['sum_quantity'] = $sum_quantity;
					$data_quick_order['products'] =  serialize($quick_products);
					$data_quick_order['products'] = urlencode($data_quick_order['products']);
					$template = $this->config->get('neoseo_quick_order_cart_template');
					$data['neoseo_quick_order_cart_template'] = $this->renderTemplate('module/neoseo_quick_order_' . $template . '.tpl', $data_quick_order);
				}
			/* NeoSeo QuickOrder - end */

			$data['vouchers'] = array();

			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $key => $voucher) {
					$data['vouchers'][] = array(
						'key'         => $key,
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount']),
						'remove'      => $this->url->link('checkout/cart', 'remove=' . $key)
					);
				}
			}

			// Totals
			$this->load->model('extension/extension');

			$total_data = array();
			$total = 0;
			$taxes = $this->cart->getTaxes();

			// Display prices
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('total/' . $result['code']);

						$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
					}
				}

				$sort_order = array();

				foreach ($total_data as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $total_data);
			}

			$data['totals'] = array();

			foreach ($total_data as $total) {
				$data['totals'][] = array(
					'title' => $total['title'],
					'text'  => $this->currency->format($total['value'])
				);
			}

			$data['continue'] = $this->url->link('common/home');

			$data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');

			$this->load->model('extension/extension');

			$data['checkout_buttons'] = array();

			$files = glob(DIR_APPLICATION . '/controller/total/*.php');

			if ($files) {
				foreach ($files as $file) {
					$extension = basename($file, '.php');

					$data[$extension] = $this->load->controller('total/' . $extension);
				}
			}

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/checkout/cart.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/checkout/cart.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/checkout/cart.tpl', $data));
			}
		} else {
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_error'] = $this->language->get('text_empty');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			unset($this->session->data['success']);

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}

	public function add() {
		$this->load->language('checkout/cart');

		$json = array();

		if (isset($this->request->post['product_id'])) {
			$product_id = (int)$this->request->post['product_id'];
		} else {
			$product_id = 0;
		}

		$this->load->model('catalog/product');

		$product_info = $this->model_catalog_product->getProduct($product_id);

		if ($product_info) {
			if (isset($this->request->post['quantity']) && ((int)$this->request->post['quantity'] >= $product_info['minimum'])) {
				$quantity = (int)$this->request->post['quantity'];
			} else {
				$quantity = $product_info['minimum'] ? $product_info['minimum'] : 1;
			}

			if (isset($this->request->post['option'])) {
				$option = array_filter($this->request->post['option']);
			} else {
				$option = array();
			}

			$product_options = $this->model_catalog_product->getProductOptions($this->request->post['product_id']);

			foreach ($product_options as $product_option) {
				if ($product_option['required'] && empty($option[$product_option['product_option_id']])) {
					$json['error']['option'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
				}
			}

			if (isset($this->request->post['recurring_id'])) {
				$recurring_id = $this->request->post['recurring_id'];
			} else {
				$recurring_id = 0;
			}

			$recurrings = $this->model_catalog_product->getProfiles($product_info['product_id']);

			if ($recurrings) {
				$recurring_ids = array();

				foreach ($recurrings as $recurring) {
					$recurring_ids[] = $recurring['recurring_id'];
				}

				if (!in_array($recurring_id, $recurring_ids)) {
					$json['error']['recurring'] = $this->language->get('error_recurring_required');
				}
			}

			if (!$json) {
				$this->cart->add($this->request->post['product_id'], $quantity, $option, $recurring_id);

				$json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('checkout/cart'));

				// Unset all shipping and payment methods
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);

				// Totals
				$this->load->model('extension/extension');

				$total_data = array();
				$total = 0;
				$taxes = $this->cart->getTaxes();

				// Display prices
				if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
					$sort_order = array();

					$results = $this->model_extension_extension->getExtensions('total');

					foreach ($results as $key => $value) {
						$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
					}

					array_multisort($sort_order, SORT_ASC, $results);

					foreach ($results as $result) {
						if ($this->config->get($result['code'] . '_status')) {
							$this->load->model('total/' . $result['code']);

							$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
						}
					}

					$sort_order = array();

					foreach ($total_data as $key => $value) {
						$sort_order[$key] = $value['sort_order'];
					}

					array_multisort($sort_order, SORT_ASC, $total_data);
				}

				$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
			} else {
				$json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']));
			}
		}
		/* NeoSeo Checkout - begin */
		$this->event->trigger('post.cart.add', $json);
		/* NeoSeo Checkout - end */

		$this->response->addHeader('Content-Type: application/json');

		/* NeoSeo Popup Cart - begin */
		if($this->config->get('neoseo_popup_cart_status') == 1){
			$this->load->model("module/neoseo_popup_cart");
			$json = $this->model_module_neoseo_popup_cart->getCart($json);
		}
		/* NeoSeo Popup Cart - end */

		$this->response->setOutput(json_encode($json));
	}

	public function edit() {
		$this->load->language('checkout/cart');

		$json = array();

		// Update
		if (!empty($this->request->post['quantity'])) {
			foreach ($this->request->post['quantity'] as $key => $value) {
				$this->cart->update($key, $value);
			}

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			/* NeoSeo Popup Cart - begin */
			if( !isset($this->request->post['noredir']) ) {
			/* NeoSeo Popup Cart - end */
			$this->response->redirect($this->url->link('checkout/cart'));
			/* NeoSeo Popup Cart - begin */
			}
			/* NeoSeo Popup Cart - end */
		}
		/* NeoSeo Checkout - begin */
		$this->event->trigger('post.cart.edit', $json);
		/* NeoSeo Checkout - end */

		$this->response->addHeader('Content-Type: application/json');
		/* NeoSeo Popup Cart - begin */
		if($this->config->get('neoseo_popup_cart_status') == 1){
			$this->load->model("module/neoseo_popup_cart");
			$json = $this->model_module_neoseo_popup_cart->getCart($json);
		}
		/* NeoSeo Popup Cart - end */
		$this->response->setOutput(json_encode($json));
	}

	public function remove() {
		$this->load->language('checkout/cart');

		$json = array();

		// Remove
		if (isset($this->request->post['key'])) {
			/* NeoSeo Popup Cart - begin */
			if($this->config->get('neoseo_popup_cart_status') == 1){
				$this->load->model('catalog/product');
				$this->load->model('catalog/category');
				$this->load->model('catalog/manufacturer');
				if (isset($this->request->post['key'])) {
					 $product_id = (int)$this->request->post['key'];
				} else {
					$product_id = 0;
				}
				$product_info = $this->model_catalog_product->getProduct($this->request->post['key']);
				if( $product_info ) {
					$manufacturer = '';
					$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($product_info['manufacturer_id']);
					if( $manufacturer_info ) {
						$manufacturer = $manufacturer_info['name'];
					}

					$categories = $this->model_catalog_product->getCategories($product_info['product_id']);
					$category_id = 0;
					foreach( $categories as $category ) {
						if( !$category_id ) {
							$category_id = $category['category_id'];
						}
						if( isset($category['main_category']) && $category['main_category'] ) {
							$category_id = $category['category_id'];
							break;
						}
					}
					$category = '';
					if( $category_id ) {
						$category_info = $this->model_catalog_category->getCategory($category_id);
						while( $category_info ) {
						if ( $category ) {
							$category = $category_info['name'] . " / " . $category;
						} else {
							$category = $category_info['name'];
						}
						$category_info = $this->model_catalog_category->getCategory($category_info['parent_id']);
						}
					}

					$json['ecommerce'] = array(
						"product_id" => $product_info['product_id'],
						"sku" => $product_info['sku'],
						"name" => $product_info['name'],
						"manufacturer" => $manufacturer,
						"category" => $category,
						);
				}
			}
			/* NeoSeo Popup Cart - end */
			$this->cart->remove($this->request->post['key']);

			unset($this->session->data['vouchers'][$this->request->post['key']]);

			$this->session->data['success'] = $this->language->get('text_remove');

			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['reward']);

			// Totals
			$this->load->model('extension/extension');

			$total_data = array();
			$total = 0;
			$taxes = $this->cart->getTaxes();

			// Display prices
			if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('total/' . $result['code']);

						$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
					}
				}

				$sort_order = array();

				foreach ($total_data as $key => $value) {
					$sort_order[$key] = $value['sort_order'];
				}

				array_multisort($sort_order, SORT_ASC, $total_data);
			}

			/* NeoSeo Popup Cart - begin */
			if($this->config->get('neoseo_popup_cart_status') == 1){
				$this->load->model('catalog/product');
				$this->load->model('catalog/category');
				$this->load->model('catalog/manufacturer');
				$manufacturer = '';
				$manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($product_info['manufacturer_id']);
				if( $manufacturer_info ) {
					$manufacturer = $manufacturer_info['name'];
				}

				$categories = $this->model_catalog_product->getCategories($product_info['product_id']);
				$category_id = 0;
				foreach( $categories as $category ) {
					if( !$category_id ) {
					$category_id = $category['category_id'];
				 }
				if( isset($category['main_category']) && $category['main_category'] ) {
					$category_id = $category['category_id'];
					break;
				}
				}
				$category = '';
				if( $category_id ) {
					$category_info = $this->model_catalog_category->getCategory($category_id);
					while( $category_info ) {
						if ( $category ) {
							$category = $category_info['name'] . " / " . $category;
						} else {
							$category = $category_info['name'];
						}
						$category_info = $this->model_catalog_category->getCategory($category_info['parent_id']);
					}
				}
				$json['ecommerce'] = array(
					"product_id" => $product_info['product_id'],
					"sku" => $product_info['sku'],
					"name" => $product_info['name'],
					"manufacturer" => $manufacturer,
					"category" => $category,
				);
				/* NeoSeo Popup Cart - end */
				$json['total'] = sprintf($this->language->get('text_items'), $this->cart->countProducts() + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
			}
		}
		/* NeoSeo Checkout - begin */
		$this->event->trigger('post.cart.remove', $json);
		/* NeoSeo Checkout - end */
		$this->response->addHeader('Content-Type: application/json');
		/* NeoSeo Popup Cart - begin */
		if($this->config->get('neoseo_popup_cart_status') == 1){
			$this->load->model("module/neoseo_popup_cart");
			$json = $this->model_module_neoseo_popup_cart->getCart($json);
		}
		/* NeoSeo Popup Cart - end */
		$this->response->setOutput(json_encode($json));
	}
}
