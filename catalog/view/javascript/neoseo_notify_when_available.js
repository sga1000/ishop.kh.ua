var subscribeStatus = false;
var currentObject = '';
var currentProduct = '';
var notifyAllObject = {};

$(function () {
	var product_id = '';
	var product_ids = [];

	//Товары в списках
	$('a.buy-one-click').each(function (key, value) {
		if (this.hasAttribute("data-product")) {
			product_id = $(this).data('product');
			product_ids.push(product_id);
			notifyAllObject[key] = {product_id: product_id, obj: this};
		}
	});

	// Получаем актуальный статус по подписке для товаров
	if (product_ids.length !== 0) {
		var language = "";
		if (window.current_language) {
			language = window.current_language;
		}

		$.ajax({
			url: language + 'index.php?route=module/neoseo_notify_when_available/getNotifyProductStatus',
			type: 'post',
			data: {'product_ids': product_ids},
			dataType: 'json',
			success: function (json) {
				if (json.result == 'true') {
					$.each(notifyAllObject, function (key, value) {
						if (typeof json.snwa_requests[value.product_id] !== 'undefined') {
							$(value.obj).attr('data-checked', json.snwa_requests[value.product_id]['status'])
							$(value.obj).find('span').text(json.snwa_requests[value.product_id]['text_button']);
						}

					});
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
});

function popupNotifyWhenAvailableShow(json) {

	if ($("#popup-notifyWhenAvailable").length == 0) {
		$("body").append("<div id=\"popup-notifyWhenAvailable\"></div>");
	}
	$("#popup-notifyWhenAvailable").html(json["popup"]);
	$(".text_wrap").html(json["text"]);
	if (json["product"]) {
		$("input[name=\'product\']").val(json["product"]);
	}
	if (json["button"] === 'unsubscribe') {
		$('.type_botton').html('<a onclick="unsubscribeNotifyWhenAvailable()" class="btn btn-primary">' + json["text_button"] + '</a>');
	}

	// Если подписка непосредственно в карточке товара
	if (subscribeStatus == true) {
		$(currentObject).attr('data-checked', true);

	} else {
		$(currentObject).attr('data-checked', false);
	}
	$(currentObject).find('span').html(json['button']);

	//Изменяем статус и текст для текущего товара во всех модулях
	$.each(notifyAllObject, function (key, value) {
		if (value.product_id == currentProduct) {
			if (subscribeStatus == true) {
				$(value.obj).attr('data-checked', true);

			} else {
				$(value.obj).attr('data-checked', false);
			}
			$(value.obj).find('span').html(json['button']);
		}
	});
	$('#popup-notifyWhenAvailable > div').modal();
}

function showNWA(product_id, object) {

	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	var option_id = "";
	var option = "";
	var send = "";

	currentObject = object;
	currentProduct = product_id;

	option_ids = $(object).data('option-id');
	//option = $(object).data('option');
	//if (option_id != "") {
	//send = send + '&' + option_id + '=' + option;
	//}

	if ($(object).attr('data-checked') === "false") {
		$.ajax({
			url: language + 'index.php?route=module/neoseo_notify_when_available',
			type: 'post',
			data: 'product_id=' + product_id + '&options=' + option_ids,
			dataType: 'json',
			success: function (json) {
				$('.alert').remove();

				if (json['result_subscribe'] == "true") {
					subscribeStatus = true;

				}
				if (json['popup']) {
					popupNotifyWhenAvailableShow(json);
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});

	} else {
		unsubscribeNotifyWhenAvailable(product_id, option_ids);
	}
	$(object).removeData();
}

function processNotifyWhenAvailable() {

	if (!$("#notifyWhenAvailable").valid())
		return;
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=module/neoseo_notify_when_available/subscribe',
		type: 'post',
		data: $('#notifyWhenAvailable input[type=\'text\'], #notifyWhenAvailable input[type=\'hidden\'], #notifyWhenAvailable input[type=\'radio\']:checked, #notifyWhenAvailable input[type=\'checkbox\']:checked, #notifyWhenAvailable select, #notifyWhenAvailable textarea'),
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

			if (json['result_subscribe'] == "true") {
				$('#popup-notifyWhenAvailable > div').modal('hide');
				$('.modal-backdrop').remove();
				subscribeStatus = true;
				popupNotifyWhenAvailableShow(json);
				$("input[name=\'product\']").val($('input[name=\'product_id\']').val());
			}
		},
		error: function (request, status, error) {
			alert(request.responseText);
		}
	});

}

function unsubscribeNotifyWhenAvailable(product_id, option_ids) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	if (!product_id) {
		var product_id = $('#popup-notifyWhenAvailable input[name=\'product\']').val();
	}
	$.ajax({
		url: language + 'index.php?route=module/neoseo_notify_when_available/unsubscribe',
		type: 'post',
		data: 'product_id=' + product_id + '&options=' + option_ids,
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
				$('#popup-notifyWhenAvailable > div').modal('hide');
				$('.modal-backdrop').remove();
				subscribeStatus = false;
				popupNotifyWhenAvailableShow(json);
			}
		},
		error: function (request, status, error) {
			alert(request.responseText);
		}
	});

}
