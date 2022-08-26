<?php
// Heading
$_['heading_title']    = '<span style="color:red; font-weight:bold;"><i class="fa fa-rocket"></i> SP</span> Remarketing All in One + Ecommerce - v3.7';

// Text
$_['text_extension']    = 'Модули';
$_['text_success']      = 'Настройки модуля обновлены!';
$_['text_edit']         = 'Редактирование модуля';
$_['text_id']   	   	= 'ID товара';
$_['text_model']        = 'Модель';
$_['text_events']       = 'События';
$_['text_identifier']   = 'Идентификатор товара';
$_['text_google_remarketing']        = 'Ремаркетинг Google';
$_['text_facebook_remarketing']        = 'Ремаркетинг Facebook';
$_['text_mytarget_remarketing']        = 'Ремаркетинг Mytarget';
$_['text_vk_remarketing']        = 'Ретаргетинг VK';
$_['text_ecommerce']        = 'Ecommerce Google и Яндекс';
$_['text_ecommerce_ga4']        = 'Ecommerce Google GA4';
$_['text_ecommerce_measurement']        = 'Ecommerce - Measurement Protocol (new!)';
$_['text_counters']        = 'Счетчики';
$_['text_to_be_continued']        = 'Скоро будет еще что-то интересное';
$_['text_instruction']        = 'Возможности модуля и документация';
$_['text_help']        = 'Помощь и поддержка';
$_['text_summary']        = 'Сводка'; 

// Entry
$_['entry_status']     = 'Статус';
$_['entry_feed_status']     = 'Статус простого фида';
$_['entry_feed_link']     = 'Ссылка на фид';
$_['entry_google_identifier']     = 'Идентификатор Google Adwords (AW-CONVERSION_ID)';
$_['entry_google_ads_identifier']     = 'Идентификатор конверсии Google Adwords<br>
(AW-CONVERSION_ID/AW-CONVERSION_LABEL)';
$_['entry_facebook_identifier']     = 'ID пикселя Facebook ';
$_['entry_facebook_token']     = 'Маркер доступа для Consversions API';
$_['entry_mytarget_identifier']     = '№ списка в Mytarget (обычно 1) ';
$_['entry_vk_identifier']     = '№ списка в VK (обычно 1) '; 
$_['entry_google_code']     = 'Код Adwords (если еще не установлен)';
$_['entry_facebook_code']   = 'Код пикселя Facebook (если еще не установлен)';
$_['entry_server_side']   = 'Включить Server Side (отправка событий с сервера)';
$_['entry_mytarget_code']   = 'Код счетчика Mail.ru (если еще не установлен)';
$_['entry_currency']   = 'Валюта';
$_['entry_google_merchant_identifier']   = 'ID Google Merchant';
$_['entry_reviews_date']   = 'Прибавить дней к текущей дате';
$_['entry_reviews_country']   = 'Страна доставки (RU, UA)';
$_['entry_events_cart']   = 'Javascript cобытие открытия корзины';
$_['entry_events_cart_add']   = 'Javascript событие добавления товара в корзину';
$_['entry_events_purchase']   = 'Javascript событие оформления заказа';
$_['entry_events_wishlist']   = 'Javascript событие добавления в закладки';
$_['entry_ecommerce_selector']   = 'Javascript селектор карточки товара (например, .product-thumb)';
$_['entry_ecommerce_analytics_id']   = 'ID Google Analytics (UA-XXXXXXXXX)';
$_['entry_counter1']   = 'Счетчики в хэдере';
$_['entry_counter2']   = 'Счетчики после открывающегося body';
$_['entry_counter3']   = 'Счетчики в подвале';
 
// Error
$_['error_permission'] = 'У вас нет прав для управления этим модулем!';

