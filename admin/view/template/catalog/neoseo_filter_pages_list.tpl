<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<!-- NeoSeo Filter Page Generator - begin -->
				<?php if(isset($filter_page_generator)) { ?>
				<a href="<?php echo $filter_page_generator['href']; ?>" data-toggle="tooltip" title="<?php echo $filter_page_generator['name']; ?>" class="btn btn-default"><i class="fa fa-cog"></i> <?php echo $filter_page_generator['name']; ?></a>
				<?php } ?>
				<!-- NeoSeo Filter Page Generator - end -->
				<a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
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
						<label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
						<input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label class="control-label" for="input-name"><?php echo $entry_h1; ?></label>
						<input type="text" name="filter_h1" value="<?php echo $filter_h1; ?>" placeholder="<?php echo $entry_h1; ?>" id="input-name" class="form-control" />
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label class="control-label" for="input-status"><?php echo $entry_status; ?></label>
						<select name="filter_status" id="input-status" class="form-control">
							<option value="*"></option>
							<?php if ($filter_status) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<?php } ?>
							<?php if (!$filter_status && !is_null($filter_status)) { ?>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<label class="control-label" for="input-keyword"><?php echo $entry_keyword; ?></label>
						<input type="text" name="filter_keyword" value="<?php echo $filter_keyword; ?>" placeholder="<?php echo $entry_keyword; ?>" id="input-keyword" class="form-control" />
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label class="control-label" for="input-category"><?php echo $entry_category; ?></label>
						<select name="filter_category" id="input-category" class="form-control">
							<option value="*"></option>
							<?php foreach($categories as $category_id => $category_name){ ?>
							<option value="<?php echo $category_id; ?>" <?php if($filter_category == $category_id) { ?> selected="selected" <?php } ?>><?php echo $category_name; ?></option>
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
						<td class="text-left"><?php if ($sort == 'fpd.name') { ?>
							<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
							<?php } ?></td>
						<td class="text-left"><?php if ($sort == 'fpd.h1') { ?>
							<a href="<?php echo $sort_h1; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_h1; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_h1; ?>"><?php echo $column_h1; ?></a>
							<?php } ?></td>
						<td class="text-right"><?php echo $column_category; ?></td>
						<td class="text-right"><?php echo $column_options; ?></td>
						<td class="text-right"><?php echo $column_keyword; ?></td>
						<td class="text-right"><?php if ($sort == 'fp.status') { ?>
							<a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
							<?php } else { ?>
							<a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
							<?php } ?></td>
						<td class="text-right"><?php echo $column_action; ?></td>
					</tr>
					</thead>
					<tbody>
					<?php if ($pages) { ?>
					<?php foreach ($pages as $page) { ?>
					<tr>
						<td class="text-center"><?php if (in_array($page['page_id'], $selected)) { ?>
							<input type="checkbox" name="selected[]" value="<?php echo $page['page_id']; ?>" checked="checked" />
							<?php } else { ?>
							<input type="checkbox" name="selected[]" value="<?php echo $page['page_id']; ?>" />
							<?php } ?></td>
						<td class="text-left"><?php echo $page['name']; ?></td>
						<td class="text-left"><?php echo $page['h1']; ?></td>
						<td class="text-left"><?php echo $page['category']; ?></td>
						<td class="text-left"><?php echo $page['options']; ?></td>
						<td class="text-right"><?php echo $page['keyword']; ?></td>
						<td class="text-right"><?php echo $page['status']; ?></td>
						<td class="text-right">
							<a href="<?php echo $page['href']; ?>" target="_new" data-toggle="tooltip" title="" class="btn btn-success" data-original-title="<?php echo $button_view;?>"><i class="fa fa-eye"></i></a>
							<a href="<?php echo $page['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
							<button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? location = '<?php echo $page['delete']; ?>' : false;"><i class="fa fa-trash-o"></i></button>
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
		var url = 'index.php?route=catalog/neoseo_filter_pages&token=<?php echo $token; ?>';
		var filter_h1 = $('input[name=\'filter_h1\']').val();
		var filter_name = $('input[name=\'filter_name\']').val();

		if (filter_name) {
			url += '&filter_name=' + encodeURIComponent(filter_name);
		}

		if (filter_h1) {
			url += '&filter_h1=' + encodeURIComponent(filter_h1);
		}

		var filter_status = $('select[name=\'filter_status\']').val();

		if (filter_status != '*') {
			url += '&filter_status=' + encodeURIComponent(filter_status);
		}
		var filter_keyword = $('input[name=\'filter_keyword\']').val();

		if (filter_keyword) {
			url += '&filter_keyword=' + encodeURIComponent(filter_keyword);
		}

		var filter_category = $('select[name=\'filter_category\']').val();

		if (filter_category != '*') {
			url += '&filter_category=' + encodeURIComponent(filter_category);
		}


		location = url;
	});
	//--></script>
<script type="text/javascript"><!--
	$('input[name=\'filter_h1\']').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/neoseo_filter_pages/autocomplete&token=<?php echo $token; ?>&filter_h1=' + encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['h1'],
							value: item['page_id']
						}
					}));
				}
			});
		},
		'select': function(item) {
			$('input[name=\'filter_h1\']').val(item['label']);
		}
	});

	$('input[name=\'filter_keyword\']').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/neoseo_filter_pages/autocomplete&token=<?php echo $token; ?>&filter_keyword=' + encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['keyword'],
							value: item['page_id']
						}
					}));
				}
			});
		},
		'select': function(item) {
			$('input[name=\'filter_keyword\']').val(item['label']);
		}
	});
	//--></script>
<?php echo $footer; ?>