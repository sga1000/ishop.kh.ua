function reloadShippingWrapper(){

    reloadShipping( function(){
        $('#shipping-method input[name=\'shipping_method\'], #shipping-method select[name=\'shipping_method\']').change(function(){
            shippingMethodChangedWrapper();
        });
        reloadPaymentWrapper();
    });

}

function shippingMethodChangedWrapper(){
    shippingMethodChanged( function(){
        reloadPaymentWrapper();
    });
}

function reloadPaymentWrapper() {
    reloadPayment( function(){
        $('#payment-method input[name=\'payment_method\'], #payment-method select[name=\'payment_method\']').change(function(){
            paymentMethodChangedWrapper();
        });
        reloadCustomerWrapper();
        reloadCartWrapper();
    });
}

function paymentMethodChangedWrapper(){
    shippingMethodChanged( function(){
        reloadPaymentWrapper();
    });
}

function reloadCustomerWrapper(){
    reloadCustomer();
}

function reloadCartWrapper(){
    reloadCart(function() {
        $('#button-coupon').click(function() {
            validateCoupon(function(){
                reloadCartWrapper();
            });
        });

        $('#button-voucher').click(function() {
            validateVoucher(function(){
                reloadCartWrapper();
            });
        });

        $('#button-reward').click(function() {
            validateReward(function(){
                reloadCartWrapper();
            });
        });

        $("#checkout-cart .plus").click(function(e){
            e.preventDefault();
            var parent = $(this).parent();
            $("input",parent).val( parseInt($("input",parent).val()) + 1 );
            updateCart($(':input',parent),function() {
                reloadShippingWrapper();
            });
        });

        $("#checkout-cart .minus").click(function(e){
            e.preventDefault();
            var parent = $(this).parent();
            if( parseInt($("input",parent).val())  > 1 ) {
                $("input", parent).val(parseInt($("input", parent).val()) - 1);
                updateCart($(':input', parent),function() {
                    reloadShippingWrapper();
                });
            }
        });

        $('#checkout-cart .trash').click(function(e) {
            e.preventDefault();
            var key2 = $(this).attr('href');
            updateCart({remove: key2},function() {
                reloadShippingWrapper();
            });
        });

    });
}