$_['text_credits']        = '
<b>Спасибо за покупку моего модуля!</b><br>
<div class="text-credits">
Если вам необходима поддержка, доработка этого модуля либо какого другого - обращайтесь, буду рад помочь.<br><br>
Связаться со мной можно следующими способами:<br>
1. Личное сообщение на opencartforum - <a href="https://opencartforum.com/profile/678128-spectre/" target="_blank" style="display: inline-block;border-radius: 2px;padding: 1px 5px;font-size: 90%;color: #fff;text-decoration: none !important;background: #3d6594;">@spectre</a><br>
2. Электронная почта - <a href="mailto:job@freelancer.od.ua">job@freelancer.od.ua</a><br><br>

Если хотите поблагодарить или угостить пивом когда читаете эту страницу:<br>
1. Яндекс-Деньги - 41001189848733<br>
2. QIWI - SPECTREAV<br>
3. Приватбанк - 5168742228748467<br><br>

<b style="font-size:18px;color:red;">Удачных продаж! <i class="fa fa-hand-peace-o"></i></b>
</div>
';
$_['text_google_reviews']        = 'Отзывы в Google Merchant';
$_['text_events_help']        = ' <b>Важно!</b><p>Здесь можно добавить события для метрики, VK и тп.</p>
<p>Например, yaCounterXXXXXX.reachGoal("addtocart") или gtag("event", "cart_add", {"event_category": "Cart"});</p>
<p>Рекомендую проверять подобным образом:<br>
 if (typeof yaCounterXXXXXX != \'undefined\') { yaCounterXXXXXX.reachGoal("addtocart") }</p>
 <p>sсriрt /sсriрt писать не надо!</p>
 ';
 $_['text_instructions']        = 'Представляю вашему вниманию модуль, который который умеет почти все и будет уметь все, связанное с ремаркетингом и электронной коммерцией.<br><br>
 Итак, возможности и ссылки на документацию: <br>
 
 <div class="heading">Ремаркетинг в Google</div>
 <div class="description">
 Генерация событий сделана по последней инструкции Google: <a href="https://support.google.com/google-ads/answer/7305793?hl=ru" target="_blank"><b>https://support.google.com/google-ads/answer/7305793?hl=ru</b></a><br><br>
 Также есть возможность отправлять конверсию в Adwords: <a href="https://support.google.com/google-ads/answer/6095821?hl=ru" target="_blank"><b>https://support.google.com/google-ads/answer/6095821?hl=ru</b></a><br><br>
  
 Поддерживаются события:<br>
 - <b>view_item_list</b> - Просмотр списка товаров (в категории, производителе и акциях)<br>
 - <b>view_search_results</b> - Просмотр результатов поиска<br>
 - <b>view_item</b> - Просмотр карточки товара<br>
 - <b>add_to_cart</b> - Добавление товара в корзину (при успешном добавлении товара в корзину из карточки товара или по клику на кнопке купить в листингах (скоро будет возможность отслеживать правильно ли добавился товар в корзину)<br>
 - <b>purchase</b> - Оформление заказа<br>
 </div>
 <div class="notice">
 <b>Особенности:</b> <br>
 - Не поддерживаются модули заказа в 1 клик - их бесчисленное количество и практически везде javascript который нельзя модифицировать. Возможно за небольшие деньги в частном порядке (см вкладку поддержка).<br>
 - Не поддерживается изменение количества в корзине, simplecheckout и пр. Это на самом деле мало кому нужно и существенно удорожает разработку. Обычно никому это не нужно.
 </div>
 
 <div class="heading">Ремаркетинг в Facebook</div>
 <div class="description">
 Генерация событий сделана по последней инструкции Facebook: <a href="https://developers.facebook.com/docs/facebook-pixel/reference" target="_blank"><b>https://developers.facebook.com/docs/facebook-pixel/reference</b></a><br><br>
  
 Поддерживаются события:<br>
 - <b>ViewContent</b> - Просмотр карточки товара<br>
 - <b>AddToCart</b> - Добавление товара в корзину (при успешном добавлении товара в корзину из карточки товара или по клику на кнопке купить в листингах (скоро будет возможность отслеживать правильно ли добавился товар в корзину)<br>
 - <b>initiateCheckout</b> - Начало оформления заказа<br>
 - <b>Purchase</b> - Оформление заказа<br>
 </div>
 <div class="notice">
 <b>Особенности:</b> <br>
 - Не поддерживаются модули заказа в 1 клик - их бесчисленное количество и практически везде javascript который нельзя модифицировать. Возможно за небольшие деньги в частном порядке (см вкладку поддержка).<br>
 - Не поддерживается изменение количества в корзине, simplecheckout и пр. Это на самом деле мало кому нужно и существенно удорожает разработку. Обычно никому это не нужно.
 </div>
 
 <div class="heading">Электронная коммерция Google и Яндекс</div>
 <div class="description">
 Модуль умеет формировать контейнер ecommerce в dataLayer<br>
 Отправка событий в гугл сделана по этой инструкции: <a href="https://netpeak.net/ru/blog/kak-nastroit-rasshirennuyu-elektronnuyu-torgovlyu-s-pomoshch-yu-google-tag-manager/" target="_blank"><b>https://netpeak.net/ru/blog/kak-nastroit-rasshirennuyu-elektronnuyu-torgovlyu-s-pomoshch-yu-google-tag-manager/</b></a><br>
 Яндекс понимает просто контейнер ecommerce - <a href="https://yandex.ru/support/metrica/data/e-commerce.html" target="_blank"><b>https://yandex.ru/support/metrica/data/e-commerce.html</b></a><br><br>
  
 Поддерживаются события:<br>
- <b>Product Impressions</b> - Просмотры товаров в каталоге. - категория, производитель, поиск, акции<br>
- <b>Product Clicks</b> - Клики по товарам. - клики по карточкам товаров в каталоге<br>
- <b>Views of Product Details</b> - Просмотры карточек товаров.<br>
- <b>Adding a Product to a Product Cart</b> - Добавление товара в корзину.<br>
- <b>Removing a Product from a Product Cart</b> - Удаление товара из корзины.<br>
- <b>Checkout Steps</b> - Шаги оформления заказа. - только первый шаг - переход к оформлению<br>
- <b>Purchases</b> - Совершенные покупки.
 </div>
 <div class="notice">
 <b>Особенности:</b> <br>
 - Google Tag Manager вам нужно будет настроить самостоятельно по ссылке выше<br>
 - Удаление работает через метод корзины remove и только так, но возможны варианты<br>
 - Не поддерживаются модули заказа в 1 клик - их бесчисленное количество и практически везде javascript который нельзя модифицировать. Возможно за небольшие деньги в частном порядке (см вкладку поддержка).<br>
 - Не поддерживаются модули товаров вроде рекомендуемые в категории, карусели, табы и тп - их бесчисленное количество. Возможно за небольшие деньги в частном порядке (см вкладку поддержка).<br>
 - Не поддерживаются шаги оформления заказа, только переход к самому оформлению и непосредственно сама покупка.<br>
 - Не поддерживается изменение количества в корзине, simplecheckout и пр. Это на самом деле мало кому нужно и существенно удорожает разработку. Обычно никому это не нужно.
 </div>
 
 <div class="heading">Электронная коммерция Google - Measurement protocol</div>
 <div class="description">
 
 Отправка событий в гугл сделана по этой инструкции: <a href="https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide?hl=ru" target="_blank"><b>https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide?hl=ru</b></a><br><br>
 <b>Преимущество Measurement protocol в том что он работает на стороне сервера и фиксирует события независимо от того включен у пользователя AdBlock или подобные программы для блокировки трекинга и рекламы или нет.</b><br><br>
 Поддерживаются события:<br>
- <b>Product Impressions</b> - Просмотры товаров в каталоге. - категория, производитель, поиск, акции<br>
- <b>Product Clicks</b> - Клики по товарам. - клики по карточкам товаров в каталоге<br>
- <b>Views of Product Details</b> - Просмотры карточек товаров.<br>
- <b>Adding a Product to a Product Cart</b> - Добавление товара в корзину.<br>
- <b>Removing a Product from a Product Cart</b> - Удаление товара из корзины.<br>
- Удаление работает через метод корзины remove и только так, но возможны варианты<br>
- <b>Checkout Steps</b> - Шаги оформления заказа. - только первый шаг - переход к оформлению<br>
- <b>Purchases</b> - Совершенные покупки.
 </div>
 <div class="notice">
 <b>Особенности:</b> <br>
 - Не поддерживаются модули заказа в 1 клик - их бесчисленное количество и практически везде javascript который нельзя модифицировать. Возможно за небольшие деньги в частном порядке (см вкладку поддержка).<br>
 - Не поддерживаются модули товаров вроде рекомендуемые в категории, карусели, табы и тп - их бесчисленное количество. Возможно за небольшие деньги в частном порядке (см вкладку поддержка).<br>
 - Не поддерживаются шаги оформления заказа, только переход к самому оформлению и непосредственно сама покупка.<br>
 - Не поддерживается изменение количества в корзине, simplecheckout и пр. Это на самом деле мало кому нужно и существенно удорожает разработку. Обычно никому это не нужно.
 </div>
 
 <div class="heading">Ремаркетинг в MyTarget</div>
 <div class="description">
 Генерация событий сделана по последней инструкции Facebook: <a href="https://target.my.com/help/advertisers/remarketing/ru" target="_blank"><b>https://target.my.com/help/advertisers/remarketing/ru</b></a><br><br>
  
 Поддерживаются события:<br>
 - Просмотр карточки товара<br>
 - Просмотр категории товаров<br>
 - Добавление товара в корзину (при успешном добавлении товара в корзину из карточки товара или по клику на кнопке купить в листингах (скоро будет возможность отслеживать правильно ли добавился товар в корзину)<br>
 - Начало оформления заказа<br>
 - Оформление заказа<br>
 </div>
 <div class="notice">
 <b>Особенности:</b> <br>
 - Не поддерживаются модули заказа в 1 клик - их бесчисленное количество и практически везде javascript который нельзя модифицировать. Возможно за небольшие деньги в частном порядке (см вкладку поддержка).<br>
 - Не поддерживается изменение количества в корзине, simplecheckout и пр. Это на самом деле мало кому нужно и существенно удорожает разработку. Обычно никому это не нужно.
 </div>
 
 <div class="heading">Интеграция с Google отзывы (модуль опроса)</div>
 <div class="description">
 Ссылка на документацию: <a href="https://support.google.com/merchants/answer/7106244" target="_blank"><b>https://support.google.com/merchants/answer/7106244</b></a><br><br>
Модуль умеет генерировать фид отзывов для Google Merchant по инструкции <a href="https://support.google.com/merchants/answer/7075225?hl=ru" target="_blank"><b>https://support.google.com/merchants/answer/7075225?hl=ru</b></a><br><br>
 Запрос отзыва просто работает :)
 </div>
 
 <div class="heading">Фиды, поддержка не оказывается, представлены как есть (AS IS)</div>
 <div class="description">
 
 Модуль умеет генерировать простые фиды для Google Merchant, Facebook и YML (для яндекс-маркета и myTarget) для <b>небольшого</b> количества товаров
 </div>
 <div class="notice">
 <b>Особенности:</b> <br>
- <b>Поддержка не оказывается, фиды представлены как есть</b><br>
- Можно купить у автора правильный фид для Google Merchant и Facebook
 </div>
 
 <div class="heading">Цели</div>
 <div class="description">
 Модуль умеет выполнять различный js-код при:<br>
 - открытии корзины или начале оформления заказа <br>
 - добавлении товара в корзину<br>
 - успешном оформлении заказа<br>
 </div>
 <div class="notice">
 <b>Особенности:</b> <br>
- <b>не пишите script /script и проверяйте функции через if (typeof function_name != \'undefined\') { function_name() } !</b><br>
 </div>
 
 <div class="heading">Счетчики</div>
 <div class="description">
 Модуль умеет добавлять произвольные счетчики в следующие места:<br>
 - в секцию head <br>
 - после открывающего body - обычно тег менеджер <br>
 - в подвал<br>
 </div>
 ';
