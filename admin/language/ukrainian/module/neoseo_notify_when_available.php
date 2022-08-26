<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Підписка на поступлення товару</p>';
$_['heading_title_raw'] = 'NeoSeo Підписка на поступлення товару';

// Tab
$_['tab_general'] = 'Параметри';
$_['tab_subscribe'] = 'Підписка';
$_['tab_unsubscribe'] = 'Відписка';
$_['tab_notify'] = 'Повідомлення';
$_['tab_fields'] = 'Поля';
$_['tab_logs'] = 'Логи';
$_['tab_support'] = 'Підтримка';
$_['tab_license'] = 'Ліцензія';
$_['tab_fields'] = 'Поля';

// Text
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
$_['entry_debug_desc'] = 'В логи модуля буде писатися різна інформація для розробника модуля';
$_['entry_subscribe_subject'] = 'Тема листа';
$_['entry_subscribe_subject_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_subscribe_message'] = 'Текст повідомлення';
$_['entry_subscribe_message_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_unsubscribe_subject'] = 'Тема листа';
$_['entry_unsubscribe_subject_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_unsubscribe_message'] = 'Текст повідомлення';
$_['entry_unsubscribe_message_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_subscribe_subject_mail'] = 'Тема листа';
$_['entry_subscribe_subject_mail_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_subscribe_message_mail'] = 'Текст повідомлення';
$_['entry_subscribe_message_mail_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_subscribe_notify'] = 'Одержувачі повідомлення про заявку, через кому';
$_['entry_admin_subscribe_notify_subject'] = ' Тема листа адміну';
$_['entry_admin_subscribe_notify_subject_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_subscribe_notify_message'] = 'Текст сообщения админу';
$_['entry_admin_subscribe_notify_message_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_unsubscribe_notify_subject'] = 'Текст повідомлення адміну';
$_['entry_admin_unsubscribe_notify_subject_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_unsubscribe_notify_message'] = 'Текст повідомлення адміну';
$_['entry_admin_unsubscribe_notify_message_desc'] = 'Допускається використання {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_image_width'] = 'Ширина зображення';
$_['entry_image_height'] = 'Висота зображення';
$_['entry_field_list_name'] = 'Шаблон';
$_['entry_field_list_desc'] = 'Опис';
$_['entry_subscribe_text'] = 'Текст повідомлення, в разі успішної підписки';
$_['entry_unsubscribe_text'] = 'Текст повідомлення, в разі відписки';
$_['entry_stock_statuses'] = 'Статуси';
$_['entry_stock_statuses_desc'] = 'Підписка доступна для товарів, у яких статус відзначений галочкою в цьому списку.';
$_['entry_script'] = 'Скрипт приховування зайвих елементів';


// Error
$_['error_permission'] = 'У Вас немає прав для управління цим модулем!';
$_['error_supplier_info'] = 'Це поле є обов`язковим для заповнення!';
$_['error_download_logs'] = 'Файл логів пустий або відсутній!';

//Params
$_['param_subscribe_text'] = "<p>Шановний, {name}!</p><p>Дякуємо що цікавитесь товарами нашого магазину!</p><p>Як тільки товар \"{product_name} {options}\" з`явиться в наявності, ми відразу повідомимо Вас листом з повідомленням про це.</p>";
$_['param_subscribe_subject'] = "Заявка №{id} прийнята";
$_['param_subscribe_message'] = "Вітаємо, {name}!<br><br>Ви успішно підписались на письмове повідомлення про надходження товару <a href='{product_url}'>{product_name} {options}</a>";
$_['param_admin_subscribe_notify_subject'] = "Поступила заявка №{id} на повідомлення про поступлення товару";
$_['param_admin_subscribe_notify_message'] = "Відвідувач <a href='mailto:{email}'>{name}</a> залишив заявку №{id} про повідомлення наявності товару <a href='{product_url}'>{product_name} {options}</a>.";

$_['param_unsubscribe_text'] = "<p>Шановний, {name}!</p><p>Ви відписалися від повідомлення про появу товару \"{product_name}\"!</p><p>Більше листи про появу товару \"{product_name}\" не будуть вас турбувати.</p>";
$_['param_unsubscribe_subject'] = "Заявка №{id} відключена";
$_['param_unsubscribe_message'] = "Вітаємо, {name}!<br><br>Ви успішно відписалися від повідомлення про надходження товару <a href='{product_url}'>{product_name}</a>";
$_['param_admin_unsubscribe_notify_subject'] = "Відключена заявка №{id} на повідомлення про надходження товару";
$_['param_admin_unsubscribe_notify_message'] = "Відвідувач <a href='mailto:{email}'>{name}</a> відписався від повідомлення про надходження товару <a href='{product_url}'>{product_name}</a>";

$_['param_subscribe_subject_mail'] = "Поступив товар \"{product_name}\"";
$_['param_subscribe_message_mail'] = "<p>Вітаємо, {name}!</p><p>Товар, на появу якого ви підписувалися, знову доступний для покупки: <a href='{product_url}'>{product_name} {options}</a></p>";


//Fields
$_['field_desc_subscribe_id'] = 'Номер заявки';
$_['field_desc_subscribe_name'] = 'Ім`я замовника';
$_['field_desc_subscribe_email'] = 'E-mail замовника';
$_['field_desc_subscribe_product_name'] = 'Назва товару';
$_['field_desc_subscribe_product_url'] = 'Посилання на товар';
$_['field_desc_subscribe_options'] = 'Опції товару';

$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['mail_support'] = '';
$_['module_licence'] = '';
$_['text_module_version'] = '';
