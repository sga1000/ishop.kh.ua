<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><span style="margin:0;line-height: 24px;">NeoSeo SMS Информер</span>';
$_['heading_title_raw'] = 'NeoSeo SMS Информер';

// Column
$_['column_status_name'] = 'Название статуса';
$_['column_status'] = 'Отправлять';
$_['column_template_subject'] = 'Сообщение';

// Text
$_['text_success'] = 'Настройки модуля обновлены!';
$_['text_module'] = 'Модули';
$_['text_success_clear'] = 'Лог файл успешно очищен!';
$_['text_clear_log'] = 'Очистить лог';
$_['text_select_template'] = 'Укажите шаблон';
$_["text_new_order"] = 'Получен новый заказ';
$_['text_customer_templates'] = 'Сообщения покупателям';
$_['text_admin_templates'] = 'Сообщения админам';
$_['text_module_version'] = '';
$_['text_force'] = 'Принудительно';

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
$_['entry_status_desc'] = 'Отправлять сообщения при изменении статуса заказа.';
$_['entry_customer_group'] = 'Группа покупателей:';
$_['entry_force'] = 'Форсировать:';
$_['entry_force_desc'] = 'Отсылать смс даже если не включена опция "уведомить покупателя":';
$_['entry_align'] = 'Автодополнение:';
$_['entry_align_desc'] = 'Для правильной работы шлюза нужен полный номер телефона, например 38 095 111 11 11, но покупатели часто вводят только часть, например 095 111 11 11. Укажите маску полного значения, например 38 000 000 00 00, и модуль сам дополнит введенный номер недостающими числами';
$_['entry_recipients'] = 'Получатели админских сообщений:';
$_['entry_recipients_desc'] = 'Укажите номера телефонов в международном формате через запятую.';
$_['entry_debug'] = 'Отладочный режим:';
$_['entry_debug_desc'] = 'В системные логи будет писаться различная информация для разработчика модуля.';
$_['entry_sms_gatenames'] = 'SMS-шлюз';
$_['entry_gate_login'] = 'Логин или API key для SMS-шлюза';
$_['entry_gate_login_desc']= 'Если для шлюза (например sms.ru) требуется только API key, то поля Пароль, Отправитель оставьте пустыми.';
$_['entry_gate_password'] = 'Пароль для SMS-шлюза';
$_['entry_gate_sender'] = 'Отправитель для SMS-шлюза';
$_['entry_gate_additional'] = 'Дополнительные параметры для SMS-шлюза';
$_['entry_gate_check'] = 'Проверка ';
$_['entry_gate_check_phone'] = "Телефон";
$_['entry_gate_check_message'] = "Сообщение";
$_['entry_field_list_name'] = 'Шаблон';
$_['entry_field_list_desc'] = 'Описание';
$_['entry_review_status'] = 'Статус';
$_['entry_review_status_desc'] = 'отправлять уведомления о новых отзывах';
$_['entry_review_notification_message'] = 'Текст уведомления';
$_['entry_review_notification_message_desc'] = '{product_name} - название товара, {product_sku} - артикул товара, {product_model} - модель товара, {product_id} - код товара';
$_['entry_admin_notify_type'] = 'Отсылать уведомления через:';
$_['entry_telegram_api_key'] = 'API KEY для Telegram:';
$_['entry_telegram_chat_id'] = 'Идентификатор чата для Telegram:';
$_['entry_instruction'] = 'Инструкция к модулю:';
$_['entry_history'] = 'История изменений:';
$_['entry_faq'] = 'Часто задаваемые вопросы:';

// Tab
$_['tab_general'] = 'Общее';
$_['tab_templates'] = 'Шаблоны сообщений';
$_['tab_review'] = 'Новые отзывы';
$_['tab_support'] = 'Поддержка';
$_['tab_logs'] = 'Логи';
$_['tab_license'] = 'Лицензия';
$_['tab_fields'] = 'Поля';
$_['tab_templates_desc'] = 'Укажите сообщения согласно статусам заказов';
$_['tab_admin_notify'] = 'Уведомления администраторам';
$_['tab_usefull'] = 'Полезные ссылки';

// Field
$_['field_desc_order_status'] = 'Статус заказа';
$_['field_desc_order_date'] = 'Дата заказа';
$_['field_desc_date'] = 'Текущая дата';
$_['field_desc_total'] = 'Итоги заказа (total, currency_code, currency_value)';
$_['field_desc_sub_total'] = 'Промежуточный итоги заказа (currency_code, currency_value)';
$_['field_desc_invoice_number'] = 'Номер счета';
$_['field_desc_comment'] = 'Примечание к заказу';
$_['field_desc_shipping_cost'] = 'Стоимость заказа';
$_['field_desc_tax_amount'] = 'Сумма налога';
$_['field_desc_logo_url'] = 'Ссылка на магазин';
$_['field_desc_firstname'] = 'Имя покупателя';
$_['field_desc_lastname'] = 'Фамилия покупателя';
$_['field_desc_shipping_firstname'] = 'Имя покупателя ( Доставка )';
$_['field_desc_shipping_lastname'] = 'Фамилия покупателя ( Доставка )';
$_['field_desc_payment_firstname'] = 'Имя покупателя ( Оплата )';
$_['field_desc_payment_lastname'] = 'Фамилия покупателя ( Оплата )';
$_['field_admin_notify_types']['sms'] = 'SMS';
$_['field_admin_notify_types']['telegram'] = 'Telegram';

// Error
$_['error_message'] = 'Введите сообщение';
$_['error_permission'] = 'У Вас нет прав для управления этим модулем!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';

$_['mail_support'] = '';
$_['module_licence'] = '';

//links
$_['instruction_link'] = '<a target="_blank" href="https://neoseo.com.ua/nastroyka-modulya-neoseo-sms-informer">https://neoseo.com.ua/nastroyka-modulya-neoseo-sms-informer</a>';
$_['history_link'] = '<a target="_blank" href="https://neoseo.com.ua/sms-informer-opencart#module_history">https://neoseo.com.ua/sms-informer-opencart#module_history</a>';
$_['faq_link'] = '<a target="_blank" href="https://neoseo.com.ua/sms-informer-opencart#faqBox">https://neoseo.com.ua/sms-informer-opencart#faqBox</a>';