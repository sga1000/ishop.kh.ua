<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Подписка на поступление товара</p>';
$_['heading_title_raw'] = 'NeoSeo Подписка на поступление товара';

// Tab
$_['tab_general'] = 'Параметры';
$_['tab_subscribe'] = 'Подписка';
$_['tab_unsubscribe'] = 'Отписка';
$_['tab_notify'] = 'Уведомление';
$_['tab_fields'] = 'Поля';
$_['tab_logs'] = 'Логи';
$_['tab_support'] = 'Поддержка';
$_['tab_license'] = 'Лицензия';
$_['tab_fields'] = 'Поля';

// Text
$_['text_success'] = 'Настройки модуля обновлены!';
$_['text_module'] = 'Модули';
$_['text_success_clear'] = 'Лог файл успешно очищен!';
$_['text_clear_log'] = 'Очистить лог';

// Button
$_['button_save'] = 'Сохранить';
$_['button_save_and_close'] = 'Сохранить и Закрыть';
$_['button_close'] = 'Закрыть';
$_['button_recheck'] = 'Проверить еще раз';
$_['button_clear_log'] = 'Очистить лог';
$_['button_download_log'] = 'Скачать файл логов';

// Entry
$_['entry_status'] = 'Статус';
$_['entry_debug'] = 'Отладочный режим';
$_['entry_cron'] = 'Задача для планировщика';
$_['entry_debug_desc'] = 'В логи модуля будет писаться различная информация для разработчика модуля';
$_['entry_subscribe_subject'] = 'Тема письма';
$_['entry_subscribe_subject_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_subscribe_message'] = 'Текст сообщения';
$_['entry_subscribe_message_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_unsubscribe_subject'] = 'Тема письма';
$_['entry_unsubscribe_subject_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_unsubscribe_message'] = 'Текст сообщения';
$_['entry_unsubscribe_message_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_subscribe_subject_mail'] = 'Тема письма';
$_['entry_subscribe_subject_mail_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_subscribe_message_mail'] = 'Текст письма';
$_['entry_subscribe_message_mail_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_subscribe_notify'] = 'Получатели сообщения о заявке, через запятую';
$_['entry_admin_subscribe_notify_subject'] = 'Тема письма админу';
$_['entry_admin_subscribe_notify_subject_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_subscribe_notify_message'] = 'Текст сообщения админу';
$_['entry_admin_subscribe_notify_message_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_unsubscribe_notify_subject'] = 'Тема письма админу';
$_['entry_admin_unsubscribe_notify_subject_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_unsubscribe_notify_message'] = 'Текст сообщения админу';
$_['entry_admin_unsubscribe_notify_message_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_image_width'] = 'Ширина изображения';
$_['entry_image_height'] = 'Высота изображения';
$_['entry_field_list_name'] = 'Шаблон';
$_['entry_field_list_desc'] = 'Описание';
$_['entry_subscribe_text'] = 'Текст сообщения, в случае успешной подписки';
$_['entry_unsubscribe_text'] = 'Текст сообщения, в случае отписки';
$_['entry_stock_statuses'] = 'Отображаемые статусы';
$_['entry_stock_statuses_desc'] = 'Подписка доступна для товаров, у которых статус отмечен галочкой в этом списоке.';
$_['entry_script'] = 'Скрипт скрытия лишних элементов';

// Error
$_['error_permission'] = 'У Вас нет прав для управления этим модулем!';
$_['error_supplier_info'] = 'Это поле обязательно для заполнения!';
$_['error_download_logs'] = 'Файл логов пустой или отсутствует!';

//Params
$_['param_subscribe_text'] = "<p>Уважаемый, {name}!</p><p>Спасибо что интересуетесь товарами нашего магазина!</p><p>Как только товар \"{product_name} {options}\" появится в наличии, мы тут же пришлем вам письмо с сообщением об этом.</p>";
$_['param_subscribe_subject'] = "Заявка №{id} принята";
$_['param_subscribe_message'] = "Здравствуйте, {name}!<br><br>Вы успешно подписались на письменное уведомления о поступлении товара <a href='{product_url}'>{product_name} {options}</a>";
$_['param_admin_subscribe_notify_subject'] = "Поступила заявка №{id} на уведомление о поступлении товара";
$_['param_admin_subscribe_notify_message'] = "Посетитель <a href='mailto:{email}'>{name}</a> оставил заявку №{id} на уведомление в наличии товара <a href='{product_url}'>{product_name} {options}</a>.";

$_['param_unsubscribe_text'] = "<p>Уважаемый, {name}!</p><p>Вы отписались от уведомления о появлении товара \"{product_name}\"!</p><p>Больше письма о появлении товара \"{product_name}\" не будут вас беспокоить.</p>";
$_['param_unsubscribe_subject'] = "Заявка №{id} отключена";
$_['param_unsubscribe_message'] = "Здравствуйте, {name}!<br><br>Вы успешно отписались от уведомления о поступлении товара <a href='{product_url}'>{product_name}</a>";
$_['param_admin_unsubscribe_notify_subject'] = "Отключена заявка №{id} на уведомление о поступлении товара";
$_['param_admin_unsubscribe_notify_message'] = "Посетитель <a href='mailto:{email}'>{name}</a> отписался от уведомления о поступлении товара <a href='{product_url}'>{product_name}</a>";

$_['param_subscribe_subject_mail'] = "Поступил товар \"{product_name}\"";
$_['param_subscribe_message_mail'] = "<p>Здравствуйте, {name}!</p><p>Товар, на появление которого вы подписывались, снова доступен для покупки: <a href='{product_url}'>{product_name} {options}</a></p>";


//Fields
$_['field_desc_subscribe_id'] = 'Номер заявки';
$_['field_desc_subscribe_name'] = 'Имя заказчика';
$_['field_desc_subscribe_email'] = 'E-mail заказчика';
$_['field_desc_subscribe_product_name'] = 'Название товара';
$_['field_desc_subscribe_product_url'] = 'Ссылка на товар';
$_['field_desc_subscribe_options'] = 'Опции товара';

$_['mail_support'] = '';
$_['module_licence'] = '';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['text_module_version'] = '';
