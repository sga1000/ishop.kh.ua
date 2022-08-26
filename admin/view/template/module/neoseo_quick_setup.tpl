<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">

    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                <?php } ?>
                <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
            </div>

            <img width="36" height="36" style="float:left" src="view/image/logo.png" alt=""/>
            <h1><?php echo $heading_title_raw . " " . $text_module_version; ?></h1>

            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>

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

                <ul class="nav nav-tabs">

                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <li class=""><a href="#tab-params" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <?php if( !isset($license_error) ) { ?>
                    <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>

                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">

                            <?php if( !isset($license_error) ) { ?>

                            <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>

                            <?php } else { ?>

                            <?php echo $license_error; ?>

                            <?php } ?>

                        </div>
                        <div class="tab-pane" id="tab-params">
                            <?php if( !isset($license_error) ) { ?>
                            <div class="form-group" id="field_neoseo_quick_setup_neoseo_unistor_logo" style="display: inline-block; width: 100%;">
                                <div class="col-sm-5">
                                    <label class="control-label" for="neoseo_quick_setup_neoseo_unistor_logo"><?php echo $entry_logo; ?></label>
                                </div>
                                <div class="col-sm-7">
                                    <ul class="nav nav-tabs">
                                        <?php foreach ($languages as $language) { ?>
                                        <li class="<?php echo $language['language_id']==1? 'active': '';?>"><a href="#column-neoseo_quick_setup_neoseo_unistor_logo<?php echo $language['language_id']; ?>" data-toggle="tab">
                                                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>">
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
                            <div class="form-group">
                                <div class="col-sm-5">
                                    <label class="control-label" for="input-icon"><?php echo $entry_config_icon; ?></label>
                                    <br><?php echo $entry_config_icon_desc; ?>
                                </div>
                                <div class="col-sm-7"><a href="" id="thumb-icon" data-toggle="image" class="img-thumbnail" data-original-title="" title=""><img src="<?php echo $neoseo_quick_setup_config_icon_img; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>"></a>
                                    <input type="hidden" name="config_icon" value="<?php echo $neoseo_quick_setup_config_icon; ?>" id="input-icon">
                                </div>
                            </div>
                            <?php
                            $widgets->localeInput('config_name',$languages );
                            $widgets->localeInput('config_owner',$languages );
                            $widgets->input('config_email' );
                            $widgets->dropdown('config_language',$languages_c);
                            $widgets->dropdown('config_currency',$currencies);
                            $widgets->input('neoseo_unistor_phone1');
                            $widgets->input('neoseo_unistor_phone2' );
                            $widgets->input('neoseo_unistor_phone3' );
                            $widgets->dropdown('neoseo_unistor_scheme_style',$schemes);
                            //$widgets->localeInput('neoseo_unistor_work_time',$languages);
                            $widgets->localeTextarea('config_meta_title',$languages );
                            $widgets->localeTextarea('config_meta_description',$languages );
                            $widgets->localeTextarea('config_meta_keyword' ,$languages);
                            $widgets->localeTextarea('config_address' ,$languages);
                            $widgets->localeTextarea('config_open' ,$languages);
                            $widgets->dropdown('config_country_id',$countries);
                            $widgets->dropdown('config_zone_id',$zones);
                            $widgets->dropdown('neoseo_unistor_contact_map',$maps);
                            $widgets->input('neoseo_unistor_contact_google_api_key' );
                            $widgets->input('neoseo_unistor_contact_latitude');
                            $widgets->input('neoseo_unistor_contact_longitude');
                            $widgets->dropdown('neoseo_unistor_menu_main_type',$menu_types);
                            $widgets->dropdown('neoseo_unistor_general_style',$general_styles);
                            $widgets->dropdown('neoseo_unistor_use_wide_style',array( 0 => $text_disabled, 1 => $text_enabled));
                            $widgets->localeTextarea('neoseo_unistor_delivery',$languages);
                            $widgets->localeTextarea('neoseo_unistor_payment',$languages);
                            $widgets->localeTextarea('neoseo_unistor_guarantee',$languages);

                            ?>
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
                            <?php } else { ?>
                            <?php echo $license_error; ?>
                            <?php } ?>
                        </div>
                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
                            <textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
                        </div>
                        <?php } ?>

                        <div class="tab-pane" id="tab-support">
                            <?php echo $mail_support; ?>
                        </div>

                        <div class="tab-pane" id="tab-license">
                            <?php echo $module_licence; ?>
                        </div>

                    </div>

                </form>

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
</script>
<?php echo $footer; ?>