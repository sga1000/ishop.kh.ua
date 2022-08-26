<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new SoforpWidgets('neoseo_subscribe_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

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
            <img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/neoseo.png" alt=""> 
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
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li><?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">

                            <?php if( !isset($license_error) ) { ?>

                            <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('show_name',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->localeTextarea('title', $languages); ?>
                            <?php $widgets->localeTextarea('message', $languages); ?>
                            <?php $widgets->localeTextarea('message_error', $languages); ?>
                            <?php $widgets->input('notify_list', $languages); ?>
                            <?php $widgets->input('notify_subject'); ?>
                            <?php $widgets->textarea('notify_message'); ?>

                            <?php } else { ?>

                            <?php echo $license_error; ?>

                            <?php } ?>

                        </div>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_and_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log ); ?>
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
<?php foreach ($languages as $language) { ?>
<?php if ($ckeditor) { ?>
    ckeditorInit('neoseo_subscribe_title<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
    ckeditorInit('neoseo_subscribe_message<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
    ckeditorInit('neoseo_subscribe_message_error<?php echo $language['language_id']; ?>', '<?php echo $token; ?>');
<?php } else { ?>
    $('#neoseo_subscribe_title<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'ru-RU'});
    $('#neoseo_subscribe_message<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'ru-RU'});
    $('#neoseo_subscribe_message_error<?php echo $language['language_id']; ?>').summernote({height: 300, lang:'ru-RU'});
<?php } ?>
<?php } ?>
<?php if ($ckeditor) { ?>
    ckeditorInit('neoseo_subscribe_notify_message', '<?php echo $token; ?>');
<?php } else { ?>
    $('#neoseo_subscribe_notify_message').summernote({height: 300, lang:'ru-RU'});
<?php } ?>
//--></script>
<?php echo $footer; ?>