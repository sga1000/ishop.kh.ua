function showCart(json) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$('.cart__total-list').html(json['total']);
	$('.cart__total-items').html(json['total_items']);
	$('.cart').load(language + 'index.php?route=common/cart/info .cart > *');
	$('.cart').addClass('have-item');
	if ($('.cart__total-items').html() === '0') {
		$('.cart').removeClass('have-item');
	}
	if (json["products_count"] == 0) {
		$("#popup-cart > div").modal('hide');
		if ($("#unistor-cart-total > span").length) {
			$("#unistor-cart-total > span").remove();
		}

		updateMobileCart(json["total_items"]);
	} else if (json["popup-cart"]) {
		if ($("#unistor-cart-total > span").length) {
			$("#unistor-cart-total > span").html(json["products_count"]);
		} else {
			$("#unistor-cart-total i").after("<span>" + json["products_count"] + "</span>");
		}
		if ($("#popup-cart").length == 0) {
			$("body").append("<div id=\"popup-cart\"></div>");
			$("#popup-cart").html(json["popup-cart"]);
			$("#popup-cart .modal-body").html(json["popup-cart-body"]);
			$('#popup-cart > div').modal();
		} else {
			$("#popup-cart .modal-body").html(json["popup-cart-body"]);
			$('#popup-cart > div').modal();
		}
		updateMobileCart(json["total_items"]);
	}
}

function popupCartMinus(key, quantity) {
	if (quantity <= 1)
		return;
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=checkout/cart/edit',
		type: 'post',
		data: 'quantity[' + key + ']=' + (quantity - 1) + "&noredir=1",
		dataType: 'json',
		success: function (json) {
			showCart(json);
		}
	});
}

function popupCartPlus(key, quantity) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=checkout/cart/edit',
		type: 'post',
		data: 'quantity[' + key + ']=' + (quantity + 1) + "&noredir=1",
		dataType: 'json',
		success: function (json) {
			showCart(json);
		}
	});
}

function popupCartTrash(key) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=checkout/cart/remove',
		type: 'post',
		data: 'key=' + key,
		dataType: 'json',
		success: function (json) {
			showCart(json);
		}
	});
}

function popupCartReorder(url) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: url,
		type: 'post',
		dataType: 'json',
		success: function (json) {
			$('.alert, .text-danger').remove();

			if (json['redirect']) {
				location = json['redirect'];
			}

			if (json['success']) {

				showCart(json);

				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('.cart__total-list').html(json['total']);
				}, 100);

				setTimeout(function () {
					updateMobileCart(json["total_items"]);
				}, 100);

				$('.cart > ul').load(language + 'index.php?route=common/cart/info ul li');
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

var cart = {
	'add': function (product_id, quantity) {
		var language = "";
		if (window.current_language) {
			language = window.current_language;
		}
		$.ajax({
			url: language + 'index.php?route=checkout/cart/add',
			type: 'post',
			data: 'product_id=' + product_id + '&quantity=' + (typeof (quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			success: function (json) {
				$('.alert, .text-danger').remove();

				if (window.dataLayer && json['ecommerce']) {
					var product = json['ecommerce'];
					window.dataLayer.push({
						"ecommerce": {
							"add": {
								"products": [
									{
										'id': product['sku'],
										'name': product['name'],
										'price': product['price'],
										'brand': product['manufacturer'],
										'category': product['category'],
										'quantity': product['quantity']
									}
								]
							}
						}
					});
				}

				if (json['redirect']) {
					location = json['redirect'];
				}

				if (json['success']) {

					showCart(json);

					// Need to set timeout otherwise it wont update the total
					setTimeout(function () {
						$('.cart__total-list').html(json['total']);
					}, 100);

					console.log(json);

					setTimeout(function () {
						updateMobileCart(json["total_items"]);
						}, 100);

					$('.cart > ul').load(language + 'index.php?route=common/cart/info ul li');
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'update': function (key, quantity) {
		var language = "";
		if (window.current_language) {
			language = window.current_language;
		}
		$.ajax({
			url: language + 'index.php?route=checkout/cart/edit',
			type: 'post',
			data: 'key=' + key + '&quantity=' + (typeof (quantity) != 'undefined' ? quantity : 1),
			dataType: 'json',
			success: function (json) {
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('.cart__total-list').html(json['total']);
				}, 100);

				setTimeout(function () {
					updateMobileCart(json["total_items"]);
					}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = language + 'index.php?route=checkout/cart';
				} else {
					$('.cart > ul').load(language + 'index.php?route=common/cart/info ul li');
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function (key) {
		var language = "";
		if (window.current_language) {
			language = window.current_language;
		}
		$.ajax({
			url: language + 'index.php?route=checkout/cart/remove',
			type: 'post',
			data: 'key=' + key,
			dataType: 'json',
			success: function (json) {
				if (window.dataLayer && json['ecommerce']) {
					var product = json['ecommerce'];
					window.dataLayer.push({
						"ecommerce": {
							"remove": {
								"products": [
									{
										'id': product['sku'],
										'name': product['name'],
										'price': product['price'],
										'brand': product['manufacturer'],
										'category': product['category'],
										'quantity': product['quantity']
									}
								]
							}
						}
					});
				}
				// Need to set timeout otherwise it wont update the total
				setTimeout(function () {
					$('.cart__total-list').html(json['total']);
				}, 100);

				setTimeout(function () {
					updateMobileCart(json['total_items'])
				}, 100);

				if (getURLVar('route') == 'checkout/cart' || getURLVar('route') == 'checkout/checkout') {
					location = language + 'index.php?route=checkout/cart';
				} else if (document.location.href.indexOf("/cart/") != -1) {
					location.reload(true);
				} else {
					$('.cart > ul').load(language + 'index.php?route=common/cart/info ul li');
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
}

function updateMobileCart(count) {
	if ($('.header-mobile__cart-link .--total').length > 0) {
		$('.header-mobile__cart-link .--total').html(count);
	} else {
		$('.header-mobile__cart-link').append('<span class="--total">' + count + '</span>');
	}

	if ($('.header-mobile-menu__cart .--total').length > 0) {
		$('.header-mobile-menu__cart .--total').html(count);
	} else {
		$('.header-mobile-menu__cart').append('<span class="--total">' + count + '</span>');
	}
}