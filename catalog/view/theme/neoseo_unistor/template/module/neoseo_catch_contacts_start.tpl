<div id="consultation" class="block_consultation" <?php echo 'style="background: url('.$background.') no-repeat; background-size:100%;"'?>>
     <div class='row' id="catchContacts-<?php echo $module_id?>">

     <form id="catch_contacts-<?php echo $module_id?>" onsubmit="return false">

        <?php if($position_form == 'position_top') { ?>
        <div class="col-md-12  zpos-top">
        <div class="row form-grey">

            <div class='col-md-12 form_subscribe'>
            <?php if($text_title_form) { ?>
            <div class="row title_form"><?php echo $text_title_form; ?></div>
            <?php } ?>
            <div class='row'>
                <div class="col-md-4 col-sm-4">
                <input type="text"  name="name" value="<?php echo $name ? $name : '' ?>" class="form-control" placeholder="<?php echo $text_name; ?>">
                </div>
                <div class="col-md-4 col-sm-4">
                <input type="text"  name="phone" id='catch_phone-<?php echo $module_id?>' value="<?php echo $phone ? $phone : '' ?>" class="form-control" placeholder="<?php echo $text_phone; ?>">
                </div>
                <div class="col-md-4 col-sm-4">
                <input type="text"  name="email" value="<?php echo $email ? $email : '' ?>" class="form-control" placeholder="<?php echo $text_email; ?>">
                </div>
            </div>
            <div class='row'>
                <div class="col-md-12">
                <input type="hidden"  name="module" value="<?php echo $module_id?>">
                <a onclick="processConsultation('<?php echo $module_id?>');" class="btn btn-primary"><?php echo $button_action; ?></a>
                </div>
            </div>
            </div>

        </div> </div>
        <?php if($text_title) { ?>
        <div class="col-md-12">
        <div class="title_block"><?php echo $text_title; ?></div>
        </div>
        <?php } ?>

        <?php } ?>

        <?php if($position_form == 'position_bottom') { ?>

        <?php if($text_title) { ?>
        <div class="col-md-12 zpos-bottom">
        <div class="title_block"><?php echo $text_title; ?></div>
        </div>
        <?php } ?>
        <div class="col-md-12">
        <div class="row form-grey">

            <div class='col-md-12 form_subscribe'>
            <?php if($text_title_form) { ?>
            <div class="row title_form"><?php echo $text_title_form; ?></div>
            <?php } ?>
            <div class='row'>
                <div class="col-md-4 col-sm-4">
                <input type="text"  name="name" value="<?php echo $name ? $name : '' ?>" class="form-control" placeholder="<?php echo $text_name; ?>">
                </div>
                <div class="col-md-4 col-sm-4">
                <input type="text"  name="phone" id='catch_phone-<?php echo $module_id?>' value="<?php echo $phone ? $phone : '' ?>" class="form-control" placeholder="<?php echo $text_phone; ?>">
                </div>
                <div class="col-md-4 col-sm-4">
                <input type="text"  name="email" value="<?php echo $email ? $email : '' ?>" class="form-control" placeholder="<?php echo $text_email; ?>">
                </div>
            </div>
            <div class='row'>
                <div class="col-md-12">
                <input type="hidden"  name="module" value="<?php echo $module_id?>">
                <input type="submit" onclick="processConsultation('<?php echo $module_id?>')" value="<?php echo $button_action; ?>" class="btn btn-warning">
                </div>
            </div>
            </div>

        </div>
        </div>
        <?php } ?>

        <?php if($position_form == 'position_right') { ?>
        <div class="col-md-12  zpos-left">
        <div class="col-md-6">
            <?php if($text_title) { ?>
            <div class="title_block"><?php echo $text_title; ?></div>
            <?php } ?>
        </div>
        <div class="col-md-6">
            <div class="row form-grey">

            <div class='col-md-12 form_subscribe'>
                <?php if($text_title_form) { ?>
                <div class="row title_form"><?php echo $text_title_form; ?></div>
                <?php } ?>
                <div class='row'>
                <div class="col-md-12">
                    <input type="text"  name="name" value="<?php echo $name ? $name : '' ?>" class="form-control" placeholder="<?php echo $text_name; ?>">
                </div>
                <div class="col-md-12">
                    <input type="text"  name="phone" id='catch_phone-<?php echo $module_id?>' value="<?php echo $phone ? $phone : '' ?>" class="form-control" placeholder="<?php echo $text_phone; ?>">
                </div>
                <div class="col-md-12">
                    <input type="text"  name="email" value="<?php echo $email ? $email : '' ?>" class="form-control" placeholder="<?php echo $text_email; ?>">
                </div>
                </div>
                <div class='row'>
                <div class="col-md-12">
                    <input type="hidden"  name="module" value="<?php echo $module_id?>">
                    <input type="submit" onclick="processConsultation('<?php echo $module_id?>')" value="<?php echo $button_action; ?>" class="btn btn-warning">
                </div>
                </div>
            </div>

            </div>
        </div>
        </div>
        <?php } ?>

        <?php if($position_form == 'position_left') { ?>
        <div class="col-md-12  zpos-right">
        <div class="col-md-6">
            <div class="row form-grey">

            <div class='col-md-12 form_subscribe'>
                <?php if($text_title_form) { ?>
                <div class="row title_form"><?php echo $text_title_form; ?></div>
                <?php } ?>
                <div class='row'>
                <div class="col-md-12">
                    <input type="text"  name="name" value="<?php echo $name ? $name : '' ?>" class="form-control" placeholder="<?php echo $text_name; ?>">
                </div>
                <div class="col-md-12">
                    <input type="text"  name="phone" id='catch_phone-<?php echo $module_id?>' value="<?php echo $phone ? $phone : '' ?>" class="form-control" placeholder="<?php echo $text_phone; ?>">
                </div>
                <div class="col-md-12">
                    <input type="text" name="email" value="<?php echo $email ? $email : '' ?>" class="form-control" placeholder="<?php echo $text_email; ?>">
                </div>
                </div>
                <div class='row'>
                <div class="col-md-12">
                    <input type="hidden"  name="module" value="<?php echo $module_id?>">
                    <input type="submit" onclick="processConsultation('<?php echo $module_id?>')" value="<?php echo $button_action; ?>" class="btn btn-warning">
                </div>
                </div>
            </div>
            </div>
        </div>
        <div class="col-md-6">
            <?php if($text_title) { ?>
            <div class="title_block"><?php echo $text_title; ?></div>
            <?php } ?>

        </div>
        </div>
        <?php } ?>
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
    $("#catch_contacts-<?php echo $module_id?>").validate({
    rules: {
        name: {
        required: true,
            minlength: 2
        },
        phone: {
        required: true,
            minlength: 5
        },
        email: {
        required: true,
        email: true
        }
    }
    });
    <?php if ($phone_mask) { ?> $("#catch_phone-<?php echo $module_id?>").mask("<?php echo $phone_mask; ?>"); <?php } ?>
</script>