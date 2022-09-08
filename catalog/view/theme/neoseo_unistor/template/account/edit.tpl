<?php echo $header; ?>
<div class="container">
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <div class="personal-area-container">
                <h1><?php echo $heading_title; ?></h1>
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
                    <fieldset>
                        <div class="form-group required">
                            <label class="col-sm-2 control-label" for="input-lastname"><?php echo $entry_lastname; ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="form-control"/>
                                <?php if ($error_lastname) { ?>
                                <div class="text-danger"><?php echo $error_lastname; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="form-group required">
                            <label class="col-sm-2 control-label" for="input-firstname"><?php echo $entry_firstname; ?> </label>
                            <div class="col-sm-10">
                                <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="form-control"/>
                                <?php if ($error_firstname) { ?>
                                <div class="text-danger"><?php echo $error_firstname; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="form-group required">
                            <label class="col-sm-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
                            <div class="col-sm-10">
                                <input type="tel" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control"/>
                                <?php if ($error_telephone) { ?>
                                <div class="text-danger"><?php echo $error_telephone; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="form-group required">
                            <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
                            <div class="col-sm-10">
                                <input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control"/>
                                <?php if ($error_email) { ?>
                                <div class="text-danger"><?php echo $error_email; ?></div>
                                <?php } ?>
                            </div>
                        </div>
                    </fieldset>
                    <div class="buttons text-right clearfix">
                        <div class="submit">
                            <input type="submit" value="<?php echo $button_update; ?>" class="btn btn-primary"/>
                        </div>
                    </div>
                </form>
            </div>
            <?php echo $content_bottom; ?>
        </div>
        <?php echo $column_right; ?>
    </div>
</div>
<script><!--
    // Sort the custom fields
    $('.form-group[data-sort]').detach().each(function () {
        if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('.form-group').length) {
            $('.form-group').eq($(this).attr('data-sort')).before(this);
        }

        if ($(this).attr('data-sort') > $('.form-group').length) {
            $('.form-group:last').after(this);
        }

        if ($(this).attr('data-sort') < -$('.form-group').length) {
            $('.form-group:first').before(this);
        }
    });
    //--></script>
<script><!--
    $('button[id^=\'button-custom-field\']').on('click', function () {
        var node = this;

        $('#form-upload').remove();

        $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

        $('#form-upload input[name=\'file\']').trigger('click');

        if (typeof timer != 'undefined') {
            clearInterval(timer);
        }

        timer = setInterval(function () {
            if ($('#form-upload input[name=\'file\']').val() != '') {
                clearInterval(timer);

                $.ajax({
                    url: 'index.php?route=tool/upload',
                    type: 'post',
                    dataType: 'json',
                    data: new FormData($('#form-upload')[0]),
                    cache: false,
                    contentType: false,
                    processData: false,
                    beforeSend: function () {
                        $(node).button('loading');
                    },
                    complete: function () {
                        $(node).button('reset');
                    },
                    success: function (json) {
                        $(node).parent().find('.text-danger').remove();

                        if (json['error']) {
                            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
                        }

                        if (json['success']) {
                            alert(json['success']);

                            $(node).parent().find('input').attr('value', json['code']);
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        }, 500);
    });
    //--></script>
<script><!--
    $('.date').datetimepicker({
        pickTime: false
    });

    $('.datetime').datetimepicker({
        pickDate: true,
        pickTime: true
    });

    $('.time').datetimepicker({
        pickDate: false
    });
    //--></script>
<?php echo $footer; ?>