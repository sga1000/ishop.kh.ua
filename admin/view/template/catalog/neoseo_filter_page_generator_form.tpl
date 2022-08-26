<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" name="action" value="save"  form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
				<button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
			</div>
			<img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
			<h1><?php echo $heading_title . " " . $text_module_version; ?></h1>
		</div>
		<div class="container-fluid">
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
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
						<?php $widgets->dropdown('category_id', $categories); ?>
						<div id="filter" class="form-group" style="display: inline-block; width: 100%;">
							<div style="display: inline-block; width: 100%; margin-bottom: 10px;">
								<div class="col-sm-12" style="margin-bottom: 10px;">
									<label class="control-label" style="text-decoration: underline;"><?php echo $entry_options; ?></label>
								</div>
							</div>
							<div id="filter">
								<div id="filter_placeholder" class="col-sm-12" style="margin-bottom: 10px;">
									<?php echo $text_empty_option; ?>
								</div>
								<div id="filter_options" style="display: flex; flex-wrap: wrap;">
								</div>
								<div style="margin-bottom: 10px;" class="text-right">
									<button type="button" onclick="$('#filter_options').find(':checkbox').prop('checked', true);"
										class="btn btn-primary"><i class="fa fa-pencil"></i> <?php echo $text_select_all; ?></button>
									<button type="button" onclick="$('#filter_options').find(':checkbox').prop('checked', false);"
										class="btn btn-danger"><i class="fa fa-trash-o"></i> <?php echo $text_unselect_all; ?>
									</button>
								</div>
							</div>
						</div>
						<?php $widgets->localeInput('pattern_name', $languages); ?>
						<?php $widgets->localeInput('pattern_title', $languages); ?>
						<?php $widgets->localeInput('pattern_meta_description', $languages); ?>
						<?php $widgets->localeInput('pattern_h1', $languages); ?>
						<?php $widgets->localeInput('pattern_url', $languages); ?>
						<?php $widgets->localeTextarea('pattern_description', $languages); ?>
						<?php $widgets->dropdown('use_direct_link', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
						<?php $widgets->dropdown('use_end_slash', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$('#category_id').change(function () {
		var category_id = $(this).val();
		if (!category_id) {
			$('#filter_placeholder').show();
			$('#filter_options').hide();
			$('#filter_options').html('');
		} else {
			$.ajax({
				url: '<?php echo html_entity_decode($category_options); ?>',
				type: 'post',
				data: 'category_id=' + encodeURIComponent(category_id) + '&options=' + encodeURIComponent('<?php echo $options; ?>'),
				success: function (data) {
					if (data.length > 1) {
						$('#filter_options').html(data);
						$('#filter_placeholder').hide();
						$('#filter_options').show();
					} else {
						$('#filter_placeholder').show();
						$('#filter_options').hide();
						$('#filter_options').html('');
					}
				},
				error: function () {
					$('#filter_placeholder').show();
					$('#filter_options').hide();
					$('#filter_options').html('');
				}
			});
		}
	});
	$('#category_id').trigger('change');
</script>

<?php echo $footer; ?>
