<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
				<button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-download').submit() : false;"><i class="fa fa-trash-o"></i></button>
			</div>
			<img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
			<h1><?php echo $heading_title . " " . $text_module_version; ?></h1>
		</div>
		<?php if( false ) { ?>
		<div class="container-fluid">
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
		<?php } ?>
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

		<div class="well">
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<label class="control-label" for="input-option-name"><?php echo $entry_option_name; ?></label>
						<input type="text" name="filter_option_name" value="<?php echo $filter_option_name; ?>" placeholder="<?php echo $entry_option_name; ?>" id="input-option-name" class="form-control" />
					</div>
					<div class="form-group">
						<label class="control-label" for="input-option-status"><?php echo $entry_option_status; ?></label>
						<select name="filter_option_status" id="input-option-status" class="form-control">
							<option value="*"></option>
							<?php if ($filter_option_status) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<?php } ?>
							<?php if (!$filter_option_status && !is_null($filter_option_status)) { ?>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label class="control-label" for="input-option-category"><?php echo $entry_option_category; ?></label>
						<select name="filter_option_category" id="input-option-category" class="form-control">
							<option value="*"></option>
							<?php foreach ($categories as $category) { ?>
							<?php if ($category['category_id']==$filter_option_category) { ?>
							<option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
							<?php } else { ?>
							<option value="<?php echo $category['category_id']; ?>">&nbsp;&nbsp;<?php echo $category['name']; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
							<?php } ?>
							<?php } ?>
						</select>
					</div>
					<div class="form-group">
						<label class="control-label" for="input-option-keyword"><?php echo $entry_option_keyword; ?></label>
						<input type="text" name="filter_option_keyword" value="<?php echo $filter_option_keyword; ?>" placeholder="<?php echo $entry_option_keyword; ?>" id="input-option-keyword" class="form-control" />
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label class="control-label" for="input-option-type"><?php echo $entry_option_type; ?></label>
						<select name="filter_option_type" id="input-option-type" class="form-control">
							<option value="*"></option>
							<?php foreach ($option_type as $type => $name_type) { ?>
							<?php if ($type==$filter_option_type) { ?>
							<option value="<?php echo $type; ?>" selected="selected"><?php echo $name_type; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
							<?php } else { ?>
							<option value="<?php echo $type; ?>">&nbsp;&nbsp;<?php echo $name_type; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
							<?php } ?>
							<?php } ?>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
				</div>
			</div>
		</div>

		<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-download">
			<div class="table-responsive">
				<table class="table table-bordered table-hover">
					<thead>
					<tr>
						<td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
						<td class="text-left"><?php if ($sort == 'fod.name') { ?>
							<a href="<?php echo $sort_option_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_option_name; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_option_name; ?>"><?php echo $column_option_name; ?></a>
							<?php } ?></td>
						<td class="text-left"><?php echo $column_option_value_name; ?></td>
						<td class="text-left"><?php echo $column_option_categories; ?></td>
						<td class="text-left"><?php if ($sort == 'fo.type') { ?>
							<a href="<?php echo $sort_option_type; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_option_type; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_option_type; ?>"><?php echo $column_option_type; ?></a>
							<?php } ?></td>
						<td class="text-left"><?php if ($sort == 'fo.sort_order') { ?>
							<a href="<?php echo $sort_option_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_option_sort_order; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_option_order; ?>"><?php echo $column_option_sort_order; ?></a>
							<?php } ?></td>
						<td class="text-left"><?php if ($sort == 'fo.status') { ?>
							<a href="<?php echo $sort_option_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_option_status; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_option_status; ?>"><?php echo $column_option_status; ?></a>
							<?php } ?></td>
						<td class="text-right"><?php echo $column_action; ?></td>
					</tr>
					</thead>
					<tbody>
					<?php if ($options) { ?>
					<?php foreach ($options as $option) { ?>
					<tr>
						<td class="text-center"><?php if (in_array($option['option_id'], $selected)) { ?>
							<input type="checkbox" name="selected[]" value="<?php echo $option['option_id']; ?>" checked="checked" />
							<?php } else { ?>
							<input type="checkbox" name="selected[]" value="<?php echo $option['option_id']; ?>" />
							<?php } ?></td>
						<td class="text-left"><?php echo $option['name']; ?></td>
						<td class="text-left">
							<?php
								echo implode(", ", array_slice($option['option_values'],0,5));
								if( count($option['option_values']) > 5 ) {
							echo " и еще " . ( count($option['option_values']) - 5 );
							}
							?>
						</td>
						<td class="text-left">
							<?php
								echo implode(", ", array_slice($option['categories'],0,5));
								if( count($option['categories']) > 5 ) {
							echo " и еще " . ( count($option['categories']) - 5 );
							}
							?>
						</td>
						<td class="text-left"><?php echo isset($option_type[$option['type']]) ? $option_type[$option['type']] : ''; ?></td>
						<td class="text-right"><?php echo $option['sort_order']; ?></td>
						<td class="text-center"><?php echo $option['status']; ?></td>
						<td class="text-right">
							<a href="<?php echo $option['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
							<button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? location = '<?php echo $option['delete']; ?>' : false;"><i class="fa fa-trash-o"></i></button>
						</td>
					</tr>
					<?php } ?>
					<?php } else { ?>
					<tr>
						<td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
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
<script type="text/javascript"><!--
	$('#button-filter').on('click', function() {
		var url = 'index.php?route=catalog/neoseo_filter&token=<?php echo $token; ?>';
		var filter_option_name = $('input[name=\'filter_option_name\']').val();

		if (filter_option_name) {
			url += '&filter_option_name=' + encodeURIComponent(filter_option_name);
		}

		var filter_option_status = $('select[name=\'filter_option_status\']').val();

		if (filter_option_status != '*') {
			url += '&filter_option_status=' + encodeURIComponent(filter_option_status);
		}

		var filter_option_type = $('select[name=\'filter_option_type\']').val();

		if (filter_option_type != '*') {
			url += '&filter_option_type=' + encodeURIComponent(filter_option_type);
		}


		var filter_option_category = $('select[name=\'filter_option_category\']').val();

		if (filter_option_category != '*') {
			url += '&filter_option_category=' + encodeURIComponent(filter_option_category);
		}

		var filter_option_keyword = $('input[name=\'filter_option_keyword\']').val();

		if (filter_option_keyword) {
			url += '&filter_option_keyword=' + encodeURIComponent(filter_option_keyword);
		}


		location = url;
	});
	//--></script>
<script type="text/javascript"><!--
	$('input[name=\'filter_option_name\']').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/neoseo_filter/autocomplete&token=<?php echo $token; ?>&filter_option_name=' + encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['name'],
							value: item['option_id']
						}
					}));
				}
			});
		},
		'select': function(item) {
			$('input[name=\'filter_option_name\']').val(item['label']);
		}
	});

	$('input[name=\'filter_option_keyword\']').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/neoseo_filter/autocomplete&token=<?php echo $token; ?>&filter_option_keyword=' + encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['keyword'],
							value: item['option_id']
						}
					}));
				}
			});
		},
		'select': function(item) {
			$('input[name=\'filter_option_keyword\']').val(item['label']);
		}
	});
	//--></script>
<?php echo $footer; ?>