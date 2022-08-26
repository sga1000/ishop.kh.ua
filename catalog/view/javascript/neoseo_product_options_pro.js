var options_pro = {};
var ajax_ready = [];
var current_option_value; //Текущее значение опции
var current_product_option_id; //Текущая опция

$(function () {
	$("<a class='options-button-reset' onClick='clearOptions(this);'>Очистить параметры</a>").appendTo($(".options_pro_form"));
	$('body').on('click', function (e) {
		setTimeout(function () {
			var options = $('#product .options-container .text-danger');
			if (options.length > 0) {
				setTimeout(function () {
					options.fadeOut();
				},2000)
			}
		},500);
	});
});

$(document).on('change', '.options_pro_form [name^="option"]', function () {
	var form_data = $(this).parents('form').serialize();
	var product_id = $(this).parents('form').find('input[name="product_id"]').val();
	var parentLayer = $(this).parents('.product-layout');

	//Определяем ведующую опцию
	if ($(this).prop('checked') == true) {
		current_option_value = $(this).val();
		current_product_option_id = $(this).attr('name').replace(/\D+/g, "");
	}

	if (ajax_ready[product_id] === undefined) {
		ajax_ready[product_id] = true;
	}
	if (typeof options_pro[product_id] === 'undefined' && ajax_ready[product_id]) {
		ajax_ready[product_id] = false;
		$.ajax({
			url: 'index.php?route=module/neoseo_product_options_pro/getProductOptions',
			type: 'post',
			data: form_data,
			dataType: 'json',
			success: function (json) {
				if (json['success']) {
					options_pro[product_id] = json[product_id];
					updateProductData(product_id, parentLayer);
				} else {
					options_pro[product_id] = false;
					return;
				}
				ajax_ready[product_id] = true;
			}
		});
	} else if (options_pro[product_id] !== undefined && options_pro[product_id] !== false) {
		updateProductData(product_id, parentLayer);
	}
});

function updateProductData(product_id, parentLayer) {
	var product_id = product_id;

	var product_option_values = [];
	parentLayer.find('#product_options_form_' + product_id + ' [name^="option"]:checked, #product_options_form_' + product_id + ' [name^="option"]:selected').each(function () {
		var product_option_id = $(this).attr('name').replace(/\D+/g, "");
		if (product_option_id == current_product_option_id) {
			current_option_value = $(this).val();
		}
		product_option_values.push($(this).val());
	});

	//Определяем зависимость опций
	var dependent_options = [];
	var quantity_options = [];
	$.each(options_pro[product_id], function (key, value) {
		var options = key.split('_');
		if (options.length >= 2 && options.indexOf(current_option_value) != -1) {
			if (options_pro[product_id][key]['quantity'] > 0 || options_pro[product_id][key]['snwa_status'] == true || options_pro[product_id][key]['stock_checkout'] == 1) {
				$.each(options, function (index, val) {
					if (val != current_option_value) {
						dependent_options.push(val);
						quantity_options[val] = options_pro[product_id][key]['quantity'];
					}
				});
			}
		} else {
			quantity_options[key] = options_pro[product_id][key]['quantity'];
		}
	});

	product_option_values.sort();
	var key = product_option_values.join('_');
	var article_changed = false;
	var price_changed = false;

	parentLayer.find('#product_options_form_' + product_id + ' [name^="option"]').each(function () {
		var product_option_id = $(this).attr('name').replace(/\D+/g, "");
		if (product_option_id != current_product_option_id) {
			$(this).removeClass('disabled');
			if (current_product_option_id) {
				if (dependent_options.indexOf($(this).val()) == -1) {
					$(this).attr('disabled', true);
				} else {
					$(this).attr('disabled', false);
				}
			}
			if (quantity_options[$(this).val()] <= 0) {
				$(this).addClass('disabled');
			}
		} else {
			current_product_option_id = product_option_id;
		}

		$('#button-cart').attr('disabled', false);
	});

	if (typeof options_pro[product_id][key] != "undefined") {

		if (options_pro[product_id][key]['article'] != "") {
			parentLayer.find('.articul').text(options_pro[product_id][key]['article']);
			article_changed = true;
		}

		if (options_pro[product_id][key]['stock_status'] != "") {
			parentLayer.find('.button-group-cart span:first').text(options_pro[product_id][key]['stock_status']);
		}

		if (options_pro[product_id][key]['color_status'] != "") {
			parentLayer.find('.button-group-cart span:first').css('color', options_pro[product_id][key]['color_status']);
		}

		if (options_pro[product_id][key]['quantity'] > 0 || options_pro[product_id]['stock_checkout'] == 1) {
			showAddToCartProductList(parentLayer);
		} else if (options_pro[product_id][key]['snwa_status'] == true) {
			getProductListOptionStatusNWA(product_id, key, parentLayer);
		} else {
			parentLayer.find('.cart-add-button').attr('disabled', true);
		}

		var price = parseFloat(options_pro[product_id][key].price);

		if (!isNaN(price)) {
			price_changed = true;
		}

		if (parentLayer.find('.price-new').length != 0) {
			var label_price = parentLayer.find('.price-new');
		} else {
			var label_price = parentLayer.find('.price');
		}
		if (price_changed) {
			label_price.unbind('price_change').bind('price_change', function (e, l, p, s, step) {
				if (l > p) {
					l = l - step;
					if (l < p)
						l = p;
				} else if (l < p) {
					l = l + step;
					if (l > p)
						l = p;
				}
				$(this).text($(this).text().replace(/^[\d\s]+/, (l != p ? Math.round(l).toLocaleString() : l.toLocaleString())));
				if (l != p) {
					setTimeout(function () {
						label_price.trigger('price_change', [l, p, s, step]);
					}, s);
				}
			});
			var l_price = parseFloat(label_price.text().replace(/[^\d\.]+/, ''));
			if (l_price != price) {
				label_price.trigger('price_change', [l_price, price, 25, Math.abs((l_price - price) / 10)]);
			}
		}
	}

	getProductsOptionImage(product_option_values, product_id, parentLayer);

	return;
}

