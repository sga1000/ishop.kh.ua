<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Subscription for goods receipt</p>';
$_['heading_title_raw'] = 'NeoSeo Subscription for goods receipt';

// Tab
$_['tab_general'] = 'Options';
$_['tab_subscribe'] = 'Subscription';
$_['tab_unsubscribe'] = 'Unsubscription';
$_['tab_notify'] = 'Notification';
$_['tab_fields'] = 'Fields';
$_['tab_logs'] = 'Logs';
$_['tab_support'] = 'Support';
$_['tab_license'] = 'License';
$_['tab_fields'] = 'Fields';

// Text
$_['text_success'] = 'Success: You have successfully changed module settings!';
$_['text_module'] = 'Modules';
$_['text_success_clear'] = 'The log file has been successfully cleared!';
$_['text_clear_log'] = 'Clear Log';

// Button
$_['button_save'] = 'Save';
$_['button_save_and_close'] = 'Save and Close';
$_['button_close'] = 'Close';
$_['button_recheck'] = 'Check again';
$_['button_clear_log'] = 'Clear Log';
$_['button_download_log'] = 'Download log file';

// Entry
$_['entry_status'] = 'Status';
$_['entry_debug'] = 'Debugging';
$_['entry_cron'] = 'Command for cron';
$_['entry_debug_desc'] = 'The module logs will write various information for the module developer';
$_['entry_subscribe_subject'] = 'Letter subject';
$_['entry_subscribe_subject_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_subscribe_message'] = 'Message text';
$_['entry_subscribe_message_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_unsubscribe_subject'] = 'Letter subject';
$_['entry_unsubscribe_subject_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_unsubscribe_message'] = 'Message text';
$_['entry_unsubscribe_message_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_subscribe_subject_mail'] = 'Letter subject';
$_['entry_subscribe_subject_mail_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_subscribe_message_mail'] = 'Message text';
$_['entry_subscribe_message_mail_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_subscribe_notify'] = 'Recipients of message about the application, separated by commas';
$_['entry_admin_subscribe_notify_subject'] = 'Subject of the letter to admin';
$_['entry_admin_subscribe_notify_subject_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_subscribe_notify_message'] = 'Message text to admin';
$_['entry_admin_subscribe_notify_message_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_unsubscribe_notify_subject'] = 'Subject of the letter to admin';
$_['entry_admin_unsubscribe_notify_subject_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_admin_unsubscribe_notify_message'] = 'Message text to admin';
$_['entry_admin_unsubscribe_notify_message_desc'] = 'You can use {id}, {name}, {email}, {product_name}, {product_url}, {options}';
$_['entry_image_width'] = 'Image Width';
$_['entry_image_height'] = 'Image Height';
$_['entry_field_list_name'] = 'Template';
$_['entry_field_list_desc'] = 'Description';
$_['entry_subscribe_text'] = 'Message text in case of a successful subscription';
$_['entry_unsubscribe_text'] = 'Message text in case of unsubscribing';
$_['entry_stock_statuses'] = 'Displayed statuses';
$_['entry_stock_statuses_desc'] = 'Subscription is available for products whose status is ticked in this list.';
$_['entry_script'] = 'Script to hide unnecessary elements';


// Error
$_['error_permission'] = 'You do not have the rights to manage this module!';
$_['error_supplier_info'] = 'This field is required!';
$_['error_download_logs'] = 'Log file is empty or missing!';

//Params
$_['param_subscribe_text'] = "<p>Dear, {name}!</p><p>Thank you for being interested in our products!</p><p>As soon as the goods \"{product_name} {options}\" appear in stock, we will immediately send you a letter with a message about it.</p>";
$_['param_subscribe_subject'] = "Application №{id} accepted";
$_['param_subscribe_message'] = "Hello, {name}!<br><br>You have successfully signed up to a written notice of receipt of the goods <a href='{product_url}'>{product_name} {options}</a>";
$_['param_admin_subscribe_notify_subject'] = "Received application №{id} for notice of goods receipt";
$_['param_admin_subscribe_notify_message'] = "Visitor <a href='mailto:{email}'>{name}</a> left the application №{id} for a notice to the availability of goods <a href='{product_url}'>{product_name} {options}</a>.";

$_['param_unsubscribe_text'] = "<p>Dear, {name}!</p><p>You have unsubscribed from the appearance of the product notice \"{product_name}\"!</p><p>More letters about the appearance of the goods \"{product_name}\" will not bother you.</p>";
$_['param_unsubscribe_subject'] = "Application №{id} disabled";
$_['param_unsubscribe_message'] = "Hello, {name}!<br><br>You have successfully unsubscribed from a goods receipt notification <a href='{product_url}'>{product_name}</a>";
$_['param_admin_unsubscribe_notify_subject'] = "Application №{id} for notification of goods receipt is disabled";
$_['param_admin_unsubscribe_notify_message'] = "Visitor <a href='mailto:{email}'>{name}</a> has unsubscribed from a goods receipt notification <a href='{product_url}'>{product_name}</a>";

$_['param_subscribe_subject_mail'] = "The commodity \"{product_name}\" arrived";
$_['param_subscribe_message_mail'] = "<p>Hello, {name}!</p><p>The product for which you are subscribed is available for purchase again: <a href='{product_url}'>{product_name} {options}</a></p>";

//Fields
$_['field_desc_subscribe_id'] = 'Application number';
$_['field_desc_subscribe_name'] = 'Customer name';
$_['field_desc_subscribe_email'] = 'E-mail of the customer';
$_['field_desc_subscribe_product_name'] = 'Product Name';
$_['field_desc_subscribe_product_url'] = 'Link to the product';
$_['field_desc_subscribe_options'] = 'Product options';

$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['mail_support'] = '';
$_['module_licence'] = '';
$_['text_module_version'] = '';
