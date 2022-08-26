<?php
$exists = false;
foreach ($payment_methods as $payment_method) {
	if ($payment_method['code'] == $code) {
		$exists = true;
		break;
	}
}
?>


<?php if (!$payment_methods) { ?>

<div class="alert alert-danger"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> <?php echo $error_warning; ?></div>

<?php } else { ?>

<?php if ($neoseo_checkout_payment_control) { ?>

<div id="payment_methods">
    <?php foreach ($payment_methods as $payment_method) { ?>
    <div class="radio radio-primary <?php if( $neoseo_checkout_compact ) { ?>radio-inline<?php } ?>"  <?php if( $neoseo_checkout_compact ) { ?>style="display: inline-block; margin-right: 1em;"<?php } else { ?> style="margin-bottom: 1em;"<?php } ?>>

        <?php if ($payment_method['code'] == $code || !$code || !$exists) { ?>
        <?php $code = $payment_method['code']; ?>
        <?php $exists = true; ?>
        <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
        <?php } else { ?>
        <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
        <?php } ?>

        <label for="<?php echo $payment_method['code']; ?>">
            <?php if ( $neoseo_checkout_payment_logo && isset($payment_method['image']) ) {
                preg_match('/< *img[^>]*src *= *["\']?([^"\']*)/i', $payment_method['image'], $matches);
                if( $matches && isset($matches[1])) {
                    echo '<img style="height:24px" src="' . $matches[1] . '">';
                } else {
                    echo $payment_method['image'];
                }
            } else if ( $neoseo_checkout_payment_logo && file_exists(DIR_APPLICATION . 'view/theme/default/image/payment/' . $payment_method['code'] . '.png')) { ?>
            <img src="<?php echo HTTPS_SERVER . 'catalog/view/theme/default/image/payment/' . $payment_method['code'] . '.png'; ?>" alt="<?php echo $payment_method['title']; ?>" />
            <?php } ?>
            <?php echo $payment_method['title']; ?>
        </label>
    </div>
    <?php } ?>
</div>

<?php } else { ?>
<div class="field">
    <div class="title-label"><?php echo $text_payment_method; ?></div>


    <select name="payment_method" class="large-field">
    <?php foreach ($payment_methods as $payment_method) { ?>
        <?php if ($payment_method['code'] == $code || !$code || !$exists) { ?>
        <?php $code = $payment_method['code']; ?>
        <?php $exists = true; ?>
            <option value="<?php echo $payment_method['code']; ?>" selected="selected">
        <?php } else { ?>
            <option value="<?php echo $payment_method['code']; ?>">
        <?php } ?>
        <?php echo $payment_method['title']; ?></option>
    <?php } ?>
    </select>
</div>
<?php } ?>

<?php } ?>

<div id="payment-method-fields" class="large-field"></div>
<div id="payment-method-info" class="large-field"></div>
<script>
    /*
    $('#payment-method input[name=payment_method]').on('click',function(){
        paymentMethodChangedWrapper();
    });*/
</script>