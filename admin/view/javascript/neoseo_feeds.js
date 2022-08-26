function showExport(json) {
    if ($("#popup-export").length == 0) {
        $("body").append("<div id=\"popup-export\"></div>");
        $("#popup-export").html(json["popup-export"]);
        $("#popup-export .modal-body").html(json["popup-export-body"]);
        $('#popup-export > div').modal();
    } else {
        $("#popup-export .modal-body").html(json["popup-export-body"]);
        $('#popup-export > div').modal();
    }
}

function doExport(cod) {
    var language = "";
    var token = $('a[name=\'' + cod + '\']').data('token');

    if (window.current_language) {
        language = window.current_language;
    }
    $.ajax({
        url: language + 'index.php?route=feed/neoseo/' + cod + '_feed/getDoExport&token=' + token,
        type: 'post',
        dataType: 'json',
        success: function (json) {
            showExport(json);
        }
    });
}
