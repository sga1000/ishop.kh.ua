<div class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="quick_order">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        <i class="glyphicon glyphicon-remove"></i>
                    </button>
                    <h3 class="modal-title"><?php echo $heading_title; ?></h3>
                </div>
                <div class="modal-body">
                    <?php foreach($product as $prod){ ?>
                    <div class="row">
                        <div class="col-sm-6">
                            <img src="<?php echo $prod["image"]; ?>">
                        </div>
                        <div class="col-sm-6">
                            <input type="hidden" name="product_id" value='<?php echo $prod["product_id"]; ?>'>
                            <h4><?php echo $prod["name"]; ?></h4>
                            <h4 style="margin: 20px 0;"><?php echo $text_price; ?>: <?php echo $prod["price"]; ?></h4>


                        </div>
                    </div>
                    <?php } ?>
                    <div class="form-group required">
                        <label class="control-label" for="name"><?php echo $text_name; ?></label>
                        <input type="text" id="name" name="name" class="form-control">
                    </div>

                    <div class="form-group required">
                        <label class="control-label" for="phone"><?php echo $text_phone; ?></label>
                        <input type="tel" id="phone" name="phone" class="form-control">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_continue; ?></button>
                    <a onclick="processQuickOrder()" class="btn btn-primary"><?php echo $button_action; ?></a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
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
            }
        }
    });
</script>