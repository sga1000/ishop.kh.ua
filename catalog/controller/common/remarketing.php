<?php
class ControllerCommonRemarketing extends Controller {
	public function header() {
		if ($this->config->get('remarketing_status')) {
			$data['output'] = '';
		
			if ($this->config->get('remarketing_counter1') && $this->config->get('remarketing_counter1')) {
				$data['output'] .= "\n" . $this->config->get('remarketing_counter1');
			}
		
		return html_entity_decode($data['output'], ENT_QUOTES, 'UTF-8');
		}
	}
	
	public function body() {
		if ($this->config->get('remarketing_status')) {
			$data['output'] = '';
		
			if ($this->config->get('remarketing_counter2') && $this->config->get('remarketing_counter2')) {
				$data['output'] .= "\n" . $this->config->get('remarketing_counter2');
			}

			return html_entity_decode($data['output'], ENT_QUOTES, 'UTF-8');
		}
	}
	
	public function footer() {
		
		if ($this->config->get('remarketing_status')) {
			
			$data['google_output'] = '';
			$data['google_reviews_output'] = '';
			$data['facebook_output'] = '';
			$data['mytarget_output'] = '';
			$data['vk_output'] = '';
			$data['events_output'] = '';
			$data['ecommerce_output'] = '';
			$data['counter_output'] = '';
			
			$this->load->model('catalog/product');
			$this->load->model('checkout/order');	
			$this->load->model('tool/remarketing');
		
			$route = isset($this->request->get['route']) ? $this->request->get['route'] : '';
		
			$data['google_ids'] = [];
			$data['facebook_ids'] = [];
			$data['mytarget_ids'] = [];
			$data['vk_ids'] = [];
			$data['totalvalue'] = '';
			$data['google_page'] = false;
			$data['facebook_page'] = false;
			$data['mytarget_page'] = false;
			$data['vk_page'] = false;
			$data['google_reviews_page'] = false;
			$google_currency = $this->config->get('remarketing_google_currency'); 
			$facebook_currency = $this->config->get('remarketing_facebook_currency'); 
			$ecommerce_currency = $this->config->get('remarketing_ecommerce_currency'); 

			switch ($route) {
				case '':			
				case 'common/home':	
					$data['vk_page'] = 'view_home';
				break;
				case 'product/category':
				case 'product/search':
				case 'product/special':
				case 'product/manufacturer/info':
					break;	
				case 'product/product':
					$data['google_page'] = 'view_item';
					$data['facebook_page'] = false;
					$data['mytarget_page'] = 'product';
					$product_info = $this->model_catalog_product->getProduct($this->request->get['product_id']);
					$price = $this->currency->format($this->tax->calculate($product_info['special'] ? $product_info['special'] : $product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency'], '', false);
					$data['google_ids'][] = $this->config->get('remarketing_google_id') == 'id' ? $product_info['product_id'] : $product_info['model'];
					$data['facebook_ids'][] = $this->config->get('remarketing_facebook_id') == 'id' ? $product_info['product_id'] : $product_info['model'];
					$data['mytarget_ids'][] = $this->config->get('remarketing_mytarget_id') == 'id' ? $product_info['product_id'] : $product_info['model'];
					$data['totalvalue'] = $price;
					$data['google_totalvalue'] = $this->currency->format($product_info['special'] ? $product_info['special'] : $product_info['price'], $google_currency, '', false); 
					$data['facebook_totalvalue'] = $this->currency->format($product_info['special'] ? $product_info['special'] : $product_info['price'], $facebook_currency, '', false); 
					$data['ecommerce_totalvalue'] = $this->currency->format($product_info['special'] ? $product_info['special'] : $product_info['price'], $ecommerce_currency, '', false); 

					break;	
				case 'checkout/cart':
				case 'checkout/simplecheckout':
				case 'checkout/checkout':
				case 'checkout/unicheckout':
				case 'checkout/uni_checkout':
				case 'checkout/revcheckout':
				case 'checkout/oct_fastorder':
					$data['google_page'] = 'add_to_cart';
					$data['google_page'] = false; 
					$data['facebook_page'] = 'initiate';
					$data['mytarget_page'] = 'cart';
					$data['vk_page'] = 'init_checkout';
					
					if ($this->config->get('remarketing_events_cart')) {
						$data['events_output'] .= "<script>\n";
						$data['events_output'] .= html_entity_decode($this->config->get('remarketing_events_cart'));
						$data['events_output'] .= "</script>\n";     
					}
					
					$products = $this->cart->getProducts();
					
					foreach ($products as $product) {
						$data['google_ids'][]   = $this->config->get('remarketing_google_id') == 'id' ? $product['product_id'] : $product['model'];
						$data['facebook_ids'][] = $product;
						$data['mytarget_ids'][] = $this->config->get('remarketing_mytarget_id') == 'id' ? $product['product_id'] : $product['model'];					
						$data['vk_ids'][]       = $product;					
					} 
					
					$cart_total = $this->cart->getTotal();
					
					$data['totalvalue'] = $this->currency->format($cart_total, $this->session->data['currency'], '', false); 
					$data['google_totalvalue'] = $this->currency->format($cart_total, $google_currency, '', false); 
					$data['facebook_totalvalue'] = $this->currency->format($cart_total, $facebook_currency, '', false); 
					$data['ecommerce_totalvalue'] = $this->currency->format($cart_total, $ecommerce_currency, '', false); 
				
					if ($this->config->get('remarketing_ecommerce_status')) {
						$data['ecommerce_output'] .= '<script type="text/javascript">' . "\n";
						$data['ecommerce_output'] .= 'window.dataLayer = window.dataLayer || [];' . "\n";
						$data['ecommerce_output'] .= 'dataLayer.push({' . "\n";
						$data['ecommerce_output'] .= "'ecommerce': {" . "\n";
						$data['ecommerce_output'] .= "'currencyCode': '" . $ecommerce_currency. "'," . "\n";
						$data['ecommerce_output'] .= "'checkout': {" . "\n";
						$data['ecommerce_output'] .= "'actionField': {'step': 1}," . "\n";
						$data['ecommerce_output'] .= "'products': [" . "\n";
						foreach ($products as $product) {
							$product_info = $this->model_catalog_product->getProduct($product['product_id']);
							$data['ecommerce_output'] .= "{"."\n";
							$data['ecommerce_output'] .= "'name': '" . addslashes($product['name']) . "',"."\n";
							$data['ecommerce_output'] .= "'id': '" . ($this->config->get('remarketing_ecommerce_id') == 'id' ? $product['product_id'] : $product['model']) . "'," . "\n";
							$data['ecommerce_output'] .= "'price': " . $this->currency->format($product['price'], $ecommerce_currency, '', false) . "," . "\n";
							if (isset($product_info['manufacturer']) && $product_info['manufacturer']) $data['ecommerce_output'] .= "'brand': '" . addslashes($product_info['manufacturer']) . "'," . "\n";
							$data['ecommerce_output'] .= "'category': '" . addslashes($this->model_catalog_product->getProductCategories($product['product_id'])) . "'," . "\n";
							$data['ecommerce_output'] .= "'quantity': " . $product['quantity'] . "}," . "\n";
						}
						$data['ecommerce_output'] = rtrim($data['ecommerce_output'], ',');
						$data['ecommerce_output'] .= "]}},\n";
						$data['ecommerce_output'] .= "'event': 'gtm-ee-event',
						'gtm-ee-event-category': 'Enhanced Ecommerce',
						'gtm-ee-event-action': 'Checkout Step 1',
						'gtm-ee-event-non-interaction': 'False'";
						$data['ecommerce_output'] .= '});' . "\n</script>\n";
					}
					
					if ($this->config->get('remarketing_ecommerce_ga4_status')) {
						$data['ecommerce_output'] .= '<script type="text/javascript">' . "\n";
						$data['ecommerce_output'] .= "if (typeof gtag != 'undefined') {" . "\n";
						$data['ecommerce_output'] .= 'gtag("event", "' . ($route != 'checkout/cart' ? 'begin_checkout' : 'view_cart') . '" , {'."\n";
						$data['ecommerce_output'] .= "'currency': '" . $ecommerce_currency . "',\n";
						$data['ecommerce_output'] .= "'items': ["."\n";
						$i = 1;
						foreach ($products as $product) {
							$product_info = $this->model_catalog_product->getProduct($product['product_id']);
							$categories = addslashes($this->model_catalog_product->getProductCategories($product['product_id']));
							$data['ecommerce_output'] .= "{"."\n";
							$data['ecommerce_output'] .= "'item_id': '" . ($this->config->get('remarketing_ecommerce_ga4_id') == 'id' ? $product['product_id'] : $product['model']) . "'," . "\n";
							$data['ecommerce_output'] .= "'item_name': '" . addslashes($product['name']) . "'," . "\n";
							$data['ecommerce_output'] .= "'item_list_name': '" . $categories . "'," . "\n";
							if (isset($product_info['manufacturer']) && $product_info['manufacturer']) $data['ecommerce_output'] .= "'item_brand': '" . addslashes($product_info['manufacturer']) . "'," . "\n";
							$data['ecommerce_output'] .= "'item_category': '" . $categories . "'," . "\n";
							$data['ecommerce_output'] .= "'index': " . $i . "," . "\n";
							$data['ecommerce_output'] .= "'quantity': " . $product['quantity'] . ","."\n";
							$data['ecommerce_output'] .= "'price': " . $this->currency->format($product['price'], $ecommerce_currency, '', false) . "," . "\n";
							$data['ecommerce_output'] .= "'affiliation': '" . addslashes($this->config->get('config_name')) . "'}," . "\n"; 
							$i++;
						}
						$data['ecommerce_output'] = rtrim($data['ecommerce_output'], ',');
						$data['ecommerce_output'] .= ']})};' . "\n</script>\n";
							}
					
					if ($this->config->get('remarketing_ecommerce_measurement_status')) {
						$uuid = (isset($this->session->data['uuid']) && $this->session->data['uuid']) ? $this->session->data['uuid'] : sprintf( '%04x%04x-%04x-%04x-%04x-%04x%04x%04x',  mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ),  mt_rand( 0, 0xffff ),  mt_rand( 0, 0x0fff ) | 0x4000,  mt_rand( 0, 0x3fff ) | 0x8000,  mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ));		
						$ecommerce_data = [
							'v'   => 1,
							'tid' => $this->config->get('remarketing_ecommerce_analytics_id'),
							'cid' => $uuid,
							't'   => 'event',
							'ec'  => 'Enhanced Ecommerce',
							'ea'  => 'Checkout Step 1', 
							'ni'  => 1,
							'cu'  => $ecommerce_currency,
							'pa'  => 'checkout'
						]; 
				
					if ($this->customer->isLogged()) {
						$ecommerce_data['uid'] = $this->customer->isLogged();
						unset($ecommerce_data['cid']);
					}
		
					$i = 1;
					if ($products) {
						foreach ($products as $product){
							$ecommerce_data['pr' . $i .'nm'] = $product['name'];
							$ecommerce_data['pr' . $i .'id'] = ($this->config->get('remarketing_ecommerce_measurement_id') == 'id') ? $product['product_id'] : $product['model'];
							$ecommerce_data['pr' . $i .'pr'] = $this->currency->format($product['price'], $ecommerce_currency, '', false);
							$ecommerce_data['pr' . $i .'br'] = $this->model_catalog_product->getProduct($product['product_id'])['manufacturer'];
							$ecommerce_data['pr' . $i .'ca'] = $this->model_catalog_product->getProductCategories($product['product_id']);
							$ecommerce_data['pr' . $i .'qt'] = $product['quantity'];
							$i++;
						}
					}
					
					$data['ecommerce_output'] .= '<script>window.ecommerce_data = window.ecommerce_data || {};' . "\n";
					$data['ecommerce_output'] .= 'ecommerce_data = ' . json_encode($ecommerce_data) . ";\n";
					$data['ecommerce_output'] .= "if (typeof sendEcommerceCart !== 'undefined') {\n";
					$data['ecommerce_output'] .= "sendEcommerceCart(ecommerce_data); \n";
					$data['ecommerce_output'] .= "}\n";
					$data['ecommerce_output'] .= '</script>' . "\n";
					}
					
					if ($this->config->get('remarketing_facebook_server_side') && $this->config->get('remarketing_facebook_token')) {
						$fb_time = time();
						$facebook_data['event_name'] = 'InitiateCheckout';
						$facebook_data['time'] = $fb_time;
						$fb_products = [];
						foreach ($data['facebook_ids'] as $product) {
							$fb_products[] = [
								'id'         => ($this->config->get('remarketing_facebook_id') == 'id' ? $product['product_id'] : $product['model']),
								'quantity'   => $product['quantity'],
								'item_price' => $this->currency->format($product['price'], $facebook_currency, '', false)
							];
						}
						$facebook_data['custom_data'] = [
							'value'        => $data['facebook_totalvalue'],
							'currency'     => $facebook_currency,
							'contents'     => $fb_products,
							'num_items'    => count($fb_products),
							'content_type' => 'product',
							'opt_out'      => false
						];
						
						$data['ecommerce_output'] .= '<script>window.facebook_data = window.facebook_data || {};' . "\n";
						$data['ecommerce_output'] .= 'facebook_data = ' . json_encode($facebook_data) . ";\n";
						$data['ecommerce_output'] .= "if (typeof sendFacebookCart !== 'undefined') {\n";
						$data['ecommerce_output'] .= "sendFacebookCart(facebook_data); \n";
						$data['ecommerce_output'] .= "}\n";
						$data['ecommerce_output'] .= '</script>' . "\n";
					}
					break;	
				case 'checkout/success':
					$data['google_page'] = 'purchase';
					$data['facebook_page'] = 'purchase';
					$data['mytarget_page'] = 'purchase';
					$data['vk_page'] = 'purchase';
					if (isset($this->session->data['order_id'])) {
						$order_info = $this->model_tool_remarketing->getOrderRemarketing($this->session->data['order_id']);
						if ($order_info) {
							if ($order_info['products']) {
								foreach ($order_info['products'] as $product) {
									$data['google_ids'][] = $this->config->get('remarketing_google_id') == 'id' ? $product['product_id'] : $product['model'];
									$data['facebook_ids'][] = $product;
									$data['mytarget_ids'][] = $this->config->get('remarketing_mytarget_id') == 'id' ? $product['product_id'] : $product['model'];		
									$data['vk_ids'][] = $product;		
								}							
							}
							$data['totalvalue'] = $this->currency->format($order_info['total'], $this->session->data['currency'], '', false);
							$data['google_totalvalue'] = $this->currency->format($order_info['total'], $google_currency, '', false); 
							$data['facebook_totalvalue'] = $this->currency->format($order_info['total'], $facebook_currency, '', false); 
							$data['ecommerce_totalvalue'] = $this->currency->format($order_info['total'], $ecommerce_currency, '', false); 
							
							$data['google_reviews_page'] = true;
							$data['reviews_order_id'] = $order_info['order_id'];
							$data['reviews_order_email'] = $order_info['email'];
							$data['reviews_order_date'] = date('Y-m-d', time() + 3600 * 24 * (int)$this->config->get('remarketing_reviews_date'));
							if ($this->config->get('remarketing_events_purchase')) {
								$data['events_output'] .= "<script>\n";
								$data['events_output'] .= html_entity_decode($this->config->get('remarketing_events_purchase'));
								$data['events_output'] .= "</script>\n";     
							}
					
							if ($this->config->get('remarketing_google_ads_identifier')) {
								$data['google_output'] .= '<script type="text/javascript">'."\n";
								$data['google_output'] .= "if (typeof gtag != 'undefined') {"."\n";
								$data['google_output'] .= 'gtag("event", "conversion", {'."\n";
								$data['google_output'] .= "'send_to': '" . $this->config->get('remarketing_google_ads_identifier') ."'," . "\n";
								$data['google_output'] .= "'value': " . $data['google_totalvalue'] . ",\n";
								$data['google_output'] .= "'currency': '". $google_currency . "'\n";
								$data['google_output'] .= '})};'."\n</script>\n";
							}
				 
							if ($this->config->get('remarketing_ecommerce_status')) {		
								$data['ecommerce_output'] = '';
								$data['ecommerce_output'] .= '<script type="text/javascript">' . "\n";
								$data['ecommerce_output'] .= 'window.dataLayer = window.dataLayer || [];' . "\n";
								$data['ecommerce_output'] .= 'dataLayer.push({' . "\n"; 
								$data['ecommerce_output'] .= "'ecommerce': {" . "\n";
								$data['ecommerce_output'] .= "'currencyCode': '" . $ecommerce_currency . "'," . "\n";
								$data['ecommerce_output'] .= "'purchase': {" . "\n";
								$data['ecommerce_output'] .= "'actionField': {'id': ". $this->session->data['order_id'] . "," . "\n";
								$data['ecommerce_output'] .= "'affiliation': '" . $order_info['store_name'] . "'," . "\n";
								$data['ecommerce_output'] .= "'revenue': '" . $data['ecommerce_totalvalue'] . "',\n";
								$data['ecommerce_output'] .= "'shipping': " . $this->currency->format($order_info['shipping'], $ecommerce_currency, '', false) . "\n},";
								$data['ecommerce_output'] .= "'products': ["."\n";
								foreach ($order_info['products'] as $product) {
									$data['ecommerce_output'] .= "{"."\n";
									$data['ecommerce_output'] .= "'name': '" . addslashes($product['name']) . "'," . "\n";
									$data['ecommerce_output'] .= "'id': '" . ($this->config->get('remarketing_ecommerce_id') == 'id' ? $product['product_id'] : $product['model']) . "'," . "\n";
									$data['ecommerce_output'] .= "'price': " . $product['ecommerce_price'] . "," . "\n";
									if (isset($product['product_info']['manufacturer']) && $product['product_info']['manufacturer']) $data['ecommerce_output'] .= "'brand': '" . addslashes($product['product_info']['manufacturer']) . "'," . "\n";
									$data['ecommerce_output'] .= "'category': '" . addslashes($product['category']) . "'," . "\n";
									$data['ecommerce_output'] .= "'quantity': '" . $product['quantity'] . "'}," . "\n";
								}
								$data['ecommerce_output'] = rtrim($data['ecommerce_output'], ',');
								$data['ecommerce_output'] .= "]}},\n";
								$data['ecommerce_output'] .= "'event': 'gtm-ee-event',
								'gtm-ee-event-category': 'Enhanced Ecommerce',
								'gtm-ee-event-action': 'Purchase',
								'gtm-ee-event-non-interaction': 'False'";
								$data['ecommerce_output'] .= '});' . "\n</script>\n";
							}
							
							if ($this->config->get('remarketing_ecommerce_ga4_status')) {
								$data['ecommerce_output'] .= '<script type="text/javascript">'."\n";
								$data['ecommerce_output'] .= "if (typeof gtag != 'undefined') {"."\n";
								$data['ecommerce_output'] .= 'gtag("event", "purchase", {'."\n";
								$data['ecommerce_output'] .= "'transaction_id': '" . $this->session->data['order_id'] ."'," . "\n";
								$data['ecommerce_output'] .= "'value': " . $data['ecommerce_totalvalue'] . ",\n";
								$data['ecommerce_output'] .= "'currency': '". $ecommerce_currency . "'\n,";
								$data['ecommerce_output'] .= "'shipping': " . $this->currency->format($order_info['shipping'], $ecommerce_currency, '', false) . ",\n";
								$data['ecommerce_output'] .= "'items': ["."\n";
								$i = 1;
								foreach ($order_info['products'] as $product) {
									$data['ecommerce_output'] .= "{"."\n";
									$data['ecommerce_output'] .= "'item_id': '" . ($this->config->get('remarketing_ecommerce_ga4_id') == 'id' ? $product['product_id'] : $product['model']) . "'," . "\n";
									$data['ecommerce_output'] .= "'item_name': '" . addslashes($product['name']) . "'," . "\n";
									$data['ecommerce_output'] .= "'item_list_name': '" . addslashes($product['category']) . "'," . "\n";
									if (isset($product['product_info']['manufacturer']) && $product['product_info']['manufacturer']) $data['ecommerce_output'] .= "'item_brand': '" . addslashes($product['product_info']['manufacturer']) . "'," . "\n";
									$data['ecommerce_output'] .= "'item_category': '" . addslashes($product['category']) . "'," . "\n";
									$data['ecommerce_output'] .= "'index': " . $i . "," . "\n";
									$data['ecommerce_output'] .= "'quantity': " . $product['quantity'] . ","."\n";
									$data['ecommerce_output'] .= "'price': " . $product['ecommerce_price'] . "," . "\n";
									$data['ecommerce_output'] .= "'affiliation': '" . $order_info['store_name'] . "'}," . "\n";
									$i++;
								}
								$data['ecommerce_output'] = rtrim($data['ecommerce_output'], ',');
								$data['ecommerce_output'] .= ']})};' . "\n</script>\n";
							}
		
							if ($this->config->get('remarketing_ecommerce_measurement_status')) {
								$uuid = (isset($this->session->data['uuid']) && $this->session->data['uuid']) ? $this->session->data['uuid'] : sprintf( '%04x%04x-%04x-%04x-%04x-%04x%04x%04x',  mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ),  mt_rand( 0, 0xffff ),  mt_rand( 0, 0x0fff ) | 0x4000,  mt_rand( 0, 0x3fff ) | 0x8000,  mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ));		
								$ecommerce_data = [
									'v'   => 1,
									'tid' => $this->config->get('remarketing_ecommerce_analytics_id'),
									'cid' => $uuid,
									't'   => 'event',
									'ti'  => $this->session->data['order_id'],
									'ta'  => $order_info['store_name'],
									'ts'  => $this->currency->format($order_info['shipping'], $ecommerce_currency, '', false),
									'tr'  => $data['ecommerce_totalvalue'],
									'ec'  => 'Enhanced Ecommerce',
									'ea'  => 'Purchase', 
									'ni'  => 1,
									'cu'  => $ecommerce_currency,
									'pa'  => 'purchase'
								]; 
				
								if ($this->customer->isLogged()) {
									$ecommerce_data['uid'] = $this->customer->isLogged();
									unset($ecommerce_data['cid']);
								}

								$i = 1;
								if ($order_info['products']) {
									foreach ($order_info['products'] as $product){
										$ecommerce_data['pr' . $i .'nm'] = $product['name'];
										$ecommerce_data['pr' . $i .'id'] = ($this->config->get('remarketing_ecommerce_measurement_id') == 'id') ? $product['product_id'] : $product['model'];
										$ecommerce_data['pr' . $i .'pr'] = $product['ecommerce_price'];
										$ecommerce_data['pr' . $i .'br'] = $this->model_catalog_product->getProduct($product['product_id'])['manufacturer'];
										$ecommerce_data['pr' . $i .'ca'] = $this->model_catalog_product->getProductCategories($product['product_id']);
										$ecommerce_data['pr' . $i .'qt'] = $product['quantity'];
										$i++;
									}
								}
								
								$this->model_tool_remarketing->sendEcommerce($ecommerce_data);
							}
							
					if ($this->config->get('remarketing_facebook_server_side') && $this->config->get('remarketing_facebook_token')) {
						$facebook_data['event_name'] = 'Purchase';
						$fb_products = [];
						foreach ($data['facebook_ids'] as $product) {
							$fb_products[] = [
								'id'         => ($this->config->get('remarketing_facebook_id') == 'id' ? $product['product_id'] : $product['model']),
								'quantity'   => $product['quantity'],
								'item_price' => $product['facebook_price']
							];
						}
						$facebook_data['custom_data'] = [
							'value'        => $data['facebook_totalvalue'],
							'currency'     => $facebook_currency,
							'contents'     => $fb_products,
							'num_items'    => count($fb_products),
							'content_type' => 'product',
							'opt_out'      => false
						];
						$this->load->model('tool/remarketing');
						$this->model_tool_remarketing->sendFacebook($facebook_data, $order_info);
					}
						} 
						unset($this->session->data['order_id']); 
					} else {
						$data['vk_page'] = 'view_other';
						$data['google_page'] = false;
						$data['facebook_page'] = false;
						$data['mytarget_page'] = false;
					}
					break;	 
				default:
					$data['vk_page'] = 'view_other';
					$data['google_page'] = false;
					$data['facebook_page'] = false;
					$data['mytarget_page'] = false;
					break;
			}
		
