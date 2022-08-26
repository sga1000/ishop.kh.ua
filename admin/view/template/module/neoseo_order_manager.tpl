<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <button  name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary button-submit"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button  name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default button-submit"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
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
                    <?php if( !isset($license_error) ) { ?>
                    <li><a href="#tab-columns" data-toggle="tab"><?php echo $tab_columns; ?></a></li>
                    <li><a href="#tab-fields" data-toggle="tab"><?php echo $tab_fields; ?></a></li>
                    <li><a href="#tab-buttons" data-toggle="tab"><?php echo $tab_buttons; ?></a></li>
                    <li><a href="#tab-products" data-toggle="tab"><?php echo $tab_products; ?></a></li>                  
                    <li><a href="#tab-history" data-toggle="tab"><?php echo $tab_history; ?></a></li>               
                    <li><a href="#tab-allowed" data-toggle="tab"><?php echo $tab_allowed; ?></a></li>               
                    <li><a href="#tab-colors" data-toggle="tab"><?php echo $tab_colors; ?></a></li>  
                    <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <!--                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">-->
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-general">
                        <?php if( !isset($license_error) ) { ?>

                        <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                        <?php $widgets->dropdown('replace_system_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                        <?php $widgets->dropdown('hide_unavailable',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                        <?php $widgets->dropdown('block_send_comment',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                        <div class="form-group">
                            <div class="col-sm-5">
                                <label class="control-label" for="input-order-status"><?php echo $entry_visible_statuses; ?></label>
                                <br> <?php echo $entry_visible_statuses_desc; ?>
                            </div>
                            <div class="col-sm-7">
                                <div class="well well-sm" style="min-height: 100px;max-height: 300px;overflow: auto;">
                                    <?php $class = 'odd'; ?>
                                    <?php foreach( $orders_status as $status) { ?>
                                    <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                                    <div class="<?php echo $class; ?>">
                                        <label>
                                            <?php if (in_array($status['order_status_id'], $neoseo_order_manager_visible_order_statuses)) { ?>
                                            <input type="checkbox" name="neoseo_order_manager_visible_order_statuses[]" value="<?php echo $status['order_status_id']; ?>" checked="checked" />
                                            <?php echo $status['name']; ?>
                                            <?php } else { ?>
                                            <input type="checkbox" name="neoseo_order_manager_visible_order_statuses[]" value="<?php echo $status['order_status_id']; ?>" />
                                            <?php echo $status['name']; ?>
                                            <?php } ?>
                                        </label>
                                    </div>
                                    <?php } ?>

                                </div>
                                <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a></div>
                        </div>

                        <?php } else { ?>

                        <div><?php echo $license_error; ?></div>

                        <?php } ?>
                    </div>

                    <?php if( !isset($license_error) ) { ?>
                    <div class="tab-pane" id="tab-columns">
                        <div class="container-fluid">
                            <h1><?php echo $test_columns_format_header;?></h1>
                            <p><?php echo $test_columns_format_desc;?></p>
                            <div class="pull-right">
                                <a href="<?php echo $add_columns; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> <?php echo $entry_action_add; ?></a>
                                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-columns').submit() : false;"><i class="fa fa-trash-o"></i> <?php echo $entry_action_delete; ?></button>
                            </div>            
                        </div>
                        <br>
                        <form action="<?php echo $delete_columns; ?>" method="post" enctype="multipart/form-data" id="form-columns">
                            <div class="table-responsive">

                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected_columns\']').prop('checked', this.checked);" /></td>
                                            <td class="text-center"><?php echo $entry_cl_name; ?></td>
                                            <td class="text-center"><?php echo $entry_cl_pattern; ?></td>
                                            <td class="text-center"><?php echo $entry_cl_align; ?></td>
                                            <td class="text-center"><?php echo $entry_cl_width; ?></td>
                                            <td class="text-center"><?php echo $entry_action; ?></td>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <?php if ($columns) { ?>
                                        <?php foreach ($columns as $column) { ?>
                                        <tr>
                                            <td class="text-center"><?php if (in_array($column['order_manager_columns_id'], $selected_columns)) { ?>
                                                <input type="checkbox" name="selected_columns[]" value="<?php echo $column['order_manager_columns_id']; ?>" checked="checked" />
                                                <?php } else { ?>
                                                <input type="checkbox" name="selected_columns[]" value="<?php echo $column['order_manager_columns_id']; ?>" />
                                                <?php } ?></td>
                                            <td class="text-left"><?php echo $column['name']; ?></td>
                                            <td class="text-left"><?php echo $column['pattern']; ?></td>
                                            <td class="text-left"><?php echo $column['align']; ?></td>
                                            <td class="text-left"><?php echo $column['width']; ?></td>
                                            <td class="text-center"><a href="<?php echo $column['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i> <?php echo $entry_action_edit; ?></a></td>
                                        </tr>
                                        <?php } ?>
                                        <?php } else { ?>
                                        <tr>
                                            <td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
                                        </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>

                        </form>
                    </div> 
                    <?php } ?>



                    <?php if( !isset($license_error) ) { ?>
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
                    <div class="tab-pane" id="tab-buttons">
                        <div class="container-fluid">
                            <div class="pull-right">
                                <a href="<?php echo $add_buttons; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> <?php echo $entry_action_add; ?></a>
                                <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-buttons').submit() : false;"><i class="fa fa-trash-o"></i> <?php echo $entry_action_delete; ?></button>
                            </div>            </div><br>

                        <form action="<?php echo $delete_buttons; ?>" method="post" enctype="multipart/form-data" id="form-buttons">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                            <td class="text-center"><?php echo $entry_bt_name; ?></td>
                                            <td class="text-center"><?php echo $entry_bt_class; ?></td>
                                            <td class="text-center"><?php echo $entry_bt_style; ?></td>
                                            <td class="text-center"><?php echo $entry_bt_link; ?></td>
                                            <td class="text-center"><?php echo $entry_action; ?></td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if ($buttons) { ?>
                                        <?php foreach ($buttons as $button) { ?>
                                        <tr>
                                            <td class="text-center"><?php if (in_array($button['order_manager_buttons_id'], $selected_buttons)) { ?>
                                                <input type="checkbox" name="selected_buttons[]" value="<?php echo $button['order_manager_buttons_id']; ?>" checked="checked" />
                                                <?php } else { ?>
                                                <input type="checkbox" name="selected_buttons[]" value="<?php echo $button['order_manager_buttons_id']; ?>" />
                                                <?php } ?></td>
                                            <td class="text-left"><?php echo $button['name']; ?></td>
                                            <td class="text-left"><?php echo $button['class']; ?></td>
                                            <td class="text-left"><?php echo $button['style']; ?></td>
                                            <td class="text-left"><?php echo $button['link']; ?></td>
                                            <td class="text-center"><a href="<?php echo $button['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i> <?php echo $entry_action_edit; ?></a></td>
                                        </tr>
                                        <?php } ?>
                                        <?php } else { ?>
                                        <tr>
                                            <td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
                                        </tr>
                                        <?php } ?>
                                    </tbody>
                                </table>
                            </div>
                        </form>
                    </div> 
                    <?php } ?>

                    <?php if( !isset($license_error) ) { ?>
                    <div class="tab-pane" id="tab-allowed">
                        <div class="container-fluid">

                            <h1><?php echo $entry_format_header ?></h1>
                            <p><?php echo $entry_format_header_desc ?></p>
                            <div class="pull-right">
                                <a onclick="saveAllowed();" data-toggle="tooltip" title="<?php echo $button_save_allowed; ?>" class="btn btn-primary"><i class="fa fa-floppy-o" aria-hidden="true"></i> <?php echo $button_save_allowed; ?></a>
                            </div>            </div>
                        <br>
                        <table class='table table-bordered'>
                            <tr><td class="left" width="30%"><strong><?php echo $entry_status_list_for_allow ?></strong></td><td><strong><?php echo $entry_allowed_status_list ?></strong></td></tr>                        
                            <tr><td><?php foreach($orders_status as $status) { ?>                            
                                    <input type='radio' id='osi-<?php echo $status["order_status_id"]; ?>' name='order_status_id' value='<?php echo $status["order_status_id"] ?>' />  
                                    <label for='osi-<?php echo $status["order_status_id"]; ?>'><?php echo $status["name"] ?></label> <br />
                                    <?php } ?>
                                </td><td id="allowedData"></td></tr>
                        </table>
                        </p>
                    </div> 
                    <?php } ?>

                    <?php if( !isset($license_error) ) { ?>
                    <div class="tab-pane" id="tab-history">
                        <?php $widgets->textarea('history'); ?>
                    </div> 
                    <?php } ?>

                    <?php if( !isset($license_error) ) { ?>
                    <div class="tab-pane" id="tab-products">
                        <?php $widgets->textarea('product'); ?>
                    </div> 
                    <?php } ?>

                    <?php if( !isset($license_error) ) { ?>
                    <div class="tab-pane" id="tab-colors">
                        <?php 
                        foreach($neoseo_order_manager_status_colors as $cid => $cdata){
                        ?>
                        <div class="form-group" id="field_color_status_<?php echo $cid; ?>" style="display: inline-block; width: 100%;">
                            <div class="col-sm-4">
                                <label class="control-label"
                                       for="color_status_<?php echo $cid; ?>"><?php echo $cdata["name"]; ?></label>
                            </div>
                            <div class="col-sm-8">
                                <?php foreach(range(0,1) as $num){ ?>
                                <div class="row">
                                 <div class="col-sm-3">
                                    <?php echo $params_num[$num];?>
                                 </div>
                                <div class="col-sm-4">
                                <input name="neoseo_order_manager_status_colors[<?php echo $cid ?>][<?php echo $num;?>]"
                                       id="order_manager_status_colors[<?php echo $cid ?>][<?php echo $num;?>]"
                                       value="<?php echo $cdata['value'][$num]; ?>"
                                       style="float:left;" class="pick_color form-control" />
                                </div>
                                                                    </div>
                                <?php } ?>
                            </div>
                        </div>
                        <?php } ?>    
                    </div> 
                    <?php } ?>

                    <?php if( !isset($license_error) ) { ?>
                    <div class="tab-pane" id="tab-logs">
                        <?php $widgets->debug_and_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log ); ?>
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
            </div>
        </div>
    </div>
</div>
    
<script type="text/javascript">
    <!--
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
    //-->
</script>
<script type="text/javascript"><!--
    <?php
    if ($ckeditor) { ?>
        ckeditorInit('neoseo_order_manager_product', '<?php echo $token; ?>');
        ckeditorInit('neoseo_order_manager_history', '<?php echo $token; ?>'); 
    <?php } else { ?>
        $('#neoseo_order_manager_product').summernote({
            height: 300,
            lang: 'ru-RU'
        });
        $('#neoseo_order_manager_history').summernote({
            height: 300,
            lang: 'ru-RU'
        }); 
    <?php } ?>
    //-->
</script>
<script type="text/javascript">
    $(function() {
      $(".pick_color").ColorPickerSliders({
  placement: 'right',
  title: 'Выбрать цвет',
    order: {
      hsl: 1,
      opacity: 2
    }
    });
    });
</script>
<script type="text/javascript">
    window.token = '<?php echo $token; ?>';
    $("label[id^='osi-'], input[id^='osi-']").click(function() {
        var status_id = $(this).attr("id").replace("osi-", "");
        $.ajax({
            url: 'index.php?route=module/neoseo_order_manager/getAllowedList&token=' + window.token + "&status_id=" + status_id,
            type: 'post',
            dataType: 'json',
            success: function(json) {
                if (json['redirect'])
                    location = json['redirect'];

                if (json['success'])
                    $("#allowedData").html(json["form"])
            },
         //   error: function(xhr, ajaxOptions, thrownError) {
         //       alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
         //   }
        });
    });

    function saveAllowed() {
        var status_id = $("input[name='order_status_id']:checked").val();

        if (status_id) {

            $.ajax({
                url: 'index.php?route=module/neoseo_order_manager/setAllowedList&token=' + window.token + "&status_id=" + status_id,
                type: 'post',
                data: $("input[id^='osa']:checked").serialize(),
                dataType: 'json',
                success: function(json) {
                    if (json['redirect'])
                        location = json['redirect'];

                    if (json['success'])
                        alert('<?php echo $text_success; ?>');
                }
            });

        }
    }
</script>
<script type="text/javascript">
    $('.button-submit').on('click', function() {
        saveSettingModule($(this).val());
    });
    $('#button-submit-close').on('click', function() {
        saveSettingModule();
    });

    function saveSettingModule(action) {
        
        var selectedItems = new Array();
        $('input[name=\'neoseo_order_manager_visible_order_statuses[]\']:checked').each(function() {
            selectedItems.push($(this).val());
        });
        var colorsItems = new Array(); 
                <?php foreach($neoseo_order_manager_status_colors as $cid => $cdata) { ?>
                    colorsItems[<?php echo $cid; ?>]=[];
              <?php foreach(range(0,1) as $num){ ?>
                colorsItems[<?php echo $cid; ?>][<?php echo $num; ?>]=$('input[name=\'neoseo_order_manager_status_colors[<?php echo $cid ?>][<?php echo $num; ?>]\']').val(); 
                <?php } ?>
                <?php } ?>
            $.ajax({
                url: 'index.php?route=module/neoseo_order_manager&token=' + window.token,
                type: 'post',
                data: {
                    action: action,
                    neoseo_order_manager_status: $('select[name=\'neoseo_order_manager_status\']').val(),
                    neoseo_order_manager_replace_system_status: $('select[name=\'neoseo_order_manager_replace_system_status\']').val(),
                    neoseo_order_manager_hide_unavailable: $('select[name=\'neoseo_order_manager_hide_unavailable\']').val(),
                    neoseo_order_manager_block_send_comment: $('select[name=\'neoseo_order_manager_block_send_comment\']').val(),
                    neoseo_order_manager_visible_order_statuses: selectedItems,
                    <?php  if ($ckeditor) { ?>
                    neoseo_order_manager_product: CKEDITOR.instances['neoseo_order_manager_product'].getData(),
                    neoseo_order_manager_history: CKEDITOR.instances['neoseo_order_manager_history'].getData(),
                    <?php } else { ?>
                    neoseo_order_manager_product: $('#neoseo_order_manager_product').code(),
                    neoseo_order_manager_history: $('#neoseo_order_manager_history').code(),
                    <?php } ?>
                    neoseo_order_manager_status_colors: colorsItems,
                    neoseo_order_manager_debug: $('select[name=\'neoseo_order_manager_debug\']').val(),
                },
                dataType: 'json',
                success: function(json) {
                    if (json.success) {
                        location.href = json.link;
                    }
                },
            //  error: function(xhr, ajaxOptions, thrownError) {
            //      alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            //  }
            });
    }
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
</script>
<?php echo $footer; ?>