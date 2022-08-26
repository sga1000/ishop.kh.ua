function popupConsultationShow(json) {
    if ($("#popup-consultation").length == 0) {
	$("body").append("<div id=\"popup-consultation\"></div>");
    }
    $("#popup-consultation").html(json["popup"]);
    $(".text_wrap_consultation").html(json["text"])
    $('#popup-consultation > div').modal();
}

function processConsultation(module) {
    if (!$("#catch_contacts-" + module).valid())
	return;

    var language = "";
    if (window.current_language) {
	language = window.current_language;
    }

    $.ajax({
	url:  language + 'index.php?route=module/neoseo_catch_contacts/process',
	type: 'post',
	data: $('#catchContacts-' + module + ' input[type=\'text\'], #catchContacts-' + module + ' input[type=\'hidden\'], #catchContacts-' + module + ' input[type=\'radio\']:checked, #catchContacts-' + module + ' input[type=\'checkbox\']:checked, #catchContacts-' + module + ' select, #catchContacts-' + module + ' textarea'),
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
		$('#popup-subscribe > div').modal('hide');
		$('.modal-backdrop').remove();
		popupConsultationShow(json);
	    }
	},
	error: function (xhr, ajaxOptions, thrownError) {
	    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	}
    });

}