			if ($this->config->get('remarketing_google_status') && $this->config->get('remarketing_google_identifier')) {
		
				if ($data['google_page']) {
					$data['google_output'] .= '<script type="text/javascript">'."\n";
					$data['google_output'] .= "if (typeof gtag != 'undefined') {"."\n";
					$data['google_output'] .= 'gtag("event", "' . $data['google_page'] . '", {'."\n";
					$data['google_output'] .= "'send_to': '" . $this->config->get('remarketing_google_identifier') . "',"."\n";
					$data['google_output'] .= "'value': ". (isset($data['google_totalvalue']) ? $data['google_totalvalue'] : $data['totalvalue']) . ",\n";
					if (isset($data['google_ids']) && count($data['google_ids']) > 0) {
						$data['google_output'] .= "'items': [\n";
							foreach($data['google_ids'] as $item) {
								$data['google_output'] .= "{\n";
								$data['google_output'] .= "'id': " . $item . ",\n";
								$data['google_output'] .= "'google_business_vertical': 'retail'\n";
								$data['google_output'] .= "},\n";
							}
						$data['google_output'] .= "]\n";
					}
					$data['google_output'] .= '})};'."\n</script>\n";
				}
			}
		
			if ($this->config->get('remarketing_facebook_status') && $this->config->get('remarketing_facebook_identifier')) {

				if ($data['facebook_page'] == 'purchase' || $data['facebook_page'] == 'initiate') {
					if (isset($data['facebook_ids']) && count($data['facebook_ids']) > 0) {
						$data['facebook_output'] .= '<script type="text/javascript">'."\n";
						$data['facebook_output'] .= "$(document).ready(function() {"."\n";
						$data['facebook_output'] .= "if (typeof fbq != 'undefined') {"."\n";
						if ($data['facebook_page'] == 'purchase') {
							$data['facebook_output'] .= "fbq('track', 'Purchase', {"."\n";
						} else {
							$data['facebook_output'] .= "fbq('track', 'InitiateCheckout', {"."\n";	
						}
						$data['facebook_output'] .= "content_type: 'product'," . "\n";
						$data['facebook_output'] .= "num_items: " . count($data['facebook_ids']) . "," . "\n";
						if (count($data['facebook_ids']) == 1) {
							$data['facebook_output'] .= "content_ids: ['" . (($this->config->get('remarketing_facebook_id') == 'id') ? $data['facebook_ids'][0]['product_id'] : $data['facebook_ids'][0]['model']) . "']," . "\n";
							$data['facebook_output'] .= "content_name: '" . addslashes($data['facebook_ids'][0]['name']) . "'," . "\n";
							if (isset($data['facebook_ids'][0]['category'])) $data['facebook_output'] .= "content_category: '" . $data['facebook_ids'][0]['category'] . "'," . "\n";
						} else {  
							$data['facebook_output'] .= "contents: [" . "\n";
							if ($data['facebook_page'] == 'initiate') {
								foreach ($data['facebook_ids'] as $product) {
									$data['facebook_output'] .= "{" . "'id': '" . ($this->config->get('remarketing_facebook_id') == 'id' ? $product['product_id'] : $product['model']) . "', 'price': " . $this->currency->format($product['price'], $facebook_currency, '', false) . ", 'quantity': " . $product['quantity'] . "},";
								}
							} else {
								foreach ($data['facebook_ids'] as $product) {
									$data['facebook_output'] .= "{" . "'id': '" . ($this->config->get('remarketing_facebook_id') == 'id' ? $product['product_id'] : $product['model']) . "', 'price': " . $product['facebook_price'] . ", 'quantity': " . $product['quantity'] . "},";
								}
							} 
							$data['facebook_output'] = rtrim($data['facebook_output'], ',');
							$data['facebook_output'] .= "],\n";
						}
						$data['facebook_output'] .= 'value: ' . (isset($data['facebook_totalvalue']) ? $data['facebook_totalvalue'] : $data['totalvalue']) . ',' . "\n";
						$data['facebook_output'] .= "currency: '" .  $facebook_currency ."'"."\n";
						$data['facebook_output'] .= '}, {eventID: ' . (isset($fb_time) ? $fb_time : time()) . '})}});'."\n</script>\n";
					}
				}
			}
		
