<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if( !isset($license_error) ) { ?>
				<a href="<?php echo $clear_cache; ?>" data-toggle="tooltip" title="<?php echo $button_clear_cache; ?>" class="btn btn-danger"><i class="fa fa-eraser"></i> <?php echo $button_clear_cache; ?></a>
				<button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
				<button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
				<?php } else { ?>
				<a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-default" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
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
					<li><a href="#tab-import" data-toggle="tab"><?php echo $tab_import; ?></a></li>
					<li><a href="#tab-cron" data-toggle="tab"><?php echo $tab_cron; ?></a></li>
					<li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
					<?php } ?>
				</ul>

				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">
							<?php if( !isset($license_error) ) { ?>
							<?php $widgets->dropdown('use_cache', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('not_flush_filter_module_cache', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('use_discount', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('use_special', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('use_series', array( 0 => $text_disabled, 1 => $text_enabled), $use_series_show); ?>
							<?php $widgets->dropdown('show_attributes',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('add_filters_to_h1',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('attributes_group', $attribute_groups); ?>
							<?php $widgets->dropdown('manufacturer_sort_order', $manufacturer_sorting_options); ?>
							<?php $widgets->localeInput('manufacturer_url',$full_languages); ?>
							<?php $widgets->localeInput('price_url',$full_languages); ?>
							<?php } else { ?>
							<div><?php echo $license_error; ?></div>
							<?php } ?>
						</div>

						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-import">
							<?php $widgets->dropdown('import_filter_option', $filter_options); ?>
							<?php $widgets->input('import_product_field'); ?>
							<div class="form-group" style="display: inline-block; width: 100%;">
								<div class="col-sm-12">
									<a class="btn btn-default" onclick="confirmImportProductData();" href="<?php echo $copy_product_data;?>">
										<?php echo $text_copy_product_data; ?>
									</a>
								</div>
							</div>
							<?php $widgets->button($copy_attributes, $text_copy_attributes); ?>
							<?php $widgets->button($copy_options, $text_copy_options); ?>
							<?php $widgets->button($copy_from_ocfilter, $text_copy_from_ocfilter); ?>
							<?php $widgets->button($copy_from_default_filter, $text_copy_from_default_filter); ?>
							<?php $widgets->button($clear_filter_options, $text_clear_filter_options, 'btn btn-danger'); ?>
						</div>
						<?php } ?>

						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-cron">
							<?php $widgets->text('cron_copy_attributes'); ?>
							<?php $widgets->text('cron_copy_options'); ?>
							<?php $widgets->text('cron_copy_product_data'); ?>
							<?php $widgets->text('cron_copy_from_ocfilter'); ?>
						</div>
						<?php } ?>

						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-logs">
							<?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
							<textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
						</div>
						<?php } ?>

					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--	
	if (window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length) 		{
		$(".panel-body > .nav-tabs li").removeClass("active")		;
		$("[href=" + window.location.hash + "]").parents('li').addClass("active")		;
		$(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active")		;
		$(window.location.hash).addClass("active")	;
		}
	$(".nav-tabs li a").click(function () 		{
		var url = $(this).prop('href')		;
		window.location.hash = url.substring(url.indexOf('#'))	;
	})	;
	// Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash		
	// и по итогу этот hash становится частью token		
	function getURLVar(key) 		{
		var value = [];		

		var url = String(document.location)		;
		var url = url.substring(0, url.indexOf('#'))		;
		var query = url.split('?');		

		if (query[1]) 			{
			var part = query[1].split('&');			

			for (i = 0; i < part.length; i++) 				{
				var data = part[i].split('=');				

				if (data[0] && data[1]) 					{
					value[data[0]] = data[1]				;
				}
			}			

			if (value[key]) 				{
				return value[key]			;
			} else 				{
				return ''			;
					}
			}
		}
//--></script>	
<script type="text/javascript"><!--	
	function confirmImportProductData(){
		if (!confirm('<?php echo $text_confirm_import; ?>'))
			event.preventDefault();
	}
//--></script>
<?php echo $footer; ?>