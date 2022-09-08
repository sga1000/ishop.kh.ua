<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoseoWidgets('neoseo_optimizer_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

<div id="content">

    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>'); $('#form').submit();" class="btn btn-primary"><i class="fa fa-save"></i>&nbsp;<?php echo $button_save_and_close; ?></a>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>" class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                <?php } ?>
                <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
            </div>
            <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
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
                    <?php if( !isset($license_error) ) { ?>
                    <li><a href="#tab-images" data-toggle="tab"><?php echo $tab_images; ?></a></li>
                    <li><a href="#tab-js-scripts" data-toggle="tab"><?php echo $tab_js_scripts; ?></a></li>
                    <li><a href="#tab-css-scripts" data-toggle="tab"><?php echo $tab_css_scripts; ?></a></li>
                    <li><a href="#tab-html" data-toggle="tab"><?php echo $tab_html; ?></a></li>
                    <li><a href="#tab-layout" data-toggle="tab"><?php echo $tab_cache_layout; ?></a></li>
                    <li><a href="#tab-profiler" data-toggle="tab"><?php echo $tab_profiler; ?></a></li>
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
                            <?php $widgets->dropdown('page_to_cache',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->input('expire_cache'); ?>
                            <?php $widgets->textarea('cache_url_limit'); ?>
                            <?php $widgets->text('sync_link'); ?>
                            <?php $widgets->text('cron'); ?>
                            <?php $widgets->text('cron_cpanel'); ?>
                            <div class="form-group" style="display: inline-block; width: 100%;">
                                <div class="col-sm-12">
                                    <a class="btn btn-default" id="clear_page_cache"><?php echo $button_clear_page_cache ?></a>
                                </div>
                            </div>
                            <div class="form-group" style="display: inline-block; width: 100%;">
                                <div class="col-sm-12">
                                    <a class="btn btn-default" id="clear_page_cache_expire"><?php echo $button_clear_page_cache_expire ?></a>
                                </div>
                            </div>
                            <?php } else { ?>

                            <?php echo $license_error; ?>

                            <?php } ?>

                        </div>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-images">
                            <?php $widgets->textarea('image_dir_list'); ?>
                            <?php $widgets->input('compress_level'); ?>
                            <?php $widgets->dropdown('jpg_driver',array( 0 => $text_jpegoptim, 1 => $text_mozjpeg)); ?>
                            <?php $widgets->dropdown('png_driver',array( 0 => $text_pngout, 1 => $text_optipng)); ?>
                            <?php $widgets->dropdown('png_compress',array(
                            0 => 0,
                            1 => 1,
                            2 => 2,
                            3 => 3,
                            4 => 4,
                            5 => 5,
                            6 => 6,
                            7 => 7,
                            )); ?>
                            <?php $widgets->dropdown('png_to_webp',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('webp_converter',array( 0 => $text_imagick, 1 => $text_gd)); ?>
                            <?php $widgets->dropdown('img_lazy_load',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->textarea('img_unlazy_load'); ?>
                            <?php $widgets->input('img_lazy_src'); ?>
                        </div>
                        <div class="tab-pane" id="tab-js-scripts">
                            <?php $widgets->dropdown('minify_js',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->input('js_tag'); ?>
                            <?php $widgets->textarea('js_untag_list'); ?>
                            <?php $widgets->dropdown('js_defer',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->textarea('js_undefer'); ?>
                            <?php $widgets->textarea('js_defer_page_list'); ?>
                            <?php $widgets->textarea('js_async_list'); ?>
                            <?php $widgets->textarea('js_unpack_list'); ?>
                            <?php $widgets->textarea('js_footer_list'); ?>
                        </div>
                        <div class="tab-pane" id="tab-css-scripts">
                            <?php $widgets->dropdown('minify_css',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->input('css_tag'); ?>
                            <?php $widgets->textarea('css_untag_list'); ?>
                            <?php $widgets->textarea('css_unpack_list'); ?>
                            <?php $widgets->textarea('css_footer_list'); ?>
                        </div>
                        <div class="tab-pane" id="tab-html">
                            <?php $widgets->dropdown('minify_html',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                        </div>

                        <div class="tab-pane" id="tab-layout">
                            <?php $widgets->dropdown('use_layout_cache',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->textarea('cache_exclude_modules'); ?>
                            <?php $widgets->textarea('cache_need_path'); ?>
                        </div>

                        <div class="tab-pane" id="tab-profiler">
                            <?php $widgets->debug_download_logs('profile',array( 0 => $text_disabled, 1 => $text_enabled), $clear_profiler, $download_profiler, $button_clear_log, $button_download_log); ?>
                            <textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $profiler; ?></textarea>
                        </div>
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
<script type="text/javascript"><!--
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

    $('#clear_page_cache').click(function(e){
        e.preventDefault();
        $.ajax({
            'type': "POST",
            'url': "<?php echo htmlspecialchars_decode($clear_page_cache); ?>",
            'data': {
                which: "all"
            },
            'dataType': 'json',
            success: function (response) {
                alert(response.message);
            }
        });
    });

    $('#clear_page_cache_expire').click(function(e){
        e.preventDefault();
        $.ajax({
            'type': "POST",
            'url': "<?php echo htmlspecialchars_decode($clear_page_cache); ?>",
            'data': {
                which: "expired"
            },
            'dataType': 'json',
            success: function (response) {
                alert(response.message);
            }
        });
    });

    //--></script>
<?php echo $footer; ?>