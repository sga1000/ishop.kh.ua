<?php if($neoseo_quick_order_status == 1){ ?>
<div class="col-xs-12" id="popup-cart-quick-order-form">
	<div class="row">
		<div class="form-group">
			<div class="input-group">
				<input type="text" id="input-phone-popup-cart" placeholder="<?php echo $text_quick_order; ?>" class="form-control">
				<span class="input-group-btn">
					<button id="button-quick-order-cart" type="button" class="btn btn-default" onclick="doQuickOrderPopupCart();">
						<i class="fa fa-shopping-cart"></i>
						<span><?php echo $button_quick_order ?></span>
					</button>
				</span>
			</div>
			<div class="help-block-cart" style="display:none;font-weight:bold;"><?php echo $text_no_phone; ?></div>
			<style>
				.has-error #button-quick-order-cart {
					border-bottom: 1px solid #a94442;
					border-top: 1px solid #a94442;
					border-right: 1px solid #a94442;
				}
			</style>
			<script> 
				function doQuickOrderPopupCart() {
					var phone = $('#input-phone-popup-cart').val();
					if (!phone) {
						$("#popup-cart .help-block-cart").show();
						$("#popup-cart-quick-order-form").addClass("has-error");
						return;
					}
					$("#popup-cart .help-block-cart").hide();
					$("#popup-cart-quick-order-form").removeClass("has-error");

					var quantity = 2;
					$("#popup-cart > div").modal('hide');
					addQuickOrder('a%3A1%3A%7Bi%3A2931%3Bs%3A1%3A%222%22%3B%7D', quantity, phone, 'cart_product');
				}
				<?php if($quick_order_phone_mask) { ?>
					$("#input-phone-popup-cart").mask("<?php echo $quick_order_phone_mask; ?>");
				<?php } ?>
			</script>
		</div>
	</div>
</div>
<?php } ?>