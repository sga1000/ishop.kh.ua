<div class="modal modal--quick fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="quick_order">
                <div class="modal-header">
                    <h3 class="modal-title"><i class="fa fa-shopping-cart" aria-hidden="true"></i><?php echo $heading_title; ?></h3>
                    <button type="button" class="modal-close-button close" data-dismiss="modal">
                        <span></span>
                        <span></span>
                    </button>
                </div>
                <div class="modal-body">
                    <?php if(count($product) != 1){ ?>
                    <div class="quick__box">
                        <?php foreach($product as $prod){ ?>
                            <div class="quick__item">
                            <div class="quick__item-info">
                                <img src="<?php echo $prod["image"]; ?>">
                                <input type="hidden" name="product_id[]" value='<?php echo $prod["product_id"]; ?>'>
                                <h4><?php echo $prod["name"]; ?></h4>
                            </div>
                            <div class="quick__item-price">
                                <?php if (!$prod["special"]) { ?>
                                <h4 style="margin: 20px 0;"><?php echo $text_price; ?>: <?php echo $prod["price"]; ?></h4>
                                <?php } else { ?>
                                <h4 style="margin: 20px 0;" ><?php echo $text_price; ?>:<span class="old-price" style="text-decoration: line-through;color:gray;font-size: 0.7em;"><?php echo $prod["price"]; ?></span><span class="price"><?php echo $prod["special"]; ?></span> </h4>
                                <?php } ?>
                            </div>
                        </div>
                        <?php } ?>
                    </div>
                    <div class="form-group required">
                        <label class="control-label" for="name"><?php echo $text_name; ?></label>
                        <input type="text" id="name" name="name" class="form-control">
                    </div>

                    <div class="form-group required">
                        <label class="control-label" for="phone"><?php echo $text_phone; ?></label>
                        <input type="text" id="phone" name="phone" class="form-control">
                    </div>
                    <?php if ($text_agree) { ?>
                        <div class='checkbox checkbox-primary checkbox-inline' id="check-agree">
                            <?php if ($agree) { ?>
                                <input class='checkbox' id="input-agree" type="checkbox" checked="checked" name="agree" value="1" />
                                <label for="input-agree"><?php echo $text_agree; ?></label>
                            <?php } else { ?>
                                <input id="input-agree" type="checkbox" name="agree" value="1"/>
                                <label for="input-agree"><?php echo $text_agree; ?></label>
                            <?php } ?>
                        </div>
                    <?php } ?>
                    <?php }else{ ?>
                    <?php foreach($product as $prod){ ?>
                    <div class="row">
                        <div class="col-sm-6">
                            <img src="<?php echo $prod["image"]; ?>">
                        </div>
                        <div class="col-sm-6">
                            <input type="hidden" name="product_id" value='<?php echo $prod["product_id"]; ?>'>
                            <h4><?php echo $prod["name"]; ?></h4>
                            <?php if (!$prod["special"]) { ?>
                            <h4 style="margin: 20px 0;"><?php echo $text_price; ?>: <?php echo $prod["price"]; ?></h4>
                            <?php } else { ?>
                            <h4 class="quickprice-wrap" style="margin: 20px 0;" ><?php echo $text_price; ?>:<span><span class="old-price" ><?php echo $prod["price"]; ?></span><span class="price"><?php echo $prod["special"]; ?></span></span> </h4>                            <?php } ?>
                            <div class="form-group required">
                                <label class="control-label" for="name"><?php echo $text_name; ?></label>
                                <input type="text" id="name" name="name" class="form-control">
                            </div>

                            <div class="form-group required">
                                <label class="control-label" for="phone"><?php echo $text_phone; ?></label>
                                <input type="text" id="phone" name="phone" class="form-control">
                            </div>
                            <?php if ($text_agree) { ?>
                                <div class='checkbox checkbox-primary checkbox-inline' id="check-agree">
                                    <?php if ($agree) { ?>
                                        <input class='checkbox' id="input-agree" type="checkbox" checked="checked" name="agree" value="1" />
                                        <label for="input-agree"><?php echo $text_agree; ?></label>
                                    <?php } else { ?>
                                        <input id="input-agree" type="checkbox" name="agree" value="1"/>
                                        <label for="input-agree"><?php echo $text_agree; ?></label>
                                    <?php } ?>
                                </div>
                            <?php } ?>
                        </div>
                    </div>
                    <?php } ?>

                    <?php } ?>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-long-arrow-left" aria-hidden="true"></i><?php echo $button_continue; ?></button>
                    <a onclick="processQuickOrder()" class="btn btn-primary"><?php echo $button_action; ?></a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>

    $('.popup-order-button').on('click', function () {
        setTimeout(function () {
            var a = $('#check-agree').children('span#agree-error');
            $(a).appendTo('#popup-quick_order #check-agree');
        },1000);
    });

    $.validator.setDefaults({
        highlight: function (element) {
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight: function (element) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function (error, element) {
            if (element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });
    $("#quick_order").validate({
        rules: {
            name: {
                required: true,
                minlength: 2
            },
            phone: {
                required: true,
                minlength: 5
            },
            agree: {
                required: true,
            }
        }
    });
    <?php if ( $neoseo_quick_order_phonemask ) { ?>$("#phone").mask("<?php echo $neoseo_quick_order_phonemask; ?>");<?php } ?>
</script>