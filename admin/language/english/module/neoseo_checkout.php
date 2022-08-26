<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Checkout';
$_['heading_title_raw'] = 'NeoSeo Checkout';

// Tab
$_['tab_general'] = 'Basic';
$_['tab_customer'] = 'Buyer';
$_['tab_payment'] = 'Payment';
$_['tab_shipping'] = 'Delivery';
$_['tab_shipping_type'] = 'Types of delivery';
$_['tab_logs'] = 'Logs';
$_['tab_support'] = 'Support';
$_['tab_license'] = 'License';

// Text
$_['text_module'] = 'Modules';
$_['text_success'] = 'Success: You have successfully changed the settings of the NeoSeo Checkout';
$_['text_title'] = 'Ordering';
$_['text_radio_type'] = 'Switch';
$_['text_select_type'] = 'List';
$_['text_text_type'] = 'Text Type';
$_['text_city_select_default'] = 'Manually enter the country and region';
$_['text_city_select_cities'] = 'Automatic country and region substitution by city name';
$_['text_clear_log'] = 'Clear Logs';
$_['text_success_clear'] = 'Logs successfully cleared';
$_['text_type-0'] = 'Individual';
$_['text_type-1'] = 'Legal entity';
$_['text_dependency_disabled'] = 'Payment and delivery do not depend on each other';
$_['text_dependency_payment_for_shipping'] = 'Payment depends on delivery';
$_['text_dependency_shipping_for_payment'] = 'Delivery depends on payment';
$_['text_types_of_customers'] = 'Types of customers';
$_['text_block_customers'] = 'Fields for the "Buyer" block:';
$_['text_block_payment'] = 'Fields for payment method';
$_['text_block_shipping'] = 'Fields for the delivery method';
$_['text_shipping'] = 'Shipping Method';
$_['text_payment'] = 'Payment method';
$_['text_type_shipping'] = 'Type of delivery';
$_['text_pick_your_own'] = 'Pick up yourself';
$_['text_order_delivery'] = 'Order delivery';
$_['text_select_all'] = 'Select all';
$_['text_name'] = 'Name:';
$_['text_field'] = 'Field:';
$_['text_type'] = 'Type:';
$_['text_identifier'] = 'Identifier:';
$_['text_mask'] = 'Input mask:';
$_['text_initial_value'] = 'Initial value:';
$_['text_show'] = 'Show:';
$_['text_required'] = 'Required:';

// Entry
$_['entry_status'] = 'Condition: <a class="tooltip-trigger" title="Central function to turn on/off this extension."><i class="fa fa-question-circle"></i></a>';
$_['entry_payment_logo'] = 'Show payment method logo: <a class="tooltip-trigger" title="Display the payment logo for payment methods. This only works when payment method is displayed in radio mode."><i class="fa fa-question-circle"></i></a>';
$_['entry_payment_control'] = 'Choice of payment method: <a class="tooltip-trigger" title="Sets the mode payment methods are displayed in. Either radio buttons or select drop down."><i class="fa fa-question-circle"></i></a>';
$_['entry_shipping_control'] = 'Choice of delivery method: <a class="tooltip-trigger" title="Sets the mode shipping methods are displayed in. Either radio buttons or select drop down."><i class="fa fa-question-circle"></i></a>';
$_['entry_shipping_city_select'] = 'Entering the city';
$_['entry_shipping_country_select'] = 'Entering the country';
$_['entry_shipping_country_default'] = 'Default Country';
$_['entry_shipping_zone_default'] = 'Default zone';
$_['entry_shipping_city_default'] = 'Default city';
$_['entry_novaposhta_city_name'] = 'Город по умолчанию для доставки "Новая почта"';
$_['entry_novaposhta_city_name_desc'] = 'В системе обнаружен установленный модуль "NeoSeo Новая почта" с функцией создания накладных. Для его корректной работы необходимо выбрать город по умолчанию для получателя, если Вы хотите использовать параметр "Город по умолчанию"';
$_['entry_shipping_title'] = 'Output of delivery group name';
$_['entry_shipping_novaposhta'] = 'The delivery method for new mail';
$_['entry_warehouse_types'] = 'Type of warehouse for new post';
$_['entry_agreement_id'] = 'Require acceptance of the terms of the agreement';
$_['entry_agreement_default'] = 'Initial value for the daw "I accept the terms of the agreement"';
$_['entry_agreement_text'] = 'Output text requirements';
$_['entry_stock_control'] = 'Check item from the cart';
$_['entry_min_amount'] = 'Minimum order amount';
$_['entry_use_shipping_type'] = 'Use shipping types';
$_['entry_compact'] = 'Compact output';
$_['entry_dependency_type'] = 'Dependency type';
$_['entry_dropped_cart_template'] = 'Abandoned Trash message template';
$_['entry_dropped_cart_email_subject'] = 'Subject of message of the left basket';
$_['entry_onestep'] = 'One step checkout';
$_['entry_cart_redirect'] = 'Redirect from basket to payment';
$_['entry_hide_menu'] = 'Hide the menu while placing an order';
$_['entry_hide_footer'] = 'Hide the footer while placing an order';
$_['entry_override_register'] = 'Firm registration of the client';
$_['entry_override_edit'] = 'Firm editing of the client';
$_['entry_api_key'] = 'API key Nova Poshta';
$_['entry_api_key_desc'] = 'Used to update office addresses. <a href="https://devcenter.novaposhta.ua/" target="_blank">Get key</a>';
$_['entry_use_international_phone_mask'] = 'Use the mask for the phone';
$_['entry_use_international_phone_mask_desc'] = "Use the International Telephone Input plug-in to enter and check international phone numbers. Cancels the entered mask in the buyer's preferences.";

