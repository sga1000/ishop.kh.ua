<?php
// Heading
$_['heading_title']	  = '<img width="24" height="24" src="view/image/faviconI.png" style="margin-right: 10px;float: left;"><span style="margin:0;line-height: 24px;">&nbsp;Резервные копии</span>';
$_['heading_title_raw']  = 'Резервные копии';

// Tab
$_['tab_general']		= 'Параметры';
$_['tab_logs']		   = 'Логи';
$_['tab_license']		= 'Лицензия';
$_['tab_support']		= 'Поддержка';
$_['tab_usefull'] = 'Полезные ссылки';
$_['tab_stat'] = 'Статистика';

// Text
$_['text_success']	   = 'Настройки модуля обновлены!';
$_['text_module']		= 'Модули';
$_['text_description']   = '<p>Резервные копии находятся в меню Система \ Резервные копии. Но увидеть ее сможет только тот, у кого есть права на просмотр \ удаление для этого модуля. Соответственно, сразу после установки вы должны зайти в Система \ Пользователи \ Группы пользователей и добавить права на просмотр \ модификацию нужным группам пользователей</p>';
$_['text_destination_yandex.disk']	= 'Яндекс.Диск';
$_['text_destination_dropbox']	= 'Дропбокс';
$_['text_destination_ftp']	= 'FTP-Сервер';
$_['text_destination_drive']	= 'Гугл Диск';
$_['text_check_password']	= 'Проверить пароль';
$_['text_get_token']	= 'Получить код-ответ от дропбокс';
$_['text_check_token']	= 'Проверить или получить Токен';
$_['text_get_access']	= 'Подключится к  Гугл Диску';
$_['text_check_access']	= 'Проверить подключение';
$_['text_success_clear']	= 'Логи успешно очищены';
$_['text_module_version']= '';

// Button
$_['button_save']		= 'Сохранить';
$_['button_save_and_close'] = 'Сохранить и Закрыть';
$_['button_close']	   = 'Закрыть';
$_['button_recheck']	 = 'Проверить еще раз';
$_['button_clear_log']   = 'Очистить логи';

// Entry
$_['entry_status']	   = 'Статус:';
$_['entry_debug']		= 'Отладка:';
$_['entry_replace_system_backup'] = 'Заменить системные резервные копии';
$_['entry_destination']  = 'Куда сохранять:';
$_['entry_notify_list']  = 'Кого уведомлять';
$_['entry_notify_list_desc']  = 'разделитель - ";"</i>';
$_['entry_max_copies']   = 'Максимальное количество копий:';
$_['entry_max_copies_desc']   = 'Лишние резервные копии будут удалены перед созданием новой резервной копии';
$_['entry_server']	   = 'Сервер:';
$_['entry_token']	   = 'Токен:';
$_['entry_api_key']	   = 'Api ключ:';
$_['entry_api_secret']	   = 'Api секрет:';
$_['entry_google_api']	   = 'Api ключ:';
$_['entry_client_id']	   = 'Клиент id:';
$_['entry_client_secret']	   = 'Клиент секрет:';
$_['entry_token_desc']   = 'Токен необходим для связи вашего аккаунта с нашим приложением';
$_['entry_folder']	   = 'Каталог:';
$_['entry_folder_desc']	   = 'В какую папку сохранить резервную копию, на удаленном сервере';
$_['entry_username']	 = 'Логин:';
$_['entry_password']	 = 'Пароль:';
$_['entry_confirm_password'] = 'Подтвердите пароль:';
$_['entry_cron']		 = "Запуск из крона: ";
$_['entry_google_url']		 = "Ссылка для ответа от Гугл консоли: ";
$_['entry_exclude_files']	 = 'Исключить эти файлы:';
$_['entry_exclude_files_desc']	 = 'Одна строка - одно правило, маски разрешены<br><br>Рекомендуется:<br>*cache/*<br>*.log';
$_['entry_exclude_tables']	= 'Исключить эти таблицы:';
$_['entry_exclude_tables_desc']	= 'Одна строка - одно правило, маски разрешены';
$_['entry_instruction'] = 'Инструкция к модулю:';
$_['entry_history'] = 'История изменений:';
$_['entry_faq'] = 'Часто задаваемые вопросы:';
$_['entry_send_statistics'] = 'Отправлять статистику работы на сервер';
$_['entry_statistics_server'] = 'Адрес сервера';
$_['entry_statistics_server_desc'] = 'На указанный адрес будет отправлен POST запрос в формате JSON при старте процесса резервного копирования и сообщение о его завершении. https:// обязательно!';

// Error
$_['error_permission']   = 'У Вас нет прав для управления этим модулем!';
$_['error_empty_folder']   = 'Укажите каталог.';
$_['error_zip_archive_missing'] = '<h3 style="color:red">Отсутствует php-класс <b>ZipArchive</b></h3><p>Без этого класса невозможно создание резервной копии. Обратитесь к вашему хостеру.</p>';
$_['error_ioncube_missing'] = "";
$_['error_license_missing'] = "";

$_['mail_support'] = "";
$_['module_licence'] = "";

//links
$_['instruction_link'] = '<a target="_blank" href="https://neoseo.com.ua/rezervnoe-kopirovanie-s-ispolzovaniem-google-drive">https://neoseo.com.ua/rezervnoe-kopirovanie-s-ispolzovaniem-google-drive</a>';
$_['history_link'] = '<a target="_blank" href="https://neoseo.com.ua/rezervnye-kopii#module_history">https://neoseo.com.ua/rezervnye-kopii#module_history</a>';
$_['faq_link'] = '<a target="_blank" href="https://neoseo.com.ua/rezervnye-kopii#faqBox">https://neoseo.com.ua/rezervnye-kopii#faqBox</a>';