function getProductsOptionImage(product_option_values, product_id, parentLayer) {

	var images = [];

	if (product_option_values.length > 0 && typeof options_pro[product_id] != "undefined") {
		if (options_pro[product_id]['image_priority'].length != 0) {
			var keys = options_pro[product_id]['image_priority'];
		} else {
			var keys = product_option_values.join('_');
		}
	} else {
		return;
	}

	$(product_option_values).each(function () {
		if (options_pro[product_id][this] !== undefined && options_pro[product_id][this].images.length > 0) {
			if (keys.indexOf(String(this)) != -1) {
				for (var i = 0; i < options_pro[product_id][this].images.length; i++) {
					images.push(options_pro[product_id][this].images[i]);
				}
			}
		}
	});
	if (images.length > 0) {
		for (var j = 0; j < images.length; j++) {
			if (j == 0) {
				parentLayer.find('.image img').attr('src', images[j].main);
			}
		}
	}

	return true;
}

function addToCart(product_id, prodduct_minimum, current_obj) {

	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}

	var form = $(current_obj).parents('.product-thumb').find('form#product_options_form_' + product_id);

	//Если у товара нет опций, вызываем стандартную функцию добавления товара в корзину
	if (form.length === 0) {
		cart.add(product_id, prodduct_minimum);
		return;
	}

	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: form.serialize(),
		dataType: 'json',
		beforeSend: function () {
			$('#button-cart').button('loading');
		},
		complete: function () {
			$('#button-cart').button('reset');
		},
		success: function (json) {
			$('.alert, .text-danger').remove();
			$('.form-group').removeClass('has-error');

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						var element = form.find('#input-option' + i.replace('_', '-'));

						if (element.parent().hasClass('input-group')) {
							element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						} else {
							element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
						}
					}
				}

				if (json['error']['recurring']) {
					$('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
				}

				// Highlight any found errors
				$('.text-danger').parent().addClass('has-error');
			}

			if (json['success']) {
				$('#popup-quickview > div').modal('hide');

				showCart(json);

				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('#cart-total').html(json['total']);
				}, 100);

				$('#cart > ul').load(language + 'index.php?route=common/cart/info ul li');
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function clearOptions(current_obj) {
	$(current_obj).parent().find('[name^="option"]').each(function () {
		$(this).attr('disabled', false);
		$(this).prop('checked', false);
		$(this).prop('selected', false);
	});
	$(current_obj).parents().find('.cart-add-button').show();
	$(current_obj).parents().find('.cart-add-button').attr('disabled', false);
	$('#button-cart, #quick_order_block').show();
	$("#product input[name='quantity']").parent().show();
	$('#snwa-send-btn').remove();
	$('.snwa-send-btn').remove();
}

function getProductListOptionStatusNWA(product_id, option_key, parentLayer) {
	$.ajax({
		url: 'index.php?route=module/neoseo_notify_when_available/getNotifyProductOptionStatus',
		type: 'post',
		data: {'product_id': product_id, 'options': option_key},
		dataType: 'json',
		success: function (json) {
			if (json.result == 'true') {
				hideAddToCartProduct(product_id, option_key, json['snwa_requests'][product_id], parentLayer);
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function showAddToCartProductList(parentLayer) {
	parentLayer.find('.cart-add-button').show();
	parentLayer.find('.cart-add-button').attr('disabled', false);
	parentLayer.find('.snwa-send-btn').remove();
}

function hideAddToCartProduct(product_id, option_key, snwa_request, parentLayer) {
	var html = '';
	var checked = false;

	if (snwa_request['status'] == true) {
		checked = true;
	}
	parentLayer.find('.cart-add-button').hide();
	parentLayer.find('.snwa-send-btn').remove();

	html = '<div><button type="button" onclick="showNWA(' + product_id + ',this);" data-checked="' + checked + '" data-option-id="' + option_key + '" class="btn btn-primary snwa-send-btn">';
	html += '<i class="fa fa-bell"></i>';
	html += ' <span class="hidden-xs hidden-sm hidden-md snwa_button_' + product_id + '">' + snwa_request['text_button'] + '</span>';
	html += '</button></div>';

	parentLayer.find('.button-group-cart').append(html);
}