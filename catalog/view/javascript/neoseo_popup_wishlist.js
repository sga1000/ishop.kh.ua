function popupWishlistShow(json) {

	if (json["products_count"] == 0) {
		if ($(".unistor-wishlist-total > span").length) {
			$(".unistor-wishlist-total > span").remove();
		}
		if ($(".unistor-stiky-wishlist-total > span").length) {
			$(".unistor-stiky-wishlist-total > span").remove();
		}
		updateMobileWishlist(json['products_count']);
	} else {
		if ($(".unistor-wishlist-total > span").length) {
			$(".unistor-wishlist-total > span").html(json["products_count"]);
		} else {
			$(".unistor-wishlist-total i").after("<span>" + json["products_count"] + "</span>");
		}

		if ($(".unistor-stiky-wishlist-total > span").length) {
			$(".unistor-stiky-wishlist-total > span").html(json["products_count"]);
		} else {
			$(".unistor-stiky-wishlist-total i").after("<span>" + json["products_count"] + "</span>");
		}
		updateMobileWishlist(json['products_count']);
	}

	if (json["products_count"] == 0 && json['force_show'] != 1) {
		$("#popup-wishlist > div").modal('hide');
	} else if (json["popup-modal"]) {
		if ($("#popup-wishlist").length == 0) {
			$("body").append("<div id=\"popup-wishlist\"></div>");
			$("#popup-wishlist").html(json["popup-modal"]);
			$("#popup-wishlist .modal-body").html(json["popup-modal-body"]);
			$('#popup-wishlist > div').modal();
		} else {
			$("#popup-wishlist .modal-body").html(json["popup-modal-body"]);
			$('#popup-wishlist > div').modal();
		}
	}
}

function popupWishlistTrash(product_id) {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=account/wishlist/remove',
		type: 'post',
		data: 'product_id=' + product_id,
		dataType: 'json',
		success: function (json) {
			popupWishlistShow(json);
		}
	});
}

var wishlist = {
	'add': function (product_id) {
		var language = "";
		if (window.current_language) {
			language = window.current_language;
		}
		$.ajax({
			url: language + 'index.php?route=account/wishlist/add',
			type: 'post',
			data: 'product_id=' + product_id,
			dataType: 'json',
			success: function (json) {
				$('.alert').remove();

				if (json['success']) {
					popupWishlistShow(json);

					$('#wishlist-total span').html(json['total']);
					$('#wishlist-total').attr('title', json['total']);
					updateMobileWishlist(json['products_count']);
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	},
	'remove': function () {

	}
}


function updateMobileWishlist(count) {
	if ($('.header-mobile-menu__wishlist .--total').length > 0) {
		$('.header-mobile-menu__wishlist .--total').html(count);
	} else {
		$('.header-mobile-menu__wishlist').append('<span class="--total">' + count + '</span>');
	}
}