			if ($this->config->get('remarketing_mytarget_status') && $this->config->get('remarketing_mytarget_identifier')) {	
				if ($data['mytarget_page']) {		
					if (isset($data['mytarget_ids']) && count($data['mytarget_ids']) > 1) {
						$target_id = '[\'' . implode('\',\'', $data['mytarget_ids']) . '\']';
					} elseif (!empty($data['mytarget_ids'])) {
						$target_id =  "'" . $data['mytarget_ids'][0] . "'";
					} else {
						$target_id = '';	
					}
			
					$data['mytarget_output'] .= '<!-- Rating@Mail.ru counter dynamic remarketing appendix -->' . "\n";
					$data['mytarget_output'] .= '<script type="text/javascript">' . "\n";
					$data['mytarget_output'] .= 'var _tmr = _tmr || [];' . "\n";
					$data['mytarget_output'] .= '_tmr.push({' . "\n";
					$data['mytarget_output'] .= "type: 'itemView'," . "\n";
					if (!empty($target_id)) $data['mytarget_output'] .= "productid: " . $target_id . "," . "\n";
					if (!empty($data['mytarget_page'])) $data['mytarget_output'] .= "pagetype: '" . $data['mytarget_page'] . "'," . "\n"; 
					$data['mytarget_output'] .= "list: '" . $this->config->get('remarketing_mytarget_identifier') . "'," . "\n";
					if (!empty($data['totalvalue'])) $data['mytarget_output'] .= "totalvalue: '" . $data['totalvalue'] . "'" . "\n"; 
					$data['mytarget_output'] .= '});' . "\n";
					$data['mytarget_output'] .= '</script>' . "\n";
					$data['mytarget_output'] .= '<!-- // Rating@Mail.ru counter dynamic remarketing appendix -->' . "\n";
				}
			}
			
