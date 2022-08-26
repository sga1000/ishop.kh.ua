<?php
// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><span style="margin:0;line-height: 24px;">NeoSeo Email Информер</span>';
$_['heading_title_raw'] = 'NeoSeo Email Информер';

// Column
$_['column_status_name'] = 'Название статуса';
$_['column_status'] = 'Отправлять';
$_['column_template_subject'] = 'Тема письма';
$_['column_template_filename'] = 'Шаблон письма';
$_['column_cron_days'] = 'Оповестить через N дней от даты заказа. (Допускается указание нескольких дней через запятую)';
$_['column_status_cron'] = 'Оповещать';

// Text
$_['text_success'] = 'Настройки модуля обновлены!';
$_['text_module'] = 'Модули';
$_['text_success_clear'] = 'Лог файл успешно очищен!';
$_['text_clear_log'] = 'Очистить лог';
$_['text_select_template'] = 'Укажите шаблон';
$_["text_new_order"] = 'Получен новый заказ';
$_['text_customer_templates'] = 'Шаблоны писем покупателям';
$_['text_admin_templates'] = 'Шаблоны писем админам';
$_['text_force'] = 'Принудительно';
$_['text_module_version'] = '';
$_['text_shipping_description'] = 'Вывести описание метода доставки (Модуль NeoSeo Доставка)';

// Button
$_['button_save'] = 'Сохранить';
$_['button_save_and_close'] = 'Сохранить и Закрыть';
$_['button_close'] = 'Закрыть';
$_['button_clear_log'] = 'Очистить лог';
$_['button_recheck'] = 'Проверить еще раз';
$_['button_insert'] = 'Создать';
$_['button_delete'] = 'Удалить';

// Entry
$_['entry_status'] = 'Статус:';
$_['entry_status_desc'] = 'Отправлять письма при изменении статуса заказа';
$_['entry_force'] = 'Форсировать:';
$_['entry_force_desc'] = 'Отсылать email даже если не включена опция "уведомить покупателя":';
$_['entry_debug'] = 'Отладочный режим:';
$_['entry_debug_desc'] = 'В системные логи будет писаться различная информация для разработчика модуля';$_['entry_field_list_name'] = 'Шаблон';
$_['entry_recipients'] = 'Получатели админских сообщений:';
$_['entry_recipients_desc'] = 'Укажите электронные адреса получателей через запятую.';
$_['entry_field_list_desc'] = 'Описание';
$_['entry_status_zero_shipping_cost'] = 'Вывод нулевой стоимости доставки:';
$_['entry_cron'] = 'Cсылка для планировщика:';

// Tab
$_['tab_general'] = 'Общее';
$_['tab_templates'] = 'Шаблоны писем';
$_['tab_fields'] = 'Поля';
$_['tab_support'] = 'Поддержка';
$_['tab_logs'] = 'Логи';
$_['tab_license'] = 'Лицензия';
$_['tab_templates_desc'] = 'Укажите соответствие шаблонов писем статусам заказов';
$_['tab_cron'] = 'Отправка писем по расписанию';

// Field
$_['field_desc_product:start'] = 'Начало секции продуктов';
$_['field_desc_product_url'] = 'Ссылка на продукт';
$_['field_desc_product_id'] = 'Код продукта';
$_['field_desc_product_image'] = 'Ссылка на изображение продукта';
$_['field_desc_product_name'] = 'Название продукта';
$_['field_desc_product_model'] = 'Модель продукта';
$_['field_desc_product_quantity'] = 'Количество продуктов';
$_['field_desc_product_price'] = 'Цена продукта';
$_['field_desc_product_price_gross'] = 'Цена продукта без налогов';
$_['field_desc_product_attribute'] = 'Атрибуты продукта';
$_['field_desc_product_option'] = 'Опции продукта';
$_['field_desc_product_sku'] = 'Артикул продукта';
$_['field_desc_product_upc'] = 'UPC продукта';
$_['field_desc_product_tax'] = 'Налоги по продукту';
$_['field_desc_product_total'] = 'Итого по продукту';
$_['field_desc_product_total_gross'] = 'Итого по продукту без налогов';
$_['field_desc_product:stop'] = 'Конец секции продуктов';
$_['field_desc_voucher:start'] = 'Начало секции ваучеров';
$_['field_desc_voucher_description'] = 'Название ваучера';
$_['field_desc_voucher_amount'] = 'Стоимость ваучера';
$_['field_desc_voucher:stop'] = 'Конец секции ваучеров';
$_['field_desc_tax:start'] = 'Начало секции налогов';
$_['field_desc_tax_title'] = 'Название налога';
$_['field_desc_tax_value'] = 'Сумма налога';
$_['field_desc_tax:stop'] = 'Конец секции налогов';
$_['field_desc_total:start'] = 'Начало секции итогов';
$_['field_desc_total_title'] = 'Название итога';
$_['field_desc_total_value'] = 'Сумма итога';
$_['field_desc_total:stop'] = 'Конец секции итогов';
$_['field_desc_sub_total'] = 'Промежуточный итог';
$_['field_desc_total'] = 'Итого';
$_['field_desc_order_id'] = 'Номер заказа';
$_['field_desc_invoice_number'] = 'Номер счета';
$_['field_desc_order_date'] = 'Дата заказа';
$_['field_desc_status_name'] = 'Статус заказа';
$_['field_desc_firstname'] = 'Имя клиента';
$_['field_desc_lastname'] = 'Фамилия клиента';
$_['field_desc_email'] = 'Email клиента';
$_['field_desc_telephone'] = 'Телефон клиента';
$_['field_desc_ip'] = 'IP клиента';
$_['field_desc_client_comment'] = 'Примечание клиента';
$_['field_desc_date'] = 'Дата заказа';
$_['field_desc_payment'] = 'Информация об оплате';
$_['field_desc_shipment'] = 'Информация о доставке';
$_['field_desc_order_href'] = 'Ссылка на заказ';
$_['field_desc_store_url'] = 'Ссылка на магазин';
$_['field_desc_store_telephone'] = 'Телефон магазина';
$_['field_desc_store_name'] = 'Название магазина';
$_['field_desc_comment'] = 'Примечание';
$_['field_desc_shipping_cost'] = 'Стоимость доставки';
$_['field_desc_logo_url'] = 'Ссылка на лого';
$_['field_desc_shipping_country'] = 'Страна доставки';
$_['field_desc_shipping_zone'] = 'Регион доставки';
$_['field_desc_shipping_city'] = 'Город доставки';
$_['field_desc_shipping_postcode'] = 'Почтовый индекс';
$_['field_desc_shipping_address_1'] = 'Адрес 1';
$_['field_desc_shipping_address_2'] = 'Адрес 2';
$_['field_desc_first_referrer'] = 'Источник заказа, первое посещение. Интеграция NeoSeo Источник заказов';
$_['field_desc_last_referrer'] = 'Источник заказа, посещение перед покупкой. Интеграция NeoSeo Источник заказов';

// Error
$_['error_permission'] = 'У Вас нет прав для управления этим модулем!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';

$_['mail_support'] = '';
$_['module_licence'] = '';