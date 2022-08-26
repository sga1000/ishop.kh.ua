var icon_id = 1;
var image_id = 1;
var infoblock_image_id = 9999;
function megamenuSubmit() {
    jQuery('.menu_area #area_column_menu_1 li.dd-item').removeAttr("category_id").removeAttr("parent_id");
    jQuery('.menu_area #area_column_menu_1 li.dd-item').each(function (index, value) {
        if (jQuery(this).parent('.dd-item .dd-list').length <= 0) {
            jQuery(this).find('input.parent_id').val(0);
        }
        if (jQuery(this).children('.dd-list').length > 0) {
            var parent_id = index + 1;
            jQuery(this).children('.dd-list').children('li.dd-item').each(function () {
                jQuery(this).find('input.parent_id').val(parent_id);
            })
        }
    });
    jQuery('.menu_area #area_column_menu_1').children('.dd-list').children('li').children('.info').children('.hidden-data').children('.parent_id').val(0);
    $(".colorpicker-component").colorpicker();
}

function remove_item(obj) {
    var parent = jQuery(obj).parent();
    jQuery(parent).remove();
}

function add_menu(obj, item) {
    jQuery('.right .menu_area > ol', jQuery(item).parents('.container_mega_menu')).append(obj);
    $(".colorpicker-component").colorpicker();
}

