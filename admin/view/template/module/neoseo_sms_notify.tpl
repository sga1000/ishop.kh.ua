<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_sms_notify_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

<div id="content">

	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if( !isset($license_error) ) { ?>
					<a onclick="$('#form').attr('action', '<?php echo $save; ?>'); $('#form').submit();" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></a>
					<a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>'); $('#form').submit();" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></a>
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
					<?php if( !isset($license_error) ) { ?>
						<li><a href="#tab_admin_notify" data-toggle="tab"><?php echo $tab_admin_notify; ?></a></li>
						<li><a href="#tab_templates" data-toggle="tab"><?php echo $tab_templates; ?></a></li>
						<li><a href="#tab_review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
						<li><a href="#tab-fields" data-toggle="tab"><?php echo $tab_fields; ?></a></li>
						<li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
					<?php } ?>
					<li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
					<li><a href="#tab-usefull" data-toggle="tab"><?php echo $tab_usefull; ?></a></li>
					<li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
				</ul>

				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">

							<?php if( !isset($license_error) ) { ?>

								<?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
								<?php $widgets->input('align'); ?>
								<?php $widgets->dropdown('sms_gatenames', $sms_gatenames); ?>
								<?php $widgets->input('gate_login'); ?>
								<?php $widgets->input('gate_password'); ?>
								<?php $widgets->input('gate_sender'); ?>
								<?php $widgets->textarea('gate_additional'); ?>
								<?php $widgets->checklist('customer_group', $customer_groups); ?>

								<h3><?php echo $entry_gate_check; ?></h3>

								<table class="table table-striped table-hover " id="items-table">
									<tbody >

									<tr>
										<td class="col-xs-6"><?php echo $entry_gate_check_phone; ?></td>
										<td class="col-xs-6"><?php echo $entry_gate_check_message; ?></td>
									</tr>
									<tr>
										<td class="col-xs-4"> <input class='form-control' id="phone" value=""/></td>
										<td class="col-xs-4"> <input class='form-control' id="message" value=""/></td>
										<td class="col-xs-4"> <button id="gate_test_button" class="btn" onclick="checkGate();
											return false;"><?php echo $entry_gate_check; ?></button></td>
									</tr>
									</tbody>
								</table>
							<?php } else { ?>

								<?php echo $license_error; ?>

							<?php } ?>

						</div>

						<?php if( !isset($license_error) ) { ?>

						<div class="tab-pane" id="tab_admin_notify">

							<?php $widgets->input('recipients'); ?>
							<?php $widgets->checklist('admin_notify_type', $field_admin_notify_types); ?>
							<?php $widgets->input('telegram_api_key'); ?>
							<?php $widgets->input('telegram_chat_id'); ?>

						</div>

						<div class="tab-pane" id="tab_templates">

								<table class="table table-striped table-hover" id="items-table">
									<thead>

									<th><?php echo $column_status_name; ?></th>
									<th><?php echo $column_status; ?></th>
									<th><?php echo $column_template_subject; ?></th>

									</thead>
									<tbody>
									<?php foreach($neoseo_sms_notify_templates as $id => $template_data) {?>
										<tr>
											<td class="col-xs-2"><?php echo "{$id}. " . $template_data["name"] ?></td>
											<td class="col-xs-2">
												<?php foreach ($languages as $language) { ?>
													<select class="form-control" name="neoseo_sms_notify_templates[<?php echo $id; ?>][<?php echo $language['language_id']; ?>][status]">
														<option value="0"><?php echo $text_disabled; ?></option>
														<option value="1" <?php if( 1 == $template_data[$language['language_id']]['status'] ) { ?> selected="selected" <?php } ?> ><?php echo $text_enabled;?></option>
														<option value="2" <?php if( 2 == $template_data[$language['language_id']]['status'] ) { ?> selected="selected" <?php } ?> ><?php echo $text_force;?></option>
													</select>
												<?php } ?>
												<select class="form-control" name="neoseo_sms_notify_templates[<?php echo $id; ?>][0][status]">
													<option value="0"><?php echo $text_disabled; ?></option>
													<option value="1" <?php if( 1 == $template_data[0]['status'] ) { ?> selected="selected" <?php } ?> ><?php echo $text_enabled;?></option>
													<option value="2" <?php if( 2 == $template_data[0]['status'] ) { ?> selected="selected" <?php } ?> ><?php echo $text_force;?></option>
												</select>
											</td>
											<td class="col-xs-8">
												<?php foreach ($languages as $language) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"/></span>
													<textarea rows="1" name="neoseo_sms_notify_templates[<?php echo $id; ?>][<?php echo $language['language_id']; ?>][subject]" id="<?php echo "neoseo_sms_notify_templates_" . $id . "_" . $language['language_id'] ; ?>" class="form-control" /><?php echo $template_data[$language['language_id']]['subject']; ?></textarea>
												</div>
												<?php } ?>
												<div class="input-group">
													<span class="input-group-addon"><i class="fa fa-cogs" aria-hidden="true" style="width:16px"></i></span>
													<textarea rows="1" name="neoseo_sms_notify_templates[<?php echo $id; ?>][0][subject]" id="<?php echo "neoseo_sms_notify_templates_" . $id . "_0"; ?>" class="form-control" /><?php echo $template_data[0]['subject']; ?></textarea>
												</div>
											</td>
										</tr>
									<?php } ?>
									</tbody>
								</table>
							</div>
							<div class="tab-pane" id="tab_review">
								<?php $widgets->dropdown('review_status', array(0 => $text_disabled, 1 => $text_enabled)); ?>
								<?php $widgets->textarea('review_notification_message'); ?>
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
						<div class="tab-pane" id="tab-usefull">
							<?php $widgets->usefullLinks(); ?>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
	window.token = '<?php echo $token; ?>';
	var gate = "#neoseo_sms_notify_sms_gatenames";
	var login = "#neoseo_sms_notify_gate_login";
	var password = "#neoseo_sms_notify_gate_password";
	var sender = "#neoseo_sms_notify_gate_sender";
	var additional = "#neoseo_sms_notify_gate_additional";
	var phone = "#items-table #phone";
	var message = "#items-table #message";
	var customer_group = $('[name="neoseo_sms_notify_customer_group[]"]:checked');

	function checkGate() {
		var data = {
			gate: $(gate).val(),
			login: $(login).val(),
			password: $(password).val(),
			sender: $(sender).val(),
			additional: $(additional).val(),
			phone: $(phone).val(),
			message: $(message).val(),
            customer_group: customer_group.map(function() {return this.value;}).get(),
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

				if (json['status'])
					alert('Сообщение отправлено успешно');
				else
					alert('При отправке сообщения произошла ошибка');
			}
		});
	}
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
//--></script>
<?php echo $footer; ?>