			if ($this->config->get('remarketing_vk_status') && $this->config->get('remarketing_vk_identifier')) {	
			
				if ($data['vk_page']) {		
					$eventParams = [];
					$eventParams['currency_code'] = $this->session->data['currency'];
					if (!empty($data['vk_ids'])) {
						$eventParams['products'] = [];
						foreach ($data['vk_ids'] as $product) {
							$eventParams['products'][] = [
								'id'    =>  $this->config->get('remarketing_vk_id') == 'id' ? $product['product_id'] : $product['model'],
								'price' => $product['price']
							]; 
						}
					}
					if ($data['totalvalue'] > 0) $eventParams['total_price'] = $data['totalvalue']; 
					
					$data['vk_output'] .= '<script type="text/javascript">' . "\n";
					$data['vk_output'] .= "$(document).ready(function() { setTimeout(function() { if (typeof VK != 'undefined') {" . "\n";
					$data['vk_output'] .= "VK.Retargeting.ProductEvent(" . $this->config->get('remarketing_vk_identifier') . ", '" . $data['vk_page'] . "', " . json_encode($eventParams) . ");" . "\n";
					$data['vk_output'] .= '}}, 1000)})' . "\n";
					$data['vk_output'] .= '</script>' . "\n"; 
				}
			}
	
