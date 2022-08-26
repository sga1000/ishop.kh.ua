<?php foreach($payment_shipping_links['payment_for_shipping'] as $sm => $psl) {  ?>
<div class="master3-pls-block row <?php echo $payment_shipping_links['shipping_methods_list'][$sm]['status'] != 1 ? "disabled-block": ""; ?>">
<div class="master3-pls-inner-left col-sm-2">
    <!-- Название метода доставки -->
    <h5><?php echo $payment_shipping_links['shipping_methods_list'][$sm]['name']; ?></h5>
    <?php echo $payment_shipping_links['shipping_methods_list'][$sm]['status'] != 1 ? ("<span class='disabled_label'>".$text_disabled."</span>"): ""; ?>
</div>
<div class="master3-pls-inner-right col-sm-10">
    <!-- Галочки с методами оплаты -->
    <?php foreach ($psl as $ps_code => $ps_status ) { ?>
    <div class="master3-pls-cb-div col-sm-6">
        <input
            id="ps<?php echo $sm."-".$ps_code; ?>"
            name="<?php echo "links[".$sm."][".$ps_code."]"; ?>"
            value = 1
            type="checkbox"
            class="checkbox-s"
            <?php if ($payment_shipping_links['payment_methods_list'][$ps_code]['status'] != 1 || $payment_shipping_links['shipping_methods_list'][$sm]['status'] != 1) { ?> disabled='disabled' <?php } ?>
            <?php if ($ps_status == 1) { ?> checked='checked' <?php } ?>
        />
        <label
          for="ps<?php echo $sm."-".$ps_code; ?>" "
          id="labelps-<?php echo $sm."-".$ps_code; ?>"
        ><?php echo $payment_shipping_links['payment_methods_list'][$ps_code]['name']; ?> <?php if ($payment_shipping_links['payment_methods_list'][$ps_code]['status'] != 1) { ?> <span class='disabled_label'><?php echo $text_disabled; ?></span><?php } ?></label>
    </div>
    <?php } /* foreach ps */ ?>
</div>
</div>

<?php } /* foreach psl */ ?>