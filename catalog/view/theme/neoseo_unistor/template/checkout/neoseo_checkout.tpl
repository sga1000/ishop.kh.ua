<?php if ($header_hide) {  ?>
<div class="hidden">
	<?php echo $header; ?>
</div>
<?php  } else { ?>
<?php echo $header; ?>
<?php } ?>
<?php  if(isset($hide_menu) && $hide_menu){ ?>
<script>$('#menu').remove();</script>
<?php  } ?>
<?php  if(isset($hide_footer) && $hide_footer){ ?>
<script>
	$( document ).ready(function() {
		$('.footer-top').hide();
		$('.footer-middle > .container > div').hide();
	});</script>
<?php  } ?>
<div class="container">
	<?php if (is_file(dirname(__FILE__) . '/../common/breadcrumbs.tpl')) {
		require_once(dirname(__FILE__) . '/../common/breadcrumbs.tpl'); 
	} else { ?>
	<ul class="breadcrumb box-shadow box-corner">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
	<?php } ?>
	</ul>
	<?php } ?>
	<div class="row">
		<div id="content" class="col-sm-12">
			<div class="chekout-container">
				<h1><?php echo $heading_title; ?></h1>

				<div id="warning-messages"></div>
				<div id="success-messages"></div>

				<div id="quickcheckoutconfirm" class="row">

				<div class="col-sm-8 ">

						<legend id='legend1' class='current'><span>1</span> <?php echo $text_сontact_details; ?> <a id="toggle1" style="display: none"><?php echo $text_edit;?></a></legend>
						<div id="section1" class="collapse in">

							<div id="customer" class="clearfix">
								<?php if (!$logged) { ?>
									<ul class="list-inline text-center col-sm-offset-4">
										<li class="active"><a class="btn btn-primary" href="javascript:void(0);"><?php echo $text_not_have_account; ?></a></li>
										<li><a class="btn btn-default" href="#" id="login"><?php echo $text_login; ?></a></li>
									</ul>
								<?php } ?>

								<div id="payment-address">
									<div class="quickcheckout-content form"></div>
								</div>
								<div class="pull-right">
									<a class="btn btn-primary" id="toggle2"><?php echo $text_next; ?></a>
								</div>
							</div>
						</div>

						<legend id='legend2'><span>2</span> <?php echo $text_delivery_payment_details; ?></legend>
						<div id="section2" class="collapse">

<?php if( $neoseo_checkout_dependency_type == "payment_for_shipping" ) { ?>

<?php if ($shipping_required) { ?>
							<div id="shipping" class="row">
								<h3 class="col-sm-3"><?php echo $text_shipping; ?></h3>
								<div class="col-sm-9 quickcheckout-content form">
									<?php require_once('neoseo_city.tpl'); ?>
									<div id="shipping-method"></div>
								</div>
							</div>
<?php } ?>
							<hr>

							<div id="payment" class="row">
								<h3 class="col-sm-3"><?php echo $text_payment; ?></h3>
								<div class="col-sm-9 quickcheckout-content form">
									<div id="payment-method" class="field"></div>
								</div>
							</div>

<?php } else { // if( $neoseo_checkout_dependency_type == "payment_for_shipping" ) ?>

							<div id="payment">
								<h3><?php echo $text_payment; ?></h3>
								<div class="quickcheckout-content form">
									<div id="payment-method" class="field"></div>
								</div>
							</div>

<?php if ($shipping_required) { ?>

							<div id="shipping">
								<h3><?php echo $text_shipping; ?></h3>
								<div class="quickcheckout-content form">
									<?php require_once('neoseo_city.tpl'); ?>
									<div id="shipping-method"></div>
								</div>
							</div>
<?php } ?>

<?php } ?>
						</div>

				</div>

				<div id="checkout-cart" class="col-sm-4">
					<h3><?php echo $text_cart; ?></h3>
					<div class="quickcheckout-content"></div>
					<div id="confirm" style="display:none" >
						<hr>
						<div id="payment-form" style="display:none"></div>
						<div id="shipping-form" style="display:none"></div>

						<?php if ($text_agree) { ?>
						<div class='checkbox checkbox-primary checkbox-inline'>
							<?php if ($agree) { ?>
								<input id="input-agree" type="checkbox" name="agree" value="1" checked="checked"/>
								<label for="input-agree"><?php echo $text_agree; ?></label>
							<?php } else { ?>
								<input id="input-agree" type="checkbox" name="agree" value="1"/>
								<label for="input-agree"><?php echo $text_agree; ?></label>
							<?php } ?>
						</div>
						<hr>
						<?php } ?>
						<?php if ($agreement_text) { ?>
							<div class="well box-shadow box-corner" style="height: 160px; overflow: auto;"><?php echo html_entity_decode($description_agree); ?></div>
						<?php } ?>

						<div class="text-center">
							<button id="button-payment-method" class="btn btn-primary"><?php echo $button_checkout; ?></button>
						</div>
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

	$('#toggle1').click(function(e){
		e.preventDefault();
		$('#section1').addClass("in");
		$('#section2').removeClass("in");
		$('#legend2').removeClass("current");
		$('#legend1').addClass("current").removeClass('complete');
		$('#toggle1').hide();
		$('#confirm').hide();
	});

	$('#toggle2').click(function(e){
		e.preventDefault();
		validateCustomer(function(){
			$('#section2').addClass("in");
			$('#section1').removeClass("in");
			$('#legend1').removeClass("current").addClass('complete');
			$('#legend2').addClass("current");
			$('#toggle1').show();
			$('#confirm').show();
		});
	});

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

		<?php if ( $neoseo_checkout_shipping_city_select == "cities" ) { ?>
			$('#quickcheckoutconfirm').on('keydown', '#cityselect', debounce(500, function(e) {
				changeCity($("#cityselect").val(),$("#zone_id").val(),$("#country_id").val(), function(){
					reloadCheckout();
				});
			}));
			$('#quickcheckoutconfirm').on('change', '#cityselect', function(e) {
				changeCity($("#cityselect").val(),$("#zone_id").val(),$("#country_id").val(), function(){
					reloadCheckout();
				});
			});
			$("select#zone_id").change( function(){
				changeCity($("#cityselect").val(),$("#zone_id").val(),$("#country_id").val(), function(){
					reloadCheckout();
				});
			});
		<?php } ?>

		$('#button-payment-method').click('click', function() {
			var data = { };
			$('#shipping select, #shipping input[type="hidden"], #shipping input[type="text"], #shipping input[type="radio"]:checked, #shipping input[type="checkbox"]:checked, #shipping textarea').each( function() {
				data[$(this).attr('name')] = $(this).val();
			});
			$.ajax({
				url: 'index.php?route=checkout/neoseo_checkout/save',
				type:'post',
				data: { "data": data },
				success: function() {
					validateOrder();
				}
			});
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

<?php if ($hide_footer) {  ?>
<div class="hidden">
	<?php echo $footer; ?>
</div>
<?php  } else { ?>
<?php echo $footer; ?>
<?php } ?>