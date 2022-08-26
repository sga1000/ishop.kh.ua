/**
 * Country\Zone\City managment
 */

var LabelFormat = function (obj, query) {
	var label = '';

	var name = obj.name.toLowerCase();
	query = query.toLowerCase();

	var start = name.indexOf(query);
	start = start > 0 ? start : 0;

	if (obj.typeShort) {
		label += '<span class="ac-s2">' + obj.typeShort + '. ' + '</span>';
	}

	if (query.length < obj.name.length) {
		label += '<span class="ac-s2">' + obj.name.substr(0, start) + '</span>';
		label += '<span class="ac-s">' + obj.name.substr(start, query.length) + '</span>';
		label += '<span class="ac-s2">' + obj.name.substr(start + query.length, obj.name.length - query.length - start) + '</span>';
	} else {
		label += '<span class="ac-s">' + obj.name + '</span>';
	}

	if (obj.parents) {
		for (var k = obj.parents.length - 1; k > -1; k--) {
			var parent = obj.parents[k];
			if (parent.name) {
				if (label)
					label += '<span class="ac-st">, </span>';
				label += '<span class="ac-st">' + parent.name + ' ' + parent.typeShort + '.</span>';
			}
		}
	}

	return label;
};

function changeCity(city, zone, country, callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	data = {city: city, zone: zone, country: country};
	$.ajax({
		url: language + 'index.php?route=checkout/neoseo_checkout/city',
		data: data,
		dataType: 'json',
		cache: false,
		success: function (response) {
			$('#country_id').val(response['country_id'])
			$('#zone_id').val(response['zone_id'])
			callback();
		},
		error: function () {
			$("#city").val("");
		}
	});
}

