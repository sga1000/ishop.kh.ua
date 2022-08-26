function sendGoogleECommerceTransaction(order){

	ga('ecommerce:addTransaction', {
		'id': order['order_id'],             // Transaction ID. Required.
		'affiliation': order['store_name'],  // Affiliation or store name.
		'revenue': order['total'],           // Grand Total.
		'shipping': '0',                     // Shipping.
		'tax': '0'                           // Tax.
	});

	var product;

	for( var key in order['products'] ) {
		product = order['products'][key];
		ga('ecommerce:addItem', {
			'id': order['order_id'],          // Transaction ID. Required.
			'name': product["name"],         // Product name. Required.
			'sku': product["sku"],           // SKU/code.
			'category': product["category"], // Category or variation.
			'price': product["price"],       // Unit price.
			'quantity': product["quantity"]  // Quantity.
		});
	}

	ga('ecommerce:send');
}
