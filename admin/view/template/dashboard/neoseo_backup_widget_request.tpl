<div class="tile tile-dash tile-special tile-backup">
	<div class="tile-heading"><span class="tile-title"><?php echo $heading_title; ?></span><a href="<?php echo $setting_widget; ?>" target="_blank" class="widget-link widget-link-r" ></a></div>
	<?php if($send_request) { ?>
	
		<div class="tile-body module-absent">
			<div>
				<a href="#" class="dropdown-toggle  btn-tile" data-toggle="dropdown"><?php echo $text_buy; ?></a>
			<div id="range" class="dropdown-menu dropdown-menu-right dropdown-absent">
				<form id="request_backup_widget">
					<div class="row form-group form-group-links">
						<label class="control-label" for="input-domain"><?php echo $entry_domain; ?></label>
						<div class="">
							<input type="text" name="domain" value="<?php echo $domain; ?>" placeholder="<?php echo $entry_domain; ?>"  class="form-control" />
						</div>
					</div>
					<div class="row form-group form-group-links">
						<label class="control-label" for="input-domain"><?php echo $entry_email; ?></label>
						<div class="">
							<input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>"  class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-12">
							<button class="btn-tile btn-absent-request" data-original-title="<?php echo $button_request; ?>" onclick='sendRequestBackupWidget();
									return false;'><?php echo $button_request; ?></button>
						</div>
					</div>
				</form>
			</div>
			</div>
		</div>
		<div class="tile-footer module-absent">
			<p><?php echo $text_content; ?></p>
		</div>

	<?php } else { ?>
	
		<div class="tile-body  module-turnof">
			<div>
				<a href="#" class="dropdown-toggle  btn-tile " data-toggle="dropdown"><?php echo $button_details; ?></a>
				<div id="range" class="dropdown-menu dropdown-menu-right dropdown-turnof">
					<?php echo $text_no_information; ?>
					<a href="<?php echo $setting_module; ?>" target="_blank"><?php echo $button_enabled; ?></a>
				</div>
			</div>
		</div>
		<div class="tile-footer  module-turnof">
			<p><?php echo $text_content; ?></p>
		</div>
	<?php } ?>
</div>
<?php if($send_request) { ?>
<script type="text/javascript">
	function sendRequestBackupWidget() {
		var domain = $("#request_backup_widget input[name=\'domain\']").val();
		var email = $("#request_backup_widget input[name=\'email\']").val();

		$.ajax({
			url: 'index.php?route=dashboard/neoseo_backup_widget/sendRequest&token=<?php echo $token; ?>&domain=' + encodeURIComponent(domain) + '&email=' + encodeURIComponent(email),
			dataType: 'json',
			success: function (json) {
				$('.alert, .text-danger, .alert, .text-success').remove();

				if (json.error) {
					$('#request_backup_widget').before('<div class="alert alert-danger"><i class="fa fa-check-circle"></i> ' + json.result + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				} else {
					$('#request_backup_widget').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json.result + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
</script>
<?php } ?>