// Shipping
var neoseo_checkout_shipping_validate_ajax = null;
function validateShippingMethod(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	if (neoseo_checkout_shipping_validate_ajax)
		neoseo_checkout_shipping_validate_ajax.abort();
	neoseo_checkout_shipping_validate_ajax = $.ajax({
		url: language + 'index.php?route=checkout/neoseo_shipping/validate',
		type: 'post',
		data: $('#shipping select, #shipping input[type=\'hidden\'], #shipping input[type=\'text\'], #shipping input[type=\'radio\']:checked, #shipping input[type=\'checkbox\']:checked, #shipping textarea'),
		dataType: 'json',
		cache: false,
		success: function (json) {
			$('.warning, .error').remove();

			if (json['redirect']) {
				location = json['redirect'];
			} else if (json['error']) {
				$('#button-payment-method').attr('disabled', false);
				$('.wait').remove();

				var scrollItem = "";
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('.warning').fadeIn('slow');
					scrollItem = '.warning';
				}

				$("#quickcheckoutconfirm input, #quickcheckoutconfirm select").css('border', '1px solid #ccc').css('background', '#fff');

				for (var field in json['error']['shipping_fields']) {
					$("#quickcheckoutconfirm input[name=\'" + field + "\'] ,#quickcheckoutconfirm select[name=\'" + field + "\'] ").after('<span class="error" style="color:#f00">' + json['error']['shipping_fields'][field] + '</span>');
					$("#quickcheckoutconfirm input[name=\'" + field + "\'], #quickcheckoutconfirm select[name=\'" + field + "\']").css('border', '1px solid #f00').css('background', '#F8ACAC');
					if (!scrollItem)
						scrollItem = "#shipping-method-fields input[name=\'" + field + "\']";
				}

				if (!scrollItem)
					scrollItem = "h1";
				$('html, body').animate({scrollTop: $(scrollItem).offset().top}, 'slow');

			} else {
				callback();
			}
		}
	});
	return neoseo_checkout_shipping_validate_ajax;
}
var neoseo_checkout_shipping_ajax = null;
function reloadShippingMethod(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	if (neoseo_checkout_shipping_ajax)
		neoseo_checkout_shipping_ajax.abort();
	neoseo_checkout_shipping_ajax = $.ajax({
		url: language + 'index.php?route=checkout/neoseo_shipping',
		type: 'post',
		data: $('#shipping select, #shipping input[type=\'hidden\'], #shipping input[type=\'text\'], #shipping input[type=\'radio\']:checked, #shipping input[type=\'checkbox\']:checked, #shipping textarea'),
		dataType: 'html',
		cache: false,
		success: function (html) {
			$('#shipping-method').html(html);

			$('#shipping_pickpoint').click(function () {
				$('#shipping_methods div.type-pickpoint').show();
				$('#shipping_methods div.type-address').hide();
			});

			$('#shipping_address').click(function () {
				$('#shipping_methods div.type-pickpoint').hide();
				$('#shipping_methods div.type-address').show();
			});

			shippingMethodChanged(callback);
		}
	});
}
var neoseo_checkout_shipping_set_ajax = null;
function shippingMethodChanged(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	if (neoseo_checkout_shipping_set_ajax)
		neoseo_checkout_shipping_set_ajax.abort();
	neoseo_checkout_shipping_set_ajax = $.ajax({
		url: language + 'index.php?route=checkout/neoseo_shipping/set',
		type: 'post',
		data: $('#shipping select, #shipping input[type=\'hidden\'], #shipping input[type=\'text\'], #shipping input[type=\'radio\']:checked, #shipping input[type=\'checkbox\']:checked, #shipping textarea'),
		dataType: 'json',
		cache: false,
		success: function (json) {
			if (json["shipping"]) {
				$("#shipping-method-info").html(json["shipping"]);
				$("#shipping-form .buttons").remove();
				$("#shipping-form").append($("#payment-method-info .buttons"));
				$("#shipping-method-info h2").remove();
				$("#shipping-method-info").show();
			} else {
				$("#shipping-method-info").html("");
				$("#shipping-method-info").hide();
			}
			if (json["fields"]) {
				$("#shipping-method-fields").html(json["fields"]);
				//$("#shipping-method-fields").find(".row").removeClass("row");
				$("#shipping-method-fields").show();
			} else {
				$("#shipping-method-fields").html("");
				$("#shipping-method-fields").hide();
			}

			callback();
		},
		error: function () {
			$("#shipping-method-info").html("");
		}
	});
}

