<?php echo $header; ?><?php echo $result_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php
                foreach($buttonsData as $data) {
                $action = "index.php?route=" . $data["link"] . "&token=" . $token;
                echo '<a onclick="$(\'#form_attribute\').attr(\'action\', \'' . $action . '\'); $(\'#form_attribute\').attr(\'target\', \'_blank\'); $(\'#form_attribute\').submit();" class="' . ($data["class"] ? $data["class"] : "btn btn-primary"). '" ' . ($data["style"] ? "style='" . $data["style"] . "'" : "") . '>' . $data["name"] . '</a>&nbsp;&nbsp;';
				}
				?>
				<a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> <?php echo $button_add; ?></a>&nbsp;
				<button type="button" id="button-delete" data-loading-text="<?php echo $text_loading; ?>" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form_attribute').submit() : false;"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?></button>&nbsp;

			</div>
			<img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
			<h1><?php echo $heading_title . " " . $text_module_version; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if ($success) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
			</div>
			<div class="panel-body">
				<div class="well" style="padding-top: 0px;padding-bottom: 10px;margin-bottom: 7px;">
					<div class='row'>
						<div class="pull-right">
							<form action="<?php echo $change_status; ?>" method="post" enctype="multipart/form-data" id="form-status">
								<div class='form-group'>
									<div class="col-sm-5" style="padding-top: 10px;">
										<label class="control-label" for="input-id"><?php echo $text_change_status; ?></label>
									</div>
									<div class="col-sm-4">
										<select name="manager_order_status" id="manager_order_status" class="form-control">
											<?php foreach($order_statuses as $status){ ?>
											<option value="<?php echo $status['order_status_id']?>"><?php echo $status['name']?></option>
											<?php } ?>
										</select>
									</div>
									<div class="col-sm-3">
										<button type="button"  id="button-change-status" data-loading-text="<?php echo $text_loading; ?>" data-toggle="tooltip" title="<?php echo $button_change_status; ?>" class="btn btn-primary"><?php echo $button_change_status;?></button></td>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="well">
					<div class="row">
						<?php $counter=1;?>
						<?php foreach($columnsData["name"] as $id => $data) { ?>
						<?php if($store_name_id && $id == $store_name_id){ ?>
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="input-id"><?php echo $data;  ?></label>
								<select placeholder="<?php echo $data;?>" name='filters[<?php echo $id ?>]' class='form-control'>
									<?php if (!$filters && !isset($filters[$id])) { ?>
									<option value="" selected="selected"></option>
									<?php }else { ?>
									<option value=""></option>
									<?php } ?>
									<?php foreach ($stores as $store_id => $store_data) { ?>
									<?php
										if($store_id == 0){
											$store_zero = "'0'";
										}else{
											$store_zero = $store_id;
										}

										?>

									<?php if ($filters && isset($filters[$id]) && $filters[$id] == $store_zero ) { ?>
									<option value="<?php echo $store_zero; ?>" selected="selected"><?php echo $store_data['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $store_zero; ?>"><?php echo $store_data['name']; ?></option>
									<?php } ?>
									<?php } ?>
								</select>
								<!--<input class='form-control'  placeholder="<?php echo $data;?>" type='text' name='filters[<?php echo $id ?>]' value="<?php echo ($filters && isset($filters[$id]) ? $filters[$id] : '')?>" size='20' />-->
							</div>


						</div>
						<?php }else{ ?>
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="input-id"><?php echo $data;  ?></label>
								<input class='form-control'  placeholder="<?php echo $data;?>" type='text' name='filters[<?php echo $id ?>]' value="<?php echo ($filters && isset($filters[$id]) ? $filters[$id] : '')?>" size='20' />
							</div>
						</div>
						<?php } ?>
						<?php if($counter%3 == 0){ ?>
					</div>

					<div class="row">
						<?php } ?>
						<?php $counter++; ?>
						<?php    } ?>
					</div>
					<div class="row">
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="input-date-added-min"><?php echo $entry_date_added_min; ?></label>
								<div class="input-group date">
									<input type="text" name="filters_date_added_min" value="<?php echo $filter_date_added_min; ?>" placeholder="<?php echo $entry_date_added_min; ?>" data-date-format="YYYY-MM-DD" id="input-date-added-min" class="form-control" />
									  <span class="input-group-btn">
									  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
									  </span>
								</div>

							</div>
						</div>
						<div class="col-sm-4">
							<div class="form-group">
								<label class="control-label" for="input-date-added-max"><?php echo $entry_date_added_max; ?></label>
								<div class="input-group date">
									<input type="text" name="filters_date_added_max" value="<?php echo $filter_date_added_max; ?>" placeholder="<?php echo $entry_date_added_max; ?>" data-date-format="YYYY-MM-DD" id="input-date-added-max" class="form-control" />
									  <span class="input-group-btn">
									  <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
									  </span>
								</div>
							</div>
						</div>


					</div>
					<div class="row">
						<button type="button" id="button-filter" class="btn btn-primary pull-right" onclick="filter();"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>&nbsp;&nbsp;
						<a style="margin-right:6px;" class="btn btn-primary pull-right" href="<?= $neoseo_order_xls_export ?>"><span class="hidden-xs hidden-sm hidden-md"><?= $text_export_order_to_xls ?></span> <i class="fa fa-upload fa-lg"></i></a>&nbsp;&nbsp;
					</div>

				</div>
				<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form_attribute" name="form_attribute">
					<div class="table-responsive">
						<table class="table table-bordered table-hover" style="min-width: 100%;">
							<thead>
							<tr>
								<td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
								<?php $i = 0; $width = array();
                                    foreach($columnsData["name"] as $id => $data) {
								echo "<td " . ($columnsData["align"][$id] ? "algin = '" . $columnsData["align"][$id]  . "'" : "") ." " . ($columnsData["width"][$id]  ? "style = 'width:" . $columnsData["width"][$id]  . "px;'" : "style = 'width:150px;") ." >" . $data . "</td>";
								$width[$i] = $columnsData["width"][$id]; $i++;
								}
								?>
								<td style="width: 200px;" class="text-center"><?php echo $column_action; ?></td>
							</tr>
							</thead>
							<tbody>
							<?php if ($orders) { ?>
							<?php foreach ($orders as $order) { ?>

								<tr <?php if (isset($order['status_color'])) echo "style='background-color: ".$order['status_color']."; border-collapse: collapse;'"; ?>>
									<td style="text-align: center;"><?php if ($order['selected']) { ?>
										<input type="checkbox" name="selected[]" value="<?php echo $order['order_id']; ?>" checked="checked" />
										<?php } else { ?>
										<input type="checkbox" name="selected[]" value="<?php echo $order['order_id']; ?>" />
										<?php } ?>
									</td>

									<?php
										$i = 0;
										foreach($columnsData["rows"][$order["order_id"]] as $data) {
											echo "<td>" . $data . "</td>";
										}
									?>

									<td class="text-center" style="padding-left: 2px;padding-right: 5px;">
										<?php if ($block_send_comment) { ?>
										<div>
											<textarea id="input-send<?php echo $order['order_id']; ?>" rows="3" placeholder="<?php echo $text_send ?>" class="form-control"></textarea>
										</div><br>
										<div>
											<button type="button" onclick="send_sms(<?php echo $order['order_id']; ?>,'sms')" id="button-send-sms<?php echo $order['order_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" data-toggle="tooltip" title="<?php echo $button_send_sms; ?>" class="btn btn-info"><i class="fa fa-comment-o"></i></button>
											<button type="button" onclick="send_sms(<?php echo $order['order_id']; ?>,'email')" id="button-send-email<?php echo $order['order_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" data-toggle="tooltip" title="<?php echo $button_send_email; ?>" class="btn btn-info"><i class="fa fa-envelope-o"></i></button>
										</div><br>
										<?php } ?>
										<?php if(isset($order['action']['view']) ){ ?>
										<a href="<?php echo $order['action']['view']['href']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a>
										<?php } ?>
										<?php if(isset($order['action']['edit']) ){ ?>
										<a href="<?php echo $order['action']['edit']['href']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" id="button-edit" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
										<?php } ?>
										<button type="button" value="<?php echo $order['order_id']; ?>" id="button-delete-order<?php echo $order['order_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></button>
									</td>
								</tr>
							<?php } ?>
							<?php } else { ?>
								<tr>
									<td class="center" colspan="<?php echo (count($columnsData["id"])+2); ?>"><?php echo $text_no_results; ?></td>
								</tr>
							<?php } ?>
							</tbody>
						</table>
					</div>
				</form>
				<div class="row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
					<div class="col-sm-6 text-right"><?php echo $results; ?></div>
				</div>
			</div>
		</div>
		<div class="modal fade" id="modalComment" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
						<h4 class="modal-title"><?php echo $text_modal; ?></h4>
					</div>
					<div class="modal-body">
						<textarea name="comments" rows="3" required="" x-autocompletetype="text" type="text" class="form-control" ></textarea>
						<div class="checkbox">
							<label><input type="checkbox" id="sendmail" /> <?php echo $text_send_mail; ?></label>
						</div>
					</div>
					<div class="modal-footer">
						<input type="button" id="button-change-status-close" class="btn btn-primary pull-right" value="<?php echo $button_save; ?>">
					</div>
				</div>
			</div>
		</div>

	</div>
</div>
<script type="text/javascript"><!--
	function filter() {
		url = 'index.php?route=sale/neoseo_order_manager&token=<?php echo $token; ?>';

		var filters = $('[name^=\'filters\']').each(function (index) {
			if ($(this).val()){
				if ($(this).attr("id") == 'input-date-added-min') {
					url += '&filter_date_added_min=' + $(this).val();
				} else {
					if ($(this).attr("id") == 'input-date-added-max') {
						url += '&filter_date_added_max=' + $(this).val();
					} else {
						url += '&filters[' + $(this).attr("name").replace(/[^0-9]+/g, "") + ']=' + $(this).val();
					}
				}
			}

		});


		location = url;
	}
	//--></script>

<script type="text/javascript"><!--
	$('.date').datetimepicker({
		pickTime: false
	});
	//--></script>
<script>
	// Login to the API
	var token = '';

	$.ajax({
		url: '<?php echo $store; ?>index.php?route=api/login',
		type: 'post',
		data: 'key=<?php echo $api_key; ?>',
		dataType: 'json',
		crossDomain: true,
		success: function(json) {
			$('.alert').remove();

			if (json['error']) {
				if (json['error']['key']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['key'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				if (json['error']['ip']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['ip'] + ' <button type="button" id="button-ip-add" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-danger btn-xs pull-right"><i class="fa fa-plus"></i> <?php echo $button_ip_add; ?></button></div>');
					$('#button-edit').attr('disabled', 'disabled');
				}
			}

			if (json['token']) {
				token = json['token'];
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});

	$(document).delegate('#button-ip-add', 'click', function() {
		$.ajax({
			url: 'index.php?route=user/api/addip&token=<?php echo $token; ?>&api_id=<?php echo $api_id; ?>',
			type: 'post',
			data: 'ip=<?php echo $api_ip; ?>',
			dataType: 'json',
			beforeSend: function() {
				$('#button-ip-add').button('loading');
			},
			complete: function() {
				$('#button-ip-add').button('reset');
			},
			success: function(json) {
				$('.alert').remove();

				if (json['error']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}

				if (json['success']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});

	$('button[id^=\'button-delete-order\']').on('click', function(e) {
		if (confirm('<?php echo $text_confirm; ?>')) {
			var node = this;

			$.ajax({
				url: '<?php echo $store; ?>index.php?route=api/order/delete&token=' + token + '&order_id=' + $(node).val(),
				dataType: 'json',
				crossDomain: true,
				beforeSend: function() {
					$(node).button('loading');
				},
				complete: function() {
					$(node).button('reset');
				},
				success: function(json) {
					$('.alert').remove();

					if (json['error']) {
						$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					}

					if (json['success']) {
						$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');

						location.reload();
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	});
	//--></script>
<script>
	var selectedItems = new Array(),
			status;
	$('button[id^=\'button-change-status\']').on('click', function() {
		selectedItems = new Array();
		$('input[name=\'selected[]\']:checked').each(function() {
			selectedItems.push($(this).val());
		});
		status = $('select[name=\'manager_order_status\']').val();
		$('#modalComment').modal({show: true});
	});

	$('#button-change-status-close').on('click', function() {
		$('#modalComment').modal('hide');
		var comment = $('[name=\'comments\']').val(),
				send_mail = $('#sendmail').is(':checked');
		if(selectedItems.length>0){
			$.ajax({
				url: 'index.php?route=sale/neoseo_order_manager/changeStatus&token=<?php echo $token; ?>',
				type: 'post',
				data: {
					selected: selectedItems,
					status: status,
					comment:comment,
					send_mail:send_mail
				},
				dataType: 'json',
				success: function(json) {
					if (json.success) {
						$('.alert').remove();
						$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> ' + json.alert + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
						alert(json.alert);
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		} else {
			$('.alert').remove();
			$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + '<?php echo $error_no_change_status;?>' + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
		}
	});
	$(".date").on('dp.change', function(){
		var a = $(this).find('.save').change();
	});
	$(".checkbox").on('change', function(){
		var order_id = $(this).closest('tr').find('[name*="selected"]').val();
		var value = new Array();
		var name = $(this).parent().find('.save_check').attr('name'),
				product_id = $(this).data('product');
		$(this).parent().find('.save_check:checked').each(function() {
			value.push($(this).val());
		});
		$.ajax({
			url: 'index.php?route=sale/neoseo_order_manager/changeCheckbox&token=<?php echo $token; ?>',
			type: 'post',
			data: {
				order_id: order_id,
				name: name,
				value: value,
				product_id: product_id
			},
			dataType: 'json',
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	$('.save').on('change', function(){
		if ($(this).attr('name') == 'status') {
			selectedItems = new Array();
			selectedItems.push($(this).closest('tr').find('[name*="selected"]').val());
			status = $(this).val();
			$('#modalComment').modal({show: true});
		} else {
			var order_id = $(this).closest('tr').find('[name*="selected"]').val(),
					product_id = $(this).data('product'),
					name = $(this).attr('name'),
					value = $(this).val();
			$.ajax({
				url: 'index.php?route=sale/neoseo_order_manager/changeItem&token=<?php echo $token; ?>',
				type: 'post',
				data: {
					name: name,
					order_id: order_id,
					product_id: product_id,
					value: value
				},
				dataType: 'json',
				success: function(json) {
					if (json.success) {
						$('.alert').remove();
						$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> ' + json.alert + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					}
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		}
	});
	function send_sms (order_id, name) {
		var value = $('#input-send'+order_id).val();
		$.ajax({
			url: 'index.php?route=sale/neoseo_order_manager/sendComentToCustomer&token=<?php echo $token; ?>',
			type: 'post',
			data: {
				order_id: order_id,
				name: name,
				value: value,
			},
			dataType: 'json',
			success: function(json) {
				if (json.success) {
					$('.alert').remove();
					$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> ' + json.alert + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
					alert(json.alert);
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});

	}


	$(document).ready(function(){
		$(".status_custom").click(function(){

			if($(this).attr('data-toggle') == "0"){
				var text = $(this).text();

				$(this).attr('data-toggle', 1);
				var code = '<div class="status_change">';
				code += '<div class="status_cotainer_change">';
				code += '	<div>';
				code += '		<input type="text" class="status_val" value="'+text+'">';
				code += '	</div>';
				code += '	<div style="margin-top:7px;">';
				code += '		<button id="save_status" onclick="editCustom($(this)); $(this).parent().parent().parent().parent().find(\'.status_custom\').attr(\'data-toggle\', 0); $(this).parent().parent().parent().parent().find(\'.status_change\').remove(); return false;"><?php echo($button_save); ?></button>';
				code += '	</div>';
				code += '</div>';
				code += '</div>';

				$(this).after(code);
			}else{
				$(this).attr('data-toggle', 0);
				$(this).parent().find('.status_change').remove();

			}
		});

	});
	function editCustom(obj,order_id,field_name) {
		var order_id = obj.parent().parent().parent().parent().find('.status_custom').data('order-id');
		var field_name = obj.parent().parent().parent().parent().find('.status_custom').data('field-name');
		var field_value = obj.parent().parent().find('.status_val').val();

		$.ajax({
			url: 'index.php?route=sale/neoseo_order_manager/changeCustomField&token=<?php echo $token; ?>',
			type: 'post',
			dataType: 'json',
			async: false,
			data: {
				'order_id': order_id ,
				'field_name': field_name,
				'field_value': field_value,
			},
			success: function(json) {
				if (json['success']) {

					obj.parent().parent().parent().parent().find('.status_custom').text(field_value);
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});

	}

	//--></script>
<script>
	$(document).ready(function() {
		var table_out_width = $('.table').outerWidth();
		var table_responsive = $('.table-responsive').outerWidth();
		if ($('.table').outerWidth() > $('.table-responsive').outerWidth()) {
			var html = '<div class="joystick shadow"><div class="joystick_left"></div><div class="joystick_right"></div></div>';
			$('.table-responsive').prepend(html);
			$('.joystick').hover(
					function () { $(this).animate({'opacity':'1.0'}, 300); },
					function () { $(this).animate({'opacity':'0.5'}, 300); }
			);

			$('.joystick_left, .joystick_right').click(function() {
				var this_ = $(this);
				var width = $('.table-responsive').outerWidth();
				var scroll_left = $('.table-responsive').scrollLeft();

				if (this_.attr('class') == 'joystick_left') {
					$('.table-responsive').animate({'scrollLeft':(scroll_left - 700)}, 700);
				} else {
					$('.table-responsive').animate({'scrollLeft':(scroll_left + 700)}, 700);
				}
			});
		}
	});
</script>
<style>
	.joystick {
		position:fixed;
		top:50%;
		left:50%;
		width:150px;
		background:#F0F0F0;
		opacity:0.5;
		margin-left:-50px;
		padding:5px;
		border:1px solid #CCC;
		border-radius:3px;
		z-index:9999;
	}
	.joystick_left {
		float:left;
		background:url(view/image/go_left.png) no-repeat top center;
	}
	.joystick_right {
		float:right;
		background:url(view/image/go_right.png) no-repeat top center;
	}
	.joystick_left, .joystick_right {
		width:36px;
		height:36px;
		border:1px solid #F0F0F0;
		padding-bottom:2px;
	}
	.joystick_left:hover, .joystick_right:hover {
		border:1px solid #CCC;
		border-radius:3px;
		cursor:pointer;
	}
</style></div>
<?php echo $footer; ?>
