<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="text-right">
                <?php if( !isset($license_error) ) { ?>
                <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                <?php } ?>
                <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
            </div>
            <br/>
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
                    <li><a href="#tab-subscribe" data-toggle="tab"><?php echo $tab_subscribe; ?></a></li>
                    <li><a href="#tab-unsubscribe" data-toggle="tab"><?php echo $tab_unsubscribe; ?></a></li>
                    <li><a href="#tab-notify" data-toggle="tab"><?php echo $tab_notify; ?></a></li>
                    <li><a href="#tab-fields" data-toggle="tab"><?php echo $tab_fields; ?></a></li>
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

                            <?php $widgets->input('admin_subscribe_notify'); ?>
                            <?php $widgets->input('image_width'); ?>
                            <?php $widgets->input('image_height'); ?>
                            <?php $widgets->text('cron'); ?>
                            <?php $widgets->checklist('stock_statuses',$stock_statuses); ?>
                            <?php $widgets->textarea('script'); ?>

                            <?php } else { ?>

                            <?php echo $license_error; ?>

                            <?php } ?>

                        </div>

                        <?php if( !isset($license_error) ) { ?>

                        <div class="tab-pane" id="tab-subscribe">

                            <?php $widgets->localeTextarea('subscribe_text',$full_languages); ?>

                            <?php $widgets->localeInput('subscribe_subject',$full_languages); ?>
                            <?php $widgets->localeTextarea('subscribe_message',$full_languages); ?>

                            <?php $widgets->input('admin_subscribe_notify_subject'); ?>
                            <?php $widgets->textarea('admin_subscribe_notify_message'); ?>
                        </div>

                        <div class="tab-pane" id="tab-unsubscribe">
                            <?php $widgets->localeTextarea('unsubscribe_text',$full_languages); ?>

                            <?php $widgets->localeInput('unsubscribe_subject',$full_languages); ?>
                            <?php $widgets->localeTextarea('unsubscribe_message',$full_languages); ?>

                            <?php $widgets->input('admin_unsubscribe_notify_subject'); ?>
                            <?php $widgets->textarea('admin_unsubscribe_notify_message'); ?>
                        </div>

                        <div class="tab-pane" id="tab-notify">
                            <?php $widgets->localeInput('subscribe_subject_mail',$full_languages); ?>
                            <?php $widgets->localeTextarea('subscribe_message_mail',$full_languages); ?>
                        </div>

                        <div class="tab-pane" id="tab-fields">
                            <table class="table table-bordered table-hover" id="items-table" width="90%">
                                <thead>
                                    <tr>
                                        <td width="200px" class="left"><?php echo $entry_field_list_name; ?></td>
                                        <td><?php echo $entry_field_list_desc; ?></td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach( $fields as $field_name => $field_desc ) { ?>
                                    <tr>
                                        <td class="left">{<?php echo $field_name ?>}</td>
                                        <td><?php echo $field_desc ?></td>
                                    </tr>
                                    <?php } ?>
                                </tbody>
                            </table>
                        </div>
                        <?php } ?>

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

<?php foreach ($full_languages as $language) { ?>
<?php if ($ckeditor) { ?>
    ckeditorInit('neoseo_notify_when_available_subscribe_text<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
    ckeditorInit('neoseo_notify_when_available_subscribe_message<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
    ckeditorInit('neoseo_notify_when_available_unsubscribe_text<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
    ckeditorInit('neoseo_notify_when_available_unsubscribe_message<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
    ckeditorInit('neoseo_notify_when_available_subscribe_message_mail<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
<?php } else { ?>
    $("#neoseo_notify_when_available_subscribe_text<?php echo $language['language_id']?>").summernote({height: 300, lang:'ru-RU'});
    $("#neoseo_notify_when_available_subscribe_message<?php echo $language['language_id']?>").summernote({height: 300, lang:'ru-RU'});
    $("#neoseo_notify_when_available_unsubscribe_text<?php echo $language['language_id']?>").summernote({height: 300, lang:'ru-RU'});
    $("#neoseo_notify_when_available_unsubscribe_message<?php echo $language['language_id']?>").summernote({height: 300, lang:'ru-RU'});
    $("#neoseo_notify_when_available_subscribe_message_mail<?php echo $language['language_id']?>").summernote({height: 300, lang:'ru-RU'});
<?php } ?>
<?php } ?>
<?php if ($ckeditor) { ?>
    ckeditorInit('neoseo_notify_when_available_admin_subscribe_notify_message', '<?php echo $token; ?>');
    ckeditorInit('neoseo_notify_when_available_admin_unsubscribe_notify_message', '<?php echo $token; ?>');
<?php } else { ?>
    $('#neoseo_notify_when_available_admin_subscribe_notify_message').summernote({height: 300, lang:'ru-RU'});
    $('#neoseo_notify_when_available_admin_unsubscribe_notify_message').summernote({height: 300, lang:'ru-RU'});
<?php } ?>
//--></script>
<?php echo $footer; ?>