$(document).ready(function(){
    $(".product-thumb .image").each(function(index,object){
		$(object).prepend('<a onclick="productQuickview($(this))" class="quickview glyphicon glyphicon-eye-open"></a>');
	});
	$(".product-previews-light .product-preview__thumb-image").each(function(index,object){
		$(object).append(' <div class="-quick-buttons-"><a onclick="productQuickviewLight($(this))" class="--quikview"><i class="fa fa-search-plus"></i></a></div>');
	});
});


function productQuickview(object) {
    var a = $(">a:last",object.parent());
    $.ajax({
        url: a.prop('href'),
        type: 'post',
        data: 'quickview=1',
        dataType: 'json',
        success: function(json) {
            $('.alert').remove();

            if (json['popup']) {
                $("body").append("<div id=\"popup-quickview\"></div>");
                $("#popup-quickview").html(json["popup"]);
                $('#popup-quickview > div').modal();
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
}

function productQuickviewLight(object) {
	var a = $(object.parents('.product-preview__thumb').find('.product-preview__thumb-name a'));
	$.ajax({
		url: a.prop('href'),
		type: 'post',
		data: 'quickview=1',
		dataType: 'json',
		success: function(json) {
			$('.alert').remove();

			if (json['popup']) {
				$("body").append("<div id=\"popup-quickview\"></div>");
				$("#popup-quickview").html(json["popup"]);
				$('#popup-quickview > div').modal();
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function onChangeOptionQW(){
    var priceLabel = $('.price-area-quick');
	var priceFrom = parseFloat(priceLabel.text().replace(/[^\d\.]+/, ''));

	var priceTo = parseFloat($('#price_clear').attr('data-price').replace(/[^\d\.]+/, ''));
	$('#popup-quickview #product select option:selected, #popup-quickview #product input[type=radio]:checked, #popup-quickview #product input[type=checkbox]:checked, #popup-quickview #product input[type=text], #popup-quickview #product textarea').each(function () {
		el = $(this);

		if (el.data('price')) {
			var option_price = parseFloat(String(el.data('price')).replace(/[^\d\.]+/, ''));
			priceTo += el.data('prefix') == '-' ? option_price * (-1) : option_price;
		};
	});

	changePriceQW(
		priceFrom,
		priceTo,
		priceLabel
	);
}

function changePriceQW(priceFrom, priceTo, priceLabel){

	if ( priceFrom == priceTo || isNaN(priceFrom) || isNaN(priceTo)  ) {
	    return;
	}

	priceFrom = parseFloat(priceFrom);
	priceTo = parseFloat(priceTo);
	var price = priceFrom;
    var step = parseFloat(Number(Math.abs( priceFrom - priceTo ) / 10).toFixed(2));

	var timer_id = setInterval(function(){

		if(priceFrom > priceTo) {
			price -= step;
			if(price < priceTo) {
				price = priceTo;
			}
		} else {
			price += step;
			if(price > priceTo) {
				price = priceTo;
			}
		}

		priceLabel.text(priceLabel.text().replace(/^[\d\.\s]+/, parseFloat(price).toFixed(2) + ' '));

		if ( price != priceTo) {
			return;
		}

        clearInterval(timer_id)

	}, 20);
}