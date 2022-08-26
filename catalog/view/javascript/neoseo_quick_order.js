function popupQuickOrderShow(json) {
	if ($("#popup-quick_order").length == 0) {
		$("body").append("<div id=\"popup-quick_order\"></div>");
	}
	$("#popup-quick_order").html(json["popup"]);
	$('#popup-quick_order > div').modal();
}

function popupCart() {

	if ($("#cart_pop").val() != '') {
		var phone = $('#input-phone-popup-cart').val();
		if (!phone) {
			$("#quick_order_block_popup_cart .help-block-popup-cart").show();
			$("#quick_order_block_popup_cart").addClass("has-error");
			$('#input-phone-popup-cart').height($('#button-quick-order-popup-cart').height() + 3);
			return;
		}
		$("#quick_order_block_popup_cart .help-block-popup-cart").hide();
		$("#quick_order_block_popup_cart").removeClass("has-error");
		$('#input-phone-popup-cart').height($('#button-quick-order-popup-cart').height() + 1);

		addQuickOrder($("#cart_pop").val(), 1, phone);
	}

}

function showQuickOrder(product_id, min, type_order = 'one_product') {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}

	$.ajax({
		url: language + 'index.php?route=module/neoseo_quick_order',
		type: 'post',
		data: {product_id: product_id, min: min, type: type_order},
		dataType: 'json',
		success: function (json) {
			$('.alert').remove();
			
			const product = json['product'];

			if (json['popup']) {
				popupQuickOrderShow(json);
				if (typeof (ga) == "function") {
					ga('send', 'event', 'oneclick', 'start', product["name"], product["price"]);
				}
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}


function processQuickOrder() {
	const modalsButton = $('#quick_order .btn-primary');
	
	if (!$("#quick_order").valid() || modalsButton.attr('disabled') == true) return;

	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}

	$.ajax({
		url: language + 'index.php?route=module/neoseo_quick_order/process',
		type: 'post',
		data: $('#quick_order input[type=\'text\'], #quick_order input[type=\'hidden\'], #quick_order input[type=\'radio\']:checked, #quick_order input[type=\'checkbox\']:checked, #quick_order select, #quick_order textarea'),
		dataType: 'json',
		beforeSend: function() {
			modalsButton.attr('disabled', true);
		},
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
				$('#popup-quick_order > div').modal('hide');
				$('.modal-backdrop').remove();
				popupQuickOrderShow(json);
				if (json["order_data"]) {
					var order = json["order_data"];
					var product = order['products'][0];
					if (typeof (ga) == "function") {
						ga('send', 'event', 'oneclick', 'finish', product["name"], product["price"]);
					}
					if (typeof sendGoogleECommerceTransaction === "function") {
						sendGoogleECommerceTransaction(order);
					}
					if (typeof sendYandexECommerceTransaction === "function") {
						sendYandexECommerceTransaction(order);
					}
				}
			}
		},
		complete: function() {
			modalsButton.attr('disabled', false);
		}
	});

}

function addQuickOrder(product_id, quantity, phone, type_order = 'one_product') {

	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}

	$.ajax({
		url: language + 'index.php?route=module/neoseo_quick_order/process',
		type: 'post',
		data: {product_id: product_id, name: 'Быстрый заказ', quantity: quantity, phone: phone, type: type_order},
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
				$('#popup-quick_order > div').modal('hide');
				$('.modal-backdrop').remove();
				popupQuickOrderShow(json);
				if (json["order_data"]) {
					var order = json["order_data"];
					var product = order['products'][0];
					if (typeof (ga) == "function") {
						ga('send', 'event', 'oneclick', 'finish', product["name"], product["price"]);
					}
					if (typeof sendGoogleECommerceTransaction === "function") {
						sendGoogleECommerceTransaction(order);
					}
					if (typeof sendYandexECommerceTransaction === "function") {
						sendYandexECommerceTransaction(order);
					}
				}
			}
		}
	});

}