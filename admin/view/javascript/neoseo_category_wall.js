var icon_id = 1;
function megacategorySubmit() {
    jQuery('.category_area #area_column_category_1 li.dd-item').each(function (index, value) {
        if (jQuery(this).children('.dd-list').length > 0) {
            var parent_id = index + 1;
            jQuery(this).children('.dd-list').children('li.dd-item').each(function () {
                jQuery(this).find('input.parent_id').val(parent_id);
            })
        }
    });
    jQuery('.category_area #area_column_category_1').children('.dd-list').children('li').children('.info').children('.hidden-data').children('.parent_id').val(0);
    $(".colorpicker-component").colorpicker();
}

function remove_item(obj) {
    var parent = jQuery(obj).parent();
    jQuery(parent).remove();
}

function add_category(obj, item) {
    jQuery('.right .category_area > ol', jQuery(item).parents('.container_mega_category')).append(obj);
    $(".colorpicker-component").colorpicker();
}

function get_content_obj(obj, container) {
    var url = '';
    var title = jQuery(obj).attr('data');
    var type_id = jQuery(obj).attr('value');
    console.log(obj);

    var lang_title = "";
    for (i = 0; i < langs.length; i++) {
        lang_title += "<div class='input-group input-item'><span class='input-group-addon'><img src='view/image/flags/" + langs[i]["image"] + "' title='" + langs[i]["name"] + "' ></span><input class='form-control' type='text' name='title" + "[" + langs[i]["id"] + "][]' value='" + title + "'  /> </div>";
    }
    var url_title = "";
    for (i = 0; i < langs.length; i++) {
        url_title += "<input type='hidden' name='url" + "[" + langs[i]["id"] + "][]' value=''/>";
    }

    var params_title = "";
    params_title += "<select class='form-control' name='params" + "[]' value='' >";
    params_title += "<option selected='selected' value=''>Обычное</option>";
    params_title += "<option value='mega'>Мега-меню</option>";
    params_title += "</select>";
    var class_title = "";
    class_title += "<input class='form-control' type='text' name='class" + "[]' value='' placeholder='Дополнительный класс' />";

    var style_title = "";
    style_title += "<input class='form-control' type='text' name='style" + "[]' value='' placeholder='Дополнительный стиль' />";

    var icon_title = "";




    icon_title += "<br>"  +
    "<a href='' id='thumb-image-new" + icon_id + "' data-toggle='image' class='img-thumbnail' ><img style='max-width:24px; max-height: 24px;' src='/image/cache/no_image-24x24.png' alt='' title='' data-placeholder='/image/cache/no_image-24x24.png' /></a>" +
    "<input type='hidden' name='icon[]' value='' id='input-image-new-" + icon_id + "' />"
icon_id += 1;
    var max_width_title = "";
    max_width_title += "<input class='form-control' type='text' name='max_width" + "[]' value='' placeholder='Максимальная ширина' />";

    var bg_color_title = "";
    bg_color_title += "<input class='form-control' type='text' name='bg_color" + "[]' value='' placeholder='Цвет фона' />";

    var hover_bg_color_title = "";
    hover_bg_color_title += "<input class='form-control' type='text' name='hover_bg_color" + "[]' value='' placeholder='Цвет фона при наведении' />";

    var font_color_title = "";
    font_color_title += "<input class='form-control' type='text' name='font_color" + "[]' value='' placeholder='Цвет шрифта' />";

    var hover_font_color_title = "";
    hover_font_color_title += "<input class='form-control' type='text' name='hover_font_color" + "[]' value='' placeholder='Цвет шрифта при наведении' />";

    var result =
            "<li class='dd-item'>" +
            "<div class='dd-handle'>" +
            "<div class='bar'>" +
            "<span class='title'>" + jQuery(obj).attr('data') + "</span>" +
            "</div>" +
            "</div>" +
            "<div class='panel panel-default info hide'>" +
            "<div class='panel-body'>" +
            "<input type='hidden' class='type' name='type" + "[]' value='" + jQuery(obj).attr('class') + "'/>" +
            "<input type='hidden' class='parent_id' name='parent_id"  + "[]' value=''/>" +
            "<input type='hidden' class='type_id' name='type_id"  + "[]' value='" + type_id + "'/>" +
            "<div class='form-group'>" +
            "<label>Название: </label>" + lang_title +
            "</div>" +
            "<div class='form-group'><label>" + jQuery(obj).attr('class') + "</label>" + url_title +
            "</div>" +
            "<div class='row'>" +
            "<div class='col-sm-4'>" +
            "<div class='form-group'>" +
            "<label>Дополнительный класс: </label>" + class_title + 
            "</div></div>" +
            "<div class='col-sm-4'>" +
            "<div class='form-group'>" +
            "<label>Дополнительный стиль: </label>" + style_title + 
            "</div>" +
            "</div>" +
            "<div class='col-sm-4'>" +
            "<div class='form-group'>" +
            "<label>Максимальная ширина: </label>" + max_width_title + 
            "</div>" +
            "</div>" +
            "</div>" +
            "<div class='row'>" +
            "<div class='col-sm-6'>" +
            "<div class='form-group'>" +
            "<label>Тип меню: </label>" + params_title + 
            "</div>" +
            "</div>" +
            "<div class='col-sm-6'>" +
            "<div class='form-group'>" +
            "<label>Дополнительная иконка: </label>" + icon_title +
            "</div>" +
            "</div>" +
            "</div>" +
            "<div class='row'>" +
            "<div class='col-sm-6'>" +
            "<label>Цвет фона: </label>" +
            "<div class='input-group colorpicker-component colorpicker-element'>" +
            bg_color_title + 
            "<span class='input-group-addon'><i style='background-color: rgb(94, 142, 228);'></i></span>" +
            "</div>" +
            "<label>Цвет фона при наведении: </label>" +
            "<div class='input-group colorpicker-component colorpicker-element'>" +
            hover_bg_color_title + 
            "<span class='input-group-addon'><i style='background-color: rgb(94, 142, 228);'></i></span>" +
            "</div>" +
            "</div><div class='col-sm-6'>" +
            "<label>Цвет шрифта: </label>" +
            "<div class='input-group colorpicker-component colorpicker-element'>" +
            font_color_title + 
            "<span class='input-group-addon'><i style='background-color: rgb(94, 142, 228);'></i></span>" +
            "</div>" +
            "<label>Цвет шрифта при наведении: </label>" +
            "<div class='input-group colorpicker-component colorpicker-element'>" +
            hover_font_color_title + 
            "<span class='input-group-addon'><i style='background-color: rgb(94, 142, 228);'></i></span>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "<a class='btn btn-xs btn-danger remove' onclick='remove_item(this);'><i class='fa fa-trash-o'></i></a>" +
            "<a class='btn btn-xs btn-default explane' onclick='explane(this)'><i class='fa fa-chevron-down' aria-hidden='true'></i></a>"
    "</li>";
    return result;
}

