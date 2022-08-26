<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Оптимизатор</p>';
$_['heading_title_raw'] = 'NeoSeo Оптимизатор';

$_['tab_general'] = 'Параметры';
$_['tab_images'] = 'Сжатие Изображений';
$_['tab_js_scripts'] = 'Сжатие JavaScript';
$_['tab_css_scripts'] = 'Сжатие CSS';
$_['tab_html'] = 'Сжатие HTML';
$_['tab_profiler'] = 'Профайлер';
$_['tab_logs'] = 'Логи';
$_['tab_support'] = 'Поддержка';
$_['tab_license'] = 'Лицензия';

// Text
$_['text_module_version']= '';
$_['text_success'] = 'Настройки модуля обновлены!';
$_['text_module'] = 'Модули';
$_['text_success_clear'] = 'Лог файл успешно очищен!';
$_['text_purged'] = 'Очищенно %s файлов';
$_['text_jpegoptim'] = 'jpegoptim';
$_['text_mozjpeg'] = 'mozjpeg';
$_['text_pngout'] = 'pngout';
$_['text_optipng'] = 'optipng';
$_['text_gd'] = 'GD';
$_['text_imagick'] = 'ImageMagic';

// Button
$_['button_save'] = 'Сохранить';
$_['button_save_and_close'] = 'Сохранить и Закрыть';
$_['button_close'] = 'Закрыть';
$_['button_recheck'] = 'Проверить еще раз';
$_['button_clear_log'] = 'Очистить лог';
$_['button_clear_page_cache'] = 'Очистка постраничного кеша';
$_['button_clear_page_cache_expire'] = 'Очистить только истекшие файлы';
$_['button_download_log'] = 'Скачать логи';

// Entry
$_['entry_status'] = 'Статус:';
$_['entry_debug'] = 'Отладочный режим:';
$_['entry_image_dir_list']     = "Директория изображений для сжатия";
$_['entry_image_dir_list_desc']     = "Корневой каталог - сайт";
$_['entry_sync_link']       = 'Ссылка для запуска сжатия изображений';
$_['entry_cron']            = 'Команда для cron';
$_['entry_cron_cpanel']     = 'Команда для cron в cpanel';
$_['entry_profile'] = 'Профайлер';
$_['entry_minify_css'] = 'Сжимать CSS';
$_['entry_minify_js'] = 'Сжимать JS';
$_['entry_minify_html'] = 'Сжимать HTML';
$_['entry_compress_level'] = 'Степень сжатия изображений';
$_['entry_page_to_cache'] = 'Полностраничное кеширование (beta)';
$_['entry_cache_url_limit'] = 'Не кешировать адреса';
$_['entry_expire_cache'] = 'Время жизни кеша, сек.';
$_['entry_jpg_driver'] = 'Сжатие изображений формата JPEG с помощью:';
$_['entry_png_driver'] = 'Сжатие изображений формата PNG с помощью:';
$_['entry_png_to_webp'] = 'Сгенерировать изображения в формате webp:';
$_['entry_png_to_webp_desc'] = 'Для использования формата webp необходимо перенаправлять изображения из png на webp в .htaccess';
$_['entry_webp_converter'] = 'Библиотека для создания изображений webp:';
$_['entry_png_compress'] = 'Уровень сжатия формат PNG:';
$_['entry_png_compress_desc'] = 'Рекомендуется уровень 5';
$_['entry_js_tag'] = 'Укажите дополнительные теги для скриптов js: ';
$_['entry_js_tag_desc'] = 'Данные теги будет добавлены в каждом элементе подключения скриптов. Например rel=preload';
$_['entry_js_untag_list'] = 'Исключение файлов скриптов где теги не нужены';
$_['entry_js_untag_list_desc'] = 'Укажите наименование файлов скриптов для которых необходимо исключить доп. теги. <br>Каждый файл с новой строки';
$_['entry_js_defer'] = 'Метод загрузки js defer:';
$_['entry_js_defer_desc'] = 'Ко всем скриптам будет добавлен тег defer. Defer - выносит скрипт из общего потока, относительный порядок загрузки скриптов с defer будет сохранён';
$_['entry_js_undefer'] = 'Исключить библиотки для defer';
$_['entry_js_undefer_desc'] = 'Укажите наименования файлов библиотеки которые будут без тега defer. <br>Каждый файл с новой строки';
$_['entry_js_defer_page_list'] = 'Укажите старницы где необходимо отключать использование тегов defer и async';
$_['entry_js_defer_page_list_desc'] = 'Укажите старницы на которых тег defer и async не будет добавляться, например checkout';
$_['entry_js_async_list'] = 'Укажите библиотеки для async загрузки';
$_['entry_js_async_list_desc'] = 'Укажите наименования файлов библиотеки которые будут с тегом async. Async - скрипт будет загружаться асиннхронно, в том порядке как успеет загрузится. <br>Каждый файл с новой строки';
$_['entry_js_unpack_list'] = 'Распаковать библиотеки в тело html';
$_['entry_js_unpack_list_desc'] = 'Укажите наименование билиотек которые необходимо полностью вывести в html код. <br>Каждый файл с новой строки';
$_['entry_js_footer_list'] = 'Переместить скрипты к подвалу странице';
$_['entry_js_footer_list_desc'] = 'Укажите наименование скриптов которые необходимо прикрепить к концу странице. <br>Каждый файл с новой строки';
$_['entry_css_unpack_list'] = 'Распаковать стили в тело html';
$_['entry_css_unpack_list_desc'] = 'Укажите наименование стилей которые необходимо полностью вывести в html код. <br>Каждый файл с новой строки';
$_['entry_css_footer_list'] = 'Переместить стили к подвалу странице';
$_['entry_css_footer_list_desc'] = 'Укажите наименование стилей которые необходимо прикрепить к концу странице. <br>Каждый файл с новой строки';
$_['entry_css_tag'] = 'Укажите тег для подключения стилей: ';
$_['entry_css_tag_desc'] = 'Данный тег будет добавлен в каждом элементе подключения стилей. Например media="none" onload="if(media!=\'all\')media=\'all\'"';
$_['entry_css_untag_list'] = 'Исключение файлов стилей где тег не нужен';
$_['entry_css_untag_list_desc'] = 'Укажите наименование файлов стилей для которых необходимо исключить доп. тег. <br>Каждый файл с новой строки';
$_['entry_img_lazy_load'] = 'Применить LazyLoad (blazy.js) для всех изображений: ';
$_['entry_img_lazy_load_desc'] = 'Данная настройка активирует включение системы LazyLoad (отсроченная загрузка изображений) для всех img';
$_['entry_img_unlazy_load'] = 'Исключение img тегов по классу для LazyLoad';
$_['entry_img_unlazy_load_desc'] = 'Укажите название класса которые необходимо исключить для LazyLoad изображений. <br>Каждый класс с новой строки';
$_['entry_img_lazy_src'] = 'Изображение для placeholder для LazyLoad:';
$_['entry_img_lazy_src_desc'] = 'Укажите изображение которое будет использоваться как подложка для предзагрузки изображения.';

// Error
$_['error_permission']   = 'Warning: You do not have permission to modify account module!';
$_['error_empty_folder']   = 'Specify a directory.';
$_['error_zip_archive_missing'] = '<h3 style="color:red">The php-class <b>ZipArchive</b> is missing.</h3><p>The backup cannot be made without this class. Please contact your hosting provider.</p>';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';

$_['mail_support'] = '';
$_['module_licence'] = '';