			if ($data['google_reviews_page'] && $this->config->get('remarketing_reviews_status') && $this->config->get('remarketing_google_merchant_identifier')) {			
				$data['google_reviews_output'] .= '<script src="https://apis.google.com/js/platform.js?onload=renderOptIn"  async defer></script>' . "\n";
				$data['google_reviews_output'] .= "<script>\n";     
				$data['google_reviews_output'] .= "window.renderOptIn = function() {\n";  
				$data['google_reviews_output'] .= "window.gapi.load('surveyoptin', function() {\n"; 
				$data['google_reviews_output'] .= "      window.gapi.surveyoptin.render(\n"; 
				$data['google_reviews_output'] .= "        {\n"; 
				$data['google_reviews_output'] .= " // ОБЯЗАТЕЛЬНО\n"; 
				$data['google_reviews_output'] .= '"merchant_id": ' . $this->config->get('remarketing_google_merchant_identifier') . ",\n"; 
				$data['google_reviews_output'] .= '"order_id": "' . $data['reviews_order_id'] . "\",\n"; 
				$data['google_reviews_output'] .= '"email": "' . $data['reviews_order_email'] . "\",\n"; 
				$data['google_reviews_output'] .= '"delivery_country": "' . $this->config->get('remarketing_reviews_country') . "\",\n"; 
				$data['google_reviews_output'] .= '"estimated_delivery_date": "' . $data['reviews_order_date'] . "\",\n"; 
				$data['google_reviews_output'] .= '"opt_in_style": "CENTER_DIALOG"' . "\n"; 
				$data['google_reviews_output'] .=  "}); });}\n"; 
				$data['google_reviews_output'] .=  "</script>"; 
			}
		
