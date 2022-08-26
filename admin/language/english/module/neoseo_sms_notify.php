<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><span style="margin:0;line-height: 24px;">NeoSeo SMS Informer</span>';
$_['heading_title_raw'] = 'NeoSeo SMS Informer';

// Column
$_['column_status_name'] = 'Status Name';
$_['column_status'] = 'Send';
$_['column_template_subject'] = 'Message';

// Text
$_['text_success'] = 'Module settings updated!';
$_['text_module'] = 'Modules';
$_['text_success_clear'] = 'Log file was successfully cleared!';
$_['text_clear_log'] = 'Clear log';
$_['text_select_template'] = 'Specify template';
$_["text_new_order"] = 'New order received';
$_['text_customer_templates'] = 'Messages to customers';
$_['text_admin_templates'] = 'Message to admins';
$_['text_module_version'] = '';
$_['text_force'] = 'Force';

// Button
$_['button_save'] = 'Save';
$_['button_save_and_close'] = 'Clear and Save';
$_['button_close'] = 'Close';
$_['button_clear_log'] = 'Clear log';
$_['button_recheck'] = 'Check again';
$_['button_insert'] = 'Create';
$_['button_delete'] = 'Delete';

// Entry
$_['entry_status'] = 'Status:';
$_['entry_status_desc'] = 'Send messages when order status changes.';
$_['entry_customer_group'] = 'Customer group:';
$_['entry_force'] = 'Force:';
$_['entry_force_desc'] = 'Send SMS even if the "notify customer" option is not enabled:';
$_['entry_align'] = 'Autocompletion:';
$_['entry_align_desc'] = 'For gateway to work properly, you need a full phone number, for example 38 095 111 11 11, but customers often enter only a part, for example 095 111 11 11. Specify full value mask, for example 38 000 000 00 00, and module itself will add missing numbers to the entered number';
$_['entry_recipients'] = 'Recipients of admin messages:';
$_['entry_recipients_desc'] = 'Enter phone numbers in international format, separated by commas.';
$_['entry_debug'] = 'Debug mode:';
$_['entry_debug_desc'] = 'Various information for module developer will be written to system logs.';
$_['entry_sms_gatenames'] = 'SMS Gateway';
$_['entry_gate_login'] = 'Login or API key for SMS gateway';
$_['entry_gate_login_desc']= 'If for a gateway (for example sms.ru) only the API key is required, then leave the Password, Sender fields blank.';
$_['entry_gate_password'] = 'Password for SMS gateway';
$_['entry_gate_sender'] = 'Sender for SMS Gateway';
$_['entry_gate_additional'] = 'Additional parameters for SMS gateway';
$_['entry_gate_check'] = 'Check ';
$_['entry_gate_check_phone'] = "Phone";
$_['entry_gate_check_message'] = "Message";
$_['entry_field_list_name'] = 'Template';
$_['entry_field_list_desc'] = 'Description';
$_['entry_review_status'] = 'Status';
$_['entry_review_status_desc'] = 'send notifications about new feedbacks';
$_['entry_review_notification_message'] = 'Notification text';
$_['entry_review_notification_message_desc'] = '{product_name} - product name, {product_sku} - product sku, {product_model} - product model, {product_id} - product code';
$_['entry_admin_notify_type'] = 'Send notifications via:';
$_['entry_telegram_api_key'] = 'API KEY for Telegram:';
$_['entry_telegram_chat_id'] = 'Chat ID for Telegram:';
$_['entry_instruction'] = 'Module instructions:';
$_['entry_history'] = 'Change history:';
$_['entry_faq'] = 'Frequently asked Questions:';

// Tab
$_['tab_general'] = 'General';
$_['tab_templates'] = 'Messages template';
$_['tab_review'] = 'New feedbacks';
$_['tab_support'] = 'Support';
$_['tab_logs'] = 'Logs';
$_['tab_license'] = 'License';
$_['tab_fields'] = 'Filds';
$_['tab_templates_desc'] = 'Specify messages according to order statuses';
$_['tab_admin_notify'] = 'Notification for administrators';
$_['tab_usefull'] = 'Useful links';

// Field
$_['field_desc_order_status'] = 'Order status';
$_['field_desc_order_date'] = 'Order date';
$_['field_desc_date'] = 'Current date';
$_['field_desc_total'] = 'Order summary (total, currency_code, currency_value)';
$_['field_desc_sub_total'] = ' Order subtotal (currency_code, currency_value)';
$_['field_desc_invoice_number'] = 'Invoice number';
$_['field_desc_comment'] = 'Note to order';
$_['field_desc_shipping_cost'] = 'Order cost';
$_['field_desc_tax_amount'] = 'Tax amount';
$_['field_desc_logo_url'] = 'Store link';
$_['field_desc_firstname'] = 'Customer name';
$_['field_desc_lastname'] = 'Customer last name';
$_['field_desc_shipping_firstname'] = 'Customer name ( Shipping )';
$_['field_desc_shipping_lastname'] = 'Customer last name ( Shipping )';
$_['field_desc_payment_firstname'] = 'Customer name ( Payment )';
$_['field_desc_payment_lastname'] = 'Customer last name ( Payment )';
$_['field_admin_notify_types']['sms'] = 'SMS';
$_['field_admin_notify_types']['telegram'] = 'Telegram';

// Error
$_['error_message'] = 'Enter your message';
$_['error_permission'] = 'You do not have rights to manage this module!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';

$_['mail_support'] = '';
$_['module_licence'] = '';

//links
$_['instruction_link'] = '<a target="_blank" href="https://neoseo.com.ua/nastroyka-modulya-neoseo-sms-informer">https://neoseo.com.ua/nastroyka-modulya-neoseo-sms-informer</a>';
$_['history_link'] = '<a target="_blank" href="https://neoseo.com.ua/sms-informer-opencart#module_history">https://neoseo.com.ua/sms-informer-opencart#module_history</a>';
$_['faq_link'] = '<a target="_blank" href="https://neoseo.com.ua/sms-informer-opencart#faqBox">https://neoseo.com.ua/sms-informer-opencart#faqBox</a>';