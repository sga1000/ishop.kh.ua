<div class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="notifyPriceChange">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="glyphicon glyphicon-remove"></i></button>
                    <h3 class="modal-title"><?php echo $heading_title; ?></h3>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <img src="<?php echo $product["image"]; ?>">
                        </div>
                        <div class="col-sm-6">
                            <input type="hidden" name="product_id" value='<?php echo $product["product_id"]; ?>'>
                            <h4><?php echo $product["name"]; ?></h4>
                            <h4 style="margin: 20px 0;"><?php echo $text_price; ?>: <?php echo $product["price"]; ?></h4>

                            <div class="form-group required">
                                <label class="control-label" for="name"><?php echo $text_name; ?></label>
                                <input type="text" id="name" name="name" class="form-control" value="<?php echo $name; ?>">
                            </div>
                               <div class="form-group required">
                                <label class="control-label" for="email"><?php echo $text_email; ?></label>
                                <input type="text" id="email" name="email" class="form-control" value="<?php echo $email; ?>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_continue; ?></button>
                    <a onclick="processNotifyPriceChange()" class="btn btn-primary"><?php echo $button_action; ?></a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $.validator.setDefaults({
        highlight: function(element) {
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight: function(element) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        errorElement: 'span',
        errorClass: 'help-block',
        errorPlacement: function(error, element) {
            if(element.parent('.input-group').length) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        }
    });
    $("#notifyPriceChange").validate({
        rules: {
            name: {
                required: true,
                minlength: 2
            },
            email: {
                required: true,
                minlength: 5
            }
        }
    });
</script>