<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Менеджер заказов</p>';
$_['heading_title_raw'] = 'NeoSeo Менеджер заказов';

//Tabs
$_['tab_general'] = 'Общие';
$_['tab_support'] = 'Поддержка';
$_['tab_logs'] = 'Логи';
$_['tab_license'] = 'Лицензия';
$_['tab_columns'] = 'Колонки';
$_['tab_buttons'] = 'Кнопки';
$_['tab_products'] = 'Продукты';
$_['tab_history'] = 'История';
$_['tab_allowed'] = 'Ограничение статусов';
$_['tab_colors'] = 'Цвета';
$_['tab_fields'] = 'Поля';

//Button
$_['button_save'] = 'Сохранить';
$_['button_save_and_close'] = 'Сохранить и Закрыть';
$_['button_close'] = 'Закрыть';
$_['button_recheck'] = 'Проверить еще раз';
$_['button_clear_log'] = 'Очистить логи';
$_['button_download_log'] = 'Скачать файл логов';
$_['button_save_allowed'] = 'Сохранить набор разрешений';

// Text
$_['text_module_version'] = '';
$_['text_edit'] = 'Параметры';
$_['text_success'] = 'Настройки модуля успешно обновлены!';
$_['text_success_clear'] = 'Логи успешно удалены';
$_['text_clear_log'] = 'Очистить лог';
$_['text_clear'] = 'Очистить';
$_['text_image_manager'] = 'Менеджер изображений';
$_['text_browse'] = 'Обзор';
$_['text_module'] = 'Модули';
$_['text_product'] = '<p><a href="/admin/index.php?route=catalog/product/edit&amp;token={product.token}&amp;product_id={product.product_id}">{product.image}</a><a href="/admin/index.php?route=catalog/product/edit&amp;token={product.token}&amp;product_id={product.product_id}">{order_product.name}</a><br />{order_product.quantity}&nbsp;x&nbsp;{order_product.price}&nbsp;&nbsp;{product.sku}</p>';
$_['text_history'] = '{order_history.date_added}{order_status.status}{user.username}{order_history.comment}';
$_['text_list_columns'] = 'Управление колонками заказа';
$_['text_add'] = 'Добавление';
$_['text_edit'] = 'Редактирование';
$_['test_columns_format_header'] = 'Управления колонками заказа';
$_['test_buttons_format_header'] = 'Управления кнопками заказа';
$_['test_columns_format_desc'] = 'Описание работы с колонками';
$_['test_buttons_format_desc'] = 'Описание работы с кнопками';
$_['text_edited'] = ', возможность редактирования';

// Entry
$_['entry_status'] = 'Статус:';
$_['entry_status_desc'] = 'Усовершенствованное управление заказами доступно в меню Продажи / Менеджер заказов';
$_['entry_debug'] = 'Отладочный режим:';
$_['entry_debug_desc'] = 'В системные логи будет писаться различная информация для разработчика модуля';
$_['entry_replace_system_status'] = 'Убрать стандартный:';
$_['entry_replace_system_status_desc'] = 'Стандартный менеджер заказов будет скрыт';
$_['entry_hide_unavailable'] = 'Прятать недоступный:';
$_['entry_hide_unavailable_desc'] = 'Если пользователю не доступны права на просмотр заказов, то он не увидит этот пункт меню';
$_['entry_visible_statuses'] = 'Отображаемые статусы:';
$_['entry_visible_statuses_desc'] = 'Показывает только те заказы, у которых статус отмечен галочкой в этом списке. Хороший способ отфильтровать уже выполненные заказы';
$_['entry_block_send_comment'] = 'Отображаемый блок сообщений:';
$_['entry_block_send_comment_desc'] = 'Показывает в колонке "Действия" блок ручной отправки SMS и E-mail сообщений клиенту';
$_['entry_cl_name'] = 'Название';
$_['entry_cl_align'] = 'Выравнивание';
$_['entry_cl_pattern'] = 'Шаблон';
$_['entry_cl_width'] = 'Ширина';
$_['entry_product'] = 'Формат списка продуктов:';
$_['entry_history'] = 'Формат истории изменения статусов заказа';
$_['entry_action'] = 'Действие';
$_['entry_action_add'] = 'Создать';
$_['entry_action_edit'] = 'Редактировать';
$_['entry_action_delete'] = 'Удалить';
$_['entry_field_list_name'] = 'Шаблон';
$_['entry_field_list_desc'] = 'Описание';
$_['entry_bt_name'] = 'Название';
$_['entry_bt_class'] = 'Класс';
$_['entry_bt_style'] = 'Стиль';
$_['entry_bt_link'] = 'Ссылка';
$_['entry_bt_script'] = 'Код скрипта';
$_['entry_bt_post'] = 'POST-параметры';
$_['entry_format_header'] = 'Ограничение на изменение статусов заказа:';
$_['entry_format_header_desc'] = 'Касается изменения статуса заказа при просмотре и редактировании заказа';
$_['entry_status_list_for_allow'] = 'Базовый набор статусов';
$_['entry_allowed_status_list'] = 'Разрешенный набор статусов при изменении';

