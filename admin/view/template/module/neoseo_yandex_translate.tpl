<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-default" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
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
            <div class="panel-heading">
                <h3 class="panel-title "><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>

            <div class="panel-body">

                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <li ><a href="#tab-product" data-toggle="tab"><?php echo $tab_product; ?></a></li>
                    <li ><a href="#tab-blog-articles" data-toggle="tab"><?php echo $tab_blog_articles; ?></a></li>
                    <li ><a href="#tab-blog-categories" data-toggle="tab"><?php echo $tab_blog_categories; ?></a></li>
                    <li ><a href="#tab-blog-authors" data-toggle="tab"><?php echo $tab_blog_authors; ?></a></li>
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li><?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <?php if( !isset($license_error) ) { ?>

                            <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <div class="form-group" id="field_api_key" style="display: inline-block; width: 100%;">
                                <div class="col-sm-5">
                                    <label class="control-label" for="neoseo_yandex_translate_api_key"><?php echo $entry_api_key; ?></label>
                                    <br>
                                </div>
                                <div class="col-sm-7">
                                    <div class="input-group">
                                        <input name="neoseo_yandex_translate_api_key" id="neoseo_yandex_translate_api_key" class="form-control" value="<?php echo $neoseo_yandex_translate_api_key ? $neoseo_yandex_translate_api_key : '';?>">
                                        <span class="input-group-btn">
                                            <button class="btn btn-primary" type="button" id="check_api"><?php echo $button_check_api ?></button>
                                        </span>
                                    </div>
                                    <div id="result_check"></div>
                                </div>
                            </div>

                            <?php $widgets->input('proxy'); ?>
                            <?php $widgets->textarea('code_list'); ?>

                            <?php } else { ?>

                            <div><?php echo $license_error; ?></div>

                            <?php } ?>
                        </div>

                        <div class="tab-pane" id="tab-product">
                            <?php if( !isset($license_error) ) { ?>
                            <?php $widgets->checklist('params', $translate_content); ?>
                            <?php $widgets->dropdown('translate_source',array( 0 => $text_current_tab, 1 => $text_language_tab)); ?>
                            <?php $widgets->dropdown('from_language', $languages); ?>

                            <?php } else { ?>

                            <div><?php echo $license_error; ?></div>

                            <?php } ?>
                        </div>
                        <div class="tab-pane" id="tab-blog-articles">
                            <?php if( !isset($license_error) ) { ?>

                            <?php $widgets->checklist('params_blog_articles', $translate_content_blog_articles); ?>
                            <?php $widgets->dropdown('translate_source_blog_articles',array( 0 => $text_current_tab, 1 => $text_language_tab)); ?>
                            <?php $widgets->dropdown('from_language_blog_articles', $languages); ?>

                            <?php } else { ?>

                            <div><?php echo $license_error; ?></div>

                            <?php } ?>
                        </div>

                        <div class="tab-pane" id="tab-blog-categories">
                            <?php if( !isset($license_error) ) { ?>

                            <?php $widgets->checklist('params_blog_categories', $translate_content_blog_categories); ?>
                            <?php $widgets->dropdown('translate_source_blog_categories',array( 0 => $text_current_tab, 1 => $text_language_tab)); ?>
                            <?php $widgets->dropdown('from_language_blog_categories', $languages); ?>

                            <?php } else { ?>

                            <div><?php echo $license_error; ?></div>

                            <?php } ?>
                        </div>

                        <div class="tab-pane" id="tab-blog-authors">
                            <?php if( !isset($license_error) ) { ?>

                            <?php $widgets->checklist('params_blog_authors', $translate_content_blog_authors); ?>
                            <?php $widgets->dropdown('translate_source_blog_authors',array( 0 => $text_current_tab, 1 => $text_language_tab)); ?>
                            <?php $widgets->dropdown('from_language_blog_authors', $languages); ?>

                            <?php } else { ?>

                            <div><?php echo $license_error; ?></div>

                            <?php } ?>
                        </div>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
                            <textarea style="width: 98%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
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
    if( window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length ) {
        $(".panel-body > .nav-tabs li").removeClass("active");
        $("[href=" + window.location.hash + "]").parents('li').addClass("active");
        $(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
        $(window.location.hash).addClass("active");
    }
    $(".nav-tabs li a").click(function(){
        var url = $(this).prop('href');
        window.location.hash = url.substring(url.indexOf('#'));
    });
    // Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash
    // и по итогу этот hash становится частью token
    function getURLVar(key) {
        var value = [];

        var url = String(document.location);
        if (url.indexOf('#') != -1) {
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
    //--></script>
<script type="text/javascript">//<!--
    $('#check_api').click(function(){
        var api_key = $('[name=neoseo_yandex_translate_api_key]').val();

        if(api_key){
            $.ajax({
                url: 'index.php?route=tool/neoseo_yandex_translate/checkApiKey&token=<?php echo $token; ?>&api_key=' + api_key,
                dataType: 'json',
                success: function(json) {
                    if (json['success']) {
                        var message = json['success'];
                        $('#result_check').removeClass('text-danger').addClass('text-success').text(message);
                    } else {
                        if (json['error']) {
                            message = json['error'];
                            $('#result_check').removeClass('text-success').addClass('text-danger').text(message);
                        }
                    }
                }
            })
        }else{
            $('#result_check').removeClass('text-success').addClass('text-danger').text('<?php echo $error_empty_api_key?>');
        }
    })
    //--></script>
<?php echo $footer; ?>