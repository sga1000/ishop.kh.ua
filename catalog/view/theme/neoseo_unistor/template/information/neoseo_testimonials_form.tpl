<?php echo $header; ?>
<div class="container">
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?> neoseo_testimonial_content testimonial_form"><?php echo $content_top; ?>
            <div class="testimonial-users-container box-shadow box-corner">
            <h1><?php echo $heading_title; ?></h1>
            <?php if(isset($error)){ ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error; ?></div>
            <?php } ?>
            <div class="content"><p><?php echo $text_conditions ?></p></div>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="testimonial"
                  class="form-horizontal <?php echo $captcha ? 'with-captcha' : ''; ?>">

                <div class="form-group required">
                    <label class="col-sm-12 col-md-3 control-label" for="input-name"><?php echo $entry_name ?></label>

                    <div class="col-sm-12 col-md-9">
                        <input type="text" name="name" value="<?php echo $name; ?>"
                               placeholder="<?php echo $entry_name ?>" id="input-name" class="form-control">
                    </div>
                </div>

                <div class="form-group required">
                    <label class="col-sm-12 col-md-3 control-label"
                           for="input-description"><?php echo $entry_enquiry ?></label>

                    <div class="col-sm-12 col-md-9">
                        <textarea name="description" id="description" rows="6" placeholder="<?php echo $description; ?>"
                                  class="form-control"><?php echo $description; ?></textarea>
                    </div>
                </div>

                <div class="form-group required">
                    <label class="col-sm-12 col-md-3 control-label" for="input-rating"><?php echo $entry_rating ?></label>

                    <div class="col-sm-9 rating-fl">
                        <label class="control-label zrate-label"><?php echo $entry_rating; ?></label>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="star-rating">
                                    <span class="fa fa-star-o" data-rating="1"></span>
                                    <span class="fa fa-star-o" data-rating="2"></span>
                                    <span class="fa fa-star-o" data-rating="3"></span>
                                    <span class="fa fa-star-o" data-rating="4"></span>
                                    <span class="fa fa-star-o" data-rating="5"></span>
                                    <input type="hidden" name="rating" class="rating-value" value="3">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <?php if($need_youtube) { ?>

                <div class="form-group">
                    <label class="col-sm-12 col-md-3 control-label" for="input-name"><?php echo $entry_yt ?></label>

                    <div class="col-sm-12 col-md-9">
                        <input type="text" name="youtube" value="<?php echo $yt_link; ?>"
                               placeholder="<?php echo $entry_yt_desc ?>" id="input-name" class="form-control">
                    </div>
                </div>
                <?php } ?>

                <?php if($need_user_image) { ?>

                <div class="form-group">
                    <label class="col-sm-12 col-md-3 control-label"><?php echo $entry_user_image ?></label>
                    <div class="col-sm-12 col-md-9">
                        <button type="button" id="button-upload" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                        <input type="hidden" name="user_image" value="" id="user-image" />
                    </div>

                </div>

                <?php } ?>

                <div class="form-group">
                    <label class="col-sm-12 col-md-3 control-label" for="input-captcha"></label>

                    <div class="col-sm-12 col-md-9">
                        <?php echo $captcha; ?>
                    </div>
                </div>

                <div class="buttons">
                    <div class="pull-right">
                        <a onclick="$('#testimonial').submit();" class="btn btn-post"><?php echo $text_write; ?></a>
                    </div>
                </div>
            </form>
            </div>

        </div>
    </div>
        <?php echo $content_bottom; ?>
        <?php echo $column_right; ?>
    </div>
</div>
<script >
    var $star_rating = $('.star-rating .fa');

    var SetRatingStar = function() {
        return $star_rating.each(function() {
            if (parseInt($star_rating.siblings('input.rating-value').val()) >= parseInt($(this).data('rating'))) {
                return $(this).removeClass('fa-star-o ').addClass('fa-star');
            } else {
                return $(this).removeClass('fa-star').addClass('fa-star-o');
            }
        });
    };

    $star_rating.hover(function() {
        $star_rating.siblings('input.rating-value').val($(this).data('rating'));
        return SetRatingStar();
    });

    SetRatingStar();
    $(document).ready(function() {

    });
</script>
<script>
    // STARs
    $('.z_stars span').mouseenter(function (e) {
        var n = $(this).index();
        $(this).siblings('span').each(function (index, element) {
            if ($(this).index() < n) $(this).addClass('active');
            else $(this).removeClass('active');
        });
    });
    $('.z_stars span').mouseleave(function (e) {
        var n = $(this).index();
        var p = $(this).parent('.z_stars');
        var s = p.data('value');
        if (s) {
            if (n == s - 1) {
                $(this).addClass('active');
            }
            else {
                p.find('span').each(function (index, element) {
                    if ($(this).index() < s) $(this).addClass('active');
                    else $(this).removeClass('active');
                });
            }
        } else {
            $(this).siblings('span').each(function (index, element) {
                $(this).removeClass('active');
            });
        }
    });
    $('.z_stars span').click(function (e) {
        var i = $(this).index();
        $(this).parent('.z_stars').data('value', i + 1);
        $(this).parent('.z_stars').find('input.inp-rating').val(i + 1);
        $(this).addClass('active');
    });
    $('.z_stars').mouseleave(function (e) {
        var s = $(this).data('value');
        if (s) {
            $(this).find('span').each(function (index, element) {
                if ($(this).index() < s) $(this).addClass('active');
            });
        }
    });
    $('.z_stars').data('value', 4);
    $('.z_stars .inp-rating').val(4);
    $('.z_stars span:lt(4)').addClass('active');

    $('button[id^=\'button-upload\']').on('click', function() {
        var node = this;

        $('#form-upload').remove();

        $('body').prepend('<form enctype="multipart/form-data" id="form-upload"   style="display: none;"><input type="file" accept="image/x-png,image/gif,image/jpeg" name="file" onchange="validateFileType()" /></form>');

        $('#form-upload input[name=\'file\']').trigger('click');

        if (typeof timer != 'undefined') {
            clearInterval(timer);
        }

        timer = setInterval(function() {
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
                    beforeSend: function() {
                        $(node).button('loading');
                    },
                    complete: function() {
                        $(node).button('reset');
                    },
                    success: function(json) {
                        $('.text-danger').remove();

                        if (json['error']) {
                            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
                        }

                        if (json['success']) {
                            alert(json['success']);

                            $(node).parent().find('input').attr('value', json['code']);
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        }, 500);
    });

    function validateFileType(){
        var fileName = document.getElementById("fileName").value;
        var idxDot = fileName.lastIndexOf(".") + 1;
        var extFile = fileName.substr(idxDot, fileName.length).toLowerCase();
        if (extFile=="jpg" || extFile=="jpeg" || extFile=="png"){
            //TO DO
        }else{
            alert("Only jpg/jpeg and png files are allowed!");
        }
    }
</script>
<?php echo $footer; ?>