function popupCallbackShow(json) {
	if ($("#popup-callback").length == 0) {
		$("body").append("<div id=\"popup-callback\"></div>");
	}
	$("#popup-callback").html(json["popup"]);
	$('#popup-callback > div').modal();
}

function showCallback() {
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=module/neoseo_callback',
		type: 'post',
		data: [],
		dataType: 'json',
		success: function (json) {
			$('.alert').remove();

			if (json['popup']) {
				popupCallbackShow(json);
				if (typeof (ga) == "function") {
					ga('send', 'event', 'callback', 'start');
				}
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function processCallback() {
	if (!$("#callback").valid())
		return;
	var language = "";
	if (window.current_language) {
		language = window.current_language;
	}
	$.ajax({
		url: language + 'index.php?route=module/neoseo_callback/process',
		type: 'post',
		data: $('#callback input[type=\'text\'], #callback input[type=\'hidden\'], #callback input[type=\'tel\'], #callback input[type=\'radio\']:checked, #callback input[type=\'checkbox\']:checked, #callback select, #callback textarea'),
		dataType: 'json',
		success: function (json) {
			$('.success, .warning, .attention, .information').remove();

			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			}

			if (json['popup']) {
				$('#popup-callback > div').modal('hide');
				$('.modal-backdrop').remove();
				popupCallbackShow(json);
				if (typeof (ga) == "function") {
					ga('send', 'event', 'callback', 'finish');
				}
			}
		}
	});

}