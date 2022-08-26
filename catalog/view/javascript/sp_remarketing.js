$(document).ready(function() {
	  $.each($("[onclick*='cart.add']"), function() {
		product_id = $(this).attr('onclick').match(/[0-9]+/);
		$(this).addClass('remarketing_cart_button').attr('data-product_id', product_id);
	  })
});

function remarketingAddToCart(json) {
	
	console.log('add_to_cart_sent');
	heading = $('h1').text();
	if (json['remarketing']) {
		if (json['remarketing']['google_status'] != '0') {
			if (typeof gtag != 'undefined') {
				gtag('event', 'add_to_cart', {
				'send_to': json['remarketing']['google_identifier'],
				'value': json['remarketing']['price'],
				'items': [{'id': json['remarketing']['google_product_id'], 'google_business_vertical': 'retail'}]
				});
			}
		}
		
		if (typeof events_cart_add != 'undefined') {
			events_cart_add();
		}
		
		if (json['remarketing']['facebook_status'] != '0') {
			 if (typeof  fbq != 'undefined') {
				fbq('track', 'AddToCart', {
				content_name: json['remarketing']['name'], 
				content_ids: "['" + json['remarketing']['facebook_product_id'] + "']", 
				content_type: 'product',
				content_category: json['remarketing']['category'],
				value: json['remarketing']['facebook_price'],
				currency: json['remarketing']['facebook_currency'] 
                }, 
				{eventID: json['remarketing']['time']}
				); 
			}
		}
		
		if (json['remarketing']['vk_status'] != '0') {
			if (typeof  VK != 'undefined') {
				VK.Retargeting.ProductEvent(json['remarketing']['vk_identifier'], 'add_to_cart',
					{"currency_code":json['remarketing']['currency'],
						"products":[{"id":json['remarketing']['vk_product_id'], "price":json['remarketing']['price']}]
					});
			}
		}
		
		if (json['remarketing']['ecommerce_status'] != '0') {
			window.dataLayer = window.dataLayer || [];
			dataLayer.push({
				'ecommerce': {
				'currencyCode': json['remarketing']['ecommerce_currency'],
				'actionField': {'list': $('h1').text()},
					'add': {                                
						'products': [{                      
						'name': json['remarketing']['name'],
						'id': json['remarketing']['ecommerce_product_id'],
						'brand': json['remarketing']['brand'],
						'price': json['remarketing']['ecommerce_price'],
						'quantity': json['remarketing']['quantity'],
						'category': json['remarketing']['category']
						}]
					}
				},
				'event': 'gtm-ee-event',
				'gtm-ee-event-category': 'Enhanced Ecommerce',
				'gtm-ee-event-action': 'Adding a Product to a Shopping Cart',
				'gtm-ee-event-non-interaction': 'False'
			});
		}
		
		if (json['remarketing']['ecommerce_ga4_status'] != '0') {
			if (typeof gtag != 'undefined') {
				gtag('event', 'add_to_cart', {
					'currency': json['remarketing']['ecommerce_currency'],
					'items': [{
						'item_id': json['remarketing']['ecommerce_ga4_product_id'],
						'item_name': json['remarketing']['name'],
						'item_list_name': heading,
						'item_brand': json['remarketing']['brand'],
						'item_category': json['remarketing']['category'],
						'index': 1,
						'quantity': json['remarketing']['quantity'],
						'price': json['remarketing']['ecommerce_price']
					}]
				});
			}
		}
		
	}
}	  

function remarketingRemoveFromCart(json) {
	
	console.log('remove_from_cart_sent');
	
	if (json['remarketing']) {
		if (json['remarketing']['ecommerce_status'] != '0') {
			window.dataLayer = window.dataLayer || [];
			dataLayer.push({
				'ecommerce': {
				'currencyCode': json['remarketing']['currency'],
					'remove': {                                 
						'products': [{                      
						'name': json['remarketing']['name'],
						'id': json['remarketing']['ecommerce_product_id'],
						'brand': json['remarketing']['brand'],
						'price': json['remarketing']['ecommerce_price'],
						'quantity': json['remarketing']['quantity'],
						'category': json['remarketing']['category']
						}]
					}
				},
				'event': 'gtm-ee-event',
				'gtm-ee-event-category': 'Enhanced Ecommerce',
				'gtm-ee-event-action': 'Removing a Product from a Shopping Cart',
				'gtm-ee-event-non-interaction': 'False'
			});
		}
		
		if (json['remarketing']['ecommerce_ga4_status'] != '0') {
			if (typeof gtag != 'undefined') {
				gtag('event', 'remove_from_cart', {
					'currency': json['remarketing']['ecommerce_currency'],
					'items': [{
						'item_id': json['remarketing']['ecommerce_ga4_product_id'],
						'item_name': json['remarketing']['name'],
						'item_list_name': heading,
						'item_brand': json['remarketing']['brand'],
						'item_category': json['remarketing']['category'],
						'index': 1,
						'quantity': json['remarketing']['quantity'],
						'price': json['remarketing']['ecommerce_price']
					}]
				});
			}
		}

		if (json['remarketing']['vk_status']) {
			if (typeof  VK != 'undefined') {
				VK.Retargeting.ProductEvent(json['remarketing']['vk_identifier'], 'remove_from_cart',
					{"currency_code":json['remarketing']['currency'],
						"products":[{"id": json['remarketing']['vk_product_id'], "price": json['remarketing']['price']}]
					});
			}
		}
	}
}	  

