function popupNotifyPriceChangeShow(json, object) {
	if ($("#popup-notifyPriceChange").length == 0) {
		$("body").append("<div id=\"popup-notifyPriceChange\"></div>");
	}
	$("#popup-notifyPriceChange").html(json["popup"]);
	$(".text_wrap").html(json["text"]);
	if (json["product"]) {
		$("input[name=\'product\']").val(json["product"]);
	} 
	if (json["button"] === 'unsubscribe') {
		$('.type_botton').html('<a onclick="unsubscribeNotifyPriceChange()" class="btn btn-primary">' + json["text_button"] + '</a>');
	}
	$('#popup-notifyPriceChange > div').modal();
 
	if ($(object).data('checked') !== false) {
		$(object).data('checked', false).attr('data-checked', false);
	}
}

function showNotifyPriceChange(product_id, object) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	if (!$(object).data('checked')) {
		$.ajax({
			url: language + 'index.php?route=module/neoseo_notify_price_change',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function (json) {
				$('.alert').remove();

				if (json['popup']) {
					popupNotifyPriceChangeShow(json, object);
				}

				if (json['result'] == 'true') {
					$(object).data('checked', true).attr('data-checked', true);
					var icon = $(object).find('i.fa-line-chart');
					icon.removeClass("fa-line-chart");
					icon.addClass("fa-check-square-o");
				}
			},
			/*error: function (xhr, ajaxOptions, thrownError) {
			 alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			 }*/
		});

	} else {
		unsubscribeNotifyPriceChange(product_id, object);
	}
}

function sendECommerceNotifyPriceChange(data) {

	ga('ecommerce:addTransaction', {
		'id': data['order_id'], // Transaction ID. Required.
		'affiliation': data['store_name'] + " - БЗ", // Affiliation or store name.
		'revenue': data['total'], // Grand Total.
		'shipping': '0', // Shipping.
		'tax': '0'                          // Tax.
	});

	var product;
	for (var key in data['products']) {
		product = data['products'][key];
		ga('ecommerce:addItem', {
			'id': data['order_id'], // Transaction ID. Required.
			'name': product["name"], // Product name. Required.
			'sku': product["sku"], // SKU/code.
			'category': product["category"], // Category or variation.
			'price': product["price"], // Unit price.
			'quantity': product["quantity"]  // Quantity.
		});
	}

	ga('ecommerce:send');
	if (product)
		ga('send', 'event', 'oneclick', 'finish', product["name"], product["price"]);
}

function processNotifyPriceChange() {
	if (!$("#notifyPriceChange").valid())
		return;
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}

	$.ajax({
		url: language + 'index.php?route=module/neoseo_notify_price_change/subscribe',
		type: 'post',
		data: $('#notifyPriceChange input[type=\'text\'], #notifyPriceChange input[type=\'hidden\'], #notifyPriceChange input[type=\'radio\']:checked, #notifyPriceChange input[type=\'checkbox\']:checked, #notifyPriceChange select, #notifyPriceChange textarea'),
		dataType: 'json',
		success: function (json) {
			$('.success, .warning, .attention, .information').remove();

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			}

			if (json['result'] == "true") {
				$('#popup-notifyPriceChange > div').modal('hide');
				$('.modal-backdrop').remove();
				popupNotifyPriceChangeShow(json);
				$("input[name=\'product\']").val($('input[name=\'product_id\']').val());
				var icon = $('body').find('i.fa-line-chart');
				icon.parent('a').data('checked', true);
				icon.removeClass("fa-line-chart");
				icon.addClass("fa-check-square-o");
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
		 alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		 }
	});

}

function unsubscribeNotifyPriceChange(product, object) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	if (!product) {
		var product = $('#popup-notifyPriceChange input[name=\'product\']').val();
	}
	$.ajax({
		url: language + 'index.php?route=module/neoseo_notify_price_change/unsubscribe',
		type: 'post',
		data: 'product_id=' + product,
		dataType: 'json',
		success: function (json) {
			$('.success, .warning, .attention, .information').remove();

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			}

			if (json['result'] == "true") {
				$('#popup-notifyPriceChange > div').modal('hide');
				$('.modal-backdrop').remove();
				$('input[name="check_neoseo_notify_price_change"]').removeAttr("checked")
				popupNotifyPriceChangeShow(json, object);
				$(object).data('checked', false);
				var icon = $('#content').find('i.fa-check-square-o');
				icon.removeClass("fa-check-square-o");
				icon.addClass("fa-line-chart");
			}
		},
		/*error: function (request, status, error) {
		 alert(request.responseText);
		 }*/
	});

}