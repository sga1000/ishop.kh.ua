<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_menu_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

	<div id="content">
		<div class="page-header">
			<div class="container-fluid">
				<div class="pull-right">
					<?php if( !isset($license_error) ) { ?>
						<button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
						<button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
					<?php } else { ?>
						<a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"
								class="btn btn-primary"/><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
					<?php } ?>
					<a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>"
							class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
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
							<li id="title_tab_menus"><a id="href_tab_menus" href="#tab-menus"
										data-toggle="tab"><?php echo $tab_menus; ?></a></li>
						<?php } ?>
						<?php if( !isset($license_error) ) { ?>
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
								<?php } else { ?>

									<?php echo $license_error; ?>

								<?php } ?>
							</div>


							<?php if (!isset($license_error)) { ?>
								<div class="tab-pane" id="tab-menus">
									<div class="table-responsive">
										<div class="form-group pull-right">
											<a href="<?php echo $add; ?>" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
											<a onclick="confirm('Удалить выбранные меню?') && $('input[name=\'selected[]\']:checked').length > 0 ? $('#form').attr('action', '<?php echo $delete; ?>').submit() : false;" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash"></i></a>
											<a href="<?php echo $copy; ?>" data-toggle="tooltip" title="<?php echo $button_copy; ?>" class="btn btn-primary"><i class="fa fa-copy"></i></a>
										</div>
										<table class="table table-bordered table-hover">
											<thead>
											<tr>
												<td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
												<td class="text-center"><?php echo $entry_menu_name; ?></td>
												<td class="text-center"><?php echo $entry_menu_status; ?></td>

												<td class="text-center"><?php echo $entry_menu_action; ?></td>
											</tr>
											</thead>
											<tbody>
											<?php if(isset($menus) && $menus) { ?>
												<?php foreach ($menus as $menu) { ?>

													<tr>
														<td class="text-center"><?php if (in_array($menu['menu_id'], $selected)) { ?>
																<input type="checkbox" name="selected[]" value="<?php echo $menu['menu_id']; ?>" checked="checked" />
															<?php } else { ?>
																<input type="checkbox" name="selected[]" value="<?php echo $menu['menu_id']; ?>" />
															<?php } ?></td>
														<td class="text-left"><?php echo $menu['name']; ?></td>
														<td class="text-left"><?php echo ($menu['status'] == 1) ? 'Включено' : 'Отключено'; ?></td>

														<td class="text-center">
															<a href="<?php echo $menu['edit']; ?>" data-toggle="tooltip"
																	title="<?php echo $button_edit; ?>" class="btn btn-primary"><i
																		class="fa fa-pencil"></i></a>
															<a onclick="confirm('Удалить меню?') ? $('#form').attr('action', '<?php echo $menu['delete']; ?>').submit() : false;"
																data-toggle="tooltip" title="<?php echo $button_delete; ?>"
																class="btn btn-danger"><i class="fa fa-trash-o"></i></a>
														</td>
													</tr>
												<?php } ?>
											<?php } else { ?>
												<tr>
													<td class="text-center" colspan="9"><?php echo $text_no_results; ?></td>
												</tr>
											<?php } ?>
											</tbody>
										</table>
									</div>
									<div class="row">
										<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
										<div class="col-sm-6 text-right"><?php echo $results; ?></div>
									</div>
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

	</script>

	//--></script>
	<script type="text/javascript">
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

	</script>
<?php echo $footer; ?>