function sendEcommerceClick(data) {
	console.log('click_sent');
	heading = $('h1').text();
	currency = $('.currency_ecommerce_code').val();
	window.dataLayer = window.dataLayer || [];
	if (data) {
		dataLayer.push({
			'ecommerce': {
			'currencyCode': currency,
				'click': {
					'actionField': {'list': heading},                                 
					'products': [data]
				}
			},
			'event': 'gtm-ee-event',
			'gtm-ee-event-category': 'Enhanced Ecommerce',
			'gtm-ee-event-action': 'Product Clicks',
			'gtm-ee-event-non-interaction': 'False'
		});
	}
}	 

function sendEcommerceGa4Click(data) {
	console.log('ga4_click_sent');
	heading = $('h1').text();
	currency = $('.currency_ecommerce_code').val();
	
	if (data) {
		if (typeof gtag != 'undefined') {
			gtag('event', 'select_item', {
				'currency': currency,
				'items': [data]
			});
		}
	}
}	 

function sendEcommerceMeasurementClick(data) {
	console.log('click_sent');
	heading = $('h1').text();
	window.dataLayer = window.dataLayer || [];
	if (data) {
		$.ajax({ 
        type: 'post',
        url:  'index.php?route=common/remarketing/sendMeasurementClick',
		data: {products : data, heading: heading},
			dataType: 'json',
            success: function(json) {
				console.log('click_measurement_sent');
			}
		});
	}
}	 

function sendEcommerceImpressions(data, measurement = false) {
	console.log('impressions_sent');
	heading = $('h1').text();
	currency = $('.currency_ecommerce_code').val();
	window.dataLayer = window.dataLayer || [];
	console.log(data);
	if (data) {
		dataLayer.push({
			'ecommerce': {
				'currencyCode': currency,
				'impressions': data
			},
			'event': 'gtm-ee-event',
			'gtm-ee-event-category': 'Enhanced Ecommerce',
			'gtm-ee-event-action': 'Product Impressions',
			'gtm-ee-event-non-interaction': 'False'
		});
	}
	
	if (measurement) {
		$.ajax({ 
        type: 'post',
        url:  'index.php?route=common/remarketing/sendMeasurementImpressions',
		data: {products : data, heading: heading},
			dataType: 'json',
            success: function(json) {
				console.log('impressions_measurement_sent');
			}
		});
	} 
}	 

function sendEcommerceGa4Impressions(data, search = false) {
	console.log('ga4_impressions_sent');

	currency = $('.currency_ecommerce_code').val();
	if (data) {
		if (typeof gtag != 'undefined') {
			if (!search) {
				event_name = 'view_item_list';
			} else {
				event_name = 'view_search_results';
			}

			gtag('event', event_name, {
				'currency': currency,
				'items': data 
			});
		}
	}
}	 
 
function sendEcommerceImpressionsModule(data, heading, measurement = false) {
	console.log('impressions_sent');
	
	currency = $('.currency_ecommerce_code').val();
	
	window.dataLayer = window.dataLayer || [];
	
	if (data) {
		dataLayer.push({
			'ecommerce': {
			'currencyCode': currency,
			'actionField': {'list': heading},
				'impressions': {                                
					'products': data
				}
			},
			'event': 'gtm-ee-event',
			'gtm-ee-event-category': 'Enhanced Ecommerce',
			'gtm-ee-event-action': 'Product Impressions',
			'gtm-ee-event-non-interaction': 'False'
		});
	}
	
	if (measurement) {
		$.ajax({ 
        type: 'post',
        url:  'index.php?route=common/remarketing/sendMeasurementImpressions',
		data: {products : data, heading: heading},
			dataType: 'json',
            success: function(json) {
				console.log('impressions_measurement_sent');
			}
		});
	}
}	  

function sendEcommerceDetails(data, measurement = false) {
	console.log('details_sent');
	heading = $('h1').text();
	window.dataLayer = window.dataLayer || [];
	if (data) {
		$.ajax({ 
        type: 'post',
        url:  'index.php?route=common/remarketing/sendDetails',
		data: {products : data, heading: heading},
			dataType: 'json',
            success: function(json) {
				console.log('details_measurement_sent');
			}
		});
	}
}	 

function sendEcommerceGa4Details(data) {
	console.log('details_ga4_sent');
	
	if (data) {
		if (typeof gtag != 'undefined') {
			gtag('event', 'view_item', data);
		}
	}
}	 

function sendEcommerceCart(data) { 
	if (data) {
		$.ajax({ 
        type: 'post',
        url:  'index.php?route=common/remarketing/sendEcommerceCart',
		data: {cart : data},
			dataType: 'json',
            success: function(json) {
				console.log('ecommerce_cart_sent');
			}
		});
	}
}	 

