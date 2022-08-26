<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
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
						<div class="tab-pane active" id="tab-general">

							<?php $widgets->dropdown('option_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('option_open',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('option_style', $option_styles); ?>
							<?php $widgets->dropdown('option_type', $option_types); ?>
							<?php $widgets->dropdown('option_after_manufacturer', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->localeInput('option_name', $languages); ?>
							<?php $widgets->localeInput('option_keyword', $languages); ?>
							<?php $widgets->input('option_sort_order'); ?>
							<?php $widgets->dropdown('option_sort_order_direction', $option_direction_sorting); ?>
							<div class="form-group" id="field_option_category" style="display: inline-block; width: 100%;">
								<div class="col-sm-5">
									<label class="control-label" for="option_category"><?php echo $entry_option_category; ?></label>
									<br>
									<?php if (isset($entry_option_category_desc))
									echo $entry_option_category_desc;
									?>
								</div>
								<div class="col-sm-7">
									<input class="form-control filter" placeholder="<?php echo $text_action;?>">
									<div class="well well-sm" style="min-height: 150px;max-height: 400px;overflow: auto;">
										<?php $class = 'odd'; ?>
										<?php foreach( $categories as $category) { ?>
										<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
										<div class="<?php echo $class; ?>">
											<label><input class="category" type="checkbox" name="option_categories[]"
														  value="<?php echo $category['category_id'];?>"
														  data="<?php echo $category['name'];?>" <?php if (in_array($category['category_id'], $option_categories)) { ?> checked  <?php } ?>/>
												<?php echo $category['name'];?></label>
										</div>
										<?php } ?>
									</div>
									<a onclick="$(this).parent().find(':checkbox:visible').prop('checked', true);" class="btn btn-primary"><?php echo $text_select_all; ?></a>
									<a onclick="$(this).parent().find(':checkbox').prop('checked', false);" class="btn btn-danger" ><?php echo $text_unselect_all; ?></a>

								</div>
							</div>
							<h1 class="bg-info text-center"><?php echo $text_option_value; ?></h1>
							<div class='form-group'>
								<div class="container-fluid" style="margin-bottom: 10px; padding-right: 0px;">
									<div class="pull-right">
										<button type="button" onclick="addOptionValue();" data-toggle="tooltip" title="<?php echo $button_option_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_option_value_add; ?></button>
										<button type="button" onclick="confirm('<?php echo $text_confirm_delete; ?>')? $('[id^=option-value-row]').remove() : false;" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></button>
									</div>
								</div>
								<div class="table-responsive">
									<table id="option-value" class="table table-striped table-bordered table-hover">
										<thead>
										<tr>
											<td class="text-center"><?php echo $column_option_value_name; ?></td>
											<td class="text-center use_image" <?php if($option_style != 'image') { ?> style='display:none;' <?php } ?>><?php echo $column_option_value_image; ?></td>
											<td class="text-center use_image" <?php if($option_style != 'image') { ?> style='display:none;' <?php } ?>><?php echo $column_option_value_position_image; ?></td>
											<td class="text-center use_color" <?php if($option_style != 'color') { ?> style='display:none;' <?php } ?>><?php echo $column_option_value_color; ?></td>
											<td class="text-center"><?php echo $column_option_value_keyword; ?></td>
											<td class="text-center"><?php echo $column_option_value_sort_order; ?></td>
											<td><?php echo $column_action; ?></td>
										</tr>
										</thead>
										<tbody>
										<?php $option_value_row = 0; ?>
										<?php if($option_values){ ?>
										<?php foreach ($option_values as $option_value_id => $option_value) { ?>
										<tr id="option-value-row<?php echo $option_value_row; ?>">
											<td class="text-right">
												<?php foreach($languages as $language) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"></span>
													<input name="option_values[<?php echo $option_value_row; ?>][name][<?php echo $language['language_id']; ?>]"  class="form-control" id="option-value-name-<?php echo $language['language_id'].'-'.$option_value_row; ?>" value="<?php echo isset($option_value['name'][$language['language_id']]) ? $option_value['name'][$language['language_id']] : '' ; ?>">
												</div>
												<?php if (isset($error_option_value_name[$option_value_row][$language['language_id']])) { ?>
												<div class="text-danger text-center"><?php echo $error_option_value_name[$option_value_row][$language['language_id']]; ?></div>
												<?php } ?>
												<?php } ?>

												<?php if (!empty($option_value['option_value_id'])){ ?>
												<input name="option_values[<?php echo $option_value_row; ?>][option_value_id]" type="hidden" class="form-control" value="<?php echo $option_value['option_value_id']; ?>">
												<?php } ?>
											</td>

											<td class="text-center use_image"  <?php if($option_style != 'image') { ?> style='display:none;' <?php } ?>>
											<a href="" id="thumb-image<?php echo $option_value_row; ?>" data-toggle="image" class="img-thumbnail">
												<img src="<?php echo $option_value['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
											</a>
											<input type="hidden" name="option_values[<?php echo $option_value_row; ?>][image]" value="<?php echo $option_value['image'] ? $option_value['image'] : '' ; ?>" id="input-image<?php echo $option_value_row; ?>" />
											</td>
											<td class="text-center use_image"  <?php if($option_style != 'image') { ?> style='display:none;' <?php } ?>>
											<select name="option_values[<?php echo $option_value_row; ?>][position]" id="input-option-category" class="form-control">
												<?php foreach ($option_position as $key => $position) { ?>
												<?php if ($option_value['position'] == $key ) { ?>
												<option value="<?php echo $key; ?>" selected="selected"><?php echo $position; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>
												<?php } else { ?>
												<option value="<?php echo $key; ?>"><?php echo $position; ?></option>
												<?php } ?>
												<?php } ?>
											</select>
											</td>
											<td class="text-right use_color"  <?php if($option_style != 'color') { ?> style='display:none;' <?php } ?>>
											<div class="input-group colorpicker-component colorpicker-element">
												<input name="option_values[<?php echo $option_value_row; ?>][color]" value="<?php echo $option_value['color'] ? $option_value['color'] : '#584aa2' ; ?>" class="form-control">
												<span class="input-group-addon"><i></i></span>
											</div>
											</td>
											<td class="text-right keyword">
												<?php foreach($languages as $language) { ?>
												<div class="input-group">
													<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"></span>
													<input name="option_values[<?php echo $option_value_row; ?>][keyword][<?php echo $language['language_id']; ?>]" id="option-values-<?php echo $language['language_id']; ?>" class="form-control" value="<?php echo isset($option_value['keyword'][$language['language_id']]) ? $option_value['keyword'][$language['language_id']] : '' ; ?>">
												</div>
												<?php if (isset($error_option_value_keyword[$option_value_row][$language['language_id']])) { ?>
												<div class="text-danger text-center"><?php echo $error_option_value_keyword[$option_value_row][$language['language_id']]; ?></div>
												<?php } ?>
												<?php } ?>
											</td>
											<td class="text-right">
												<input name="option_values[<?php echo $option_value_row; ?>][sort_order]" class="form-control" value="<?php echo $option_value['sort_order'] ? $option_value['sort_order'] : '' ; ?>">
											</td>
											<td class="text-center">
												<button type="button" onclick="$(this).tooltip('destroy'); $('#option-value-row<?php echo $option_value_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></button>
											</td>
										</tr>
										<?php $option_value_row++; ?>
										<?php } ?>
										<?php }else{ ?>
										<tr id="option-value-row<?php echo $option_value_row; ?>">
											<td class="text-center" colspan="6" id="no_results"><?php echo $text_no_results; ?></td>
										</tr>
										<?php } ?>
										</tbody>
									</table>
								</div>
								<div class="container-fluid" style="margin-bottom: 10px; padding-right: 0px;">
									<div class="pull-right">
										<button type="button" onclick="addOptionValue();" data-toggle="tooltip" title="<?php echo $button_option_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i> <?php echo $button_option_value_add; ?></button>
									</div>
								</div>
							</div>
						</div>

					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

    $("body").on("blur", 'input[name*="[name]"]', function() {

        if($(this).val() != '') {

            var name = $(this).attr('name').replace('name', 'keyword'),
            input = $("input[name='" + name + "']");

            if (!input.val()) {
                $.ajax({
                    url: 'index.php?route=catalog/neoseo_filter/getKeyword&token=<?php echo $token; ?>&keyword=' + encodeURIComponent($(this).val()),
                    dataType: 'json',
                    success: function(json) {
                        input.val(json.keyword);
                    }
                });
            }
        }
    });

	<?php foreach($languages as $language){ ?>
		$("input[id='option_name<?php echo $language['language_id']; ?>'").blur(function () {
			if($(this).val() != '') {
				var input = $("input[id='option_keyword<?php echo $language['language_id']; ?>']");
				if (!input.val()) {
					$.ajax({
						url: 'index.php?route=catalog/neoseo_filter/getKeyword&token=<?php echo $token; ?>&keyword=' + encodeURIComponent($(this).val()),
						dataType: 'json',
						success: function(json) {
							input.val(json.keyword);
						}
					});
				}
			}
		});
	<?php } ?>
	<?php foreach($languages as $language){ ?>
		$("input[id^='option-value-name-<?php echo $language['language_id']; ?>-'").blur(function () {
			if($(this).val() != '') {
				var input = $(this).parents('tr').find('#option-values-<?php echo $language["language_id"]; ?>');
				if (!input.val()) {
					$.ajax({
						url: 'index.php?route=catalog/neoseo_filter/getKeyword&token=<?php echo $token; ?>&keyword=' + encodeURIComponent($(this).val()),
						dataType: 'json',
						success: function(json) {
							input.val(json.keyword);
						}
					});

				}
			}
		});
	<?php } ?>
	$(".tab-content .filter").keyup(function () {
		var filter = $(this).val();
		var items = $(this).parent().find(".well");
		if (!filter) {
			$("> div", items).show();
		} else {
			$("> div:contains(" + filter + ")", items).show();
			$("> div:not(:contains(" + filter + "))", items).hide();
		}
	});

	$("select[name='option_style'").change(function () {
		if ($(this).val() == 'color') {
			$(".use_color").show();
			$(".use_image").hide();
		} else if($(this).val() == 'image') {
			$(".use_image").show();
			$(".use_color").hide();
		}else{
			$(".use_image").hide();
			$(".use_color").hide();
		}
	});

</script>
<script type="text/javascript">
	$(document).ready(function () {
		$(".colorpicker-component").colorpicker();
	});
</script>
<script type="text/javascript">
	var option_value_row = <?php echo $option_value_row; ?>									;

	function addOptionValue() {
		$('#no_results').hide();

		html = '<tr id="option-value-row' + option_value_row + '">';
		html += '<td class="text-left">';
	<?php foreach($languages as $language) { ?>
			html += '<div class="input-group">';
			html += '<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"></span>';
			html += '<input name="option_values['+option_value_row+'][name][<?php echo $language['language_id']; ?>]"  class="form-control" value="">';
			html += '</div>';
		<?php } ?>
		html += '</td>';
		html += '<td class="text-center use_image" ';
		if ($("select[name='option_style'").val() != 'image')
			html += 'style="display:none;"';
		html += '>';
		html += '<a href="" id="thumb-image' + option_value_row + '" data-toggle="image" class="img-thumbnail">';
		html += '<img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />';
		html += '</a>';
		html += '<input type="hidden" name="option_values[' + option_value_row + '][image]" value="" id="input-image' + option_value_row + '" />';
		html += '</td>';
		html += '<td class="text-center use_image" ';
		if ($("select[name='option_style'").val() != 'image')
			html += 'style="display:none;"';
		html += '>';
		html += '<select name="option_values[' + option_value_row + '][position]" id="input-option-category" class="form-control">';
	<?php foreach ($option_position as $key => $position) { ?>
			html += '<option value="<?php echo $key; ?>">&nbsp;&nbsp;<?php echo $position; ?>&nbsp;&nbsp;&nbsp;&nbsp;</option>';
		<?php } ?>
		html += '</select>';
		html += '</td>';
		html += '<td class="text-left use_color" ';
		if ($("select[name='option_style'").val() != 'color')
			html += 'style="display:none;"';
		html += '>';
		html += '<div class="input-group colorpicker-component colorpicker-element">';
		html += '<input name="option_values[' + option_value_row + '][color]" value="#584aa2" class="form-control">';
		html += '<span class="input-group-addon"><i></i></span>';
		html += '</div>';
		html += '</td>';


		html += '<td class="text-left">';
	<?php foreach($languages as $language) { ?>
			html += '<div class="input-group">';
			html += '<span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>"></span>';
			html += '<input name="option_values[' + option_value_row + '][keyword][<?php echo $language['language_id']; ?>]"  class="form-control" value="">';
			html += '</div>';
		<?php } ?>

		html += '</td>';
		html += '<td class="text-left">';
		html += '<input name="option_values[' + option_value_row + '][sort_order]"  class="form-control" value="">';
		html += '</td>';
		html += '<td class="text-center">';
		html += '<button type="button" onclick="$(this).tooltip(\'destroy\');$(\'#option-value-row' + option_value_row + '\').remove();" data-toggle="tooltip" rel="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger">';
		html += '<i class="fa fa-trash-o"></i>';
		html += '</button>';
		html += '</td>';
		html += '</tr>';

		$('#option-value tbody').append(html);
		$('[rel=tooltip]').tooltip();
		$(".colorpicker-component").colorpicker();
		option_value_row++;
	}
</script>
<?php echo $footer; ?>
