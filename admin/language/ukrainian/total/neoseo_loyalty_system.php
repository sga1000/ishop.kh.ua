<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Програма лояльності</p>';
$_['heading_title_raw'] = 'NeoSeo Програма лояльності';

//Tab
$_['tab_general'] = 'Загальні';
$_['tab_logs'] 	  = 'Логі';
$_['tab_license'] = 'Ліцензія';
$_['tab_support'] = 'Підтримка';
$_['tab_discount_order'] = 'Порядок обрання знижок';

//Button
$_['button_save'] 		  = 'Зберегти';
$_['button_save_and_close'] = 'Зберегти і Закрити';
$_['button_close'] 		  = 'Закрити';
$_['button_recheck'] 	  = 'Перевірити ще раз';
$_['button_clear_log']	  = 'Очистити  логи';
$_['button_download_log'] = 'Завантажити файл логів';

// Text
$_['text_module_version'] = '';
$_['text_edit'] 		  = 'Параметри';
$_['text_success'] 		  = 'Налаштування модуля успішно оновлені!';
$_['text_success_clear']  = 'Логи успішно видалені';
$_['text_default']		  = 'За замовчуванням';
$_['text_module'] 		  = 'Статистика';
$_['incart_text'] = 'Закажіть ще на суму {estsumm}, щоб отримати знижку {discount}%';

// Entry
$_['entry_status'] = 'Статус:';
$_['entry_debug'] = 'Налагоджувальний режим:';
$_['entry_customer_discount_status'] = 'Використовувати персональні знижки:';
$_['entry_customer_discount_status_desc'] = 'Персональна знижка вказується в картці покупця в поле "Персональна знижка".';
$_['entry_group_discount_status'] = 'Використовувати групові знижки:';
$_['entry_group_discount_status_desc'] = 'Групова знижка вказується в картці групи покупців в поле "Персональна знижка для цієї групи покупців".';
$_['entry_cumulative_discount_status'] = 'Використовувати накопичувальні знижки:';
$_['entry_total_discount_status'] = 'Використовувати знижки на суму замовлення:';
$_['entry_total_discount_gradation'] = 'Градація знижок на суму замовлення:';
$_['entry_total_discount_gradation_desc'] = 'Наприклад: 1000: 2.5, 2000: 10. Це означає, що при досягненні суми замовлення від 1,000 грн, знижка буде 2,5%, а при замовленні від 2,000 грн, знижка буде вже 10%. Якщо вказати відсоток знижки негативним - буде вважатися як націнка приклад 100: -10 ';
$_['entry_cumulative_discount_gradation'] = 'Градація накопичувальних знижок:';
$_['entry_cumulative_discount_gradation_desc'] = 'Наприклад: 1000: 2.5, 2000: 10. Це означає, що при досягненні суми виконаних замовлень від 1,000 грн, знижка буде 2,5%, а при замовленні від 2,000 грн, знижка буде вже 10%. ';
$_['entry_sort_order'] = 'Порядок сортування:';
$_['entry_excluded_categories'] = 'Відключити знижку для категорій:';
$_['entry_excluded_manufacturers'] = 'Відключити знижку для виробників:';
$_['entry_excluded_products'] = 'Відключити знижку для товарів:';
$_['entry_incart_text_status'] = 'Показ підказки у корзині';
$_['entry_incart_text_status_desc'] = 'Показ підказки для знижки на суму заказу';
$_['entry_incart_text'] = 'Текст у корзині';
$_['entry_incart_text_desc'] = 'Дозволені шаблони: {estsumm} - Сума, яка залишилась до отримання знижки, {discount} - Відсоток знижки';
$_['entry_personal_sort_order'] = 'Порядок "персональна знижка"';
$_['entry_group_sort_order'] = 'Порядок "группова знижка"';
$_['entry_accumulative_sort_order'] = 'Порядок "накопичувальна знижка"';
$_['entry_sum_sort_order'] = 'Порядок "знижка на суму замовлення"';
$_['entry_in_neoseo_checkout_text_status'] = 'Відображення підказки на сторінці оформлення замовлення';
$_['entry_in_neoseo_checkout_text_status_desc'] = 'Відображення підказки для знижки на суму замовлення на сторінці оформлення замовлення, за умови використання модуля "NeoSeo Оформлення замовлення"';
$_['entry_in_neoseo_checkout_text'] = 'Текст на сторінці оформлення замовлення';
$_['entry_in_neoseo_checkout_text_desc'] = 'Текст на сторінці оформлення замовлення, за умови використання модуля "NeoSeo Оформлення замовлення". Дозволені шаблони: {estsumm} - Сума, що залишилася для дозамовлення, {discount} - розмір одержуваної знижки';

// Error
$_['error_permission'] = 'У Вас недостатньо прав для зміни "NeoSeo Програма лояльності"!';
$_['error_download_logs'] = 'Файл логів порожній або відсутній!';
$_['error_ioncube_missing'] = '<h3 style="color:red">Відсутній IonCube Loader!</h3><p>Щоб користуватися нашим модулем, вам потрібно встановити IonCube Loader. Нижче наводяться інструкції з установки IonCube Loader для різних випадків: </p> <ul> <li> Якщо у вас shared-хостинг - <a href="http://neoseo.com.ua/articles/ioncube-loader-shared">http://neoseo.com.ua/articles/ioncube-loader-shared</a></li><li>Якщо у вас VPS на ubuntu - <a href="http://neoseo.com.ua/articles/ioncube-loader-ubuntu">http://neoseo.com.ua/articles/ioncube-loader-ubuntu</a></li><li>Якщо у вас VPS на centos - <a href="http://neoseo.com.ua/articles/ioncube-loader-centos">http://neoseo.com.ua/articles/ioncube-loader-centos</a></li></ul><p> Якщо у вас не виходить встановити IonCube Loader самостійно, ви також можете попросити допомоги у наших фахівців за адресою <a href="mailto:license@neoseo.com.ua">license@neoseo.com.ua</a>, вказавши де саме ви придбали модуль, ваш нік на цьому ресурсі і номер замовлення.</p>';
$_['error_license_missing'] = '<h3 style="color:red">Відсутній файл ліцензії!</h3><p> Для отримання файлу ліцензії зв`яжіться з розробником модуля за адресою <a href="mailto:license@neoseo.com.ua">license@neoseo.com.ua</a>, вказавши де саме ви придбали модуль, ваш нік на цьому ресурсі і номер замовлення. </p> <p> Отриманий файл ліцензії покладіть в корінь сайту, тобто поруч з файлом robots.txt і натисніть кнопку "Перевірити ще раз". </p> <p> Ви можете не переживати що ваш файл ліцензії хтось вкраде! Ваш файл ліцензії зроблений персонально для вас і не буде працювати на іншому домені </p> ';