function sendFacebookDetails(data) {
	
	if (data) {
		$.ajax({ 
        type: 'post',
        url:  'index.php?route=common/remarketing/sendFacebookDetails',
		data: {products : data['products'], time : data['time'], url : window.location.href},
			dataType: 'json',
            success: function(json) {
				console.log('details_facebook_sent');
			}
		});
	}
}	 

function sendFacebookCart(data) {
	
	if (data) {
		$.ajax({ 
        type: 'post',
        url:  'index.php?route=common/remarketing/sendFacebookCart',
		data: {cart : data, url : window.location.href},
			dataType: 'json',
            success: function(json) {
				console.log('facebook_cart_sent');
			}
		});
	}
}	 

function sendFacebookCategoryDetails(data) {
	
	if (data) {
		$.ajax({ 
        type: 'post',
        url:  'index.php?route=common/remarketing/sendFacebookCategory',
		data: {products : data['products'], time : data['time'], url : window.location.href},
			dataType: 'json',
            success: function(json) {
				console.log('category_details_facebook_sent');
			}
		});
	}
}	 

function sendGoogleRemarketing(data) {
	console.log('remarketing_event_sent');

	if (typeof gtag != 'undefined') {
		gtag('event', data['event'], data['data']);
	}
}	

function sendWishList(json) {
	console.log('remarketing_wishlist_sent');
	heading = $('h1').text();
	
		if (json['remarketing']['vk_status'] != '0') {
			if (typeof  VK != 'undefined') {
				VK.Retargeting.ProductEvent(json['remarketing']['vk_identifier'], 'add_to_wishlist',
					{"currency_code":json['remarketing']['currency'],
						"products":[{"id": json['remarketing']['vk_product_id'], "price": json['remarketing']['price']}]
					});
			}
		}
		
		if (json['remarketing']['facebook_status'] != '0') {
			 if (typeof  fbq != 'undefined') {
				fbq('track', 'AddToWishlist', {
				content_name: json['remarketing']['name'], 
				content_ids: "['" + json['remarketing']['facebook_product_id'] + "']", 
				content_type: 'product',
				content_category: json['remarketing']['category'],
				value: json['remarketing']['facebook_price'],
				currency: json['remarketing']['facebook_currency'] 
				},
				{eventID: json['remarketing']['time']}
				); 
			}
		}
		
		if (json['remarketing']['ecommerce_ga4_status'] != '0') {
			if (typeof gtag != 'undefined') {
				gtag('event', 'add_to_wishlist', {
					'currency': json['remarketing']['ecommerce_currency'],
					'items': [{
						'item_id': json['remarketing']['ecommerce_ga4_product_id'],
						'item_name': json['remarketing']['name'],
						'item_list_name': heading,
						'item_brand': json['remarketing']['brand'],
						'item_category': json['remarketing']['category'],
						'index': 1,
						'quantity': json['remarketing']['quantity'],
						'price': json['remarketing']['ecommerce_price']
					}]
				});
			}
		}
		
		if (typeof events_wishlist != 'undefined') {
			events_wishlist();
		}
}

function remarketingQuickOrder(json) {
	
	console.log('quick_order_sent');
	
	if (json['remarketing']) {
		if (json['remarketing']['google_status'] != '0') {
			if (typeof gtag != 'undefined') {
				gtag('event', 'purchase', {
				'send_to': json['remarketing']['google_identifier'],
				'value': json['remarketing']['price'],
				'items': json['remarketing']['google_products']
				});
			}
		}
		
		if (json['remarketing']['facebook_status'] != '0') {
			 if (typeof  fbq != 'undefined') {
				fbq('track', 'Purchase', {
				content_name: json['remarketing']['name'], 
				contents: json['remarketing']['facebook_products'],
				content_type: 'product',
				num_items: json['remarketing']['facebook_items'],
				value: json['remarketing']['order_info']['total'],
				currency: json['remarketing']['currency'] 
                }, 
				{eventID: json['remarketing']['time']}
				); 
			}
		}
		
		if (json['remarketing']['vk_status'] != '0') {
			if (typeof  VK != 'undefined') {
				VK.Retargeting.ProductEvent(json['remarketing']['vk_identifier'], 'purchase',
					{"currency_code":json['remarketing']['currency'],
						"products":json['remarketing']['vk_products']
					});
			}
		}
		
		if (json['remarketing']['ecommerce_status'] != '0') {
			window.dataLayer = window.dataLayer || [];
			dataLayer.push({
				'ecommerce': {
				'currencyCode': json['remarketing']['currency'],
					'purchase': { 
						'actionField': {
						'id': json['remarketing']['order_info']['order_id'],
						'affiliation': json['remarketing']['order_info']['store_name'],
						'revenue': json['remarketing']['order_info']['total'],
						'shipping': json['remarketing']['order_info']['shipping'],
						},
						'products': json['remarketing']['ecommerce_products']
					}
				},
				'event': 'gtm-ee-event',
				'gtm-ee-event-category': 'Enhanced Ecommerce',
				'gtm-ee-event-action': 'Purchase',
				'gtm-ee-event-non-interaction': 'False'
			});
		}
	}
}	    