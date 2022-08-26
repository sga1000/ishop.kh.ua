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
                    <li><a href="#tab-depth" data-toggle="tab"><?php echo $tab_depth; ?></a></li>
                    <li><a href="#tab-courier" data-toggle="tab"><?php echo $entry_courier_delivery_status; ?></a></li>
                    <li><a href="#tab-warehouse" data-toggle="tab"><?php echo $entry_warehouse_delivery_status; ?></a></li>
                    <li><a href="#tab-handbook" data-toggle="tab"><?php echo $tab_handbook; ?></a></li>
                    <li><a href="#tab-package" data-toggle="tab"><?php echo $tab_package; ?></a></li>
                    <li><a href="#tab-tarifs" data-toggle="tab"><?php echo $tab_tarifs; ?></a></li>
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
                            <?php $widgets->input('api_key'); ?>
                            <?php $widgets->input('api_url'); ?>
                            <?php $widgets->checklist('order_status',$order_statuses); ?>
                            <?php $widgets->dropdown('cod_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('cod_order_status_id',$order_statuses); ?>
                            <?php $widgets->dropdown('city_list_lang',array(1 => 'В зависимости от языка пользователя', 2 => 'Русский', 3 => 'Украинский')); ?>
                            <?php $widgets->input('sort_order'); ?>
                            <?php $widgets->dropdown('before',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php } else { ?>

                            <?php echo $license_error; ?>

                            <?php } ?>

                        </div>
                        <div class="tab-pane" id="tab-depth">
                            <?php $widgets->input('min_weight'); ?>
                            <?php $widgets->input('min_width'); ?>
                            <?php $widgets->input('min_height'); ?>
                            <?php $widgets->input('min_depth'); ?>
                            <?php $widgets->dropdown('weight_class_id',$weight_classes); ?>
                            <?php $widgets->dropdown('length_class_id',$length_classes); ?>
                        </div>
                        <div class="tab-pane" id="tab-courier">
                            <?php $widgets->dropdown('courier_delivery_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('courier_delivery_send_type',$handbook_handbooks['service']); ?>
                            <?php $widgets->dropdown('courier_delivery_pay_type',$handbook_handbooks['payment']); ?>
                            <?php $widgets->localeInput('courier_delivery_name',$full_languages); ?>
                        </div>
                        <div class="tab-pane" id="tab-warehouse">
                            <?php $widgets->dropdown('warehouse_delivery_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('warehouse_delivery_send_type',$handbook_handbooks['service']); ?>
                            <?php $widgets->dropdown('warehouse_delivery_pay_type',$handbook_handbooks['payment']); ?>
                            <?php $widgets->localeInput('warehouse_delivery_name',$full_languages); ?>
                        </div>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
                            <textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
                        </div>
                        <?php } ?>

                        <div class="tab-pane" id="tab-handbook">
                            <?php $widgets->text('cron'); ?>
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <td class="text-left"><?php echo $text_name; ?></td>
                                    <td class="text-left"><?php echo $text_last_up; ?></td>
                                    <td class="text-left"><?php echo $text_count; ?></td>
                                    <td class="text-left"><?php echo $text_description; ?></td>
                                </tr>
                                </thead>
                                <?php foreach($handbook_data as $hd) { ?>
                                <tr>
                                    <td class="text-left"><?php echo ${'text_' . $hd['id'] . '_name'}; ?></td>
                                    <td class="text-left"><?php echo $hd['up_date'] ?></td>
                                    <td class="text-left"><?php echo $hd['count'] ?></td>
                                    <td class="text-left"><?php echo ${'text_' . $hd['id'] . '_description'}; ?></td>
                                </tr>
                                <?php } ?>
                            </table>
                            <a href="<?php echo $uphblink; ?>" class="btn btn-primary"><?php echo $text_update_handbook; ?></a>
                        </div>

                        <div class="tab-pane" id="tab-package">
                            <?php if($api_key == "") { ?>
                            <div class="alert alert-danger">
                                <i class="fa fa-exclamation-circle"></i> <?php echo $text_no_api_key; ?>
                            </div>
                            <?php } else if (!isset($sender['sender']) || (!isset($sender['contacts']) || count($sender['contacts']) == 0)) { ?>
                            <div class="alert alert-danger">
                                <i class="fa fa-exclamation-circle"></i> <?php echo $text_no_np_sender; ?>
                            </div>
                            <?php } else { ?>
                            <input type="hidden" name="<?php echo $sysname; ?>_np_sender_ref" value="<?php echo $sender['sender']; ?>">
                            <?php $widgets->dropdown('np_sender_contact',$sender['contacts']); ?>
                            <?php $widgets->input('np_sender_phone'); ?>

                            <div class="form-group" style="display: inline-block; width: 100%;">
                                <div class="col-sm-5">
                                    <label class="control-label" for="cityselect"><?php echo $entry_sender_city; ?></label>
                                    <br><?php echo $entry_sender_city_desc; ?>
                                </div>
                                <div class="col-sm-7">
                                    <input type="hidden" name="<?php echo $sysname; ?>_sender_city" id="neoseo_novaposhta_sender_city" value="<?php echo $sender_city; ?>">
                                    <input type="text" name="cityselect" class="form-control" value="<?php echo $cityname; ?>">

                                </div>
                            </div>
                            <div class="form-group" style="display: inline-block; width: 100%;">
                                <div class="col-sm-5">
                                    <label class="control-label" for="<?php echo $sysname; ?>sender_warehouse"><?php echo $entry_sender_warehouse; ?></label>
                                    <br><?php echo $entry_sender_warehouse_desc; ?>
                                </div>
                                <div class="col-sm-7">
                                    <select name="<?php echo $sysname; ?>_sender_warehouse" id="<?php echo $sysname; ?>_sender_warehouse" class="form-control">
                                        <?php foreach($warehouses as $warehouse) { ?>
                                            <?php if($warehouse['ref'] == $sender_warehouse) { ?>
                                                <option value="<?php echo $warehouse['ref']; ?>" selected="selected"><?php echo $warehouse['descriptionru']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $warehouse['ref']; ?>"><?php echo $warehouse['descriptionru']; ?></option>
                                            <?php } ?>
                                         <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <?php $widgets->dropdown('package_type',$handbook_handbooks['cargo']); ?>
                            <?php $widgets->dropdown('payer',$handbook_handbooks['payer']); ?>
                            <?php $widgets->dropdown('delivery_day',array(0 => $text_p0day, 1 => $text_p1day, 2 => $text_p2day, 3 => $text_p3day)); ?>
                            <?php $widgets->input('description'); ?>
                            <?php } // else ?>
                        </div>

                        <div class="tab-pane" id="tab-tarifs">
                            <?php $widgets->input('add_tax'); ?>
                            <?php $widgets->dropdown('use_custom_cost',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('custom_cost_type',array( 0 => $text_by_weight, 1 => $text_by_total)); ?>
                            <table id="wt-table" class="table table-striped table-bordered table-hover" style="<?php echo ($current_cost_type == 0)?"":"display:none;"; ?>">
                                <thead>
                                <tr>
                                    <td class="text-left" style="width: 200px;"><?php echo $text_weight; ?></td>
                                    <td class="text-left"><?php echo $text_price_for.$text_warehouse_shipping; ?></td>
                                    <td class="text-left"><?php echo $text_price_for.$text_courier_shipping; ?></td>
                                    <td class="text-left" style="width: 50px;">&nbsp;</td>
                                </tr>
                                </thead>
                                <tbody>
                                <?php $wt_row = 0; ?>
                                <?php foreach($weigh_table as $wt) { ?>
                                    <tr id="tw-row<?php echo $wt_row; ?>">
                                        <td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs[<?php echo $wt_row; ?>][weight]" value="<?php echo $wt['weight'];?>"></td>
                                        <td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs[<?php echo $wt_row; ?>][warehouse]" value="<?php echo $wt['warehouse'];?>"></td>
                                        <td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs[<?php echo $wt_row; ?>][courier]" value="<?php echo $wt['courier'];?>"></td>
                                        <td class="text-left"><button type="button" onclick="$('#tw-row<?php echo $wt_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                    </tr>
                                <?php $wt_row++; ?>
                                <?php } ?>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="3"></td>
                                    <td class="text-left"><button type="button" onclick="addrow();" data-toggle="tooltip" title="<?php echo $text_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                </tr>
                                </tfoot>
                            </table>

                            <table id="wtt-table" class="table table-striped table-bordered table-hover" style="<?php echo ($current_cost_type == 1)?"":"display:none;"; ?>" >
                                <thead>
                                <tr>
                                    <td class="text-left" style="width: 200px;"><?php echo $text_total; ?></td>
                                    <td class="text-left"><?php echo $text_price_for.$text_warehouse_shipping; ?></td>
                                    <td class="text-left"><?php echo $text_price_for.$text_courier_shipping; ?></td>
                                    <td class="text-left" style="width: 50px;">&nbsp;</td>
                                </tr>
                                </thead>
                                <tbody>
                                <?php $wtt_row = 0; ?>
                                <?php foreach($totals_table as $wtt) { ?>
                                <tr id="ttw-row<?php echo $wtt_row; ?>">
                                    <td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs_total[<?php echo $wtt_row; ?>][total]" value="<?php echo $wtt['total'];?>"></td>
                                    <td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs_total[<?php echo $wtt_row; ?>][warehouse]" value="<?php echo $wtt['warehouse'];?>"></td>
                                    <td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs_total[<?php echo $wtt_row; ?>][courier]" value="<?php echo $wtt['courier'];?>"></td>
                                    <td class="text-left"><button type="button" onclick="$('#ttw-row<?php echo $wtt_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
                                </tr>
                                <?php $wtt_row++; ?>
                                <?php } ?>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <td colspan="3"></td>
                                    <td class="text-left"><button type="button" onclick="addrowt();" data-toggle="tooltip" title="<?php echo $text_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
                                </tr>
                                </tfoot>
                            </table>

                        </div>

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
    var wt_row = <?php echo $wt_row; ?>;
    function addrow()
    {
        html = '<tr id="tw-row'+wt_row+'">';
        html += '<td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs['+wt_row+'][weight]" value=""></td>';
        html += '<td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs['+wt_row+'][warehouse]" value=""></td>';
        html += '<td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs['+wt_row+'][courier]" value=""></td>';
        html += '<td class="text-left"><button type="button" onclick="$(\'#tw-row'+wt_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
        html += '</tr>';
        $('#wt-table tbody').append(html);
        wt_row++;
    }

    var wtt_row = <?php echo $wtt_row; ?>;
    function addrowt()
    {
        html = '<tr id="ttw-row'+wtt_row+'">';
        html += '<td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs_total['+wtt_row+'][total]" value=""></td>';
        html += '<td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs_total['+wtt_row+'][warehouse]" value=""></td>';
        html += '<td><input type="text" class="form-control" name="<?php echo $sysname; ?>_custom_costs_total['+wtt_row+'][courier]" value=""></td>';
        html += '<td class="text-left"><button type="button" onclick="$(\'#ttw-row'+wtt_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
        html += '</tr>';
        $('#wtt-table tbody').append(html);
        wtt_row++;
    }

    $('#<?php echo $sysname ?>_custom_cost_type').on('change',function () {
        //alert($(this).val())
        if($(this).val() == 1){
            $('#wt-table').hide();
            $('#wtt-table').show();
        } else {
            $('#wtt-table').hide();
            $('#wt-table').show();
        }
    });

    $('input[name=\'cityselect\']').autocomplete({
        'source': function(request, response) {
            $.ajax({
                url: 'index.php?route=shipping/<?php echo $sysname; ?>/cityautocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                dataType: 'json',
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item['name'],
                            value: item['id'],
                        }
                    }));
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        },
        'select': function(item) {
            $(this).val(item['label']);
            $('input[name="<?php echo $sysname; ?>_sender_city"]').val(item['value']);
            $('#<?php echo $sysname; ?>_sender_warehouse').load('index.php?route=shipping/<?php echo $sysname; ?>/warehouseAutocomplete&city_ref=' + item['value'] + '&token=<?php echo $token; ?>');

        }
    });



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
	//--></script>
<?php echo $footer; ?>