// Payment
var neoseo_checkout_payment_ajax = null;
function reloadPaymentMethod(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	if (neoseo_checkout_payment_ajax)
		neoseo_checkout_payment_ajax.abort();
	neoseo_checkout_payment_ajax = $.ajax({
		url: language + 'index.php?route=checkout/neoseo_payment',
		type: 'post',
		data: $('#payment select, #payment input[type=\'hidden\'], #payment input[type=\'text\'], #payment input[type=\'radio\']:checked, #payment input[type=\'checkbox\']:checked, #payment textarea'),
		dataType: 'html',
		cache: false,
		success: function (html) {
			$('#payment-method').html(html);

			paymentMethodChanged(callback);
		}
	});
}
var neoseo_checkout_payment_set_ajax = null;
function paymentMethodChanged(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	if (neoseo_checkout_payment_set_ajax)
		neoseo_checkout_payment_set_ajax.abort();
	neoseo_checkout_payment_set_ajax = $.ajax({
		url: language + 'index.php?route=checkout/neoseo_payment/set',
		type: 'post',
		data: $('#payment select, #payment input[type=\'hidden\'], #payment input[type=\'text\'], #payment input[type=\'radio\']:checked, #payment input[type=\'checkbox\']:checked, #payment textarea'),
		dataType: 'json',
		cache: false,
		success: function (json) {
			if (json["payment"]) {
				$("#payment-method-info").html(json["payment"]);
				$("#payment-form .buttons").remove();
				$("#payment-form").append($("#payment-method-info .buttons"));
				$("#payment-method-info h2").remove();
			} else {
				$("#payment-method-info").html("");
			}
			if (json["fields"]) {
				$("#payment-method-fields").html(json["fields"]);
			} else {
				$("#payment-method-fields").html("");
			}

			callback();
		},
		error: function () {
			$("#payment-method-info").html("");
            callback();
		}
	});
}
var neoseo_checkout_payment_validate_ajax = null;
function validatePaymentMethod(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	if (neoseo_checkout_payment_validate_ajax)
		neoseo_checkout_payment_validate_ajax.abort();
	neoseo_checkout_payment_validate_ajax = $.ajax({
		url: language + 'index.php?route=checkout/neoseo_payment/validate',
		type: 'post',
		data: $('#payment select, #payment input[type=\'hidden\'], #payment input[type=\'text\'], #payment input[type=\'radio\']:checked, #payment input[type=\'checkbox\']:checked, #payment textarea'),
		dataType: 'json',
		cache: false,
		success: function (json) {
			$('.warning, .error').remove();

			if (json['redirect']) {
				location = json['redirect'];
			} else if (json['error']) {
				$('#button-payment-method').attr('disabled', false);
				$('.wait').remove();


				var scrollItem = "";
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="alert alert-danger">' + json['error']['warning'] + '</div>');
					scrollItem = '#warning-messages';
				}

				for (var field in json['error']['payment_fields']) {
					$("#payment-method-fields input[name=\'" + field + "\']").after('<br><span class="error">' + json['error']['payment_fields'][field] + '</span>');
					$("#payment-method-fields input[name=\'" + field + "\']").css('border', '1px solid #f00').css('background', '#F8ACAC');
					if (!scrollItem)
						scrollItem = "#payment-method-fields input[name=\'" + field + "\']";
				}

				if (!scrollItem)
					scrollItem = "h1";
				$('html, body').animate({scrollTop: $(scrollItem).offset().top}, 'slow');
			} else {
				callback();
			}
		}
	});
	return neoseo_checkout_payment_validate_ajax;
}

// Customer
function reloadCustomer(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=checkout/neoseo_customer',
		dataType: 'html',
		cache: false,
		success: function (html) {
			$('#customer .quickcheckout-content').html(html);
			$("[name=register]").click(function () {
				registerChanged();
			});
			$('[name=register]').on('ifChanged', function () {
				registerChanged();
			});


			callback();
		}
	});
}

function validateCustomer(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	var formData = new FormData();
	$.each($("#customer textarea:enabled, #customer  input[type=\'hidden\']:enabled, #customer  input[type=\'text\']:enabled, #customer  input[type=\'password\']:enabled, #customer input[type=\'checkbox\']:checked:enabled, #customer input[type=\'radio\']:checked:enabled, #customer select:enabled, #city"), function (key, object) {
		formData.append($(this).attr('name'), $(this).val());
	});
	for (var i = 0; i < files_array.length; i++)
		formData.append('files[]', files_array[i]);

	return $.ajax({
		url: language + 'index.php?route=checkout/neoseo_customer/validate',
		type: 'post',
		data: formData,
		dataType: 'json',
		cache: false,
		contentType: false,
		processData: false,
		async: false,
		success: function (json) {
			$('.warning, .error').remove();
			$("#customer input").css('border', '').css('background', '');
			$("#customer input").parent().find('span.error').remove();

			if (json['redirect']) {
				location = json['redirect'];
			} else if (!json['error']) {
				callback();
			} else {

				$('#button-payment-method').attr('disabled', false);
				$('.wait').remove();

				var scrollItem = "";
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('.warning').fadeIn('slow');
					scrollItem = ".warning";
				}

				for (var field in json['error']['customer_fields']) {
					$("#customer input[name=\'" + field + "\']").after('<span class="error" style="color:#f00">' + json['error']['customer_fields'][field] + '</span>');
					$("#customer input[name=\'" + field + "\']").css('border', '1px solid #f00').css('background', '#F8ACAC');
					if (!scrollItem)
						scrollItem = "#customer input[name=\'" + field + "\']";
				}
				if (!scrollItem)
					scrollItem = "h1";

				$('html, body').animate({scrollTop: $(scrollItem).offset().top}, 'slow');
			}
		}
	});
}


