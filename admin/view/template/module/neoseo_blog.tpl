<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_blog_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if (!isset($license_error)) { ?>
				<a onclick="$('#form').attr('action', '<?php echo $save; ?>'); $('#form').submit();" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></a>
					<a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>'); $('#form').submit();" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></a>
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
					<?php if (!isset($license_error)) { ?><li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li><?php } ?>
					<li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
					<li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
				</ul>

				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">

							<?php if (!isset($license_error)) { ?>

							<?php $widgets->dropdown('comment_auto_approval',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->input('article_time_format'); ?>
							<?php $widgets->input('comment_time_format'); ?>

							<?php $widgets->input('image_article_list_width'); ?>
							<?php $widgets->input('image_article_list_height'); ?>

							<?php $widgets->input('image_article_block_width'); ?>
							<?php $widgets->input('image_article_block_height'); ?>

							<?php $widgets->input('image_product_block_width'); ?>
							<?php $widgets->input('image_product_block_height'); ?>

							<?php $widgets->input('image_category_block_width'); ?>
							<?php $widgets->input('image_category_block_height'); ?>

							<?php $widgets->input('image_author_block_width'); ?>
							<?php $widgets->input('image_author_block_height'); ?>

							<?php } else { ?>

							<?php echo $license_error; ?>

							<?php } ?>

						</div>

						<?php if (!isset($license_error)) { ?>
						<div class="tab-pane" id="tab-fields">
							<table class="list display" id="items-table" width="90%">
								<thead>
								<tr>
									<td width="200px" class="left"><?php echo $entry_field_list_name; ?></td>
									<td><?php echo $entry_field_list_desc; ?></td>
								</tr>
								</thead>
								<tbody>
								<?php foreach( $fields as $field_name => $field_desc ) { ?>
								<tr>
									<td class="left">{<?php echo $field_name ?>}</td>
									<td><?php echo $field_desc ?></td>
								</tr>
								<?php } ?>
								</tbody>
							</table>
						</div>
						<?php } ?>

						<?php if (!isset($license_error)) { ?>
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
<script type="text/javascript"><!--
			// Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash
			// и по итогу этот hash становится частью token -->
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

	$(function () {

		// Обработка хеш-тегов для табов
		var tabs = [];
		$('.panel-body:first > .nav-tabs li').each(function (index) {
			var obj = $(this).children().prop('href');
			tabs.push(obj.substring(obj.indexOf('#')));
		});
		if (window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length) {
			$(".panel-body > .nav-tabs li").removeClass("active");
			$("[href=" + window.location.hash + "]").parents('li').addClass("active");
			$(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
			$(window.location.hash).addClass("active");
		}
		$(".panel-body").delegate(".nav-tabs li a", 'click', function () {
			var url = $(this).prop('href');
			var tab = url.substring(url.indexOf('#'));
			// $(this).parents(2).find('.tab-content .language').removeClass('active');
			// x $(this).parents(2).find('.tab-content .language'+tab).addClass('active');
			if ($.inArray(tab, tabs) != -1) {
				window.location.hash = tab;
			}
		});
	});

</script>
<?php echo $footer; ?>