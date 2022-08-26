<?php echo $header; ?>
<style type="text/css">
.border {
	margin-bottom: 15px;
	border-radius: 3px;
	border: 1px solid #eff2f9;
	transition: all 1s;
	margin: 15px;
	padding:0px;
}
.border .tile-heading{
	background-color:#eff2f9;
	text-align: left;
	color: #000;
}
.border .tile-body{
	color:#666;
	padding:10px;
	line-height: 15px;
}
#tab-notes .row{
	margin-right:0px;
}
</style>
<?php echo $column_left; ?>
<div id="content">

	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if( !isset($license_error) ) { ?>
				<button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
				<a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>');
				$('#form').submit();" class="btn btn-primary"><i class="fa fa-save"></i>&nbsp;<?php echo $button_save_and_close; ?></a>
				<?php } else { ?>
				<a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
				<?php } ?>
				<a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
			</div>

			<img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/neoseo.png" alt=""> 
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
					<li><a href="#tab-notes" data-toggle="tab"><?php echo $tab_notes; ?></a></li>
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
							<?php $widgets->localeInput('title', $languages); ?>

							<?php } else { ?>

							<?php echo $license_error; ?>

							<?php } ?>

						</div>

						<?php if( !isset($license_error) ) { ?>
						<div class="tab-pane" id="tab-notes">
							<div class="row">
								<div class="form-group  pull-right">
									<a href="<?php echo $add; ?>" data-toggle="tooltip"  title="<?php echo $button_add_note; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i>&nbsp;<?php echo $button_add_note; ?></a>
								</div>
							</div>
							<div class="row">
								<?php if($notes) { ?>
								<?php $count=0; ?>
								<?php foreach ($notes as $note) { ?>
								<?php if($count && $count%5 == 0) { ?>
								</div>
								<div class="row">
								<?php } ?>
								<div class="col-lg-2 col-md-2 col-sm-6 border tile-note" id="note_<?php echo $note['note_id']; ?>">
									<div class="tile-heading">
										<a href="<?php echo $note['view']; ?>"><?php echo $note['title']; ?></a>
										<div class="pull-right">
											<button type="button"class="btn btn-xs" onclick="deleteNote(<?php echo $note['note_id']; ?>)" data-toggle="tooltip"  title="<?php echo $button_delete; ?>"><i class="fa fa-times"></i></button>
										</div>
									</div>
									<a href="<?php echo $note['view']; ?>">
										<div class="tile-body" style="background-color:<?php echo $note['color']; ?>; color:<?php echo $note['font_color']; ?>">
											<?php if($note['use_notification']  && $note['date_notification']) { ?>
											<b><?php echo $text_date_notification; ?></b> <?php echo $note['date_notification']; ?><br>
											<?php } ?>
											<?php echo $note['text']; ?>
										</div>
									</a>
								</div>
								<?php $count++; ?>
								<?php } ?>
								<?php } else{ ?>
									<div class="col-xs-12"><?php echo $text_no_results; ?></div>
								<?php } ?>
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
		if( url.indexOf('#') != -1 ) {
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
	function deleteNote(note_id){
		$.ajax({
			url: 'index.php?route=module/neoseo_notes_widget/delete&token=<?php echo $token; ?>&note_id=' + note_id,
			dataType: 'json',
			success: function (json) {
				
				if(json.result == true){
					$('#note_' + note_id).remove();
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
	//--></script>
<?php echo $footer; ?>