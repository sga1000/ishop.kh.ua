function shopSimilarProductsPopup(product_id) {
    var language = "";
    if( window.current_language ) {
        language = window.current_language;
    }
    $.ajax({
        url: language + 'index.php?route=module/neoseo_similar_products/popup',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {
            $('.alert, .text-danger').remove();

            if (json['redirect']) {
                location = json['redirect'];
            }

            if (json['popup']) {
                if($("#popupAnalog").length == 0) {
                    $("body").append("<div id=\"popupAnalog\" class=\"popup\"></div>");
                    $("#popupAnalog").html(json["popup"]);
                }

                $.fancybox($('#popupAnalog'), {
                    padding: 0,
                    fitToView: true,
                    height: '80%'
                });

                setTimeout(function() {
                    $("#owl-analog").owlCarousel({
                        //loop:true,
                        dots:false,
                        responsive:{
                            0:{ items:1, dots:false },
                            550:{ items:2, dots:false },
                            992:{ items:3, dots:false },
                            1200:{ items:4 }
                        }
                    });

                    $('#popupAnalog .next').click(function() {

                        var block = $(this).parent().parent().parent().parent().parent();
                        if (!!block.find('.tab-pane.active').text()) {
                            var id = '#' + block.find('.tab-pane.active .owl-carousel').attr('id');
                        } else {
                            var id = '#' + block.find('.owl-carousel').attr('id');
                        }
                        $(id).trigger('next.owl.carousel');
                    });

                    $('#popupAnalog .prev').click(function() {
                        var block = $(this).parent().parent().parent().parent().parent();
                        if (!!block.find('.tab-pane.active').text()) {
                            var id = '#' + block.find('.tab-pane.active .owl-carousel').attr('id');
                        } else {
                            var id = '#' + block.find('.owl-carousel').attr('id');
                        }
                        $(id).trigger('prev.owl.carousel');
                    });
                }, 100);


            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
}