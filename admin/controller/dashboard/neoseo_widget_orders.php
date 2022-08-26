<?php

require_once( DIR_SYSTEM . '/engine/neoseo_controller.php');

class ControllerDashboardNeoSeoWidgetOrders extends NeoSeoController
{

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_widget_orders";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug");
	}

	public function index()
	{
		if ($this->config->get($this->_moduleSysName . '_status') != 1) {
			return false;
		}

		$this->load->model('tool/' . $this->_moduleSysName);
		$this->load->model('customer/customer_group');
		$this->load->model('sale/order');
		$this->load->model('tool/image');

		$data = $this->language->load('dashboard/' . $this->_moduleSysName);

		$language_id = $this->config->get('config_language_id');
		$product_image_width = $this->config->get($this->_moduleSysName . '_product_image_width');
		$product_image_height = $this->config->get($this->_moduleSysName . '_product_image_height');
		$limit = $this->config->get($this->_moduleSysName . '_limit');
		$order_statuses = $this->config->get($this->_moduleSysName . '_order_statuses');
		$title = $this->config->get($this->_moduleSysName . '_title');
		$data['title'] = isset($title[$language_id]) ? $title[$language_id] : '';
		$data['show_order_number'] = $this->config->get($this->_moduleSysName . '_show_order_number');
		$data['show_customer'] = $this->config->get($this->_moduleSysName . '_show_customer');
		$data['show_customer_email'] = $this->config->get($this->_moduleSysName . '_show_customer_email');
		$data['show_customer_telephone'] = $this->config->get($this->_moduleSysName . '_show_customer_telephone');
		$data['show_order_status'] = $this->config->get($this->_moduleSysName . '_show_order_status');
		$data['show_date_added'] = $this->config->get($this->_moduleSysName . '_show_date_added');
		$data['show_order_total'] = $this->config->get($this->_moduleSysName . '_show_order_total');
		$data['show_order_view'] = $this->config->get($this->_moduleSysName . '_show_order_view');
		$data['show_comment'] = $this->config->get($this->_moduleSysName . '_show_comment');
		$data['show_order_referrer'] = $this->config->get($this->_moduleSysName . '_show_order_referrer');
		$data['more'] = $this->url->link('sale/order', 'token=' . $this->session->data['token'], 'SSL');
		$data['setting_widget'] = $this->url->link('module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');

		/* NeoSeo Order Referrer - before */
		$order_referrer = false;
		if ($data['show_order_referrer'] == 1 &&
		    $this->config->get('neoseo_order_referrer_status') == 1) {
			$this->load->model('tool/neoseo_order_referrer');
			$order_referrer = true;
		} else {
			$data['show_order_referrer'] = 0;
		}
		/* NeoSeo Order Referrer - end */

		$data['count_items'] = $this->model_tool_neoseo_widget_orders->getTotalOrders($order_statuses);

		$data['orders'] = array();
		$orders = $this->model_tool_neoseo_widget_orders->getOrders($order_statuses, $limit);

		foreach ($orders as $order_info) {

			/* NeoSeo Order Referrer - before */
			if ($order_referrer) {
				$order = $this->model_sale_order->getOrder($order_info['order_id']);
				$order_info['first_referrer'] = $this->model_tool_neoseo_order_referrer->decode($order['first_referrer'], "list");
				$order_info['last_referrer'] = $this->model_tool_neoseo_order_referrer->decode($order['last_referrer'], "list");
			}
			/* NeoSeo Order Referrer - end */

			$customer_view = false;
			if ($order_info['customer_id'] != 0) {
				$customer_view = $this->url->link('customer/customer/edit', 'token=' . $this->session->data['token'] . '&customer_id=' . $order_info['customer_id'], 'SSL');
			}

			$customer_group = $this->model_customer_customer_group->getCustomerGroup($order_info['customer_group_id']);

			// Shipping Address
			if ($order_info['shipping_address_format']) {
				$format = $order_info['shipping_address_format'];
			} else {
				$format = $format = '{country}' . "\n" . '{postcode}' . "\n" . '{zone}' . "\n" . '{city}' . "\n" . '{address_1}' . "\n" . '{address_2}';
			}

			$find = array(
				'{country}',
				'{zone}',
				'{postcode}',
				'{city}',
				'{address_1}',
				'{address_2}',
			);

			$replace = array(
				'country' => $order_info['shipping_country'],
				'postcode' => $order_info['shipping_postcode'],
				'zone' => $order_info['shipping_zone'],
				'city' => $order_info['shipping_city'],
				'address_1' => $order_info['shipping_address_1'],
				'address_2' => $order_info['shipping_address_2'],
			);

			$shipping_address = str_replace(array("\r\n", "\r", "\n"), ', ', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), ', ', trim(str_replace($find, $replace, $format))));

			//Products order
			$products = array();

			$order_products = $this->model_sale_order->getOrderProducts($order_info['order_id']);

			foreach ($order_products as $product) {
				$option_data = array();

				$options = $this->model_sale_order->getOrderOptions($product['product_id'], $product['order_product_id']);

				foreach ($options as $option) {
					if ($option['type'] != 'file') {
						$option_data[] = array(
							'name' => $option['name'],
							'value' => $option['value'],
							'type' => $option['type']
						);
					} else {
						$this->load->model('tool/upload');
						$upload_info = $this->model_tool_upload->getUploadByCode($option['value']);

						if ($upload_info) {
							$option_data[] = array(
								'name' => $option['name'],
								'value' => $upload_info['name'],
								'type' => $option['type'],
								'href' => $this->url->link('tool/upload/download', 'token=' . $this->session->data['token'] . '&code=' . $upload_info['code'], 'SSL')
							);
						}
					}
				}
				$product_image = $this->model_tool_neoseo_widget_orders->getProductImage($product['product_id']);

				if ($product_image) {
					$image = $this->model_tool_image->resize($product_image, $product_image_width, $product_image_height);
				} else {
					$image = $this->model_tool_image->resize('no_image.png', $product_image_width, $product_image_height);
				}

				$products[] = array(
					'product_id' => $product['product_id'],
					'name' => $product['name'],
					'model' => $product['model'],
					'option' => $option_data,
					'quantity' => $product['quantity'],
					'image' => $image,
					'price' => $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']),
					'total' => $this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']),
					'href' => $this->url->link('catalog/product/edit', 'token=' . $this->session->data['token'] . '&product_id=' . $product['product_id'], 'SSL')
				);
			}

			//totals
			$order_totals = array();

			$totals = $this->model_sale_order->getOrderTotals($order_info['order_id']);

			foreach ($totals as $total) {
				$order_totals[] = array(
					'title' => $total['title'],
					'text' => $this->currency->format($total['value'], $order_info['currency_code'], $order_info['currency_value']),
				);
			}

			$data['orders'][] = array(
				'order_id' => $order_info['order_id'],
				/* NeoSeo Order Referrer - before */
				'first_referrer' => isset($order_info['first_referrer']) ? $order_info['first_referrer'] : '',
				'last_referrer' => isset($order_info['last_referrer']) ? $order_info['last_referrer'] : '',
				/* NeoSeo Order Referrer - end */
				'customer' => $order_info['firstname'] . ' ' . $order_info['lastname'],
				'email' => $order_info['email'],
				'telephone' => $order_info['telephone'],
				'customer_view' => $customer_view,
				'status' => $order_info['status'],
				'payment_method' => $order_info['payment_method'],
				'shipping_method' => $order_info['shipping_method'],
				'comment' => $order_info['comment'],
				'store_url' => $order_info['store_url'],
				'store_name' => $order_info['store_name'],
				'customer_group' => isset($customer_group['name']) ? $customer_group['name'] : '',
				'shipping_address' => $shipping_address,
				'products' => $products,
				'totals' => $order_totals,
				'date_added' => date($this->language->get('date_format_short'), strtotime($order_info['date_added'])),
				'total' => $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value']),
				'view' => $this->url->link('sale/order/info', 'token=' . $this->session->data['token'] . '&order_id=' . $order_info['order_id'], 'SSL'),
			);
		}

		return $this->load->view('dashboard/' . $this->_moduleSysName . '.tpl', $data);
	}

}
