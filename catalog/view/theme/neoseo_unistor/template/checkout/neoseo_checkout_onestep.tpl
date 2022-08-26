<?php if ($header_hide) {  ?>
<div class="hidden">
	<?php echo $header; ?>
</div>
<br>
<?php  } else { ?>
<?php echo $header; ?>
<br>
<?php } ?>
<div class="container">
	<?php require_once(dirname(__FILE__) . '/../common/breadcrumbs.tpl'); ?>
	<div class="row">
		<div id="content" class="col-sm-12">
			<div class="account-container box-shadow box-corner checkout-container">
			<!-- <h1><?php echo $heading_title; ?></h1> -->

			<div id="warning-messages"></div>
			<div id="success-messages"></div>

			<div id="quickcheckoutconfirm" class="clearfix">

				<div class="col-sm-12 col-md-7 order-values-block">
					<h1><?php echo $heading_title; ?></h1>
					<h3><?php echo $text_contact_info; ?></h3>
					<div id="customer" class="clearfix">
						<?php if (!$logged) { ?>
							<ul class="list-inline text-center col-sm-offset-4">
								<li class="active"><a class="btn btn-primary" href="javascript:void();"><?php echo $text_not_have_account; ?></a></li>
								<li><a class="btn btn-default" href="#" id="login"><?php echo $text_login; ?></a></li>
							</ul>
						<?php } ?>

						<div id="payment-address">
							<div class="quickcheckout-content form"></div>
						</div>
					</div>

<?php if( $neoseo_checkout_dependency_type == "payment_for_shipping" ) { ?>

<?php if ($shipping_required) { ?>
					<div id="shipping" class="row">
						<div class="col-sm-4">
							<h3 for="shipping-method" class="control-label"><?php echo $text_shipping; ?></h3>
						</div>
						<div class="col-sm-8 quickcheckout-content form">
							<?php require_once('neoseo_city.tpl'); ?>
							<div id="shipping-method"></div>
						</div>
					</div>
<?php } ?>
					<div id="payment" class="row">
						<div class="col-sm-4">
							<h3 for="payment-method" class="control-label"><?php echo $text_payment; ?></h3>
						</div>
						<div class="col-sm-8 quickcheckout-content form">
							<div id="payment-method" class="field"></div>
						</div>
					</div>

<?php } else { // if( $neoseo_checkout_dependency_type == "payment_for_shipping" ) ?>

					<div id="payment">
						<div class="col-sm-4">
							<label for="payment-method" class="control-label"><?php echo $text_payment; ?></label>
						</div>
						<div class="col-sm-8 quickcheckout-content form">
							<div id="payment-method" class="field"></div>
						</div>
					</div>

<?php if ($shipping_required) { ?>

					<div id="shipping">
						<div class="col-sm-4">
							<label for="shipping-method" class="control-label"><?php echo $text_shipping; ?></label>
						</div>
						<div class="col-sm-8 quickcheckout-content form">
							<?php require_once('neoseo_city.tpl'); ?>
							<div id="shipping-method"></div>
						</div>
					</div>
<?php } ?>

<?php } ?>
					
					<?php if ($text_agree) { ?>
						<div class='checkbox checkbox-primary checkbox-inline' id="check-agree">
							<?php if ($agree) { ?>
								<input class='checkbox' id="input-agree" type="checkbox" name="agree" value="1" checked="checked" />
								<label for="input-agree"><?php echo $text_agree; ?></label>
							<?php } else { ?>
								<input id="input-agree" type="checkbox" name="agree" value="1"/>
								<label for="input-agree"><?php echo $text_agree; ?></label>
							<?php } ?>
						</div>
						<hr></hr>
						<?php } ?>
						<?php if ($agreement_text) { ?>
							<div class="well box-shadow box-corner" style="height: 160px; overflow: auto;"><?php echo html_entity_decode($description_agree); ?></div>
						<?php } ?>

						<div class="text-left">
							<button id="button-payment-method" class="btn btn-primary"><?php echo $button_checkout; ?></button>
						</div>

				</div>

				<div id="checkout-cart" class="col-sm-12 col-md-5 order-cart-block">
					<h3><?php echo $text_cart; ?></h3>
					<div class="quickcheckout-content"></div>
					<div id="confirm">
						<hr>
						<div id="payment-form" style="display:none"></div>
						<div id="shipping-form" style="display:none"></div>



						
						<div style="clear:both;height: 17px;"></div>

					</div>

				</div>

			</div>
			</div>
        </div>
    </div>
</div>

<script>
	function debounce (timeout, fn ) {
		var timer;
		return function() {
			var args = arguments;
			var ctx = this;
			clearTimeout(timer);
			timer = setTimeout(function() {
				fn.apply(ctx,args);
				timer = null;
			}, timeout);
		};
	}

	$(document).ready(function(){
		$("#login").click(function(e) {
			e.preventDefault();
			doLogin();
		});

		$('#quickcheckoutconfirm').on('keydown', 'input,textarea', debounce(500, function(e) {
			saveField($(this).prop('name'),$(this).val());
		}));

		$('#quickcheckoutconfirm').on('change', 'input,select,textarea', function(e) {
			if( $(this).prop('type') == 'checkbox' ) {
				saveField($(this).prop('name'), $(this).prop('checked') ? 1 : 0 );
			} else {
				saveField($(this).prop('name'), $(this).val());
			}
		});

		<?php if ( $neoseo_checkout_shipping_city_select == "default" ) { ?>
		$('#quickcheckoutconfirm').on('keydown', '#city', debounce(500, function(e) {
			changeCity($("#city").val(),$("#zone_id").val(),$("#country_id").val(), function(){
				reloadCheckout();
			});
		}));
		$('#quickcheckoutconfirm').on('change', '#city', function(e) {
			changeCity($("#city").val(),$("#zone_id").val(),$("#country_id").val(), function(){
				reloadCheckout();
			});
		});
		$("select#zone_id").change( function(){
			changeCity($("#city").val(),$("#zone_id").val(),$("#country_id").val(), function(){
				reloadCheckout();
			});
		});
		<?php } ?>

		$('#button-payment-method').click('click', function() {
			var validate = '[]';
			validate = validateCustomer(function(){
			});
			if(validate.responseText == '[]') {
				var data = {};
				$('#shipping select, #shipping input[type="hidden"], #shipping input[type="text"], #shipping input[type="radio"]:checked, #shipping input[type="checkbox"]:checked, #shipping textarea').each(function () {
					data[$(this).attr('name')] = $(this).val();
				});
				$.ajax({
					url: 'index.php?route=checkout/neoseo_checkout/save',
					type: 'post',
					data: {"data": data},
					success: function () {
						validateOrder();
					}
				});
			}
		});

		reloadCheckout();
	});
<?php if(isset($hide_city_block) && $hide_city_block) { ?>
	$(document).delegate('input[name=\'shipping_method\']', 'change', function() {
		var sel_sh = $(this).val();
		console.log(sel_sh);
		var sh_methods = ["<?php echo implode('","',$shipping_require_city); ?>"];
		if($.inArray(sel_sh,sh_methods) !== -1 ){
			$('.shipping_hider').show();
		} else {
			$('.shipping_hider').hide();
		}
	});
<?php } ?>
</script>
<!-- hide_footer -->
<?php if ($hide_footer) {  ?>
<div class="hidden">
	<?php echo $footer; ?>
</div>
<?php  } else { ?>
<?php echo $footer; ?>
<?php } ?>
