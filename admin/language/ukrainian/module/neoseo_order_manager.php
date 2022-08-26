<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Менеджер замовлень</p>';
$_['heading_title_raw'] = 'NeoSeo Менеджер замовлень';

//Tabs
$_['tab_general'] = 'Загальні';
$_['tab_support'] = 'Підтримка';
$_['tab_logs'] = 'Логи';
$_['tab_license'] = 'Ліцензія';
$_['tab_columns'] = 'Колонки';
$_['tab_buttons'] = 'Кнопки';
$_['tab_products'] = 'Продукти';
$_['tab_history'] = 'Історія';
$_['tab_allowed'] = 'Обмеження статусів';
$_['tab_colors'] = 'Кольору';
$_['tab_fields'] = 'Поля';

//Button
$_['button_save'] = 'Зберегти';
$_['button_save_and_close'] = 'Зберегти і Закрити';
$_['button_close'] = 'Закрити';
$_['button_recheck'] = 'Перевірити ще раз';
$_['button_clear_log'] = 'Очистити логи';
$_['button_download_log'] = 'Завантажити файл логів';
$_['button_save_allowed'] = 'Зберегти набір дозволів';

// Text
$_['text_module_version'] = '';
$_['text_edit'] = 'Параметри';
$_['text_success'] = 'Налаштування модуля успішно оновлені!';
$_['text_success_clear'] = 'Список успішно видалені';
$_['text_clear_log'] = 'Очистити лог';
$_['text_clear'] = 'Очистити';
$_['text_image_manager'] = 'Менеджер зображень';
$_['text_browse'] = 'Огляд';
$_['text_module'] = 'Модулі';
$_['text_product'] = '<p><a href="/admin/index.php?route=catalog/product/edit&amp;token={product.token}&amp;product_id={product.product_id}">{product.image}</a><a href="/admin/index.php?route=catalog/product/edit&amp;token={product.token}&amp;product_id={product.product_id}">{order_product.name}</a><br />{order_product.quantity}&nbsp;x&nbsp;{order_product.price}&nbsp;&nbsp;{product.sku}</p>';
$_['text_history'] = '{order_history.date_added}{order_status.status}{user.username}{order_history.comment}';
$_['text_list_columns'] = 'Управління колонками замовлення';
$_['text_add'] = 'Додавання';
$_['text_edit'] = 'Редагування';
$_['test_columns_format_header'] = 'Управління колонками замовлення';
$_['test_buttons_format_header'] = 'Управління кнопками замовлення';
$_['test_columns_format_desc'] = 'Опис роботи з колонками';
$_['test_buttons_format_desc'] = 'Опис роботи з кнопками';
$_['text_edited'] = ', можливість редагування';

// Entry
$_['entry_status'] = 'Статус:';
$_['entry_status_desc'] = 'Вдосконалена система розподілу ресурсів замовленнями є в меню Продажі / Менеджер замовлень';
$_['entry_debug'] = 'Налагоджувальний режим:';
$_['entry_debug_desc'] = 'В системні логи буде писатися різна інформація для розробника модуля';
$_['entry_replace_system_status'] = 'Прибрати стандартний:';
$_['entry_replace_system_status_desc'] = 'Стандартний Менеджер замовлень буде приховано';
$_['entry_hide_unavailable'] = 'Ховати недоступний:';
$_['entry_hide_unavailable_desc'] = 'Якщо користувачеві не доступні права на перегляд замовлень, то він не побачить цей пункт меню';
$_['entry_visible_statuses'] = 'Відображені статуси:';
$_['entry_visible_statuses_desc'] = 'Показує тільки ті замовлення, у яких статус відзначений галочкою в цьому списку. Хороший спосіб відфільтрувати вже виконані замовлення';
$_['entry_block_send_comment'] = 'Відображається блок повідомлень:';
$_['entry_block_send_comment_desc'] = 'Показує в колонці "Дії" блок ручної відправки SMS і E-mail повідомлень клієнту';
$_['entry_cl_name'] = 'Назва';
$_['entry_cl_align'] = 'Вирівнювання';
$_['entry_cl_pattern'] = 'Шаблон';
$_['entry_cl_width'] = 'Ширина';
$_['entry_product'] = 'Формат списку продуктів:';
$_['entry_history'] = 'Формат історії зміни статусів замовлення';
$_['entry_action'] = 'Дія';
$_['entry_action_add'] = 'Створити';
$_['entry_action_edit'] = 'Редагувати';
$_['entry_action_delete'] = 'Видалити';
$_['entry_field_list_name'] = 'Шаблон';
$_['entry_field_list_desc'] = 'Опис';
$_['entry_bt_name'] = 'Назва';
$_['entry_bt_class'] = 'Клас';
$_['entry_bt_style'] = 'Стиль';
$_['entry_bt_link'] = 'Посилання';
$_['entry_bt_script'] = 'Код скрипта';
$_['entry_bt_post'] = 'POST-параметри';
$_['entry_format_header'] = 'Обмеження на зміну статусів замовлення:';
$_['entry_format_header_desc'] = 'Стосується зміни статусу замовлення при перегляді і редагуванні замовлення';
$_['entry_status_list_for_allow'] = 'Базовий набір статусів';
$_['entry_allowed_status_list'] = 'Дозволений набір статусів при зміні';

