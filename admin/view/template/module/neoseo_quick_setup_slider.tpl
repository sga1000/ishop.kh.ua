<?php echo $header; ?>

<div id="content">
    <div class="settings-master active-help">
        <div class="settings-master__nav">
            <div class="settings-master__nav-item current">
                <a href="<?php echo $neoseo_m1_link; ?>" >
                    <?php echo $neoseo_m1_title; ?>
                </a>
            </div>
            <div class="settings-master__nav-item">
                <a href="<?php echo $neoseo_m2_link; ?>" >
                    <?php echo $neoseo_m2_title; ?>
                </a>
            </div>
            <div class="settings-master__nav-item">
                <a href="<?php echo $neoseo_m3_link; ?>" >
                    <?php echo $neoseo_m3_title; ?>
                </a>
            </div>
            <div class="settings-master__nav-item">
                <a href="<?php echo $neoseo_m4_link; ?>" >
                    <?php echo $neoseo_m4_title; ?>
                </a>
            </div>
        </div>
        <div class="settings-master__content">
            <div class="page-header">
                <div class="container-fluid">
                    <ul class="breadcrumbs-tabs">
                        <li class="current"><span><span class="hidden-xs"><?php echo $text_step; ?></span> 1</span></li>
                        <li><span><span class="hidden-xs"><?php echo $text_step; ?></span>  2</span></li>
                        <li><span><span class="hidden-xs"><?php echo $text_step; ?></span>  3</span></li>
                        <li><span><span class="hidden-xs"><?php echo $text_step; ?></span>  4</span></li>
                        <li><span><span class="hidden-xs"><?php echo $text_step; ?></span>  5</span></li>
                        <li class="breadcrumbs-tabs__tooltip"><span>Пройдите все шаги, чтобы закончить настройку мастера</span><i onclick="$('.settings-master').removeClass('active-help')" class="fa fa-close"></i></li>
                    </ul>
                    <h2><?php echo $heading_h2_title; ?></h2>
                </div>
            </div>
            <div class="container-fluid">

            <?php if ($error_warning) { ?>
            <div class="alert alert-danger">
                <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
    
            <?php if (isset($success) && $success) { ?>
            <div class="alert alert-success">
                <i class="fa fa-check-circle"></i>
                <?php echo $success; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
    
            <div class="panel panel-default">
                <div class="panel-body">
                    <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="qs_form">
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab-params">
                                <?php if( !isset($license_error) ) { ?>
                                <div id="step0" <?php if($start_page == 1) { ?>style="display: none;"<?php } ?>>

                                <?php $widgets->checkList('need_languages',$languages_c); ?>
                                <?php $widgets->checkList('need_currencies',$currencies); ?>
                                <button type="button" class="btn btn-success pull-right" onclick="validateStep0()"><?php echo $text_next; ?></button>
                            </div>
                            <div id="step1" <?php if($start_page == 0) { ?>style="display: none;"<?php } ?>>

                            <?php $widgets->localeInput('config_name',$languages ); ?>
                            <?php $widgets->localeInput('config_owner',$languages ); ?>
                            <?php $widgets->localeTextarea('config_address' ,$languages); ?>
                            <?php $widgets->input('config_email' ); ?>
                            <?php $widgets->input('neoseo_unistor_phone1'); ?>
                            <?php $widgets->input('neoseo_unistor_phone2' ); ?>
                            <?php $widgets->input('neoseo_unistor_phone3' ); ?>
                            <?php $widgets->localeTextarea('config_open' ,$languages); ?>
                            <button type="button" class="btn btn-success pull-right" onclick="step(1,2)"><?php echo $text_next; ?></button>
                        </div>
                        <div id="step2" style="display: none;">

                            <!-- Logo begin -->
                            <div class="form-group" id="field_neoseo_quick_setup_neoseo_unistor_logo" style="display: inline-block; width: 100%;">
                                <div class="col-sm-5">
                                    <label class="control-label" for="neoseo_quick_setup_neoseo_unistor_logo"><?php echo $entry_logo; ?></label>
                                    <br><?php echo $entry_logo_desc; ?>
                                </div>
                                <div class="col-sm-7">
                                    <ul class="nav nav-tabs">
                                        <?php foreach ($languages as $language) { ?>
                                        <li class="<?php echo $language['language_id']==1? 'active': '';?>"><a href="#column-neoseo_quick_setup_neoseo_unistor_logo<?php echo $language['language_id']; ?>" data-toggle="tab">
                                                <?php echo mb_strtoupper($language['code']); ?>
                                                <?php echo $language['name'];?>
                                            </a>
                                        </li>
                                        <?php } ?>
                                    </ul>
                                    <div class="tab-content">
                                        <?php foreach ($languages as $language) { ?>
                                        <div class="tab-pane <?php echo $language['language_id']==1? 'active': '';?>" id="column-neoseo_quick_setup_neoseo_unistor_logo<?php echo $language['language_id']; ?>">
                                            <a href="" id="thumb-image-logo-<?php echo $language['language_id']?>" data-toggle="image" class="img-thumbnail">
                                                <img src="<?php echo $neoseo_quick_setup_neoseo_unistor_logo_img[$language['language_id']]; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                                            </a>
                                            <input type="hidden" name="neoseo_quick_setup_neoseo_unistor_logo[<?php echo $language['language_id'];?>]" value="<?php echo $neoseo_quick_setup_neoseo_unistor_logo[$language['language_id']]; ?>" id="input-image-logo-<?php echo $language['language_id']?>" />
                                        </div>
                                        <?php } ?>
                                    </div>
                                </div>
                            </div>
                            <!-- Logo end -->
                            <!-- Favicon begin -->
                            <div class="form-group">
                                <div class="col-sm-5">
                                    <label class="control-label" for="input-icon"><?php echo $entry_config_icon; ?></label>
                                    <br><?php echo $entry_config_icon_desc; ?>
                                </div>
                                <div class="col-sm-7"><a href="" id="thumb-icon" data-toggle="image" class="img-thumbnail" data-original-title="" title=""><img src="<?php echo $neoseo_quick_setup_config_icon_img; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>"></a>
                                    <input type="hidden" name="config_icon" value="<?php echo $neoseo_quick_setup_config_icon; ?>" id="input-icon">
                                </div>
                            </div>
                            <!-- Favicon END -->
                            <?php $widgets->dropdown('config_language',$languages_c); ?>
                            <?php $widgets->dropdown('config_admin_language',$languages_c); ?>
                            <?php $widgets->dropdown('config_country_id',$countries); ?>
                            <?php $widgets->dropdown('config_zone_id',$zones); ?>
                            <?php $widgets->dropdown('config_currency',$currencies); ?>
                            <?php $widgets->dropdown('neoseo_unistor_scheme_style',$schemes); ?>

                            <?php $widgets->dropdown('neoseo_unistor_use_wide_style',array( 0 => $text_shop_is_regular, 1 => $text_shop_is_wide)); ?>
    
                            <button type="button" class="btn btn-warning" onclick="step(2,1)"><?php echo $text_prev; ?></button>
                            <button type="button" class="btn btn-success pull-right" onclick="step(2,3)"><?php echo $text_next; ?></button>
                        </div>
    
                        <div id="step3" style="display: none;">

                            <?php $widgets->localeTextarea('neoseo_unistor_delivery',$languages); ?>
                            <?php $widgets->localeTextarea('neoseo_unistor_payment',$languages); ?>
                            <?php $widgets->localeTextarea('neoseo_unistor_guarantee',$languages); ?>
    
                            <button type="button" class="btn btn-warning" onclick="step(3,2)"><?php echo $text_prev; ?></button>
                            <button type="button" class="btn btn-success pull-right" onclick="step(3,4)"><?php echo $text_next; ?></button>
                        </div>
                        <div id="step4" style="display: none;">

                            <?php $widgets->dropdown('neoseo_unistor_menu_main_type',$menu_types); ?>
                            <?php $widgets->dropdown('neoseo_unistor_contact_map',$maps); ?>
                            <?php $widgets->input('neoseo_unistor_contact_google_api_key' ); ?>
                            <?php $widgets->input('neoseo_unistor_contact_latitude'); ?>
                            <?php $widgets->input('neoseo_unistor_contact_longitude'); ?>
                            <?php $widgets->localeInput('neoseo_google_analytics_code',$languages ); ?>
                            <?php $widgets->localeInput('neoseo_jivosite_code',$languages ); ?>
                            <div class="form-group" id="field_neoseo_quick_setup_big_banners" style="display: inline-block; width: 100%;">
                                <div class="col-sm-5">
                                    <label class="control-label" for="field_neoseo_quick_setup_big_banners"><?php echo $entry_big_slides; ?></label>
                                    <br><?php echo $entry_big_slides_desc; ?>
                                </div>
                                <div class="col-sm-7" >
                                    <div id="big_banners">
                                        <?php $image_row_b = 0;
                                            foreach ($big_slides as $bb ) { ?>
                                        <div class="input-group pull-left" >
                                            <a href="" id="thumb-image_b<?php echo $image_row_b; ?>" data-toggle="image" class="img-thumbnail">
                                                <img src="<?php echo $bb['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                                            </a>
                                            <input type="hidden" name="big_banner[<?php echo $image_row_b; ?>][image]" value="<?php echo (isset($bb['image']) ? $bb['image'] : ''); ?>" id="input-image_b<?php echo $image_row_b; ?>" />
                                        </div>
                                        <?php $image_row_b ++ ; ?>
                                        <?php } ?>
                                    </div>
                                    <button type="button" onclick="bigBannerAdd()" class="btn btn-primary" style="margin-top: 33px;margin-left: 10px;"><i class="fa fa-plus-circle"></i></button>
                                </div>
                            </div>
                            <?php /*
                                    <div class="form-group" id="field_neoseo_quick_setup_small_banners" style="display: inline-block; width: 100%;">
                            <div class="col-sm-5">
                                <label class="control-label" for="field_neoseo_quick_setup_small_banners"><?php echo $entry_small_slides; ?></label>
                                <br><?php echo $entry_small_slides_desc; ?>
                            </div>
                            <div class="col-sm-7">
                                <div id="small_banners">
                                    <?php $image_row_s = 0;
                                            foreach ($small_slides as $bb ) { ?>
                                    <div class="input-group pull-left">
                                        <a href="" id="thumb-image_s<?php echo $image_row_s; ?>" data-toggle="image" class="img-thumbnail">
                                            <img src="<?php echo $bb['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                                        </a>
                                        <input type="hidden" name="small_banner[<?php echo $image_row_s; ?>][image]" value="<?php echo (isset($bb['image']) ? $bb['image'] : ''); ?>" id="input-image_s<?php echo $image_row_s; ?>" />
                                    </div>
                                    <?php $image_row_s ++ ; ?>
                                    <?php } ?>
                                </div>
                                <button type="button" onclick="smallBannerAdd()" class="btn btn-primary" style="margin-top: 33px;margin-left: 10px;"><i class="fa fa-plus-circle"></i></button>
                            </div>
                        </div>
                        */ ?>
                        <button type="button" class="btn btn-warning" onclick="step(4,3)"><?php echo $text_prev; ?></button>
                        <input type="hidden" name="master1" value="1">
                        <button type="submit" name="action" value="complete" form="qs_form" title="<?php echo $button_save; ?>" class="btn btn-primary  pull-right"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                    </form>
                </div>
    
                <?php } else { ?>
                <?php echo $license_error; ?>
                <?php } ?>
            </div>
            </div>
        </div>
    </div>





</div>

</div>

</div>
</div>
<div class="showImageGallery">
    <div onclick="hideImage()" class="showImageGallery__Close">
        <i class="fa fa-times"></i>
    </div>
    <div class="showImageGallery__Content">
        <img onclick="hideImage()" src="" alt="">
    </div>
</div>

<script><!--

    function showImage(object) {
        $('body').addClass('showImageActive');
        $('.showImageGallery').show();
        $('.showImageGallery__Content img').attr('src',$(object).attr('data-image'));
    }

    function hideImage() {
        $('body').removeClass('showImageActive');
        $('.showImageGallery').hide();
    }

    function step(from,to)
    {
        if (to > from) {
            $('.breadcrumbs-tabs li.current').eq(-1).toggleClass('complete').next().addClass('current');
        } else {
            $('.breadcrumbs-tabs li.complete').eq(-1).removeClass('complete').addClass('current');
            $('.breadcrumbs-tabs li.current').eq(-1).removeClass('current');
        }
        $('#step'+from).slideToggle();
        $('#step'+to).slideToggle();
        $("body,html").animate({ scrollTop:0 }, 500);
        partial_save();
    }

    function partial_save()
    {
        $.ajax({
            type: "POST",
            url: '<?php echo html_entity_decode($save); ?>&quick_save=1',
            data: $('#form').serialize(),
        });
    }

    function validateStep0()
    {
        if($('#field_need_languages').find('input[type=checkbox]:not(:checked)').length > 0 || $('#field_need_currencies').find('input[type=checkbox]:not(:checked)').length > 0){
            if($('#field_need_languages').find('input[type=checkbox]:checked').length == 0 || $('#field_need_currencies').find('input[type=checkbox]:checked').length == 0){
                alert('<?php echo $error_all_empty; ?>');
                return;
            }
            if(!confirm('<?php echo $text_confirm_cleanup_lc; ?>')) {
                return;
            }
            var nl_lang = [];
            var nl_cur = [];
            $('#field_need_languages').find('input[type=checkbox]:not(:checked)').each(function(){
                nl_lang.push($(this).val());
            });
            $('#field_need_currencies').find('input[type=checkbox]:not(:checked)').each(function(){
                nl_cur.push($(this).val());
            });

            $.ajax({
                url: '<?php echo $ml_update_link; ?>',
                type: "POST",
                data: {'nl_lang':nl_lang,'nl_cur':nl_cur},
                success: function (data){
                    //alert(data);
                    location.reload();
                },
            });
        } else {
            step(0,1);
        }
    }

    if (window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length) {
        $(".panel-body > .nav-tabs li").removeClass("active");
        $("[href=" + window.location.hash + "]").parents('li').addClass("active");
        $(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
        $(window.location.hash).addClass("active");
    }
    $(".nav-tabs li a").click(function () {
        var url = $(this).prop('href');
        window.location.hash = url.substring(url.indexOf('#'));
    });

    // Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash
    // и по итогу этот hash становится частью token
    function getURLVar(key) {
        var value = [];

        var url = String(document.location);
        if( url.indexOf('#') != -1 ) {
            url = url.substring(0, url.indexOf('#'));
        }
        var query = url.split('?');

        if (query[1]) {
            var part = query[1].split('&');

            for (i = 0; i < part.length; i++) {
                var data = part[i].split('=');

                if (data[0] && data[1]) {
                    value[data[0]] = data[1];
                }
            }

            if (value[key]) {
                return value[key];
            } else {
                return '';
            }
        }
    }

    image_row_s = <?php echo isset($image_row_s)?$image_row_s:0; ?>;
    image_row_b = <?php echo $image_row_b; ?>;
    function bigBannerAdd() {
        html = '<div class="input-group pull-left"><a href="" id="thumb-image_b'+image_row_b +'" data-toggle="image" class="img-thumbnail">\n' +
            '<img src="<?php echo $no_image; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />\n' +
            '</a>\n' +
            '<input type="hidden" name="big_banner[' + image_row_b + '][image]" value="" id="input-image_b'+image_row_b+'" /></div>\n' ;
        $('#big_banners').append(html);
        image_row_b = image_row_b +1;
    }

    function smallBannerAdd() {
        html = '<div class="input-group pull-left"><a href="" id="thumb-image_s'+image_row_s +'" data-toggle="image" class="img-thumbnail">\n' +
            '<img src="<?php echo $no_image; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />\n' +
            '</a>\n' +
            '<input type="hidden" name="small_banner[' + image_row_s + '][image]" value="" id="input-image_s'+image_row_s+'" /></div>\n' ;
        $('#small_banners').append(html);
        image_row_s = image_row_s +1;
    }
    //--></script>
<script>
    <?php foreach ($languages as $language) { ?>
    <?php if ($ckeditor) { ?>
            ckeditorInit('neoseo_quick_setup_neoseo_unistor_delivery<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
            ckeditorInit('neoseo_quick_setup_neoseo_unistor_payment<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
            ckeditorInit('neoseo_quick_setup_neoseo_unistor_guarantee<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
        <?php } else { ?>
            $('#neoseo_quick_setup_neoseo_unistor_delivery<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'ru-RU'});
            $('#neoseo_quick_setup_neoseo_unistor_payment<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'ru-RU'});
            $('#neoseo_quick_setup_neoseo_unistor_guarantee<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'ru-RU'});
        <?php } ?>
    <?php } ?>

    $('select[name=\'neoseo_quick_setup_config_country_id\']').trigger('change');
    $('select[name=\'neoseo_quick_setup_config_country_id\']').on('change', function() {
        $.ajax({
            url: 'index.php?route=localisation/country/country&token=<?php echo $token; ?>&country_id=' + this.value,
            dataType: 'json',
            beforeSend: function() {
                $('select[name=\'neoseo_quick_setup_config_country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
            },
            complete: function() {
                $('.fa-spin').remove();
            },
            success: function(json) {
                html = '<option value=""><?php echo $text_select; ?></option>';

                if (json['zone'] && json['zone'] != '') {
                    for (i = 0; i < json['zone'].length; i++) {
                        html += '<option value="' + json['zone'][i]['zone_id'] + '"';

                        if (json['zone'][i]['zone_id'] == '<?php echo $config_zone_id; ?>') {
                            html += ' selected="selected"';
                        }

                        html += '>' + json['zone'][i]['name'] + '</option>';
                    }
                } else {
                    html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
                }

                $('select[name=\'neoseo_quick_setup_config_zone_id\']').html(html);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    $(document).ready(function() {
        $('.j-tooltip').each(function () {
            jQuery("<img>").attr("src", $($(this).attr('title')).attr('src'));
            console.log($($(this).attr('title')).attr('src'));
        })
        $('.j-tooltip').tooltipster({
            contentAsHTML: true,
            side: 'right',
            delay: 500,
            trackOrigin:true,
            trackTooltip:true,
        });
    });
</script>
<style>
    .tooltip-image {
        max-width: 700px;
        min-width: 400px;
        /*min-height: 300px;
        max-height: 700px;*/
    }/*
    .tooltip-inner {
        max-width: 550px;
        min-width: 550px;
        width: 550px;
    }*/
    .j-tooltip {
        cursor: help;
        border-bottom: 1px dashed #0000FF;
        color: #0000FF;
    }
    .tooltip_templates{
        display: none;
    }

</style>
<?php echo $footer; ?>