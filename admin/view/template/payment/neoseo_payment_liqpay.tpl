<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">

	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if( !isset($license_error) ) { ?>
				<button type="submit" name="action" value="save" form="form" data-toggle="tooltip"
						title="<?php echo $button_save; ?>" class="btn btn-primary"><i
							class="fa fa-save"></i> <?php echo $button_save; ?></button>
				<button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip"
						title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i
							class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
				<?php } else { ?>
				<a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"
				   class="btn btn-primary"/><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
				<?php } ?>
				<a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>"
				   class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
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
					<li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
					<?php } ?>
					<li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
					<li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
				</ul>

				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">
							<?php if (!isset($license_error)) { ?>

							<?php $widgets->dropdown('status', array(0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->input('merchant'); ?>
							<?php $widgets->input('signature'); ?>
							<?php $widgets->dropdown('type', array('liqpay' => $text_pay, 'card' => $text_card)); ?>
							<?php $widgets->input('total'); ?>
							<?php $widgets->dropdown('hold', array(0 => $text_off, 1 => $text_on)); ?>
							<?php $widgets->dropdown('hold_order_status_id', $order_statuses); ?>
							<?php $widgets->dropdown('order_status_id', $order_statuses); ?>
							<?php $widgets->dropdown('missing_order_status_id', $order_statuses); ?>
							<?php $widgets->dropdown('geo_zone_id', $geo_zones); ?>
							<?php $widgets->input('sort_order'); ?>
							<?php $widgets->dropdown('cron_status', array(0 => $text_disabled, 1 => $text_enabled)); ?>

							<div class="form-group field_liqpay_cron">
								<div class="col-sm-2">
									<label class="control-label"><?php echo $text_cron_information; ?></label>
								</div>
								<div class="col-sm-10">
									<?php foreach (range(1, 7) as $day_id) { ?>
									<div class="col-sm-12 form-group">
										<div class="col-sm-3 text-right">
											<label class="control-label"><?php echo isset($param_days_week[$day_id]) ? $param_days_week[$day_id] : '' ; ?></label>
										</div>
										<div class="col-sm-9">
											<div class="col-sm-1 text-right">
												<label class="control-label" for="liqpay_cron_from_<?php echo $day_id ?>"><?php echo $text_from;?></label>
											</div>
											<div class="col-sm-5">
												<div class="input-group time">
													<input name="neoseo_payment_liqpay_cron[<?php echo $day_id ?>][from]" id="liqpay_cron_from_<?php echo $day_id ?>"  value="<?php echo $neoseo_payment_liqpay_cron[$day_id]['from']?>" class="form-control" data-format="hh:mm:ss"/>
													<span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-clock-o"></i></button>
                                            </span>
												</div>
											</div>
											<div class="col-sm-1 text-right">
												<label class="control-label" for="liqpay_cron_to_<?php echo $day_id ?>"><?php echo $text_to;?></label>
											</div>
											<div class="col-sm-5">
												<div class="input-group time">
													<input name="neoseo_payment_liqpay_cron[<?php echo $day_id ?>][to]" id="liqpay_cron_to_<?php echo $day_id ?>"  value="<?php echo $neoseo_payment_liqpay_cron[$day_id]['to']?>" class="form-control"/>
													<span class="input-group-btn">
                                            <button type="button" class="btn btn-default"><i class="fa fa-clock-o"></i></button>
                                            </span>
												</div>
											</div>
										</div>
									</div>
									<?php } ?>
								</div>
								<div class="col-sm-13 text-left">
									<?php $widgets->textarea('non_working_days');?>
								</div>
							</div>
							<?php } else { ?>
							<?php echo $license_error; ?>
							<?php } ?>
						</div>
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
	$(function(){
		toggleCron($('[name=neoseo_payment_liqpay_cron_status]').val());
	});

	$('[name=neoseo_payment_liqpay_cron_status]').change(function(e) {
		toggleCron($(this).val());
	});

	function toggleCron(value){
		if(value == 1){console.log(value);
		$('.field_liqpay_cron').show();
		}else{
			$('.field_liqpay_cron').hide();
		}
	}
	<?php foreach (range(1, 7) as $day_id) { ?>
		$('#liqpay_cron_from_<?php echo $day_id; ?>').on('change', function(){
			if($(this).val() == ''){
				$(this).val('00:00');
			}
		});
		$('#liqpay_cron_to_<?php echo $day_id; ?>').on('change', function(){
			if($(this).val() == ''){
				$(this).val('23:59');
			}
		});
	<?php } ?>
	$('.time').datetimepicker({
		pickDate: false
	});
	//--></script>
<?php echo $footer; ?>




