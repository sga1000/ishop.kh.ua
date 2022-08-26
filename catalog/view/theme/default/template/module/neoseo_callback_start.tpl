<div class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="callback">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="glyphicon glyphicon-remove"></i></button>
                    <h3 class="modal-title"><?php echo $heading_title; ?></h3>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6 text-center">
                            <img style="width:70%" src="/image/neoseo_callback.jpg">
                        </div>
                        <div class="col-sm-6">
                            <h4><?php echo $text_prompt; ?></h4>
                            <div class="form-group required">
                                <label class="control-label" for="name"><?php echo $text_name; ?></label>
                                <input type="text" id="name" name="name" class="form-control">
                            </div>
                            <div class="form-group required">
                                <label class="control-label" for="phone"><?php echo $text_phone; ?></label>
                                <input type="tel" id="phone" name="phone" class="form-control">
                            </div>
                            <div class="form-group">
                                <label class="control-label" for="message"><?php echo $text_message; ?></label>
                                <textarea id="message" name="message" class="form-control"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><?php echo $button_continue; ?></button>
                    <a onclick="processCallback()" class="btn btn-primary"><?php echo $button_action; ?></a>
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
    $("#callback").validate({
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
    <?php if ( $mask ) { ?>$("#phone").mask("<?php echo $mask; ?>");<?php } ?>
</script>