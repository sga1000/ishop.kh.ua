
<?php if (isset($error_warning) && $error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<?php
$exists = false;
foreach ($shipping_methods as $shipping_method) {
	foreach ($shipping_method['quote'] as $quote) {
		if ($quote['code'] == $code) {
			$exists = true;
			break;
		}
	}
}
?>



<?php if (!$shipping_methods) { ?>

<?php if( !$city ) { ?>
<div class="alert alert-danger"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> <?php echo $error_city; ?></div>
<?php } ?>

<?php } else { ?>

<?php if ($neoseo_checkout_shipping_control) { ?>

<div id="shipping_methods" class="form-group row">
	<div class="col-sm-12">
<?php if( $neoseo_checkout_use_shipping_type ) { ?>
	<div class="field">
		<div class="shipping-tabs-holder">
			<div class="title-label"><?php echo $text_shipping_method; ?></div>
			<div class="shipping-tabs">
				<div class='radio radio-primary radio-inline'>
					<input id="shipping_pickpoint" type="radio" name="neoseo_checkout_shipping_type" checked="checked"/>
					<label for="shipping_pickpoint">Забрать самостоятельно</label>
				</div>
				<div class='radio radio-primary radio-inline'>
					<input id="shipping_address" type="radio" name="neoseo_checkout_shipping_type" />
					<label for="shipping_address">Заказать доставку</label>
				 </div>
			</div>
		</div>
	</div>
<?php } ?>
    <?php foreach ($shipping_methods as $shipping_method) { ?>

    <?php if( $neoseo_checkout_shipping_title ) { ?>
    <div class="shipping-method-title"><b><?php echo $shipping_method['title']; ?></b></div>
    <?php } ?>

    <?php if (!$shipping_method['error']) { ?>
    <?php foreach ($shipping_method['quote'] as $quote) { ?>
    <div style="display: inline-block; margin-right: 15px;" class="type-<?php echo $quote['type']; ?> field" <?php if( $neoseo_checkout_compact ) { ?>style="display: inline-block; margin-right: 1em;"<?php } ?>>
        <div class='radio radio-primary <?php if( $neoseo_checkout_compact ) { ?>radio-inline<?php } ?>'>
<?php if ($quote['code'] == $code || !$code || !$exists) { ?>
<?php $code = $quote['code']; ?>
<?php $exists = true; ?>
        <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
<?php } else { ?>
        <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
<?php } ?>
        <label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?> <?php echo isset($quote['np_html']) ? $quote['text'] : ""; ?></label>
		</div>
<?php if( false && isset($quote['description'])) { ?> <br><small><?php echo $quote['description']; ?></small><?php } ?>
    </div>
<?php } ?>
    <?php if( $neoseo_checkout_use_shipping_type ) { ?><script>
        if( $('#shipping_methods div.type-pickpoint').length > 0 ) {
            $('#shipping_pickpoint').prop('checked', 'checked');
            $('#shipping_methods div.type-address').hide();
        } else {
            $('#shipping_address').prop('checked', 'checked');
            $('#shipping_methods div.type-pickpoint').hide();
        }
    </script><?php } ?>

    <?php } else { ?>

    <div class="error"><?php echo $shipping_method['error']; ?></div>

    <?php } ?>
    <?php } ?>
	</div>
</div>

<?php } else { ?>

<select class="large-field" name="shipping_method" id="shipping_methods">
    <?php foreach ($shipping_methods as $shipping_method) { ?>
    <?php foreach ($shipping_method['quote'] as $quote) { ?>
    <?php if ($quote['code'] == $code || !$code || !$exists) { ?>
    <?php $code = $quote['code']; ?>
    <?php $exists = true; ?>
    <option value="<?php echo $quote['code']; ?>" selected="selected">
        <?php } else { ?>
    <option value="<?php echo $quote['code']; ?>">
        <?php } ?>
        <?php echo $quote['title']; ?>&nbsp;&nbsp;(<?php echo $quote['text']; ?>) </option>
    <?php } ?>
    <?php } ?>
</select>

<?php } ?>

<?php } ?>

<div id="shipping-method-fields" class=""></div>
<div id="shipping-method-info" class="field text-block"></div>
<script>
  
  /*$('#shipping-method input[name=shipping_method]').on('click',function(){
      shippingMethodChangedWrapper();
  });*/
</script>