function registerChanged() {
	var container = $("[name=register]:enabled").parents(".types");
	if ($("[name=register]", container).prop('checked')) {
		$(".quickcheckout-content.form").find('input').each(function (index) {
			if ($(this).data('register')) {
				$(this).parents('.row.form-group').show();
			}
		});
		if (!window.email_required && $("[for^=email]", container).html())
			$("[for^=email]", container).parent().addClass("required");

	} else {
		$(".quickcheckout-content.form").find('input').each(function (index) {
			if ($(this).data('register')) {
				$(this).parents('.row.form-group').hide();
			}
		});
		if (!window.email_required && $("[for^=email]", container).html())
			$("[for^=email]", container).parent().removeClass("required");
		$("#customer input[name=email]").css('border', '').css('background', '');
		$("#customer input[name=email]").parent().find('span.error').remove();
	}
}

function onLogin() {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	return $.ajax({
		url: language + 'index.php?route=checkout/neoseo_checkout/validateLogin',
		type: 'post',
		data: $('#popup-login :input'),
		dataType: 'json',
		cache: false,
		success: function (json) {
			$('#popup-login .alert').remove();

			if (json['redirect']) {
				location = json['redirect'];
			} else if (json['error']) {
				$('#popup-login .modal-body').prepend('<div class="alert alert-danger">' + json['error']['warning'] + '</div>');
			}
		}
	});
}

// Cart
function reloadCart(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=checkout/neoseo_cart',
		dataType: 'html',
		cache: false,
		success: function (html) {
			$('#checkout-cart .quickcheckout-content').html(html);

			callback();
		}
	});
}

function updateCart(data, callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=checkout/neoseo_cart/update',
		type: 'post',
		data: data,
		dataType: 'json',
		cache: false,
		success: function (json) {
			if (json['redirect']) {
				location = json['redirect'];
			} else {
				$('#cart-total, .cart-total, .cart__total-cost').html(json['total']);
				$('#cart-total-items,.cart-total-items span, .cart__total-items').html(json['total_items']);
				$('#cart').load('index.php?route=common/cart/info #cart > *');
				$('.cart').load('index.php?route=common/cart/info .cart > *');
				callback();
			}
		}
	});
}

// Order

function validateTerms(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	return $.ajax({
		url: language + 'index.php?route=checkout/neoseo_checkout/validate',
		type: 'post',
		data: $('#confirm input[type=\'checkbox\']:checked, #check-agree input[type=\'checkbox\']:checked'),
		dataType: 'json',
		cache: false,
		success: function (json) {
			if (json['error']) {
				$('#button-payment-method').attr('disabled', false);
				$('.warning, .error').remove();
				$('.wait').remove();

				var scrollItem = "";
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning alert alert-danger" style="display: none;"><a href="#" class="close" data-dismiss="alert" aria-label="close" title="close">×</a>' + json['error']['warning'] + '</div>');
					$('.warning').fadeIn('slow');
					scrollItem = '.warning';
				}

				if (!scrollItem)
					scrollItem = "h1";
				$('html, body').animate({scrollTop: $(scrollItem).offset().top}, 'slow');
			} else {
				callback();
			}
		}
	});
}

// Voucher

function validateVoucher(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	return $.ajax({
		url: language + 'index.php?route=checkout/neoseo_cart/validateVoucher',
		type: 'post',
		data: $('#collapse-voucher :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function () {
			$('#button-voucher').prop('disabled', true);
			$('#button-voucher').prepend('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> ');
		},
		complete: function () {
			$('#button-voucher').prop('disabled', false);
			$('#button-voucher .glyphicon').remove();
		},
		success: function (json) {
			$('.warning, .success').remove();

			if (json['success']) {
				$('#success-messages').prepend('<div class="success alert alert-success" style="display:none;">' + json['success'] + '</div>');
				$('html, body').animate({scrollTop: 0}, 'slow');
				$('.success').fadeIn('slow');
			} else if (json['error']) {
				$('#warning-messages').prepend('<div class="warning alert alert-danger" style="display: none;">' + json['error']['warning'] + '</div>');
				$('html, body').animate({scrollTop: 0}, 'slow');
				$('.warning').fadeIn('slow');
			}

			callback();
		}
	});
}

