<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">

	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if( !isset($license_error) ) { ?>
				<button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
				<button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
				<?php } else { ?>
				<a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
				<?php } ?>
				<a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
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

				<ul class="nav nav-tabs">

					<li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
					<?php if( !isset($license_error) ) { ?>
					<li><a href="#tab-generate-page" data-toggle="tab"><?php echo $tab_generate_page; ?></a></li>
					<li><a href="#tab-generate-rule" data-toggle="tab"><?php echo $tab_generate_rule; ?></a></li>
					<li><a href="#tab-patterns" data-toggle="tab"><?php echo $tab_patterns; ?></a></li>
					<li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
					<?php } ?>
					<li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
					<li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
				</ul>

				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">

							<?php if( !isset($license_error) ) { ?>

							<?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->input('limit_pagination'); ?>
							<?php $widgets->textarea('ip_list'); ?>
							<?php $widgets->text('cron'); ?>

							<?php } else { ?>

							<?php echo $license_error; ?>

							<?php } ?>

						</div>

						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-generate-page">
							<?php $widgets->dropdown('page_status_default',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->input('limit_records'); ?>
							<?php $widgets->input('limit_url'); ?>
							<?php $widgets->input('separator_page_options'); ?>
							<?php $widgets->input('separator_page_option_values'); ?>
							<?php $widgets->input('separator_page_filters'); ?>
							<?php $widgets->input('separator_page_option_option_values'); ?>
						</div>
						<?php } ?>

						<?php if( !isset($license_error) ) { ?>
							<div class="tab-pane" id="tab-patterns">
								<table class="table table-bordered table-hover" id="items-table" width="50%">
									<thead>
										<tr>
											<td width="200px" class="left"><?php echo $entry_pattern_list_name; ?></td>
											<td><?php echo $entry_pattern_list_desc; ?></td>
										</tr>
									</thead>
									<tbody>
									 <?php foreach( $patterns as $name => $desc ) { ?>
									<tr>
										<td class="left">[<?php echo $name ?>]</td>
										<td><?php echo $desc ?></td>
									</tr>
									<?php } ?>
									</tbody>
								</table>
							</div>
						<?php } ?>

						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-generate-rule">
							<div class="form-group" style="display: inline-block; width: 100%;">
								<div class="col-sm-5">
									<label class="control-label"><?php echo $entry_generate_rules; ?></label>
									<br><?php echo $entry_generate_rules_desc; ?>
								</div>
								<div class="col-sm-7">

									<div id="progress-rules" class="progress" style="margin-top:20px; display:none">
										<div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">0%
										</div>
									</div>
									<a onclick="generate('#progress-rules', '<?php echo $generate_rules; ?>');
											return false;" class="btn btn-primary">
										<span>
											<i class="fa fa-cog"></i> <?php echo $button_generate_rules; ?>
										</span>
									</a>
								</div>
							</div>
							<?php $widgets->input('limit_categories'); ?>
							<?php $widgets->localeInput('pattern_name_default', $languages); ?>
							<?php $widgets->localeInput('pattern_title_default', $languages); ?>
							<?php $widgets->localeInput('pattern_meta_description_default', $languages); ?>
							<?php $widgets->localeInput('pattern_h1_default', $languages); ?>
							<?php $widgets->localeTextarea('pattern_description_default', $languages); ?>
							<?php $widgets->localeInput('pattern_url_default', $languages); ?>
							<?php $widgets->localeInput('pattern_manufacturer', $languages); ?>
							<?php $widgets->dropdown('use_direct_link_default',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('use_end_slash_default',array( 0 => $text_disabled, 1 => $text_enabled)); ?>

						</div>
						<?php } ?>

						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-logs">
							<?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
							<textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
						</div>
						<?php } ?>

						<div class="tab-pane" id="tab-support">
							<?php echo $mail_support; ?>
						</div>

						<div class="tab-pane" id="tab-license">
							<?php echo $module_licence; ?>
						</div>

					</div>

				</form>

			</div>

		</div>

	</div>
</div>

<script type="text/javascript">
	
function generate(element_id, callback) {
	
	if(!confirm('<?php echo $text_confirm; ?>')){
		return false;
	}
	
	generateNext(element_id, callback);

}
function generateNext(element_id, callback, offset = 0) {
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
				generateNext(element_id, callback, data['offset']);
			}
		}
	});
}
</script>	
	<script type="text/javascript"><!--	
	if (window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length) {
			$(".panel-body > .nav-tabs li").removeClass("active");
			$("[href=" + window.location.hash + "]").parents('li').addClass("active");
			$(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
			$(window.location.hash).addClass("active");
		}
		$(".nav-tabs li a").click(function () {
			var url = $(this).prop('href');
			window.location.hash = url.substring(url.indexOf('#'));
		});

		// Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash	
		// и по итогу этот hash становится частью token	
		function getURLVar(key) {
			var value = [];

			var url = String(document.location);
			if (url.indexOf('#') != -1) {
				url = url.substring(0, url.indexOf('#'));
			}
			var query = url.split('?');

			if (query[1]) {
				var part = query[1].split('&');

				for (i = 0; i < part.length; i++) {
					var data = part[i].split('=');

					if (data[0] && data[1]) {
						value[data[0]] = data[1];
					}
				}

				if (value[key]) {
					return value[key];
				} else {
					return '';
				}
			}
		}
		//--></script>
<?php echo $footer; ?>