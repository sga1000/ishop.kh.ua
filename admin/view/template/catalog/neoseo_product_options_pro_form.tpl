<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-option" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
		<?php } elseif($error_no_options) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_no_options; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } elseif($error_duplicate) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_duplicate; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-option" class="form-horizontal">
					<div class="form-group required">
						<label class="col-sm-3 control-label"><?php echo $entry_name; ?></label>
						<div class="col-sm-9">
							<?php foreach ($languages as $language) { ?>
							<div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
								<input type="text" name="option_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($option_description[$language['language_id']]) ? $option_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
							</div>
							<?php if (isset($error_name[$language['language_id']])) { ?>
							<div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
							<?php } ?>
							<?php } ?>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-3 control-label" for="input-status"><?php echo $entry_status; ?></label>
						<div class="col-sm-9">
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
					<div class="form-group">
						<label class="col-sm-3 control-label" for="input-status"><?php echo $entry_status_image; ?></label>
						<div class="col-sm-9">
							<select name="status_image" id="input-status" class="form-control">
								<?php if ($status_image) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
						<div class="col-sm-9">
							<input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
						</div>
					</div>
					<table id="option-related" class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<td class="text-left required"><?php echo $entry_option; ?></td>
								<td class="text-right"><?php echo $entry_sort_order; ?></td>
								<td></td>
							</tr>
						</thead>
						<tbody>
							<?php $option_related_row = 0; ?>
							<?php foreach ($option_relateds as $option_related) { ?>
							<tr id="option-related-row<?php echo $option_related_row; ?>">
								<td>
									<select name="option_related[<?php echo $option_related_row; ?>][option_related_id]" class="form-control">
										<?php foreach ($options as $option) { ?>
										<?php if ($option['option_id'] == $option_related['option_id']) { ?>
										<option value="<?php echo $option['option_id'] ?>" selected="selected"><?php echo $option['name']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $option['option_id'] ?>"><?php echo $option['name']; ?></option>
										<?php } ?>
										<?php } ?>
									</select>
								</td>
								<td class="text-right"><input type="text" name="option_related[<?php echo $option_related_row; ?>][sort_order]" value="<?php echo $option_related['sort_order']; ?>" class="form-control" /></td>
								<td>
									<button type="button" onclick="$('#option-related-row<?php echo $option_related_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger">
										<i class="fa fa-minus-circle"></i>
									</button>
								</td>
								<?php $option_related_row++; ?>
								<?php } ?>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2"></td>
								<td class="text-left"><button type="button" onclick="addOptionRelated();" data-toggle="tooltip" title="<?php echo $button_option_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
							</tr>
						</tfoot>
					</table>

				</form>
			</div>
		</div>
	</div>
  <script type="text/javascript"><!--
$('select[name=\'type\']').on('change', function() {
	if (this.value == 'related') {
		$('#option-related').show();
	} else {
		$('#option-related').hide();
	}
});

$('select[name=\'type\']').trigger('change');

var option_related_row = <?php echo $option_related_row; ?>;

function addOptionRelated() {
	html  = '<tr id="option-related-row' + option_related_row + '">';	
    html += '  <td class="text-left">';
	html += '  <select name="option_related[' + option_related_row + '][option_related_id]" class="form-control">' + '<?php echo $options_list; ?>' + '</select>';
	html += '  </td>';
	html += '  <td class="text-right"><input type="text" name="option_related[' + option_related_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
	html += '  <td class="text-left"><button type="button" onclick="$(\'#option-related-row' + option_related_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';	
	
	$('#option-related tbody').append(html);
	
	option_related_row++;
}
//--></script>
</div>
<?php echo $footer; ?>