<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><span style="margin:0;line-height: 24px;">NeoSeo Подписка на изменение цены</span>';
$_['heading_title_raw'] = 'NeoSeo Подписка на изменение цены';

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
$_['text_module_version'] = '';
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
$_['entry_subscribe_subject_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_subscribe_message'] = 'Текст сообщения';
$_['entry_subscribe_message_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_unsubscribe_subject'] = 'Тема письма';
$_['entry_unsubscribe_subject_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_unsubscribe_message'] = 'Текст сообщения';
$_['entry_unsubscribe_message_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_subscribe_subject_mail'] = 'Тема письма';
$_['entry_subscribe_subject_mail_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {price_new}, {price_old}';
$_['entry_subscribe_message_mail'] = 'Текст сообщения';
$_['entry_subscribe_message_mail_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}, {price_new}, {price_old}';
$_['entry_admin_subscribe_notify'] = 'Получатели сообщения о заявке, через запятую';
$_['entry_admin_subscribe_notify_subject'] = 'Тема письма админу';
$_['entry_admin_subscribe_notify_subject_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_admin_subscribe_notify_message'] = 'Текст сообщения админу';
$_['entry_admin_subscribe_notify_message_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_admin_unsubscribe_notify_subject'] = 'Тема письма админу';
$_['entry_admin_unsubscribe_notify_subject_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_admin_unsubscribe_notify_message'] = 'Текст сообщения админу';
$_['entry_admin_unsubscribe_notify_message_desc'] = 'Допускается использование {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_image_width'] = 'Ширина изображения';
$_['entry_image_height'] = 'Высота изображения';
$_['entry_field_list_name'] = 'Шаблон';
$_['entry_field_list_desc'] = 'Описание';
$_['entry_subscribe_text_subscribe'] = 'Текст сообщения, в случае успешной подписки';
$_['entry_unsubscribe_text_unsubscribe'] = 'Текст сообщения, в случае отписки';
$_['entry_stock_status'] = 'Отображаемые статусы';
$_['entry_stock_status_desc'] = 'Подписка доступна для товаров, у которых статус отмечен галочкой в этом списоке.';


//Params
$_['param_subscribe_subject'] = "Заявка №{id} на уведомление об изменении цены товара {product_name} принята";
$_['param_subscribe_message'] = "Ваша заявка №{id} на уведомление об изменении цены товара записана!";
$_['param_unsubscribe_subject'] = "Вы отписались от расслыки";
$_['param_unsubscribe_message'] = "Вы отписались от расслыки!";
$_['param_subscribe_subject_mail'] = "Цена на товар {product_name} изменена.";
$_['param_subscribe_message_mail'] = "Здравствуйте, {name}. Цена на товар <a href='{product_url}'>{product_name}</a> изменена. Новая цена товара {price_new}.";
$_['param_admin_subscribe_notify_subject'] = "Новая заявка №{id} на уведомление о поступлении товара";
$_['param_admin_subscribe_notify_message'] = "Посетитель {name} оставил заявку №{id} на уведомление об изменении цены товара {product_name}.";
$_['param_admin_unsubscribe_notify_subject'] = "Посетитель {name} отписался от рассылки";
$_['param_admin_unsubscribe_notify_message'] = "Посетитель {name} отписался от рассылки";
$_['param_subscribe_text_subscribe'] = "При при изменении цены товара Вам придет уведомление!";
$_['param_unsubscribe_text_unsubscribe'] = "Вы отписались от уведомления об изменении цены товара!";

//Fields
$_['field_desc_id'] = 'Номер заявки';
$_['field_desc_name'] = 'Имя заказчика';
$_['field_desc_phone'] = 'Телефон заказчика';
$_['field_desc_email'] = 'E-mail заказчика';
$_['field_desc_product_name'] = 'Название товара';
$_['field_desc_price_old'] = 'Старая цена товара';
$_['field_desc_price_new'] = 'Новая цена товара';
$_['field_desc_product_url'] = 'Ссылка на товар';

// Error
$_['error_download_logs'] = 'Файл логов пустой или отсутствует!';
$_['error_permission'] = 'У Вас нет прав для управления этим модулем!';
$_['error_supplier_info'] = 'Это поле обязательно для заполнения!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['mail_support'] = '';
$_['module_licence'] = '';
