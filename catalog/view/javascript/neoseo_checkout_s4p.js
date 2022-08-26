function reloadShippingWrapper(){

	reloadShippingMethod( function(){
		$("#shipping-method input[name='shipping_method'], #shipping-method select[name='shipping_method']").change(function(){
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
	reloadPaymentMethod( function(){
		$("#payment-method input[name='payment_method'], #payment-method select[name='payment_method']").change(function(){
			paymentMethodChangedWrapper();
		});
		//reloadCustomerWrapper();
		reloadCartWrapper();
	});
}

function paymentMethodChangedWrapper(){
	paymentMethodChanged( function(){
		reloadCartWrapper();
	});
}

function reloadCustomerWrapper(){
	reloadCustomer(function(){
		reloadShippingWrapper();
	});
}

function reloadCartWrapper(){
	reloadCart(function() {
		$('#button-coupon').click(function() {
			validateCoupon(function(){
				reloadCheckout();
			});
		});

		$('#button-voucher').click(function() {
			validateVoucher(function(){
				reloadCheckout();
			});
		});

		$('#button-reward').click(function() {
			validateReward(function(){
				reloadCheckout();
			});
		});

		$("#checkout-cart .plus").click(function(e){
			e.preventDefault();
			var parent = $(this).parent();
			$("input",parent).val( parseInt($("input",parent).val()) + 1 );
			updateCart($(':input',parent),function() {
				reloadCheckout();
			});
		});

		$("#checkout-cart .minus").click(function(e){
			e.preventDefault();
			var parent = $(this).parent();
			if( parseInt($("input",parent).val())  > 1 ) {
				$("input", parent).val(parseInt($("input", parent).val()) - 1);
				updateCart($(':input', parent),function() {
					reloadCheckout();
				});
			}
		});

		$('#checkout-cart .trash').click(function(e) {
			e.preventDefault();
			var key2 = $(this).attr('href');
			updateCart({remove: key2},function() {
				reloadCheckout();
			});
		});

	});
}

function validateCustomerWrapper(){
	validateCustomer(function(){
		validateShippingMethodWrapper();
	});
}

function validateShippingMethodWrapper(){
	validateShippingMethod(function(){
		validatePaymentMethodWrapper();
	});
}

function validatePaymentMethodWrapper(){
	validatePaymentMethod(function(){
		validateTermsWrapper();
	});
}

function validateTermsWrapper(){
	validateTerms(function(){
		createOrder();
	});
}

function reloadCheckout(){
	reloadCustomerWrapper();
}

function validateOrder(){
	$('#button-payment-method').prop('disabled', true);
	$('#button-payment-method').prepend('<span class="wait glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> ');
	//validateCustomerWrapper();
	validateShippingMethodWrapper();
}