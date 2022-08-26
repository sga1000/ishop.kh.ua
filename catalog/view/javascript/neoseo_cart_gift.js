$(function () {
    $('body').on('click', '.addGift', addGiftToCart);
    $('body').on('click', '.addGiftCheckout', addGiftToCartCheckout);

    function getURLVar(key) {
        var value = [];

        var query = String(document.location).split('?');

        if (query[1]) {
            var part = query[1].split('&');

            for (i = 0; i < part.length; i++) {
                var data = part[i].split('=');

                if (data[0] && data[1]) {
                    value[data[0]] = data[1];
                }
            }

            if (value[key]) {
                return value[key];
            } else {
                return '';
            }
        }
    }

    function addGiftToCart(e) {

        e.preventDefault();

        var product_id = $(this).attr('data-product-id');
        var quantity = 1;
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: 'product_id=' + product_id + '&quantity=' + (typeof (quantity) != 'undefined' ? quantity : 1) + '&is_gift=1',
            dataType: 'json',
            success: function (json) {
                $('#cart > ul').load('index.php?route=common/cart/info ul li');
                $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                if (getURLVar('route') == 'checkout/cart') {
                    location = 'index.php?route=checkout/cart';
                } else if(getURLVar('route') == 'checkout/checkout') {
                    $.ajax({
                        url: 'index.php?route=checkout/confirm',
                        dataType: 'html',
                        success: function(html) {
                            $('#collapse-checkout-confirm .panel-body').html(html);
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                }

            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    function addGiftToCartCheckout(e) {

        e.preventDefault();

        var product_id = $(this).attr('data-product-id');
        var quantity = 1;
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: 'product_id=' + product_id + '&quantity=' + (typeof (quantity) != 'undefined' ? quantity : 1) + '&is_gift=1',
            dataType: 'json',
            success: function (json) {
                reloadCheckout();
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
});