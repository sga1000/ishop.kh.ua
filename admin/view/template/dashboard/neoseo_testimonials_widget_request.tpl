<div class="tile tile-dash">
	<div class="tile-heading"><a href="<?php echo $setting_widget; ?>" target="_blank" class="widget-link" ></a><a href="<?php echo $params_link; ?>" class="link-why" target="_blank"><?php echo $text_link; ?></a></div>

	<?php if($send_request) { ?>
	<div class="tile-body module-absent">
		<div>
			<?php echo $heading_title; ?>
			<a href="#" class="dropdown-toggle  btn-tile" data-toggle="dropdown"><?php echo $text_buy; ?></a>
			<div id="range" class="dropdown-menu dropdown-menu-right dropdown-absent">
				<form id="request_testimonials_widget">
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
							<button class="btn-tile btn-absent-request" data-original-title="<?php echo $button_request; ?>" onclick='sendRequestTestimonialsWidget();
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
	<?php } ?>
</div>

	<?php if($send_request) { ?>
<script type="text/javascript">
	function sendRequestTestimonialsWidget() {
		var domain = $("#request_testimonials_widget input[name=\'domain\']").val();
		var email = $("#request_testimonials_widget input[name=\'email\']").val();

		$.ajax({
			url: 'index.php?route=dashboard/neoseo_testimonials_widget/sendRequest&token=<?php echo $token; ?>&domain=' + encodeURIComponent(domain) + '&email=' + encodeURIComponent(email),
			dataType: 'json',
			success: function (json) {
				$('.alert, .text-danger, .alert, .text-success').remove();

				if (json.error) {
					$('#request_testimonials_widget').before('<div class="alert alert-danger"> ' + json.result + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				} else {
					$('#request_testimonials_widget').before('<div class="alert alert-success"> ' + json.result + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	}
</script>
<?php } ?>