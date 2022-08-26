<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><span style="margin:0;line-height: 24px;">NeoSeo Підписка на зміну ціни</span>';
$_['heading_title_raw'] = 'NeoSeo Підписка на зміну ціни';

// Tab
$_['tab_general'] = 'Параметри';
$_['tab_subscribe'] = 'Підписка';
$_['tab_unsubscribe'] = 'Відписка';
$_['tab_notify'] = 'Сповіщення';
$_['tab_fields'] = 'Поля';
$_['tab_logs'] = 'Логи';
$_['tab_support'] = 'Підтримка';
$_['tab_license'] = 'Ліцензія';
$_['tab_fields'] = 'Поля';

// Text
$_['text_module_version'] = '';
$_['text_success'] = 'Налаштування модуля оновлені!';
$_['text_module'] = 'Модулі';
$_['text_success_clear'] = 'Лог файл успішно очищений!';
$_['text_clear_log'] = 'Очистити лог';

// Button
$_['button_save'] = 'Зберегти';
$_['button_save_and_close'] = 'Зберегти і Закрити';
$_['button_close'] = 'Закрити';
$_['button_recheck'] = 'Перевірити ще раз';
$_['button_clear_log'] = 'Очистити лог';
$_['button_download_log'] = 'Завантажити файл логів';

// Entry
$_['entry_status'] = 'Статус';
$_['entry_debug'] = 'Налагоджувальний режим';
$_['entry_cron'] = 'Завдання для планувальника';
$_['entry_debug_desc'] = 'У логи модуля буде писатися різна інформація для розробника модуля';
$_['entry_subscribe_subject'] = 'Тема листа';
$_['entry_subscribe_subject_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_subscribe_message'] = 'Текст повідомлення';
$_['entry_subscribe_message_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_unsubscribe_subject'] = 'Тема листа';
$_['entry_unsubscribe_subject_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_unsubscribe_message'] = 'Текст повідомлення';
$_['entry_unsubscribe_message_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_subscribe_subject_mail'] = 'Тема листа';
$_['entry_subscribe_subject_mail_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {price_new}, {price_old}';
$_['entry_subscribe_message_mail'] = 'Текст повідомлення';
$_['entry_subscribe_message_mail_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {price_new}, {price_old}';
$_['entry_admin_subscribe_notify'] = 'Одержувачі повідомлення про заявку, через кому';
$_['entry_admin_subscribe_notify_subject'] = 'Тема листа адміну';
$_['entry_admin_subscribe_notify_subject_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_admin_subscribe_notify_message'] = 'Текст повідомлення админу';
$_['entry_admin_subscribe_notify_message_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_admin_unsubscribe_notify_subject'] = 'Тема листа адміну';
$_['entry_admin_unsubscribe_notify_subject_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_admin_unsubscribe_notify_message'] = 'Текст повідомлення админу';
$_['entry_admin_unsubscribe_notify_message_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_image_width'] = 'Ширина зображення';
$_['entry_image_height'] = 'Висота зображення';
$_['entry_field_list_name'] = 'Шаблон';
$_['entry_field_list_desc'] = 'Опис';
$_['entry_subscribe_text_subscribe'] = 'Текст повідомлення, в разі успішної підписки';
$_['entry_unsubscribe_text_unsubscribe'] = 'Текст повідомлення, в разі відписки';
$_['entry_stock_status'] = 'Відображені статуси';
$_['entry_stock_status_desc'] = 'Підписка доступна для товарів, у яких статус відзначений галочкою в цьому списку.';


//Params
$_['param_subscribe_subject'] = "Замовлення №{id} на повідомлення про зміну ціни товару {product_name} прийнята";
$_['param_subscribe_message'] = "Ваше замовлення №{id} на повідомлення про зміну ціни товару записана!";
$_['param_unsubscribe_subject'] = "Ви відписалися від розсилки";
$_['param_unsubscribe_message'] = "Ви відписалися від розсилки!";
$_['param_subscribe_subject_mail'] = "Ціна на товар {product_name} змінена";
$_['param_subscribe_message_mail'] = "Привіт, {name}. Ціна на товар <a href='{product_url}'>{product_name}</a> змінена. Нова ціна товару {price_new}.";
$_['param_admin_subscribe_notify_subject'] = "Нова заявка №{id} на повідомлення про надходження товару";
$_['param_admin_subscribe_notify_message'] = "Відвідувач {name} залишив замовлення №{id} на повідомлення про зміну ціни товару {product_name}.";
$_['param_admin_unsubscribe_notify_subject'] = "Відвідувач {name} відписався від розсилки";
$_['param_admin_unsubscribe_notify_message'] = "Відвідувач {name} відписався від розсилки";
$_['param_subscribe_text_subscribe'] = "При при зміні ціни товару Вам прийде повідомлення!";
$_['param_unsubscribe_text_unsubscribe'] = "Ви відписалися від повідомлення про зміну ціни товару!";

//Fields
$_['field_desc_id'] = 'Номер заявки';
$_['field_desc_name'] = 'Ім\'я замовника';
$_['field_desc_phone'] = 'Телефон замовника';
$_['field_desc_email'] = 'E-mail замовника';
$_['field_desc_product_name'] = 'Назва товару';
$_['field_desc_price_old'] = 'Стара ціна товару';
$_['field_desc_price_new'] = 'Нова ціна товару';
$_['field_desc_product_url'] = 'Посилання на товар';

// Error
$_['error_download_logs'] = 'Файл логів порожній або відсутній!';
$_['error_permission'] = 'У Вас немає прав для управління цим модулем!';
$_['error_supplier_info'] = 'Це поле є обов`язковим для заповнення!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['mail_support'] = '';
$_['module_licence'] = '';
