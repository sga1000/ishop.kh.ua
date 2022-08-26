function sendSmsFromHeader() {
	token = getURLVar('token');
	var header_phone = "#neoseo_sms_notify_header_phone";
	var header_message = "#neoseo_sms_notify_header_message";

	var data = {
		phone: $(header_phone).val(),
		message: $(header_message).val(),
	};

	$.ajax({
		url: 'index.php?route=marketing/neoseo_sms_notify/sendSmsFromHeader&token=' + token,
		type: 'post',
		data: data,
		dataType: 'json',
		success: function (json) {
			$('#modal-sms-notify .alert').remove();

			if (json['status'] == 1) {
				$(header_phone).val('');
				$(header_message).val('');
				alert('Сообщение отправлено успешно');
			}
			if (json['status'] == 0) {
				alert('При отправке сообщения произошла ошибка');
			}
			if (json['message']) {
				$('#field_header_phone').before('<div class="alert alert-danger">' + json['message'] + '</div>');
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}