			if ($this->config->get('remarketing_counter3') && $this->config->get('remarketing_counter3')) {
				$data['counter_output'] .=  html_entity_decode($this->config->get('remarketing_counter3'));
			}
			
			if ($this->config->get('remarketing_events_cart_add')) {
				$data['events_output'] .= "<script>\n";
				$data['events_output'] .= "function events_cart_add() {\n";
				$data['events_output'] .= html_entity_decode($this->config->get('remarketing_events_cart_add')) . "\n";
				$data['events_output'] .= "}\n";     
				$data['events_output'] .= "</script>\n";     
			}
			
			if ($this->config->get('remarketing_events_wishlist')) {
				$data['events_output'] .= "<script>\n";
				$data['events_output'] .= "function events_wishlist() {\n";
				$data['events_output'] .= html_entity_decode($this->config->get('remarketing_events_wishlist')) . "\n";
				$data['events_output'] .= "}\n";     
				$data['events_output'] .= "</script>\n";     
			}
			
			return $data['google_output'] . "\n\n" . $data['facebook_output'] . "\n\n" . $data['mytarget_output'] . "\n\n" . $data['vk_output'] . "\n\n" . $data['google_reviews_output'] . "\n\n" . $data['events_output'] . "\n\n" . $data['ecommerce_output'] . "\n\n" . $data['counter_output']; 
		
		}
	}
	
	public function sendMeasurementImpressions() {
		if (isset($this->request->post)) {
			if (isset($this->request->post['products'])) {
				$products_data = $this->request->post['products'];
				$this->load->model('tool/remarketing');
				$this->model_tool_remarketing->sendEcommerceImpressions($products_data, $this->request->post['heading']);
			}
		}
	}
	
	public function sendDetails() {
		if (isset($this->request->post)) {
			if (isset($this->request->post['products'])) {
				$products_data = $this->request->post['products'];
				$this->load->model('tool/remarketing'); 
				$this->model_tool_remarketing->sendEcommerceDetails($products_data['ecommerce']['detail'], !empty($products_data['ecommerce']['impressions']) ? $products_data['ecommerce']['impressions'] : [], $this->request->post['heading']);
			}
		}
	}
	
	public function sendEcommerceCart() {
		if (isset($this->request->post)) {
			if (isset($this->request->post['cart'])) {
				$data = $this->request->post['cart'];
				$this->load->model('tool/remarketing'); 
				$this->model_tool_remarketing->sendEcommerceCart($data);
			}
		}
	}
	
	public function sendFacebookDetails() {
		if (isset($this->request->post)) {
			if (isset($this->request->post['products']) && $this->config->get('remarketing_facebook_server_side') && $this->config->get('remarketing_facebook_token')) {
				$facebook_data['event_name'] = 'ViewContent';
				$facebook_data['custom_data'] = $this->request->post['products'];
				$facebook_data['time'] = $this->request->post['time'];
				$facebook_data['url'] = $this->request->post['url'];
				$this->load->model('tool/remarketing');
				$this->model_tool_remarketing->sendFacebook($facebook_data);
			}
		}
	}
	
	public function sendFacebookCart() {
		if (isset($this->request->post)) {
			if (isset($this->request->post['cart']) && $this->config->get('remarketing_facebook_server_side') && $this->config->get('remarketing_facebook_token')) {
				$facebook_data['event_name'] = 'InitiateCheckout';
				$facebook_data['custom_data'] = $this->request->post['cart']['custom_data'];
				$facebook_data['url'] = $this->request->post['url'];
				$facebook_data['time'] = $this->request->post['cart']['time'];
				$this->load->model('tool/remarketing');
				$this->model_tool_remarketing->sendFacebook($facebook_data);
			}
		}
	}
	
	public function sendFacebookCategory() {
		if (isset($this->request->post)) {
			if (isset($this->request->post['products']) && $this->config->get('remarketing_facebook_server_side') && $this->config->get('remarketing_facebook_token')) {
				$facebook_data['event_name'] = 'ViewCategory';
				$facebook_data['custom_data'] = $this->request->post['products'];
				$facebook_data['time'] = $this->request->post['time'];
				$facebook_data['url'] = $this->request->post['url'];
				$this->load->model('tool/remarketing');
				$this->model_tool_remarketing->sendFacebook($facebook_data);
			}
		}
	}
	
	public function sendMeasurementClick() {
		if (isset($this->request->post)) {
			if (isset($this->request->post['products'])) {
				$products_data = $this->request->post['products'];
				$this->load->model('tool/remarketing'); 
				$this->model_tool_remarketing->sendMeasurementClick($products_data, $this->request->post['heading']);
			}
		}
	}
}