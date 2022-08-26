<?php echo $header; ?><?php echo $column_left; ?>
	<div id="content">
		<div class="page-header">
			<div class="container-fluid">
				<div class="pull-right">
					<a href="<?php echo $refresh; ?>" data-toggle="tooltip" title="<?php echo $button_refresh; ?>" class="btn btn-default"><i class="fa fa-refresh"></i></a>
					<a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
					<button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-city').submit() : false;"><i class="fa fa-trash-o"></i></button>
				</div>
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
					<div class="well">
						<div class="row">
							<div class="col-sm-12 col-md-4">
								<div class="form-group">
									<label class="control-label" for="input-status"><?php echo $column_country; ?></label>
									<select  name="filter_country" id="input-country" class="form-control">
										<option value="*"></option>
										<?php foreach ($countries as $country) { ?>
											<?php // if ($country['city_count'] >= 1) { ?>
											<?php if ($country['country_id']==$filter_country) { ?>
												<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
											<?php } else { ?>
												<option value="<?php echo $country['country_id']; ?>">&nbsp;&nbsp;<?php echo $country['name']; ?></option>
											<?php } ?>
											<?php // } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="col-sm-12 col-md-4">
								<div class="form-group">
									<label class="control-label" for="input-status"><?php echo $column_zone; ?></label>
									<select name="filter_zone" id="input-zone" class="form-control">
										<option value="*"></option>
										<?php foreach ($zones as $zone) { ?>
											<?php //  if ($zone['city_count'] >= 1) { ?>
											<?php if ($zone['zone_id']==$filter_zone) { ?>
												<option value="<?php echo $zone['zone_id']; ?>" selected="selected"><?php echo $zone['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
											<?php } else { ?>
												<option value="<?php echo $zone['zone_id']; ?>">&nbsp;&nbsp;<?php echo $zone['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
											<?php } ?>
											<?php //  } ?>
										<?php } ?>
									</select>
								</div>
							</div>
							<div class="col-sm-12 col-md-4">
								<div class="form-group">
									<label class="control-label" for="input-name"><?php echo $column_name; ?></label>
									<input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 text-right">
								<button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
							</div>
						</div>
					</div>


					<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-city">
						<div class="table-responsive">
							<table class="table table-bordered table-hover">
								<thead>
								<tr>
									<td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
									<td class="text-left"><?php if ($sort == 'c.name') { ?>
											<a href="<?php echo $sort_country; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_country; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_country; ?>"><?php echo $column_country; ?></a>
										<?php } ?></td>
									<td class="text-left"><?php if ($sort == 'z.name') { ?>
											<a href="<?php echo $sort_zone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_zone; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_zone; ?>"><?php echo $column_zone; ?></a>
										<?php } ?></td>
									<td class="text-left"><?php if ($sort == 'cd.name') { ?>
											<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
										<?php } else { ?>
											<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
										<?php } ?></td>

									<td class="text-right"><?php echo $column_action; ?></td>
								</tr>
								</thead>
								<tbody>
								<?php if ($cities) { ?>
									<?php foreach ($cities as $city) { ?>
										<tr>
											<td class="text-center"><?php if (in_array($city['city_id'], $selected)) { ?>
													<input type="checkbox" name="selected[]" value="<?php echo $city['city_id']; ?>" checked="checked" />
												<?php } else { ?>
													<input type="checkbox" name="selected[]" value="<?php echo $city['city_id']; ?>" />
												<?php } ?></td>
											<td class="text-left"><?php echo $city['country']; ?></td>
											<td class="text-left"><?php echo $city['zone']; ?></td>
											<td class="text-left"><?php echo $city['name']; ?></td>
											<!-- todo: Добавить на кнопку удаления подтверждение -->
											<td class="text-right"><a href="<?php echo $city['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a> <a href="<?php echo $city['delete']; ?>" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></a></td>
										</tr>
									<?php } ?>
								<?php } else { ?>
									<tr>
										<td class="text-center" colspan="5"><?php echo $text_no_results; ?></td>
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
		</div>
	</div>
	<script type="text/javascript">
		$('#input-country').on('change', function() {
			var country_id=$('#input-country').val();
			console.log(country_id);
			$.ajax({
				url: 'index.php?route=localisation/neoseo_city/reloadzones&token=' + getURLVar('token'),
				type: 'post',
				data: 'country_id=' + country_id + '&fromlist=1'<?php if ($filter_zone) {?> + '&zone_id=' +<?php echo $filter_zone; } ?>,
				dataType: 'html',
				success: function(html) {
					var zonelist = '<option value="*"></option>' + html;
					$('#input-zone').html(zonelist);
					console.log('changed');
				}
			});
		});

		$('#button-filter').on('click', function() {
			var url = 'index.php?route=localisation/neoseo_city&token=<?php echo $token; ?>';

			var filter_name = $('input[name=\'filter_name\']').val();

			if (filter_name) {
				url += '&filter_name=' + encodeURIComponent(filter_name);
			}

			var filter_country = $('select[name=\'filter_country\']').val();

			if (filter_country != '*') {
				url += '&filter_country=' + encodeURIComponent(filter_country);
			}

			var filter_zone = $('select[name=\'filter_zone\']').val();

			if (filter_zone != '*') {
				url += '&filter_zone=' + encodeURIComponent(filter_zone);
			}


			location = url;
		});
	</script>


<?php echo $footer; ?>