$_['mail_support'] = '';
$_['module_licence'] = '';

$_['mail_support1'] = '<h3 style="color:red">Дякуємо вам за вибір нашого продукту!</h3><p><a href="http://neoseo.com.ua">Веб студія NeoSeo </a> прикладає максимум зусиль для того, щоб її продукти встановлювалися якомога швидше і простіше, не створюючи конфліктів з іншими модулями і темами оформлення, і доставляючи клієнтам тільки радість від використання продуктів. Ми будемо раді якщо ви <a href="http://seomag.com.ua/moduli/moduli-obrabotki-zakazov/soforp-cash-memo" target="_blank">купите модуль NeoSeo Jivosite</a> ще раз або будь-який інший модуль в магазині seomag.com.ua. <b>Діють накопичувальні знижки!</b></p><p>Однак це не завжди можливо, з огляду на що opencart має дуже слабкі технічні можливості для цього, тому просимо поставитися до цих нюансів з розумінням.</p><p><b>Що ми гарантуємо </b>, і забезпечуємо безкоштовно:</p><ul><li> роботу наших модулів на стандартній темі оформлення opencart </li><li> роботу наших модулів на стандартній адмінки opencart </li></ul><p>Якщо у вас виникла проблема з роботою модуля в цьому контексті, то ви завжди можете запитати безкоштовну технічну підтримку за адресою <a href="mailto:license@neoseo.com.ua"> license@neoseo.com.ua </a>. </p><p><b> Що ми намагаємося забезпечити, але не гарантуємо </b>:</p><ul><li> роботу наших модулів на НЕ стандартній темі оформлення opencart </li><li> роботу наших модулів на НЕ стандартної адмінки opencart </li></ul><p> Як вже говорилося, заздалегідь не можна передбачити всі нюанси чужих тем оформлення, тому в разі проблем в цьому ключі, ми забезпечуємо платну підтримку за символічну вартість. Запросити її, а також комплексне технічне обслуговування вашого магазину можна за адресою <a href="mailto:license@neoseo.com.ua"> license@neoseo.com.ua </a></p><p> <b> УВАГА !!! </b> Якщо ви відчуваєте труднощі з встановленням модулів, то вам не обов`язково витрачати свій дорогоцінний час на цей рутинний процес. Дозвольте нашим технічним фахівцям виконати це замість вас за символічну плату, а заощаджений час ви сможеет витратити на розвиток свого бізнесу, сім`ю і хобі. Замовити установку і технічне обслуговування можна за адресою <a href="mailto:license@neoseo.com.ua"> license@neoseo.com.ua </a> </p>';
$_['module_licence1'] = '<h3 style="color:red">Дякуємо вам за вибір нашого продукту!</h3><p>Всі права на програмний продукт, далі модуль, належать <a href="http://neoseo.com.ua">веб студії NeoSeo</a>. Ви можете <a href="http://seomag.com.ua/moduli/moduli-obrabotki-zakazov/soforp-cash-memo" target="_blank">купити модуль NeoSeo Jivosite</a> ще раз в магазині seomag.com.ua. <b>Діють накопичувальні знижки!</b></p><p><b>Ліцензія на даний модуль дає право на:</b><ul><li>активацию на <b>ОДИН домен</b>. Не на сайт, не на человека, не на студию. У вас несколько доменов подключены к одному сайту - значит вам нужно несколько лицензий.</li><li>на использование на своем магазине или магазине клиента.</li><li>бесплатные апдейты владельцам магазина в течение года после покупки, вне зависимости от того кто был установщиком модуля</li></ul></p><p><b>Категорично забороняється:</b><ul><li> Публікувати модуль на інших сайтах без повідомлення автора </li><li> Передавати модуль третім особам </li><li> Продавати від свого імені без попередньої домовленості з автором </li><li> Використовувати неліцензійні версії модулів (варез). У разі порушення, анулюються всі покупки по домену без повернення грошей </li></ul></p><p><b>Відмова від відповідальності:</b><ul><li> Автор модуля не несе будь-якої відповідальності за матеріальний і нематеріальний збиток, заподіяний модулем. Ви використовуєте модуль на свій страх і ризик. </li><li> Щоб значно мінімізувати ризики, ви можете <a href="http://seomag.com.ua/moduli/moduli-prochie/soforp-backup" target="_blank"> купити модуль NeoSeo Програма лояльності </a> , який надійно захистить ваш магазин від втрати даних, або замовити комплексне обслуговування вашого магазину у автора <a href="mailto:license@neoseo.com.ua"> license@neoseo.com.ua </a> </li><li> Автор залишає за собою право в будь-який момент змінити умови ліцензійної угоди, без узгодження з кінцевими користувачами його продуктів. </li></ul></p>';