// Coupon

function validateCoupon(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	return $.ajax({
		url: language + 'index.php?route=checkout/neoseo_cart/validateCoupon',
		type: 'post',
		data: $('#collapse-coupon :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function () {
			$('#button-coupon').prop('disabled', true);
			$('#button-coupon').prepend('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> ');
		},
		complete: function () {
			$('#button-coupon').prop('disabled', false);
			$('#button-coupon .glyphicon').remove();
		},
		success: function (json) {
			$('.warning, .success').remove();

			if (json['success']) {
				$('#success-messages').prepend('<div class="success alert alert-success" style="display:none;">' + json['success'] + '</div>');
				$('html, body').animate({scrollTop: 0}, 'slow');
				$('.success').fadeIn('slow');
			} else if (json['error']) {
				$('#warning-messages').prepend('<div class="warning alert alert-danger" style="display: none;">' + json['error']['warning'] + '</div>');
				$('html, body').animate({scrollTop: 0}, 'slow');
				$('.warning').fadeIn('slow');
			}

			callback();
		}
	});
}

// Reward

function validateReward(callback) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=checkout/neoseo_cart/validateReward',
		type: 'post',
		data: $('#collapse-reward :input'),
		dataType: 'json',
		cache: false,
		beforeSend: function () {
			$('#button-reward').prop('disabled', true);
			$('#button-reward').prepend('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> ');
		},
		complete: function () {
			$('#button-reward').prop('disabled', false);
			$('#button-reward .glyphicon').remove();
		},
		success: function (json) {
			$('.warning, .success').remove();

			if (json['success']) {
				$('#success-messages').prepend('<div class="success alert alert-success" style="display:none;">' + json['success'] + '</div>');
				$('html, body').animate({scrollTop: 0}, 'slow');
				$('.success').fadeIn('slow');
			} else if (json['error']) {
				$('#warning-messages').prepend('<div class="warning alert alert-danger" style="display: none;">' + json['error']['warning'] + '</div>');
				$('html, body').animate({scrollTop: 0}, 'slow');
				$('.warning').fadeIn('slow');
			}

			callback();
		}
	});
}



/**
 * Order Confirmation
 */

// Load confirm
function createOrder() {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	return $.ajax({
		url: language + 'index.php?route=checkout/neoseo_checkout/confirm',
		dataType: 'json',
		cache: false,
		success: function (json) {
			if (json['error']) {
				$('#button-payment-method').attr('disabled', false);
				$('.wait').remove();

				$('html, body').animate({scrollTop: 0}, 'slow');

				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error'] + '</div>');
					$('.warning').fadeIn('slow');
				}
			} else if (json['redirect']) {
				document.location = json['redirect'];
			} else {
				if (json["order_data"]) {
					var order = json["order_data"];

					if (typeof ga !== 'undefined' && ga === 'function') {
						ga('send', 'event', 'checkout', 'finish', "Order #" + order['order_id'], order["total"]);
					}

					if (typeof sendGoogleECommerceTransaction !== 'undefined' && typeof sendGoogleECommerceTransaction === "function") {
						sendGoogleECommerceTransaction(order);
					}
					if (typeof sendYandexECommerceTransaction !== 'undefined' && typeof sendYandexECommerceTransaction === "function") {
						sendYandexECommerceTransaction(order);
					}
				}
				if (json["payment"]) {
					$("#payment-method-info").html(json["payment"]);
					$("#payment-method-info .buttons").css('display', 'none');
					$("#payment-method-info h2").css('display', 'none');

					//$("#payment-form .buttons").remove();
					//$("#payment-form").append($("#payment-method-info .buttons"));

					if ($('#payment-method-info form')[0]) {
						$('#payment-method-info form').submit();
					} else if ($('#payment-method-info input[type=button]')[0]) {
						$('#payment-method-info input[type=button]').trigger('click');
					} else if ($('#payment-method-info [type=submit]')[0]) {
						$('#payment-method-info [type=submit]').trigger('click');
					} else if ($('#payment-method-info a.button')[0]) {
						$('#payment-method-info a.button').trigger('click');
					} else {
						$('html, body').animate({scrollTop: 0}, 'slow');
						$('#warning-messages').prepend('<div class="warning" style="display: none;">' + "Не удается завершить заказ. Свяжитесь с администратором магазина!" + '</div>');
						$('.warning').fadeIn('slow');
					}
				} else {
					// Такого быть не должно, это ошибка.
					$('html, body').animate({scrollTop: 0}, 'slow');
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + "Не удается завершить заказ. Свяжитесь с администратором магазина!" + '</div>');
					$('.warning').fadeIn('slow');
				}
			}
		}
	});
}

