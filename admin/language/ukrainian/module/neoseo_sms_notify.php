<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><span style="margin:0;line-height: 24px;">NeoSeo SMS Інформер</span>';
$_['heading_title_raw'] = 'NeoSeo SMS Інформер';

// Column
$_['column_status_name'] = 'Назва статусу';
$_['column_status'] = 'Відправляти';
$_['column_template_subject'] = 'Повідомлення';

// Text
$_['text_success'] = 'Налаштування модуля оновлені!';
$_['text_module'] = 'Модулі';
$_['text_success_clear'] = 'Лог файл успішно очищений!';
$_['text_clear_log'] = 'Очистити лог';
$_['text_select_template'] = 'Вкажіть шаблон';
$_["text_new_order"] = 'Отримано нове замовлення';
$_['text_customer_templates'] = 'Повідомлення покупцям';
$_['text_admin_templates'] = 'Повідомлення адмінам';
$_['text_module_version'] = '';
$_['text_force'] = 'Примусово';

// Button
$_['button_save'] = 'Зберегти';
$_['button_save_and_close'] = 'Зберегти і Закрити';
$_['button_close'] = 'Закрити';
$_['button_clear_log'] = 'Очистити лог';
$_['button_recheck'] = 'Перевірити ще раз';
$_['button_insert'] = 'Створити';
$_['button_delete'] = 'Видалити';

// Entry
$_['entry_status'] = 'Статус:';
$_['entry_status_desc'] = 'Відправляти повідомлення при зміні статусу замовлення.';
$_['entry_customer_group'] = 'Група покупців:';
$_['entry_force'] = 'Форсувати:';
$_['entry_force_desc'] = 'Відсилати смс навіть якщо не включена опція "повідомити покупця":';
$_['entry_align'] = 'Автодоповнення:';
$_['entry_align_desc'] = 'Для правильної роботи шлюзу потрібен повний номер телефону, наприклад 38 095 111 11 11, але покупці часто вводять тільки частина, наприклад 095 111 11 11. Вкажіть маску повного значення, наприклад 38 000 000 00 00, і модуль сам доповнить введений номер відсутніми числами';
$_['entry_recipients'] = 'Одержувачі адмінських повідомлень:';
$_['entry_recipients_desc'] = 'Вкажіть номери телефонів в міжнародному форматі через кому.';
$_['entry_debug'] = 'Налагоджувальний режим:';
$_['entry_debug_desc'] = 'В системні логи буде писатися різна інформація для розробника модуля.';
$_['entry_sms_gatenames'] = 'SMS-шлюз';
$_['entry_gate_login'] = 'Логін або API key для SMS-шлюзу';
$_['entry_gate_login_desc']= 'Якщо для шлюзу (наприклад sms.ru) потрібно тільки API key, то поля Пароль, Відправник залиште порожніми.';
$_['entry_gate_password'] = 'Пароль для SMS-шлюзу';
$_['entry_gate_sender'] = 'Відправник для SMS-шлюзу';
$_['entry_gate_additional'] = 'Розширені можливості пошуку для SMS-шлюзу';
$_['entry_gate_check'] = 'Перевірка ';
$_['entry_gate_check_phone'] = "Телефон";
$_['entry_gate_check_message'] = "Повідомлення";
$_['entry_field_list_name'] = 'Шаблон';
$_['entry_field_list_desc'] = 'Опис';
$_['entry_review_status'] = 'Статус';
$_['entry_review_status_desc'] = 'відправляти повідомлення про нові відгуках';
$_['entry_review_notification_message'] = 'текст повідомлення';
$_['entry_review_notification_message_desc'] = '{product_name} - назва товару, {product_sku} - артикул товару, {product_model} - модель товару, {product_id} - код товару';
$_['entry_admin_notify_type'] = 'Відсилати повідомлення через:';
$_['entry_telegram_api_key'] = 'API KEY для Telegram:';
$_['entry_telegram_chat_id'] = 'Ідентифікатор чату для Telegram:';
$_['entry_instruction'] = 'Інструкція до модуля:';
$_['entry_history'] = 'Історія змін:';
$_['entry_faq'] = 'Часто задавані питання:';

// Tab
$_['tab_general'] = 'Загальна';
$_['tab_templates'] = 'Шаблони повідомлень';
$_['tab_review'] = 'Нові відгуки';
$_['tab_support'] = 'Підтримка';
$_['tab_logs'] = 'Логи';
$_['tab_license'] = 'Ліцензія';
$_['tab_fields'] = 'Поля';
$_['tab_templates_desc'] = 'Вкажіть повідомлення згідно статусах замовлень';
$_['tab_admin_notify'] = 'Повідомлення адміністраторам ';
$_['tab_usefull'] = 'Корисні посилання';

// Field
$_['field_desc_order_status'] = 'Статус замовлення';
$_['field_desc_order_date'] = 'Дата замовлення';
$_['field_desc_date'] = 'Поточна дата';
$_['field_desc_total'] = 'Підсумки замовлення (total, currency_code, currency_value)';
$_['field_desc_sub_total'] = 'Проміжний підсумок замовлення (currency_code, currency_value)';
$_['field_desc_invoice_number'] = 'Номер рахунку';
$_['field_desc_comment'] = 'Примітка до замовлення';
$_['field_desc_shipping_cost'] = 'Вартість замовлення';
$_['field_desc_tax_amount'] = 'сума податку';
$_['field_desc_logo_url'] = 'Посилання на магазин';
$_['field_desc_firstname'] = 'Ім\'я покупця';
$_['field_desc_lastname'] = 'Прізвище покупця';
$_['field_desc_shipping_firstname'] = 'Ім\'я покупця ( Доставка )';
$_['field_desc_shipping_lastname'] = 'Прізвище покупця ( Доставка )';
$_['field_desc_payment_firstname'] = 'Ім\'я покупця ( Оплата )';
$_['field_desc_payment_lastname'] = 'Прізвище покупця ( Оплата )';
$_['field_admin_notify_types']['sms'] = 'SMS';
$_['field_admin_notify_types']['telegram'] = 'Telegram';

// Error
$_['error_message'] = 'Введіть повідомлення';
$_['error_permission'] = 'У Вас немає прав для управління цим модулем!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';

$_['mail_support'] = '';
$_['module_licence'] = '';

//links
$_['instruction_link'] = '<a target="_blank" href="https://neoseo.com.ua/nastroyka-modulya-neoseo-sms-informer">https://neoseo.com.ua/nastroyka-modulya-neoseo-sms-informer</a>';
$_['history_link'] = '<a target="_blank" href="https://neoseo.com.ua/sms-informer-opencart#module_history">https://neoseo.com.ua/sms-informer-opencart#module_history</a>';
$_['faq_link'] = '<a target="_blank" href="https://neoseo.com.ua/sms-informer-opencart#faqBox">https://neoseo.com.ua/sms-informer-opencart#faqBox</a>';