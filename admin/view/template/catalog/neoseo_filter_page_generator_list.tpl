<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right"><a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><?php echo $button_add; ?> <i class="fa fa-plus"></i></a>
				<button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-rules').submit() : false;"><?php echo $button_delete; ?> <i class="fa fa-trash-o"></i></button>
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
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-list"></i><?php echo $text_list_rules; ?></h3>
			</div>
			<div class="panel-body">
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
						<div class="col-sm-6">
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
						<div class="col-sm-6">
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
						<div class="col-sm-12">
							<button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
						</div>
					</div>
					<?php if(false){ ?>
					<div class="row text-right" style='margin-top: 10px;'>
						<div id="progress-rules" class="progress" style="margin-top:20px; display:none">
							<div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">0%
							</div>
						</div>
						<button onclick="generate('#progress-rules', '<?php echo $generate_all; ?>'); return false;" class="btn btn-default">
							<span>
								<i class="fa fa-cog"></i> <?php echo $button_all_rule_generate; ?>
							</span>
						</button>
							
						<button onclick="generate('#progress-rules', '<?php echo $generate_selected_rule; ?>'); return false;" class="btn btn-default">
							<span>
								<i class="fa fa-cog"></i> <?php echo $button_select_rule_generate; ?>
							</span>
						</button>
					</div>
					<?php } ?>
				</div>

				<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-rules">
					<div class="table-responsive">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
									<td class="text-center"><?php echo $column_category; ?></td>
									<td class="text-left"><?php echo $column_options; ?></td>
									<td class="text-center"><?php if ($sort == 'fp.status') { ?>
										<a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
										<?php } else { ?>
										<a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
										<?php } ?></td>
									<td class="text-center"><?php echo $column_generate; ?></td>
									<td class="text-center"><?php echo $column_action; ?></td>
								</tr>
							</thead>
							<tbody>
								<?php if ($list_generator) { ?>
								<?php foreach ($list_generator as $rule) { ?>
								<tr>
									<td class="text-center"><?php if (in_array($rule['rule_id'], $selected)) { ?>
										<input type="checkbox" name="selected[]" value="<?php echo $rule['rule_id']; ?>" checked="checked" />
										<?php } else { ?>
										<input type="checkbox" name="selected[]" value="<?php echo $rule['rule_id']; ?>" />
										<?php } ?></td>
									<td class="text-center"><?php echo $rule['category']; ?></td>
									<td class="text-left"><?php echo utf8_substr(strip_tags(html_entity_decode($rule['options'])), 0, 100) . '..'; ?></td>
									<td class="text-center" style="color:<?php echo !$rule['status']? '#FF3030':'#00CD66' ?>">
										<input name="checkedStatus" type="checkbox" <?php echo $rule['status']? 'checked': ''; ?> data-generator='<?php echo $rule['rule_id']?>' data-toggle="toggle" data-on="<?php echo $text_enabled ?>" data-off="<?php echo $text_disabled ?>" data-onstyle="success" data-offstyle="danger">
									</td>
									<td class="text-center">
										<button onclick="generate('#progress-rule-<?php echo $rule['rule_id']; ?>', '<?php echo $generate; ?>'); return false;" class="btn btn-primary"><span><?php echo $button_generate; ?></span></button>
										<div id="progress-rule-<?php echo $rule['rule_id']; ?>" class="progress" style="margin-top:20px; display:none">
											<div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">0%
											</div>
										</div>
									</td>
									<td class="text-center">
										<a href="<?php echo $rule['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
										<button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? location = '<?php echo $rule['delete']; ?>' : false;"><i class="fa fa-trash-o"></i></button>
									</td>
								</tr>
								<tr>
									<td class="text-left" colspan="6">
										<b><?php echo $column_cron; ?></b>
										<br> <?php echo $rule['cron']; ?>
										<br> <?php echo $rule['wget']; ?>
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
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
					<div class="col-sm-6 text-right"><?php echo $results; ?></div>
				</div>


			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function generate(element_id, callback, offset = 0) {
	el = $(element_id);
	var onClickAttr = el.attr('onclick');
	el.attr('onclick', '').unbind('click');
	el.addClass('disabled');
	$(element_id).removeClass('hide').show();
	$('.prError').remove();
	$('.generating-error').remove();

	var url = ''
	if(offset){
		url += '&offset=' + offset;
	}
	if (element_id.indexOf('#progress-rule-') == 0) {
		rule_id = element_id.replace('#progress-rule-', '');
		url += '&rule_id=' + rule_id;
	}

	if (element_id.indexOf('#progress-rules') == 0) {
		var selected= [];
		$('input[name^=selected]:checked').each(function () { 
			 selected.push($(this).val());
		});
		if(selected.length){ 
			url += '&selected=' + selected.join(',');
		}
	}

	$.ajax({
		type: 'POST',
		url: 'index.php?route='+callback+'&token=<?php echo $token; ?>'+url,
		dataType: 'json',
		success: function(data) {
			if (data['error']) {
				$(element_id).addClass('hide');
				$(element_id).after("<span class='generating-error alert alert-warning' style='display: block; margin-top:10px;'>" + data['error'] + "</span>");
				el.attr('onclick', onClickAttr).bind('click');
				el.removeClass('disabled');
				return false;
			}
			var percent = Math.floor((data['offset'] / data['total']) * 100);
			$(element_id + " .progress-bar").prop("aria-valuenow", percent);
			$(element_id + " .progress-bar").css("width", percent + "%");
			$(element_id + " .progress-bar").html(percent + "%");
			if (percent < 100) {
				generate(element_id, callback, data['offset']);
			}
		}
	});
}

function generateRule(rule_id, callback, object) {
    var url = ''
	url += '&rule_id=' + rule_id;
	$(object).prop('disabled', true);
	$(object).prepend('<span class="wait glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> ');

    $.ajax({
        type: 'POST',
        url: 'index.php?route='+callback+'&token=<?php echo $token; ?>'+url,
        dataType: 'json',
        success: function(data) {
            $(object).prop('disabled', false);
            $('.wait').remove();
            if (data['error']) {
                $(object).after("<span class='generating-error alert alert-warning' style='display: block; margin-top:10px;'>" + data['error'] + "</span>");
            }
        }
    });
}
</script>	
<script type="text/javascript">
$('#button-filter').on('click', function() {
	var url = 'index.php?route=catalog/<?php echo $moduleSysName; ?>&token=<?php echo $token; ?>';
	var filter_status = $('select[name=\'filter_status\']').val();
	if (filter_status != '*') {
		url += '&filter_status=' + encodeURIComponent(filter_status);
	}

	var filter_category = $('select[name=\'filter_category\']').val();
	if (filter_category != '*') {
		url += '&filter_category=' + encodeURIComponent(filter_category);
	}

	location = url;
});
</script>	
<script>
$(function() {
	$('input[name=checkedStatus]').change(function() {
		var rule_id = 0;
		var status = 0;
		if ($(this).prop('checked')) {
			status = 1;
		}
		rule_id = $(this).data('generator');
		$.ajax({
			url: 'index.php?route=catalog/<?php echo $moduleSysName; ?>/checkedStatus&token=<?php echo $token; ?>',
			type: 'post',
			data: {
				'status': status,
				'rule_id': rule_id
			},
			dataType: 'json',
			success: function(json) {
				$('.alert').remove();
				if (json['error']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
});
</script>
<?php echo $footer; ?>