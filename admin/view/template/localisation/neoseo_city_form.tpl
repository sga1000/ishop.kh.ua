<?php echo $header; ?><?php echo $column_left; ?>
	<div id="content">
		<div class="page-header">
			<div class="container-fluid">
				<div class="pull-right">
					<button type="submit" form="form-city" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
					<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
				<h1><?php echo $heading_title; ?></h1>
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
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
				</div>
				<div class="panel-body">
					<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-city" class="form-horizontal">

						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-country"><?php echo $entry_country; ?></label>
							<div class="col-sm-10">
								<select id="country_id" name="country_id" id="input-country" class="form-control">
									<?php foreach ($countries as $country) { ?>
										<?php if ($country['country_id'] == $country_id) { ?>
											<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
										<?php } else { ?>
											<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
										<?php } ?>
									<?php } ?>
								</select>
							</div>

						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-country"><?php echo $entry_zone; ?></label>
							<div class="col-sm-10">
								<select name="zone_id" id="input-zone" class="form-control">
									<?php foreach ($zones as $zone) { ?>
										<?php if ($zone['zone_id'] == $zone_id) { ?>
											<option value="<?php echo $zone['zone_id']; ?>" selected="selected"><?php echo $zone['name']; ?></option>
										<?php } else { ?>
											<option value="<?php echo $zone['zone_id']; ?>"><?php echo $zone['name']; ?></option>
										<?php } ?>
									<?php } ?>
								</select>
							</div>
						</div>
						<div class="form-group required">
							<label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
							<div class="col-sm-10">

								<?php foreach ($languages as $language) { ?>
									<div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
										<input type="text" name="name[<?php echo $language['language_id']; ?>]" value="<?php echo isset($name[$language['language_id']]) ? $name[$language['language_id']] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
									</div>
									<?php if (isset($error_name[$language['language_id']])) { ?>
										<div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
									<?php } ?>
								<?php } ?>
							</div>
						</div>


						<div class="form-group">
							<label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
							<div class="col-sm-10">
								<select name="status" id="input-status" class="form-control">
									<?php if ($status) { ?>
										<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
										<option value="0"><?php echo $text_disabled; ?></option>
									<?php } else { ?>
										<option value="1"><?php echo $text_enabled; ?></option>
										<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
									<?php } ?>
								</select>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$('#country_id').on('change', function() {
			var country_id=$('#country_id').val();
			console.log(country_id);
			$.ajax({
				url: 'index.php?route=localisation/neoseo_city/reloadzones&token=' + getURLVar('token'),
				type: 'post',
				data: 'country_id=' + country_id<?php if ($zone_id) {?> + '&zone_id=' +<?php echo $zone_id; } ?>,
				dataType: 'html',
				success: function(html) {
					$('#input-zone').html(html);
					console.log('changed');
				}
			});
		});

	</script>

<?php echo $footer; ?>