// Technical
$_['entry_debug'] = 'Debugging: <a class="tooltip-trigger" title="Turn on debug mode for checkout. Only turn this on if you know what you are doing."><i class="fa fa-question-circle"></i></a>';
$_['entry_payment_reloads_cart'] = 'Update the shopping cart when changing the payment method: <a class="tooltip-trigger" title="Only enable if your payment methods have surcharges. Disable to reduce ajax requests."><i class="fa fa-question-circle"></i></a>';
$_['entry_shipping_reloads_cart'] = 'Update cart when changing delivery method: <a class="tooltip-trigger" title="Only enable if your payment methods are dependent on your shipping methods. Disable to reduce ajax requests."><i class="fa fa-question-circle"></i></a>';

// Module
$_['entry_coupon'] = 'Display Coupon Module: <a class="tooltip-trigger" title="Turn on/off the coupon module on the checkout page."><i class="fa fa-question-circle"></i></a>';
$_['entry_voucher'] = 'Display Voucher Module: <a class="tooltip-trigger" title="Turn on/off the voucher module on the checkout page."><i class="fa fa-question-circle"></i></a>';
$_['entry_reward'] = 'Display Reward Module: <a class="tooltip-trigger" title="Turn on/off the reward module on the checkout page."><i class="fa fa-question-circle"></i></a>';
$_['entry_cart'] = 'Display Cart Module: <a class="tooltip-trigger" title="Turn on/off the cart module on the checkout page."><i class="fa fa-question-circle"></i></a>';
$_['entry_shipping_module'] = 'Display Shipping Method Module: <a class="tooltip-trigger" title="Turn on/off the shipping method module on the checkout page."><i class="fa fa-question-circle"></i></a>';
$_['entry_payment_module'] = 'Display Payment Method Module: <a class="tooltip-trigger" title="Turn on/off the payment method module on the checkout page."><i class="fa fa-question-circle"></i></a>';
$_['entry_login_module'] = 'Display Login Module: <a class="tooltip-trigger" title="Turn on/off the login module on the checkout page."><i class="fa fa-question-circle"></i></a>';

$_['entry_aways_show_delivery_block'] = 'Show delivery before choosing a city';
$_['entry_aways_show_delivery_block_desc'] = 'Warning! Not all delivery methods may be displayed. Some delivery methods require you to select a city before they are displayed. When this option is enabled, the city input box will be hidden and displayed only for the delivery services selected below. For this option to work, the fields "Country by default", "Region by default", "City by default" must be filled.';
$_['entry_shipping_require_city'] = "List of delivery methods that require a choice of city";
$_['entry_shipping_require_city_desc'] = "When using the 'Show delivery before city selection' option, the city selection block will be displayed only for the selected delivery methods";

// Button
$_['button_add'] = 'Add';
$_['button_continue'] = 'Apply';
$_['button_save_and_close'] = 'Save and Close';
$_['button_clear_log'] = 'Clear Log';

// Error
$_['error_permission'] = '';
$_['error_warehouse_types'] = 'Error request of getWarehouseTypes';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';

$_['mail_support'] = '';
$_['module_licence'] = '';
$_['text_module_version'] = '';
