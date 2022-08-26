$(function () {
    $('body').on('click', '.addGift', addGiftToCart);
    $('body').on('click', '.addGiftCheckout', addGiftToCartCheckout);

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
                showCart(json);
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