//Field
$_['field_desc_order_id'] = 'Номер замовлення';
$_['field_desc_status'] = 'Статус замовлення';
$_['field_desc_date_added'] = 'Дата створення замовлення';
$_['field_desc_total'] = 'Загальна вартість замовлення';
$_['field_desc_firstname'] = 'Ім\'я покупця';
$_['field_desc_lastname'] = 'Прізвище покупця';
$_['field_desc_telephone'] = 'Номер телефону покупця';
$_['field_desc_email'] = 'Електронна адреса покупця';
$_['field_desc_shipping_address_1'] = 'Адреса доставки 1';
$_['field_desc_shipping_address_2'] = 'Адреса доставки 2';
$_['field_desc_shipping_city'] = 'Місто доставки';
$_['field_desc_payment_method'] = 'Спосіб оплати';
$_['field_desc_shipping_method'] = 'Метод доставки';
$_['field_desc_shipping_zone'] = 'Зона доставки';
$_['field_desc_comment'] = 'Примітка';
$_['field_desc_status_select'] = 'Статус замовлення з можлівістю Зміни';
$_['field_desc_custom_fields'] = 'Додаткові поля з таблиці order_scfield. Приклад custom_additional - де custom_ - обов\'язкове початок для доп. полів, additional - ім\'я поля';
$_['field_desc_store_id'] = 'Висновок id магазину до якого належить замовлення';
$_['field_desc_store_name'] = 'Висновок назви магазину до якого належить замовлення';
$_['shipping_custom_field'] = 'Додаткові поля в адресі доставки, де "id" = 1,2,3, ... - код додаткового поля';

//Params
$_['params_colors'] = 'a:14:{i:0;s:0:"";i:1;a:2:{i:0;s:18:"rgb(255, 255, 203)";i:1;s:18:"rgb(255, 255, 203)";}i:2;a:2:{i:0;s:18:"rgb(255, 255, 203)";i:1;s:18:"rgb(255, 255, 203)";}i:3;a:2:{i:0;s:18:"rgb(187, 223, 141)";i:1;s:18:"rgb(187, 223, 141)";}i:4;s:0:"";i:5;a:2:{i:0;s:18:"rgb(187, 223, 141)";i:1;s:18:"rgb(187, 223, 141)";}i:6;s:0:"";i:7;a:2:{i:0;s:18:"rgb(255, 160, 153)";i:1;s:18:"rgb(255, 160, 153)";}i:8;a:2:{i:0;s:18:"rgb(255, 160, 153)";i:1;s:18:"rgb(255, 160, 153)";}i:9;a:2:{i:0;s:18:"rgb(255, 160, 153)";i:1;s:18:"rgb(255, 160, 153)";}i:10;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}i:11;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}i:12;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}i:13;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}}';
$_['params_num'] = array(0 => 'Парний',
	1 => 'Непарний'
);

// Error
$_['error_permission'] = 'У Вас недостатньо прав для зміни "NeoSeo Резервні копії"!';
$_['error_download_logs'] = 'Файл логів порожній або відсутній!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['error_delete'] = 'Помилка: Ви намагаєтеся видалити неіснуючий об\'єкт!';
$_['mail_support'] = '';
$_['module_licence'] = '';