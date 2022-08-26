<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><span style="margin:0;line-height: 24px;">NeoSeo Price change subscription</span>';
$_['heading_title_raw'] = 'NeoSeo Price change subscription';

// Tab
$_['tab_general'] = 'Options';
$_['tab_subscribe'] = 'Subscription';
$_['tab_unsubscribe'] = 'Unsubscribe';
$_['tab_notify'] = 'Notification';
$_['tab_fields'] = 'Fields';
$_['tab_logs'] = 'Logs';
$_['tab_support'] = 'Support';
$_['tab_license'] = 'License';
$_['tab_fields'] = 'fields';

// Text
$_['text_module_version'] = '';
$_['text_success'] = 'Module settings updated!';
$_['text_module'] = 'Modules';
$_['text_success_clear'] = 'Log file cleared successfully!';
$_['text_clear_log'] = 'Clear log';

// Button
$_['button_save'] = 'Save';
$_['button_save_and_close'] = 'Save and Close';
$_['button_close'] = 'Close';
$_['button_recheck'] = 'Check again';
$_['button_clear_log'] = 'Clear log';
$_['button_download_log'] = 'Download log file';

// Entry
$_['entry_status'] = 'Status';
$_['entry_debug'] = 'Debug mode';
$_['entry_cron'] = 'Task for planner';
$_['entry_debug_desc'] = 'Various information for module developer will be written to module logs';
$_['entry_subscribe_subject'] = 'Email subject';
$_['entry_subscribe_subject_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_subscribe_message'] = 'Message text';
$_['entry_subscribe_message_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_unsubscribe_subject'] = 'Email subject';
$_['entry_unsubscribe_subject_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_unsubscribe_message'] = 'Message text';
$_['entry_unsubscribe_message_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_subscribe_subject_mail'] = 'Email subject';
$_['entry_subscribe_subject_mail_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}, {price_new}, {price_old}';
$_['entry_subscribe_message_mail'] = 'Message text';
$_['entry_subscribe_message_mail_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}, {price_new}, {price_old}';
$_['entry_admin_subscribe_notify'] = 'Request message recipients, separated by commas';
$_['entry_admin_subscribe_notify_subject'] = 'Email subject for admit';
$_['entry_admin_subscribe_notify_subject_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_admin_subscribe_notify_message'] = 'Message text for admit';
$_['entry_admin_subscribe_notify_message_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_admin_unsubscribe_notify_subject'] = 'Email subject for admit';
$_['entry_admin_unsubscribe_notify_subject_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_admin_unsubscribe_notify_message'] = 'Message text for admit';
$_['entry_admin_unsubscribe_notify_message_desc'] = 'Allowed to use {id}, {name}, {email}, {product_name}, {product_url}';
$_['entry_image_width'] = 'Image Width';
$_['entry_image_height'] = 'Image Height';
$_['entry_field_list_name'] = 'Шаблон';
$_['entry_field_list_desc'] = 'Описание';
$_['entry_subscribe_text_subscribe'] = 'Message text, in case of successful subscription';
$_['entry_unsubscribe_text_unsubscribe'] = 'Message text, in case of unsubscribing';
$_['entry_stock_status'] = 'Displayed statuses';
$_['entry_stock_status_desc'] = 'Subscription is available for products that have status checked in this list.';


//Params
$_['param_subscribe_subject'] = "Request №{id} for notification of product price change {product_name} accepted";
$_['param_subscribe_message'] = "Your request №{id} for notification of product price change saved!";
$_['param_unsubscribe_subject'] = "You have unsubscribed from mailing list";
$_['param_unsubscribe_message'] = "You have unsubscribed from mailing list!";
$_['param_subscribe_subject_mail'] = "Price for {product_name} product changed.";
$_['param_subscribe_message_mail'] = "Hello, {name}. Price for product <a href='{product_url}'>{product_name}</a> changed. New product price {price_new}.";
$_['param_admin_subscribe_notify_subject'] = "New order №{id} for product arrival notification";
$_['param_admin_subscribe_notify_message'] = "User {name} left request №{id} for notification of product price change {product_name}.";
$_['param_admin_unsubscribe_notify_subject'] = "User {name} unsubscribed from the mailing list";
$_['param_admin_unsubscribe_notify_message'] = "User {name} unsubscribed from the mailing list";
$_['param_subscribe_text_subscribe'] = "When product price changes, you will receive notification!";
$_['param_unsubscribe_text_unsubscribe'] = "You have unsubscribed from change notification in the product price!";

//Fields
$_['field_desc_id'] = 'Request number';
$_['field_desc_name'] = 'Customer name';
$_['field_desc_phone'] = 'Customer phone';
$_['field_desc_email'] = ' Customer E-mail';
$_['field_desc_product_name'] = 'Product name';
$_['field_desc_price_old'] = 'Old product price';
$_['field_desc_price_new'] = 'New product price';
$_['field_desc_product_url'] = 'Link to the product';

// Error
$_['error_download_logs'] = 'Log file is empty or missing!';
$_['error_permission'] = 'You do not have rights to manage this module!';
$_['error_supplier_info'] = 'This field is required!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['mail_support'] = '';
$_['module_licence'] = '';