function get_content_obj(obj, container) {
    var url = '';
    var title = jQuery(obj).attr('data');
    var type_id = jQuery(obj).attr('value');
    var parent_id = jQuery(obj).attr('parent');
    var category_data = " category_id='" + type_id + "'";
    if (parent_id)
        category_data += " parent_id='" + parent_id + "'";
    //console.log(obj);

    var lang_title = "";
    for (i = 0; i < langs.length; i++) {
        lang_title += "<div class='input-group input-item'><span class='input-group-addon'><img src='view/image/flags/" + langs[i]["image"] + "' title='" + langs[i]["name"] + "' ></span><input class='form-control' type='text' name='title" + "[" + langs[i]["id"] + "][]' value='" + title + "'  /> </div>";
    }

    var lang_description = ""; /*T.R.description*/
    for (i = 0; i < langs.length; i++) {
        lang_description += "<div class='input-group input-item'><span class='input-group-addon'><img src='view/image/flags/" + langs[i]["image"] + "' title='" + langs[i]["name"] + "' ></span><input class='form-control' type='text' name='custom_description" + "[" + langs[i]["id"] + "][]' value='" + title + "'  /> </div>";
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




    icon_title += "<br>" +
        "<a href='' id='thumb-image-new" + icon_id + "' data-toggle='image' class='img-thumbnail' ><img style='max-width:24px; max-height: 24px;' src='/image/cache/no_image-24x24.png' alt='' title='' data-placeholder='/image/cache/no_image-24x24.png' /></a>" +
        "<input type='hidden' name='icon[]' value='' id='input-image-new-" + icon_id + "' />"
    icon_id += 1;
    var max_width_title = "";
    max_width_title += "<input class='form-control' type='text' name='max_width" + "[]' value='' placeholder='Максимальная ширина' />";

    var image_position = "";
    image_position += "<br>" +
        "<a href='' id='thumb-image-main-" + image_id + "' data-toggle='image' class='img-thumbnail' ><img style='max-width:100px; max-height: 100px;' src='/image/cache/no_image-100x100.png' alt='' title='' data-placeholder='/image/cache/no_image-100x100.png' /></a>" +
        "<input type='hidden' name='image[]' value='' id='input-image-main-" + image_id + "' />" +
        "<select name='image_position[]' id='image-position'>" +
        "<option value='image_background' selected='selected'>Изображение фоном</option>" +
        "<option value='image_box' >Изображение в меню</option>" +
        "</select>"
    image_id += 1;

    var image_width = "";
    image_width += "<input class='form-control' type='text' name='image_width" + "[]' value='' placeholder='Ширина изображения' />";

    var image_height = "";
    image_height += "<input class='form-control' type='text' name='image_height" + "[]' value='' placeholder='Высота изображения' />";

    var bg_color_title = "";
    bg_color_title += "<input class='form-control' type='text' name='bg_color" + "[]' value='' placeholder='Цвет фона' />";

    var hover_bg_color_title = "";
    hover_bg_color_title += "<input class='form-control' type='text' name='hover_bg_color" + "[]' value='' placeholder='Цвет фона при наведении' />";

    var font_color_title = "";
    font_color_title += "<input class='form-control' type='text' name='font_color" + "[]' value='' placeholder='Цвет шрифта' />";

    var hover_font_color_title = "";
    hover_font_color_title += "<input class='form-control' type='text' name='hover_font_color" + "[]' value='' placeholder='Цвет шрифта при наведении' />";

    var result =
        "<li class='dd-item'" + category_data + ">" +
        "<div class='dd-handle'>" +
        "<div class='bar'>" +
        "<span class='title'>" + jQuery(obj).attr('data') + "</span>" +
        "</div>" +
        "</div>" +
        "<div class='panel panel-default info hide'>" +
        "<div class='panel-body'>" +
        "<input type='hidden' class='type' name='type" + "[]' value='" + jQuery(obj).attr('class') + "'/>" +
        "<input type='hidden' class='parent_id' name='parent_id" + "[]' value=''/>" +
        "<input type='hidden' class='type_id' name='type_id" + "[]' value='" + type_id + "'/>" +
        "<div class='form-group'>" +
        "<label>Название: </label>" + lang_title +
        "</div>" +
        "<div class='form-group'>" +
        "<label>Описание: </label>" + lang_description + /*T.R.description*/
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
        "<div class='col-sm-4'>" +
        "<div class='form-group image-position'>" +
        "<label>Изображение в меню: </label>" + image_position +
        "</div>" +
        "</div>" +
        "<div class='col-sm-4'>" +
        "<div class='form-group'>" +
        "<label>Ширина изображения: </label>" + image_width +
        "</div>" +
        "</div>" +
        "<div class='col-sm-4'>" +
        "<div class='form-group'>" +
        "<label>Высота  изображения: </label>" + image_height +
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
        "<div class='panel panel-default' style='margin-top: 15px;'>" +
        "<div class='panel-heading'>Инофрмационный блок при открытии меню</div>" +
        "<div class='panel-body'>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Использовать инфоблок</label>" +
        "<select name='infoblock_status[]' class='form-control'>" +
        "<option value='1'>Включено</option>" +
        "<option value='0' selected=''>Отключено</option>" +
        "</select>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Положение информационного блока</label>" +
        "<select name='infoblock_position[]' class='form-control'>" +
        "<option value='left'>Слева</option>" +
        "<option value='right' selected=''>Справа</option>" +
        "</select>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'><div class='form-group'>" +
        "<label>Заголовок инфоблока</label>" +
        "<div class='input-group input-item'>" +
        "<span class='input-group-addon'><img src='view/image/flags/ru.png' title='Russian'></span>" +
        "<input class='form-control' type='text' name='infoblock_title[1][]' value=''>" +
        "</div>" +
        "<div class='input-group input-item'>" +
        "<span class='input-group-addon'><img src='view/image/flags/gb.png' title='English'></span>" +
        "<input class='form-control' type='text' name='infoblock_title[2][]' value=''>" +
        "</div>" +
        "</div>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'><div class='form-group'>" +
        "<label>Ссылка инфоблока</label>" +
        "<div class='input-group input-item'>" +
        "<span class='input-group-addon'><img src='view/image/flags/ru.png' title='Russian'></span>" +
        "<input class='form-control' type='text' name='infoblock_link[1][]' value=''>" +
        "</div>" +
        "<div class='input-group input-item'>" +
        "<span class='input-group-addon'><img src='view/image/flags/gb.png' title='English'></span>" +
        "<input class='form-control' type='text' name='infoblock_link[2][]' value=''>" +
        "</div>" +
        "</div>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Класс для элементов инфоблока</label>" +
        "<input name='infoblock_main_class[]' class='form-control' value=''>" +
        "</div>" +
        "</div>" +
        "<div class='col-sm-12'>" +
        "<label class='control-label' for='input-infoblock-image-" + infoblock_image_id + "'>Изображение инфоблока</label>" +
        "<br>" +
        "<a href='' id='infoblock-image-" + infoblock_image_id + "' data-toggle='image' class='img-thumbnail'><img style='max-width:100px; max-height: 100px;' src='http://ocart.local/image/cache/no_image-100x100.png' alt='' title='' data-placeholder='/image/cache/no_image-24x24.png'></a>" +
        "<input type='hidden' name='infoblock_image[]' value='' id='input-infoblock-image-" + infoblock_image_id + "'>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Ширина изображения информационного блока</label>" +
        "<input name='infoblock_image_width[]' class='form-control' value='0'>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Высота изображения информационного блока</label>" +
        "<input name='infoblock_image_height[]' class='form-control' value='0'>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Показывать кнопку купить</label>" +
        "<select name='infoblock_show_by_button[]' class='form-control'>" +
        "<option value='1'>Включено</option>" +
        "<option value='0' selected=''>Отключено</option>" +
        "</select>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Связанный продукт</label>" +
        "<input name='infoblock_product_name[]' data-pid='" + infoblock_image_id + "' class='form-control products-ac' value=''>" +
        "<input name='infoblock_product_id[]' id='infoblock_product_id_" + infoblock_image_id + "' class='form-control' type='hidden' value='0'>" +
        "</div>" +
        "</div>" +
        "</div><!-- -->" +
        "</div>" +
        "</div>" +
        "<a class='btn btn-xs btn-danger remove' onclick='remove_item(this);'><i class='fa fa-trash-o'></i></a>" +
        "<a class='btn btn-xs btn-default explane' onclick='explane(this)'><i class='fa fa-chevron-down' aria-hidden='true'></i></a>"
    "</li>";
    infoblock_image_id += 1;
    return result;
}

function get_content_obj_custom(obj, container) {
    var url = jQuery(obj).parent().find('input.url').val();
    var title = jQuery(obj).parent().find('input.title').val();


    var lang_title = "";
    for (i = 0; i < langs.length; i++) {
        lang_title += "<div class='input-group input-item'><span class='input-group-addon'><img src='view/image/flags/" + langs[i]["image"] + "' title='" + langs[i]["name"] + "' ></span><input class='form-control' type='text' name='title" + "[" + langs[i]["id"] + "][]' value='" + title + "'  /></div>";
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
    class_title += "<input class='form-control' type='text' name='class" + "[]' value=''  />";

    var style_title = "";
    style_title += "<input class='form-control' type='text' name='style" + "[]' value=''  />";

    var icon_title = "";
    icon_title += "<br>" +
        "<a href='' id='thumb-image-new" + icon_id + "' data-toggle='image' class='img-thumbnail' ><img style='max-width:24px; max-height: 24px;' src='/image/cache/no_image-24x24.png' alt='' title='' data-placeholder='/image/cache/no_image-24x24.png' /></a>" +
        "<input type='hidden' name='icon[]' value='' id='input-image-new-" + icon_id + "' />"
    icon_id += 1;

    var max_width_title = "";
    max_width_title += "<input class='form-control' type='text' name='max_width" + "[]' value=''  />";

    var image_position = "";
    image_position += "<br>" +
        "<a href='' id='thumb-image-main-" + image_id + "' data-toggle='image' class='img-thumbnail' ><img style='max-width:100px; max-height: 100px;' src='/image/cache/no_image-100x100.png' alt='' title='' data-placeholder='/image/cache/no_image-100x100.png' /></a>" +
        "<input type='hidden' name='image[]' value='' id='input-image-main-" + image_id + "' />" +
        "<select name='image_position[]' id='image-position'>" +
        "<option value='image_background' selected='selected'>Изображение фоном</option>" +
        "<option value='image_box' >Изображение в меню</option>" +
        "</select>"
    image_id += 1;

    var image_width = "";
    image_width += "<input class='form-control' type='text' name='image_width" + "[]' value='' placeholder='Ширина изображения' />";

    var image_height = "";
    image_height += "<input class='form-control' type='text' name='image_height" + "[]' value='' placeholder='Высота изображения' />";

    var bg_color_title = "";
    bg_color_title += "<input class='form-control' type='text' name='bg_color" + "[]' value=''  />";

    var hover_bg_color_title = "";
    hover_bg_color_title += "<input class='form-control' type='text' name='hover_bg_color" + "[]' value=''  />";

    var font_color_title = "";
    font_color_title += "<input class='form-control' type='text' name='font_color" + "[]' value=''  />";

    var hover_font_color_title = "";
    hover_font_color_title += "<input class='form-control' type='text' name='hover_font_color" + "[]' value=''  />";


    var result =
        "<li class='dd-item'>" +
        "<div class='dd-handle'>" +
        "<div class='bar'>" +
        "<span class='title'>" + title + "</span>" +
        "</div>" +
        "</div>" +
        "<div class='panel panel-default info hide'>" +
        "<div class='panel-body'>" +
        "<input type='hidden' class='type' name='type" + "[]' value='custom'/>" +
        "<input type='hidden' class='parent_id' name='parent_id" + "[]' value=''/>" +
        "<input type='hidden' class='type_id' name='type_id" + "[]' value=''/>" +
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
        "<div class='col-sm-4'>" +
        "<div class='form-group image-position'>" +
        "<label>Изображение в меню: </label>" + image_position +
        "</div>" +
        "</div>" +
        "<div class='col-sm-4'>" +
        "<div class='form-group'>" +
        "<label>Ширина изображения: </label>" + image_width +
        "</div>" +
        "</div>" +
        "<div class='col-sm-4'>" +
        "<div class='form-group'>" +
        "<label>Высота  изображения: </label>" + image_height +
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
        "<div class='panel panel-default' style='margin-top: 15px;'>" +
        "<div class='panel-heading'>Инофрмационный блок при открытии меню</div>" +
        "<div class='panel-body'>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Использовать инфоблок</label>" +
        "<select name='infoblock_status[]' class='form-control'>" +
        "<option value='1'>Включено</option>" +
        "<option value='0' selected=''>Отключено</option>" +
        "</select>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Положение информационного блока</label>" +
        "<select name='infoblock_position[]' class='form-control'>" +
        "<option value='left'>Слева</option>" +
        "<option value='right' selected=''>Справа</option>" +
        "</select>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'><div class='form-group'>" +
        "<label>Заголовок инфоблока</label>" +
        "<div class='input-group input-item'>" +
        "<span class='input-group-addon'><img src='view/image/flags/ru.png' title='Russian'></span>" +
        "<input class='form-control' type='text' name='infoblock_title[1][]' value=''>" +
        "</div>" +
        "<div class='input-group input-item'>" +
        "<span class='input-group-addon'><img src='view/image/flags/gb.png' title='English'></span>" +
        "<input class='form-control' type='text' name='infoblock_title[2][]' value=''>" +
        "</div>" +
        "</div>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'><div class='form-group'>" +
        "<label>Ссылка инфоблока</label>" +
        "<div class='input-group input-item'>" +
        "<span class='input-group-addon'><img src='view/image/flags/ru.png' title='Russian'></span>" +
        "<input class='form-control' type='text' name='infoblock_link[1][]' value=''>" +
        "</div>" +
        "<div class='input-group input-item'>" +
        "<span class='input-group-addon'><img src='view/image/flags/gb.png' title='English'></span>" +
        "<input class='form-control' type='text' name='infoblock_link[2][]' value=''>" +
        "</div>" +
        "</div>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Класс для элементов инфоблока</label>" +
        "<input name='infoblock_main_class[]' class='form-control' value=''>" +
        "</div>" +
        "</div>" +
        "<div class='col-sm-12'>" +
        "<label class='control-label' for='input-infoblock-image'>Изображение инфоблока</label>" +
        "<br>" +
        "<a href='' id='infoblock-image-" + infoblock_image_id + "' data-toggle='image' class='img-thumbnail'><img style='max-width:100px; max-height: 100px;' src='http://ocart.local/image/cache/no_image-100x100.png' alt='' title='' data-placeholder='/image/cache/no_image-24x24.png'></a>" +
        "<input type='hidden' name='infoblock_image[]' value='' id='input-infoblock-image-" + infoblock_image_id + "'>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Ширина изображения информационного блока</label>" +
        "<input name='infoblock_image_width[]' class='form-control' value='0'>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Высота изображения информационного блока</label>" +
        "<input name='infoblock_image_height[]' class='form-control' value='0'>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Показывать кнопку купить</label>" +
        "<select name='infoblock_show_by_button[]' class='form-control'>" +
        "<option value='1'>Включено</option>" +
        "<option value='0' selected=''>Отключено</option>" +
        "</select>" +
        "</div>" +
        "</div>" +
        "<div class='row'><div class='col-sm-12'>" +
        "<label>Связанный продукт</label>" +
        "<input name='infoblock_product_name[]' data-pid='" + infoblock_image_id + "' class='form-control products-ac' value=''>" +
        "<input name='infoblock_product_id[]' id='infoblock_product_id_" + infoblock_image_id + "' class='form-control' type='hidden' value='0'>" +
        "</div>" +
        "</div>" +
        "</div><!-- -->" +
        "</div>" +
        "</div>" +
        "<a class='btn btn-xs btn-danger remove' onclick='remove_item(this);'><i class='fa fa-trash-o'></i></a>" +
        "<a class='btn btn-xs btn-default explane' onclick='explane(this)'><i class='fa fa-chevron-down' aria-hidden='true'></i></a>" +
        "</li>";
    infoblock_image_id += 1;
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
    jQuery('a.add-to-menu').click(function () {
        var parent = jQuery(this).parent().children('div');
        var container = jQuery(this).parents('.container_mega_menu').attr('id');
        if (container.indexOf("column_menu_1") != -1) {
            container = container.replace("column_menu_1", "");
        } else {
            container = "";
        }
        jQuery(parent).find('input').each(function () {
            if (jQuery(this).is(':checked')) {
                var obj = get_content_obj(this, container);
                add_menu(obj, this);
                jQuery(this).attr('checked', false);
            }
        });
    });


    jQuery('a.add-to-menu_custom').click(function () {
        var container = jQuery(this).parents('.container_mega_menu').attr('id');

        if (container.indexOf("column_menu_1") != -1) {
            container = container.replace("column_menu_1", "");
        } else {
            container = "";
        }
        var obj = get_content_obj_custom(this, container);
        add_menu(obj, this);
    });

    jQuery('a.generate-menu-category').click(function () {
        $(".well.category-block").find(':checkbox:visible').prop('checked', true);

        console.log("generate-menu-category");

        var parent = jQuery(this).parent().children('div');
        var container = jQuery(this).parents('.container_mega_menu').attr('id');
        if (container.indexOf("column_menu_1") != -1) {
            container = container.replace("column_menu_1", "");
        } else {
            container = "";
        }
        jQuery(parent).find('input').each(function () {
            if (jQuery(this).is(':checked')) {
                $(this).attr("data", $(this).attr("data").split(">").slice(-1).pop().trim());
                var obj = get_content_obj(this, container);
                add_menu(obj, this);
                jQuery(this).attr('checked', false);
            }
        });

        jQuery(".dd.menu_area").find('.dd-item[parent_id]').each(function () {
            var parent_id = $(this).attr("parent_id");
            var $parent = $('.dd-item[category_id="' + parent_id + '"]');

            if (parent_id == 25) {
               // console.log($parent.attr("category_id"));
            }


            var $ol = $parent.find("ol.dd-list");
            if (!$ol.length) {
                $parent.append('<ol class="dd-list"></ol>');
                $ol = $parent.find("ol.dd-list");
                $parent.prepend('<button data-action="expand" type="button" style="display: block;">Expand</button>');
                $parent.prepend('<button data-action="collapse" type="button" style="display: none;">Collapse</button>');
            }

            $(this).appendTo($ol);

        });

        jQuery('.menu_area').nestable('collapseAll');


        $(".well.category").find(':checkbox:visible').prop('checked', false);
    });

    jQuery('.menu_area').nestable({
        group: 1
    });
    jQuery(".menu_area").nestable('collapseAll');
});