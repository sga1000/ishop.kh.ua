<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM.'/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_backup_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<?php if (!isset($license_error)) { ?>
				<button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
				<button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
				<?php } else { ?>
				<a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-default" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
				<?php } ?>
				<a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
			</div>
			<img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
			<h1><?php echo $heading_title_raw." ".$text_module_version; ?></h1>
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
					<?php if (!isset($license_error)) { ?>
					<li><a href="#tab-stat" data-toggle="tab"><?php echo $tab_stat; ?></a></li>
					<li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
					<?php } ?>
					<li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
					<li><a href="#tab-usefull" data-toggle="tab"><?php echo $tab_usefull; ?></a></li>
					<li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
				</ul>

				<form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
					<div class="tab-content">
						<div class="tab-pane active" id="tab-general">

						<?php if (!isset($license_error)) { ?>

							<?php $widgets->dropdown('status',array(0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->dropdown('replace_system_backup',array(0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->textarea('notify_list'); ?>
							<?php $widgets->input('max_copies'); ?>
							<?php $widgets->textarea('exclude_files'); ?>
							<?php $widgets->textarea('exclude_tables'); ?>
							<?php $widgets->dropdown('destination',$neoseo_backup_destinations); ?>
							<?php $widgets->input('api_key'); ?>
							<?php $widgets->input('api_secret'); ?>
							<?php $widgets->input('token'); ?>
							<?php $widgets->input('client_id'); ?>
							<?php $widgets->input('client_secret'); ?>
							<?php $widgets->input('google_api'); ?>
							<?php $widgets->input('server'); ?>
							<?php $widgets->input('folder'); ?>
							<?php $widgets->text('google_url'); ?>
							<?php $widgets->input('username'); ?>
							<?php $widgets->password('password'); ?>
							<?php $widgets->text('cron'); ?>

						<?php } else { ?>

							<?php echo $license_error; ?>

						<?php } ?>
						</div>

						<?php if (!isset($license_error)) { ?>
						<div class="tab-pane" id="tab-stat">
							<?php $widgets->dropdown('send_statistics',array(0 => $text_disabled, 1 => $text_enabled)); ?>
							<?php $widgets->input('statistics_server'); ?>
						</div>

						<div class="tab-pane" id="tab-logs">
							<?php $widgets->debug_and_logs('debug',array(0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log ); ?>
							<textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
						</div>
						<?php } ?>

						<div class="tab-pane" id="tab-support">
							<?php echo $mail_support; ?>
						</div>

						<div class="tab-pane" id="tab-license">
							<?php echo $module_licence; ?>
						</div>
						<div class="tab-pane" id="tab-usefull">
							<?php $widgets->usefullLinks(); ?>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
	$('[name=neoseo_backup_password]').after('<a id="check_password" href="#"><?php echo $text_check_password;?></a>');
	$('[name=neoseo_backup_token]').after('<a id="get_token" href="#"><?php echo $text_get_token;?> </a><br><a id="check_token" href="#"> <?php echo $text_check_token;?></a>');
	$('[name=neoseo_backup_google_api]').after('<a id="get_access" href="#"><?php echo $text_get_access;?> </a><br><a id="check_access" href="#"> <?php echo $text_check_access;?></a>');
	$('#check_password').click(function(e) {
		e.preventDefault();
		$.ajax({
			'type': "POST",
			'url': "<?php echo htmlspecialchars_decode($check_password); ?>",
			'data': {
				destination: $("[name=neoseo_backup_destination]").val(),
				server: $("[name=neoseo_backup_server]").val(),
				folder: $("[name=neoseo_backup_folder]").val(),
				login: $("[name=neoseo_backup_username]").val(),
				password: $("[name=neoseo_backup_password]").val()
					},
			'dataType': 'json',
			success: function (response) {
				alert(response.message);
			}
		});
	});
	$('#get_token').click(function(e) {
		e.preventDefault();
		$.ajax({
			'type': "POST",
			'url': "<?php echo htmlspecialchars_decode($get_token); ?>",
			'data': {
				destination: $("[name=neoseo_backup_destination]").val(),
				apikey: $("[name=neoseo_backup_api_key]").val(),
				apisecret: $("[name=neoseo_backup_api_secret]").val()
			},
			'dataType': 'json',
			success: function (response) {
				if (response.message.indexOf('dropbox.com') + 1) {
					window.open(response.message, '_blank');
				} else {
					alert(response.message);
				}

			}
		});
	});
	$('#check_token').click(function(e) {
		e.preventDefault();
		$.ajax({
			'type': "POST",
			'url': "<?php echo htmlspecialchars_decode($check_token); ?>",
			'data': {
				destination: $("[name=neoseo_backup_destination]").val(),
				apikey: $("[name=neoseo_backup_api_key]").val(),
				apisecret: $("[name=neoseo_backup_api_secret]").val(),
				token: $("[name=neoseo_backup_token]").val(),
			},
			'dataType': 'json',
			success: function (response) {
				if ((response.message.indexOf('Ошибка') + 1) || (response.message == 'error' )) {
					alert('Получение токен: '+response.message);
				} else {
					if ((response.message.indexOf('Ваше имя') + 1)) {
						alert(response.message);
					} else {
						alert('Token получен и записан в поле Токен');
						$("[name=neoseo_backup_token]").val(response.message);
					}

				}
			}
		});
	});

	$('#get_access').click(function(e) {
		e.preventDefault();
		$.ajax({
			'type': "POST",
			'url': "<?php echo htmlspecialchars_decode($get_access); ?>",
			'data': {
				destination: $("[name=neoseo_backup_destination]").val(),
				googleApi: $("[name=neoseo_backup_google_api]").val(),
				clientId: $("[name=neoseo_backup_client_id]").val(),
				clientSecret: $("[name=neoseo_backup_client_secret]").val()
			},
			'dataType': 'json',
			success: function (response) {
				if (response.message.indexOf('google') + 1) {
					window.open(response.message, '_blank');
				} else {
					alert(response.message);
				}
			}
		});
	});

	$('#check_access').click(function(e) {
		e.preventDefault();
		$.ajax({
			'type': "POST",
			'url': "<?php echo htmlspecialchars_decode($check_access); ?>",
			'data': {
				destination: $("[name=neoseo_backup_destination]").val(),
				googleApi: $("[name=neoseo_backup_google_api]").val(),
				clientId: $("[name=neoseo_backup_client_id]").val(),
				clientSecret: $("[name=neoseo_backup_client_secret]").val()
			},
			'dataType': 'json',
			success: function (response) {
				if (response.message.indexOf('google') + 1) {
					window.open(response.message, '_blank');
				} else {
					alert(response.message);
				}
			}
		});
	});


	$('[name=neoseo_backup_destination]').change(function(e) {
		if ($(this).val() != "ftp") {
			$('#neoseo_backup_server').parent("div").parent("div").hide();
		} else {
			$('#neoseo_backup_server').parent("div").parent("div").show();
		}

		if ($(this).val() != "dropbox") {
			$('#neoseo_backup_token').parent("div").parent("div").hide();
			$('#neoseo_backup_api_key').parent("div").parent("div").hide();
			$('#neoseo_backup_api_secret').parent("div").parent("div").hide();
			$('#neoseo_backup_username').parent("div").parent("div").show();
			$('#neoseo_backup_password').parent("div").parent("div").show();
		} else {
			$('#neoseo_backup_token').parent("div").parent("div").show();
			$('#check_token, #get_token').show();
			$('#check_token, #get_token').show();
			$('#neoseo_backup_api_key').parent("div").parent("div").show();
			$('#neoseo_backup_api_secret').parent("div").parent("div").show();
			$('#neoseo_backup_username').parent("div").parent("div").hide();
			$('#neoseo_backup_password').parent("div").parent("div").hide();
		}

		if ($(this).val() != "drive") {
			$('#neoseo_backup_google_api').parent("div").parent("div").hide();
			$('#neoseo_backup_client_id').parent("div").parent("div").hide();
			$('#neoseo_backup_client_secret').parent("div").parent("div").hide();
			$('#neoseo_backup_username').parent("div").parent("div").show();
			$('#neoseo_backup_password').parent("div").parent("div").show();
		} else {
			$('#neoseo_backup_google_api').parent("div").parent("div").show();
			$('#neoseo_backup_client_id').parent("div").parent("div").show();
			$('#neoseo_backup_client_secret').parent("div").parent("div").show();
			$('#field_google_url').show();
			$('#neoseo_backup_username').parent("div").parent("div").hide();
			$('#neoseo_backup_password').parent("div").parent("div").hide();
		}

		if ($(this).val() == "yandex.disk") {
			$('#neoseo_backup_token').parent("div").parent("div").show();
			$('#neoseo_backup_api_key').parent("div").parent("div").hide();
			$('#neoseo_backup_api_secret').parent("div").parent("div").hide();
			$('#neoseo_backup_username').parent("div").parent("div").hide();
			$('#neoseo_backup_password').parent("div").parent("div").hide();
			$('#check_token, #get_token').hide();
		}

	});
	$('[name=neoseo_backup_destination]').trigger('change');


	//--></script>
<?php echo $footer; ?>