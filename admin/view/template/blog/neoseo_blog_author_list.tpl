<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
	<div class="page-header">
	<div class="container-fluid">
		<div class="pull-right">
		<a href="<?php echo $insert; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
		<button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-blog-author').submit() : false;"><i class="fa fa-trash-o"></i></button>
		<?php if (isset($found_user_view_all)) { ?>
		<a href="<?php echo $view_all_ticket; ?>" class="btn btn-primary" data-toggle="tooltip" title="<?php echo $button_view_all; ?>"><i class="fa fa-eye"></i></a>
		<?php } ?>
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
		<h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title_raw; ?></h3>
		</div>

		<div class="panel-body">
		<div class="well">
			<div class="row">
			<div class="col-sm-4">
				<div class="form-group">
				<label class="control-label" for="input-name"><?php echo $column_author_name; ?></label>
				<input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="<?php echo $column_author_name; ?>" id="input-name" class="form-control" />
				</div>
			</div>
			<div class="col-sm-4">
				<div class="form-group">
				<label class="control-label" for="input-date-added"><?php echo $column_date_added; ?></label>
				<div class="input-group date">
					<input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" placeholder="<?php echo $column_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
					<span class="input-group-btn">
					<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
					</span></div>
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
				<button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
			</div>
			</div>
		</div>
		<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-blog-author">
			<div class="table-responsive">
			<table class="table table-bordered table-hover">
				<thead>

				<tr>
					<td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>

					<td class="text-left">
					<?php if ($sort == 'ba.name') { ?>
					<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_author_name; ?></a>
					<?php } else { ?>
					<a href="<?php echo $sort_name; ?>"><?php echo $column_author_name; ?></a>
					<?php } ?>
					</td>

					<td class="text-left">
					<?php if ($sort == 'ba.status') { ?>
					<a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
					<?php } else { ?>
					<a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
					<?php } ?>
					</td>	

					<td class="text-right">
					<?php if ($sort == 'ba.date_added') { ?>
					<a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
					<?php } else { ?>
					<a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
					<?php } ?>
					</td>

					<td class="text-right"><?php echo $column_action; ?></td>
				</tr>

				</thead>

				<tbody>
				<?php if ($authors) { ?>
				<?php foreach ($authors as $author) { ?>
				<tr>
					<td class="text-center">
					<?php if (in_array($author['author_id'], $selected)) { ?>
					<input type="checkbox" name="selected[]" value="<?php echo $author['author_id']; ?>" checked="checked" />
					<?php } else { ?>
					<input type="checkbox" name="selected[]" value="<?php echo $author['author_id']; ?>" />
					<?php } ?>
					</td>

					<td class="text-left"><?php echo $author['name']; ?></td>
					<td class="text-left"><?php echo $author['status']; ?></td>
					<td class="text-right"><?php echo $author['date_added']; ?></td>
					<td class="text-right">
					<a href="<?php echo $author['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
					</td>
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
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-left"><?php echo $pagination; ?></div>
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-right"><?php echo $results; ?></div>
		</div>
		</div>    
	</div>        
	</div>        
</div>   
<script type="text/javascript"><!--
$('#button-filter').on('click', function () {
	var url = 'index.php?route=blog/neoseo_blog_author&token=<?php echo $token; ?>';

	var filter_name = $('input[name=\'filter_name\']').val();

	if (filter_name) {
		url += '&filter_name=' + encodeURIComponent(filter_name);
	}

	var filter_date_added = $('input[name=\'filter_date_added\']').val();

	if (filter_date_added) {
		url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
	}

	var filter_status = $('select[name=\'filter_status\']').val();

	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}

	location = url;
	});
//--></script>
<script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
<script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
	});
//--></script>
<?php echo $footer; ?>