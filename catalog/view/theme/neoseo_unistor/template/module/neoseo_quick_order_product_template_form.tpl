<?php if($neoseo_quick_order_status == 1){ ?>
<div class="product-quick-input" id="quick_order_block_cart">
    <div class="form-group">
        <div class="input-group">
            <input type="text" id="input-phone-cart" placeholder="<?php echo $text_quick_order; ?>" class="form-control">
            <span class="input-group-btn">
                                                <button id="button-quick-order-cart" type="button" class="btn btn-default" onclick="doQuickOrder();">
                                                    <i class="fa fa-shopping-cart"></i>
                                                    <span><?php echo $button_quick_order ?></span>
                                                </button>
                                            </span>
        </div>
        <div class="help-block-cart" style="display:none;font-weight:bold;"><?php echo $text_no_phone; ?></div>
        <style>
            .has-error #button-quick-order {
                border-bottom: 1px solid #a94442;
                border-top: 1px solid #a94442;
                border-right: 1px solid #a94442;
            }
        </style>
        <script>
            function doQuickOrder(){
                var phone = $('#input-phone-cart').val();
                if( !phone ) {
                    $("#quick_order_block_cart .help-block-cart").show();
                    $("#quick_order_block_cart").addClass("has-error");
                    $('#input-phone-cart-cart').height($('#button-quick-order-cart').height()+3);
                    return;
                }
                $("#quick_order_block_cart .help-block-cart").hide();
                $("#quick_order_block_cart").removeClass("has-error");
                $('#input-phone-cart-cart').height($('#button-quick-order-cart').height()+1);

                var quantity = $('input[name="quantity"]').val();
                addQuickOrder('<?php echo $product_id ?>', quantity, phone);
            }
            <?php if($quick_order_phone_mask) { ?>
                $("#input-phone-cart").mask("<?php echo $quick_order_phone_mask; ?>");
            <?php } ?>
        </script>
    </div>
</div>
<?php } ?>