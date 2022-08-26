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
                    <?php if (!isset($license_error)) { ?>
                        <li><a href="#tab_templates" data-toggle="tab"><?php echo $tab_templates; ?></a></li>
                        <li><a href="#tab_cron" data-toggle="tab"><?php echo $tab_cron; ?></a></li>
                        <li><a href="#tab-fields" data-toggle="tab"><?php echo $tab_fields; ?></a></li>
                        <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <?php if (!isset($license_error)) { ?>
                                <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                <?php $widgets->input('recipients'); ?>
                                <?php $widgets->dropdown('status_zero_shipping_cost',array( 0 => $text_disabled, 1 => $text_enabled, 2 => $text_shipping_description)); ?>
                            <?php } else { ?>
                                <?php echo $license_error; ?>
                            <?php } ?>
                        </div>

                        <?php if (!isset($license_error)) { ?>
                            <div class="tab-pane" id="tab_templates">
                                <table class="table table-striped table-hover" id="items-table">
                                    <thead>

                                    <th><?php echo $column_status_name; ?></th>
                                    <th><?php echo $column_status; ?></th>
                                    <th><?php echo $column_template_subject; ?></th>
                                    <th><?php echo $column_template_filename; ?></th>

                                    </thead>
                                    <tbody>
                                    <?php foreach($neoseo_email_notify_templates as $id => $template_data) {
                                    if ($id < 0 )
                                    continue;
                                    ?>
                                    <tr>
                                        <td class="col-xs-2"><?php echo "{$id}. " . $template_data["name"]  ?></td>
                                        <td class="col-xs-2">
                                            <?php foreach ($languages as $language) { ?>
                                            <?php $widgets->dropdownLite('templates',array( 0 => $text_disabled, 1 => $text_enabled, 2 => $text_force), array( 0 => $id, 1 => $language['language_id'], 2 => 'status')); ?>
                                            <?php } ?>
                                            <?php $widgets->dropdownLite('templates',array( 0 => $text_disabled, 1 => $text_enabled, 2 => $text_force), array( 0 => $id, 1 => 0, 2 => 'status')); ?>
                                        </td>
                                        <td class="col-xs-6">
                                            <?php $widgets->localeInputLite('templates',$languages, array( 0 => $id, 1 => 'subject')); ?>
                                            <?php $widgets->inputLite('templates', array( 0 => $id, 1 => 0, 2 => 'subject')); ?>
                                        </td>
                                        <td class="col-xs-2">
                                            <?php foreach ($languages as $language) { ?>
                                            <?php $widgets->dropdownLiteTemplate('templates',$email_templates, array( 0 => $id, 1 => $language['language_id'], 2 => 'filename')); ?>
                                            <?php } ?>
                                            <?php $widgets->dropdownLiteTemplate('templates',$email_templates, array( 0 => $id, 1 => 0, 2 => 'filename')); ?>
                                        </td>
                                    </tr>
                                    <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php } ?>

                        <?php if (!isset($license_error)) { ?>
                        <div class="tab-pane" id="tab_cron">
                            <?php $widgets->text('cron'); ?>
                            <table id="notify-cron" class="table table-striped table-hover">
                                <thead>
                                <th><?php echo $column_status_name; ?></th>
                                <th><?php echo $column_cron_days; ?></th>
                                <th><?php echo $column_status_cron; ?></th>
                                <th><?php echo $column_template_subject; ?></th>
                                <th><?php echo $column_template_filename; ?></th>
                                <td></td>
                                </thead>
                                <tbody>
                                <?php $cron_row = 0; ?>
                                <?php if($cron_templates){ ?>
                                <?php foreach ($cron_templates as $template_data) { ?>
                                <tr id="cron-row<?php echo $cron_row; ?>">
                                    <td  class="col-xs-2">
                                        <select class="form-control" name="neoseo_email_notify_cron_templates[<?php echo $cron_row; ?>][order_status_id]">
                                            <?php foreach ($order_statuses as $order_status) { ?>
                                            <option value="<?php echo $order_status['order_status_id']; ?>" <?php if ($order_status['order_status_id'] == $template_data['order_status_id']) { ?> selected="selected" <?php } ?> ><?php echo $order_status['name'];?></option>
                                            <?php } ?>
                                        </select>
                                    </td>
                                    <td class="col-xs-2">
                                        <input name="neoseo_email_notify_cron_templates[<?php echo $cron_row; ?>][days]" class="form-control" value="<?php echo $template_data['days']; ?>"/>
                                    </td>
                                    <td class="col-xs-2">
                                        <select class="form-control" name="neoseo_email_notify_cron_templates[<?php echo $cron_row; ?>][status]">
                                            <option value="0"><?php echo $text_disabled; ?></option>
                                            <option value="1" <?php if (1 == $template_data['status']) { ?> selected="selected" <?php } ?> ><?php echo $text_enabled;?></option>
                                        </select>
                                    </td>
                                    <td class="col-xs-4">
                                        <?php foreach ($languages as $language) { ?>
                                        <div class="input-group">
                                            <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"/></span>
                                            <input name="neoseo_email_notify_cron_templates[<?php echo $cron_row; ?>][<?php echo $language['language_id']; ?>][subject]" class="form-control" value="<?php echo $template_data[$language['language_id']]['subject']; ?>"/>
                                        </div>
                                        <?php } ?>
                                    </td>
                                    <td class="col-xs-2">
                                        <?php foreach ($languages as $language) { ?>
                                        <select class="form-control" name="neoseo_email_notify_cron_templates[<?php echo $cron_row; ?>][<?php echo $language['language_id']; ?>][filename]">
                                            <option value=""><?php echo $text_select_template;?></option>
                                            <?php foreach ($email_templates as $email_template) { ?>
                                            <option value="<?php echo $email_template;?>" <?php if ($email_template == $template_data[$language['language_id']]['filename']) { ?> selected="selected" <?php } ?> ><?php echo $email_template;?></option>
                                            <?php } ?>
                                        </select>
                                        <?php } ?>
                                    </td>
                                    <td class="text-left"><button type="button" onclick="$('#cron-row<?php echo $cron_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                </tr>
                                <?php $cron_row++; ?>
                                <?php } ?>
                                <?php } ?>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="5"></td>
                                    <td class="text-left"><button type="button" onclick="addCron();" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                </tr>
                                </tfoot>
                            </table>
                        </div>
                        <?php } ?>

                        <?php if (!isset($license_error)) { ?>
                            <div class="tab-pane" id="tab-fields">
                                <table class="table table-striped table-hover" id="items-table">
                                    <thead>
                                    <tr>
                                        <th><?php echo $entry_field_list_name; ?></th>
                                        <th><?php echo $entry_field_list_desc; ?></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php foreach ($fields as $field_name => $field_desc) { ?>
                                        <tr>
                                            <td class="col-xs-3"><?php echo $field_name; ?></td>
                                            <td class="col-xs-9"><?php echo $field_desc;?></td>
                                        </tr>
                                    <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php } ?>
                        <?php if (!isset($license_error)) { ?>
                            <div class="tab-pane" id="tab-logs">
                                <?php $widgets->debug_and_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log ); ?>
                                <textarea class="form-control" style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
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
    $(".nav-tabs li a").click(function() {
        var url = $(this).prop('href');
        window.location.hash = url.substring(url.indexOf('#'));
    });
//--></script>
<script type="text/javascript"><!--
    window.token = '<?php echo $token; ?>';
    var gate = "#neoseo_sms_notify_gate";
    var login = "#neoseo_sms_notify_login";
    var password = "#neoseo_sms_notify_password";
    var sender = "#neoseo_sms_notify_sender";
    var additional = "#neoseo_sms_notify_additional";
    var phone = "#neoseo_sms_notify_phone";
    var message = "#neoseo_sms_notify_message";

    function checkGate() {
        var data = {
            gate: $(gate).val(),
            login: $(login).val(),
            password: $(password).val(),
            sender: $(sender).val(),
            additional: $(additional).val(),
            phone: $(phone).val(),
            message: $(message).val()
        };
        $.ajax({
            url: 'index.php?route=module/neoseo_sms_notify/check&token=' + window.token,
            type: 'post',
            data: data,
            dataType: 'json',
            success: function (json) {
                $('.success, .warning, .attention, .information').remove();

                if (json['redirect'])
                    location = json['redirect'];

                if (json['success'])
                    showEditForm(type, json);
            }
        });
    }
//--></script>
<script type="text/javascript">
    var cron_row = <?php echo $cron_row; ?>;

    function addCron() {
        html  = '<tr id="cron-row' + cron_row + '">';
        html  += '<td  class="col-xs-2">';
        html  += '<select class="form-control" name="neoseo_email_notify_cron_templates['+cron_row+'][order_status_id]">';
    <?php foreach ($order_statuses as $order_status) { ?>
            html  += ' <option value="<?php echo $order_status["order_status_id"]; ?>" ><?php echo $order_status["name"];?></option>';
        <?php } ?>
        html  += '</select>';
        html  += '</td>';
        html  += '<td class="col-xs-2">';
        html  += '<input name="neoseo_email_notify_cron_templates['+cron_row+'][days]" class="form-control" value=""/>';
        html  += '</td>';
        html  += '<td class="col-xs-2">';
        html  += '<select class="form-control" name="neoseo_email_notify_cron_templates['+cron_row+'][status]">';
        html  += '<option value="0"><?php echo $text_disabled; ?></option>';
        html  += ' <option value="1"><?php echo $text_enabled;?></option>';
        html  += '</select>';
        html  += '</td>';
        html  += '<td class="col-xs-4">';
        <?php foreach ($languages as $language) { ?>
            html  += '<div class="input-group">';
            html  += ' <span class="input-group-addon"><img src="view/image/flags/<?php echo $language["image"]; ?>" title="<?php echo $language["name"]; ?>"/></span>';
            html  += '<input name="neoseo_email_notify_cron_templates['+cron_row+'][<?php echo $language["language_id"]; ?>][subject]" class="form-control" value=""/>';
            html  += '</div>';
        <?php } ?>
        html  += '</td>';
        html  += '<td class="col-xs-2">';
        <?php foreach ($languages as $language) { ?>
            html  += '<select class="form-control" name="neoseo_email_notify_cron_templates['+cron_row+'][<?php echo $language["language_id"]; ?>][filename]">';
            html  += '<option value=""><?php echo $text_select_template;?></option>';
            <?php foreach ($email_templates as $email_template) { ?>
                html  += '<option value="<?php echo $email_template;?>"><?php echo $email_template;?></option>';
            <?php } ?>
            html  += '</select>';
        <?php } ?>
        html  += '</td>';
        html += '  <td class="text-left"><button type="button" onclick="$(\'#cron-row' + cron_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
        html += '</tr>';

        $('#notify-cron tbody').append(html);

        cron_row++;
    }
</script>
<?php echo $footer; ?>