function doLogin() {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=checkout/neoseo_checkout/login',
		dataType: 'json',
		success: function (json) {
			if (json['html']) {
				if ($("#popup-login").length == 0)
					$("body").append("<div id=\"popup-login\"></div>");
				$("#popup-login").html(json["html"]);
				$('#popup-login > div').modal();
				$('#button-login').click(function (e) {
					e.preventDefault();
					onLogin();
				});
			}
		}
	});
}

function saveField(name, value) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	data = {name: name, value: value};
	$.ajax({
		url: language + 'index.php?route=checkout/neoseo_checkout/save',
		data: data,
		type: 'post',
		dataType: 'json',
		cache: false
	});
}


$(document).ready(function ()
{
	files_array = [];
	$('#input_images').unbind('change');
	$('#input_images').change(function (event) {
		read_file($(this)[0].files);
	});
});

function read_file(file)
{
	$('.error_files').remove();
	for (var i = 0; i < file.length; i++)
	{
		if (file[i].type.indexOf('image') !== -1)
		{
			files_array[files_array.length] = file[i];
			var reader = new FileReader();
			reader.onload = function (event)
			{
				var contents = event.target.result;
				$('#ul-photo-preview').append('<li style="background-image:url(' + contents + ');"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
			};
			reader.readAsDataURL(file[i]);
		} else if (file[i].type.indexOf('text/plain') !== -1)
		{
			files_array[files_array.length] = file[i];
			$('#ul-photo-preview').append('<li style="background-image:url(/image/neoseo_checkout/txt.png); border:none;"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
		} else if (file[i].type.indexOf('rtf') !== -1 || file[i].type.indexOf('msword') !== -1)
		{
			files_array[files_array.length] = file[i];
			if (file[i].type.indexOf('openxmlformats-officedocument') !== -1)
				$('#ul-photo-preview').append('<li style="background-image:url(image/neoseo_checkout/xls.ico); border:none;"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
			else
				$('#ul-photo-preview').append('<li style="background-image:url(/image/neoseo_checkout/doc.ico); border:none;"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
		} else if (file[i].type.indexOf('openxmlformats-officedocument') !== -1)
		{
			files_array[files_array.length] = file[i];
			$('#ul-photo-preview').append('<li style="background-image:url(/image/neoseo_checkout/xls.ico); border:none;"><a href="" onclick="del_photo(this,' + files_array.length + '); return false;"></a></li>');
		} else
			$('.button-uploading').after('<span class="error_files" style="color:#f00"><?php echo $error_upload_file;?><span>');
	}
}

function del_photo(obj, index)
{
	var obj;
	$(obj).parent('li').remove();
	delete(files_array[index - 1]);
}
