<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if (!isset($license_error)) { ?>
                    <a onclick="save('save');" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-default"><i class="fa fa-save"></i><?php echo $button_save; ?></a>
                    <a onclick="save('save_and_close');" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i><?php echo $button_save_and_close; ?></a>
                <?php }else { ?>
                    <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
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
                    <?php if (!isset($license_error)) { ?>
                        <li class="active"><a href="#tab_import" data-toggle="tab"><?php echo $tab_import; ?></a></li>
                        <li><a href="#tab_export" data-toggle="tab"><?php echo $tab_export; ?></a></li>
                        <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li <?php echo (isset($license_error)) ? 'class="active"' : ''; ?>><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>
                <div class="tab-content">
                    <?php if (!isset($license_error)) { ?>
                        <div class="tab-pane active" id="tab_import">
                            <form action="<?php echo $action_import; ?>" method="post" enctype="multipart/form-data" id="form-import" class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="button-example"><?php echo $entry_example; ?></label>
                                    <div class="col-sm-10">
                                        <a onclick="smb();" data-toggle="tooltip" id="button-example" title="<?php echo $button_example; ?>" class="btn btn-primary"><i class="fa fa-spinner" aria-hidden="true"></i> <?php echo $button_example; ?></a>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="button-upload"><?php echo $entry_upload_file; ?></label>
                                    <div class="col-sm-10">
                                        <input type="file" name="upload" id="button-upload" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-import_action"><?php echo $entry_import_action; ?></label>
                                    <div class="col-sm-10">
                                        <select id="input-import-action" name="import_action" class="form-control">
                                            <?php foreach ($import_action_list as $key => $action) { ?>
                                                <option value="<?php echo $key; ?>" <?php echo($neoseo_simple_excel_exchange_import_action == $key) ? 'selected="selected"' : ''; ?>><?php echo $action; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="button-import"></label>
                                    <div class="col-sm-10">
                                        <a onclick="$('#button-import').html('<i class=\'fa fa-spinner fa-spin\'></i>');$('#form-import').submit()" id="button-import" data-toggle="tooltip" title="<?php echo $button_import; ?>" class="btn btn-primary"><i class="fa fa-spinner" aria-hidden="true"></i> <?php echo $button_import; ?></a>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane" id="tab_export">
                            <form action="<?php echo $action_export; ?>" method="post" enctype="multipart/form-data" id="form-export" class="form-horizontal">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="button-export"><?php echo $entry_export; ?></label>
                                    <div class="col-sm-10">
                                        <a onclick="$('#form-export').submit()" data-toggle="tooltip" title="<?php echo $button_export; ?>" class="btn btn-primary"><i class="fa fa-spinner" aria-hidden="true"></i> <?php echo $button_export; ?></a>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane" id="tab-logs">
                            <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                                <?php $widgets->debug_and_logs('debug', array(0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log); ?>
                                <textarea class="form-control" style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
                            </form>
                        </div>
                    <?php } ?>
                    <div class="tab-pane" id="tab-support">
                        <?php echo $mail_support; ?>
                    </div>
                    <div class="tab-pane" id="tab-license">
                        <?php echo $module_licence; ?>
                    </div>
                </div>
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

    function save(action) {
        $('#form').append('<input type="hidden" name="action" value="' + action + '" />');
        $('#form').append('<input type="hidden" name="neoseo_simple_excel_exchange_import_action" value="' + $('#input-import-action').val() + '" />');
        $('#form').submit();
        $('#form input[name=\'action\']').remove();
    }

    function smb() {
        $('#form-export').append('<input type="hidden" name="example" value="1" />');
        $('#form-export').submit();
        $('#form-export input[name=\'example\']').remove();
    }
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

<?php echo $footer; ?>