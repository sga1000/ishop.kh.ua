<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
	<div class="page-header">
	<div class="container-fluid">
		<div class="pull-right">
		<a href="<?php echo $insert; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
		<button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-blog-comment').submit() : false;"><i class="fa fa-trash-o"></i></button>
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
				<label class="control-label" for="input-name"><?php echo $column_article_name; ?></label>
				<input type="text" name="filter_article" value="<?php echo $filter_article; ?>" placeholder="<?php echo $column_article_name; ?>" id="input-name" class="form-control" />
				</div>
			</div>
			<div class="col-sm-4">
				<div class="form-group">
				<label class="control-label" for="input-name"><?php echo $column_author_name; ?></label>
				<input type="text" name="filter_author" value="<?php echo $filter_author; ?>" placeholder="<?php echo $column_author_name; ?>" id="input-name" class="form-control" />
				</div>
			</div>
			<div class="col-sm-2">
				<div class="form-group">
				<label class="control-label" for="input-date-added"><?php echo $column_date_added; ?></label>
				<div class="input-group date">
					<input type="text" name="filter_date_added" value="<?php echo $filter_date_added; ?>" placeholder="<?php echo $column_date_added; ?>" data-date-format="YYYY-MM-DD" id="input-date-added" class="form-control" />
					<span class="input-group-btn">
					<button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
					</span></div>
				</div>
			</div>
			<div class="col-sm-2">
				<div class="form-group">
				<label class="control-label" for="input-status"><?php echo $column_status; ?></label>
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
		<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-blog-comment">
			<div class="table-responsive">
			<table class="table table-bordered table-hover">
				<thead>

				<tr>
					<td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>

					<td class="text-left">
						<?php echo $column_comment; ?>
					</td>

					<td class="text-left">
						<?php if ($sort == 'bc.author_name') { ?>
						<a href="<?php echo $sort_author_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_author_name; ?></a>
						<?php } else { ?>
						<a href="<?php echo $sort_author_name; ?>"><?php echo $column_author_name; ?></a>
						<?php } ?>
					</td>


					<td class="text-left">
						<?php if ($sort == 'bc.status') { ?>
						<a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
						<?php } else { ?>
						<a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
						<?php } ?>
					</td>

					<td class="text-right">
						<?php if ($sort == 'bc.date_added') { ?>
						<a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
						<?php } else { ?>
						<a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
						<?php } ?>
					</td>

					<td class="text-left">
					<?php if ($sort == 'bad.name') { ?>
					<a href="<?php echo $sort_article_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_article_name; ?></a>
					<?php } else { ?>
					<a href="<?php echo $sort_article_name; ?>"><?php echo $column_article_name; ?></a>
					<?php } ?>
					</td>



					<td class="text-right"><?php echo $column_action; ?></td>
				</tr>

				</thead>

				<tbody>
				<?php if ($comments) { ?>
				<?php foreach ($comments as $comment) { ?>
				<tr>
					<td class="text-center">
					<?php if (in_array($comment['article_id'], $selected)) { ?>
					<input type="checkbox" name="selected[]" value="<?php echo $comment['comment_id']; ?>" checked="checked" />
					<?php } else { ?>
					<input type="checkbox" name="selected[]" value="<?php echo $comment['comment_id']; ?>" />
					<?php } ?>
					</td>
					<td class="text-left"><?php echo $comment['comment']; ?></td>
					<td class="text-left"><?php echo $comment['author_name']; ?></td>
					<td class="text-left"><?php echo $comment['status']; ?></td>
					<td class="text-right"><?php echo $comment['date_added']; ?></td>
					<td class="text-left"><?php echo $comment['name']; ?></td>
					<td class="text-right">
					<a href="<?php echo $comment['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
					</td>
				</tr>
				<?php } ?>
				<?php } else { ?>
				<tr>
					<td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
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
	var url = 'index.php?route=blog/neoseo_blog_comment&token=<?php echo $token; ?>';

	var filter_article = $('input[name=\'filter_article\']').val();

	if (filter_article) {
		url += '&filter_article=' + encodeURIComponent(filter_article);
	}

	var filter_author = $('input[name=\'filter_author\']').val();

	if (filter_author) {
		url += '&filter_author=' + encodeURIComponent(filter_author);
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