//Field
$_['field_desc_order_id'] = 'Номер заказа';
$_['field_desc_status'] = 'Статус заказа';
$_['field_desc_date_added'] = 'Дата создания заказа';
$_['field_desc_total'] = 'Общая стоимость заказа';
$_['field_desc_firstname'] = 'Имя покупателя';
$_['field_desc_lastname'] = 'Фамилия покупателя';
$_['field_desc_telephone'] = 'Номер телефона покупателя';
$_['field_desc_email'] = 'Электронный адрес покупателя';
$_['field_desc_shipping_address_1'] = 'Адрес доставки 1';
$_['field_desc_shipping_address_2'] = 'Адрес доставки 2';
$_['field_desc_shipping_city'] = 'Город доставки';
$_['field_desc_payment_method'] = 'Метод оплаты';
$_['field_desc_shipping_method'] = 'Метод доставки';
$_['field_desc_shipping_zone'] = 'Зона доставки';
$_['field_desc_comment'] = 'Примечание';
$_['field_desc_status_select'] = 'Статус заказа c возможностью изменения';
$_['field_desc_custom_fields'] = 'Дополнительные поля из таблицы order_scfield. Пример custom_additional - где custom_ - обязательное начало для доп. полей, additional - имя поля';
$_['field_desc_store_id'] = 'Вывод id магазина к которому относится заказ';
$_['field_desc_store_name'] = 'Вывод названия магазина к которому относится заказ';
$_['shipping_custom_field'] = 'Дополнительные поля в адресе доставки, где "id"=1,2,3,... -  код дополнительного поля';

//Params
$_['params_colors'] = 'a:14:{i:0;s:0:"";i:1;a:2:{i:0;s:18:"rgb(255, 255, 203)";i:1;s:18:"rgb(255, 255, 203)";}i:2;a:2:{i:0;s:18:"rgb(255, 255, 203)";i:1;s:18:"rgb(255, 255, 203)";}i:3;a:2:{i:0;s:18:"rgb(187, 223, 141)";i:1;s:18:"rgb(187, 223, 141)";}i:4;s:0:"";i:5;a:2:{i:0;s:18:"rgb(187, 223, 141)";i:1;s:18:"rgb(187, 223, 141)";}i:6;s:0:"";i:7;a:2:{i:0;s:18:"rgb(255, 160, 153)";i:1;s:18:"rgb(255, 160, 153)";}i:8;a:2:{i:0;s:18:"rgb(255, 160, 153)";i:1;s:18:"rgb(255, 160, 153)";}i:9;a:2:{i:0;s:18:"rgb(255, 160, 153)";i:1;s:18:"rgb(255, 160, 153)";}i:10;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}i:11;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}i:12;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}i:13;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}}';
$_['params_num'] = array(0 => 'Четный',
	1 => 'Нечетный'
);

// Error
$_['error_permission'] = 'У Вас недостаточно прав для изменения "NeoSeo Резервные копии"!';
$_['error_download_logs'] = 'Файл логов пустой или отсутствует!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['error_delete'] = 'Ошибка: Вы пытаетесь удалить не  существующий объект!';
$_['mail_support'] = '';
$_['module_licence'] = '';