function get_content_obj_custom(obj, container) {
    var url = jQuery(obj).parent().find('input.url').val();
    var title = jQuery(obj).parent().find('input.title').val();
    
    

    var lang_title = "";
    for (i = 0; i < langs.length; i++) {
        lang_title += "<div class='input-group input-item'><span class='input-group-addon'><img src='view/image/flags/" + langs[i]["image"] + "' title='" + langs[i]["name"] + "' ></span><input class='form-control' type='text' name='title"  + "[" + langs[i]["id"] + "][]' value='" + title + "'  /></div>";
    }

    var url_title = "";
    for (i = 0; i < langs.length; i++) {
        url_title += "   <div class='input-group input-item'><span class='input-group-addon'><img src='view/image/flags/" + langs[i]["image"] + "' title='" + langs[i]["name"] + "' ></span><input class='form-control' type='text' name='url" + "[" + langs[i]["id"] + "][]' value='" + url + "'  /></div>";
    }
    var params_title = "";
    params_title += "<select class='form-control' name='params" + "[]' value='' >";
    params_title += "<option selected='selected' value=''>Обычное</option>";
    params_title += "<option value='mega'>Мега-меню</option>";
    params_title += "</select>";
    var class_title = "";
    class_title += "<input class='form-control' type='text' name='class"  + "[]' value=''  />";

    var style_title = "";
    style_title += "<input class='form-control' type='text' name='style"  + "[]' value=''  />";

    var icon_title = "";
    icon_title += "<br>"  +
        "<a href='' id='thumb-image-new" + icon_id + "' data-toggle='image' class='img-thumbnail' ><img style='max-width:24px; max-height: 24px;' src='/image/cache/no_image-24x24.png' alt='' title='' data-placeholder='/image/cache/no_image-24x24.png' /></a>" +
        "<input type='hidden' name='icon[]' value='' id='input-image-new-" + icon_id + "' />"
    icon_id += 1;

    var max_width_title = "";
    max_width_title += "<input class='form-control' type='text' name='max_width"  + "[]' value=''  />";

    var bg_color_title = "";
    bg_color_title += "<input class='form-control' type='text' name='bg_color"  + "[]' value=''  />";

    var hover_bg_color_title = "";
    hover_bg_color_title += "<input class='form-control' type='text' name='hover_bg_color"  + "[]' value=''  />";

    var font_color_title = "";
    font_color_title += "<input class='form-control' type='text' name='font_color"  + "[]' value=''  />";

    var hover_font_color_title = "";
    hover_font_color_title += "<input class='form-control' type='text' name='hover_font_color"  + "[]' value=''  />";
    

    var result =
            "<li class='dd-item'>" +
            "<div class='dd-handle'>" +
            "<div class='bar'>" +
            "<span class='title'>" + title + "</span>" +
            "</div>" +
            "</div>" +
            "<div class='panel panel-default info hide'>" +
            "<div class='panel-body'>" +
            "<input type='hidden' class='type' name='type"  + "[]' value='custom'/>" +
            "<input type='hidden' class='parent_id' name='parent_id"  + "[]' value=''/>" +
            "<input type='hidden' class='type_id' name='type_id"  + "[]' value=''/>" +
            "<p class='input-item'><span class='type'>Type: Custom</span></p>" +
            "<div class='form-group'>" +
            "<label>Название: </label>" + lang_title +
            "<label>Ссылка: </label>" + url_title +
            "</div>" +
            "<div class='row'>" +
            "<div class='col-sm-4'>" +
            "<div class='form-group'>" +
            "<label>Дополнительный класс: </label>" + class_title + 
            "</div></div>" +
            "<div class='col-sm-4'>" +
            "<div class='form-group'>" +
            "<label>Дополнительный стиль: </label>" + style_title + 
            "</div>" +
            "</div>" +
            "<div class='col-sm-4'>" +
            "<div class='form-group'>" +
            "<label>Максимальная ширина: </label>" + max_width_title + 
            "</div>" +
            "</div>" +
            "</div>" +
            "<div class='row'>" +
            "<div class='col-sm-6'>" +
            "<div class='form-group'>" +
            "<label>Тип меню: </label>" + params_title + 
            "</div>" +
            "</div>" +
            "<div class='col-sm-6'>" +
            "<div class='form-group'>" +
            "<label>Дополнительная иконка: </label>" + icon_title + 
            "</div>" +
            "</div>" +
            "</div>" +
            "<div class='row'>" +
            "<div class='col-sm-6'>" +
            "<label>Цвет фона: </label>" +
            "<div class='input-group colorpicker-component colorpicker-element'>" +
            bg_color_title + 
            "<span class='input-group-addon'><i style='background-color: rgb(94, 142, 228);'></i></span>" +
            "</div>" +
            "<label>Цвет фона при наведении: </label>" +
            "<div class='input-group colorpicker-component colorpicker-element'>" +
            hover_bg_color_title + 
            "<span class='input-group-addon'><i style='background-color: rgb(94, 142, 228);'></i></span>" +
            "</div>" +
            "</div><div class='col-sm-6'>" +
            "<label>Цвет шрифта: </label>" +
            "<div class='input-group colorpicker-component colorpicker-element'>" +
             font_color_title + 
            "<span class='input-group-addon'><i style='background-color: rgb(94, 142, 228);'></i></span>" +
            "</div>" +
            "<label>Цвет шрифта при наведении: </label>" +
            "<div class='input-group colorpicker-component colorpicker-element'>" +
            hover_font_color_title + 
            "<span class='input-group-addon'><i style='background-color: rgb(94, 142, 228);'></i></span>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "</div>" +
            "<a class='btn btn-xs btn-danger remove' onclick='remove_item(this);'><i class='fa fa-trash-o'></i></a>" +
            "<a class='btn btn-xs btn-default explane' onclick='explane(this)'><i class='fa fa-chevron-down' aria-hidden='true'></i></a>" +
            "</li>";
   
    return result;
}
function explane(obj) {
    if (jQuery(obj).parent().children('.info').hasClass('hide') == true) {
        jQuery(obj).parent().children('.info').show();
        jQuery(obj).parent().children('.info').removeClass('hide');
        jQuery(obj).html('<i class="fa fa-chevron-up" aria-hidden="true"></i>');
    } else {
        jQuery(obj).parent().children('.info').hide();
        jQuery(obj).parent().children('.info').addClass('hide');
        jQuery(obj).html('<i class="fa fa-chevron-down" aria-hidden="true"></i>');
    }
}

jQuery(document).ready(function () {
    jQuery('a.add-to-category').click(function () {
        var parent = jQuery(this).parent().children('div');
        var container = jQuery(this).parents('.container_mega_category').attr('id');
        if (container.indexOf("column_category_1") != -1) {
            container = container.replace("column_category_1", "");
        } else {
            container = "";
        }
        jQuery(parent).find('input').each(function () {
            if (jQuery(this).is(':checked')) {
                var obj = get_content_obj(this, container);
                add_category(obj, this);
                jQuery(this).attr('checked', false);
            }
        });
    });


    jQuery('a.add-to-category_custom').click(function () {
        var container = jQuery(this).parents('.container_mega_category').attr('id');

        if (container.indexOf("column_category_1") != -1) {
            container = container.replace("column_category_1", "");
        } else {
            container = "";
        }
        var obj = get_content_obj_custom(this, container);
        add_category(obj, this);
    });

    jQuery('.category_area').nestable({
        group: 1
    });
	jQuery(".category_area").nestable('collapseAll');
});