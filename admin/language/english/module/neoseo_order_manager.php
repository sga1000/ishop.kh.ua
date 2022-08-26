<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Order manager</p>';
$_['heading_title_raw'] = 'NeoSeo Order manager';

//Tabs
$_['tab_general'] = 'General';
$_['tab_support'] = 'Support';
$_['tab_logs'] = 'Logs';
$_['tab_license'] = 'License';
$_['tab_columns'] = 'Columns';
$_['tab_buttons'] = 'Buttons';
$_['tab_products'] = 'Products';
$_['tab_history'] = 'History';
$_['tab_allowed'] = 'Status limitation';
$_['tab_colors'] = 'Colors';
$_['tab_fields'] = 'Fields';

//Button
$_['button_save'] = 'Save';
$_['button_save_and_close'] = 'Save and Close';
$_['button_close'] = 'Close';
$_['button_recheck'] = 'Check again';
$_['button_clear_log'] = 'Clear Log';
$_['button_download_log'] = 'Download log file';
$_['button_save_allowed'] = 'Save permission set';

// Text
$_['text_module_version'] = '';
$_['text_edit'] = 'Options';
$_['text_success'] = 'Module settings updated!';
$_['text_success_clear'] = 'The log file has been successfully cleared!';
$_['text_clear_log'] = 'Clear the log';
$_['text_clear'] = 'Clear';
$_['text_image_manager'] = 'Image manager';
$_['text_browse'] = 'Overview';
$_['text_module'] = 'Modules';
$_['text_product'] = '<p><a href="/admin/index.php?route=catalog/product/edit&amp;token={product.token}&amp;product_id={product.product_id}">{product.image}</a><a href="/admin/index.php?route=catalog/product/edit&amp;token={product.token}&amp;product_id={product.product_id}">{order_product.name}</a><br />{order_product.quantity}&nbsp;x&nbsp;{order_product.price}&nbsp;&nbsp;{product.sku}</p>';
$_['text_history'] = '{order_history.date_added}{order_status.status}{user.username}{order_history.comment}';
$_['text_list_columns'] = 'Managing order columns';
$_['text_add'] = 'Add';
$_['text_edit'] = 'Edit';
$_['test_columns_format_header'] = 'Managing order columns';
$_['test_buttons_format_header'] = 'Managing order buttons';
$_['test_columns_format_desc'] = 'How to work with the columns';
$_['test_buttons_format_desc'] = 'How to work with buttons';
$_['text_edited'] = ', the ability to edit';

// Entry
$_['entry_status'] = 'Status:';
$_['entry_status_desc'] = 'Advanced order management is available in the menu Sales / Order Manager';
$_['entry_debug'] = 'Debug mode:';
$_['entry_debug_desc'] = 'In the system logs will be written various information for the developer module';
$_['entry_replace_system_status'] = 'Remove standard:';
$_['entry_replace_system_status_desc'] = 'Standard order manager will be hidden';
$_['entry_hide_unavailable'] = 'Hide inaccessible:';
$_['entry_hide_unavailable_desc'] = 'If the user does not have rights to view orders, he will not see this menu item';
$_['entry_visible_statuses'] = 'Displayed statuses:';
$_['entry_visible_statuses_desc'] = 'Shows only those orders whose status is ticked in this list. A good way to filter out already completed orders';
$_['entry_block_send_comment'] = 'Display message block:';
$_['entry_block_send_comment_desc'] = 'Displays in the column "Actions" the block of manual sending of SMS and E-mail messages to the client';
$_['entry_cl_name'] = 'Title';
$_['entry_cl_align'] = 'Align';
$_['entry_cl_pattern'] = 'Template';
$_['entry_cl_width'] = 'Width';
$_['entry_product'] = 'Product list format:';
$_['entry_history'] = 'Format of the order status change history';
$_['entry_action'] = 'Action';
$_['entry_action_add'] = 'Create';
$_['entry_action_edit'] = 'Edit';
$_['entry_action_delete'] = 'Remove';
$_['entry_field_list_name'] = 'Template';
$_['entry_field_list_desc'] = 'Description';
$_['entry_bt_name'] = 'Title';
$_['entry_bt_class'] = 'Class';
$_['entry_bt_style'] = 'Style';
$_['entry_bt_link'] = 'Link';
$_['entry_bt_script'] = 'Script code';
$_['entry_bt_post'] = 'POST-parameters';
$_['entry_format_header'] = 'Restriction on changing order statuses:';
$_['entry_format_header_desc'] = 'Regarding the change in status when viewing and editing an order';
$_['entry_status_list_for_allow'] = 'Basic status set';
$_['entry_allowed_status_list'] = 'Permitted status set when changing';

//Field
$_['field_desc_order_id'] = 'Order number';
$_['field_desc_status'] = 'Order status';
$_['field_desc_date_added'] = 'Order creation date';
$_['field_desc_total'] = 'Total order value';
$_['field_desc_firstname'] = 'Buyer\'s name';
$_['field_desc_lastname'] = 'Buyer\'s surname';
$_['field_desc_telephone'] = 'Buyer phone number';
$_['field_desc_email'] = 'Buyer Email';
$_['field_desc_shipping_address_1'] = 'Address of 1 recipient';
$_['field_desc_shipping_address_2'] = 'Address of 2 recipient';
$_['field_desc_shipping_city'] = 'City of the recipient';
$_['field_desc_payment_method'] = 'Payment method';
$_['field_desc_shipping_method'] = 'Shipping method';
$_['field_desc_shipping_zone'] = 'Recipient region';
$_['field_desc_comment'] = 'Note';
$_['field_desc_status_select'] = 'Order status with the ability to change';
$_['field_desc_custom_fields'] = 'Additional fields from the table order_scfield. Example custom_additional - where custom_ - is a mandatory beginning for additional fields, additional - field name';
$_['field_desc_store_id'] = 'Output of the store\'s id to which the order belongs';
$_['field_desc_store_name'] = 'The output of the store name to which the order relates';
$_['shipping_custom_field'] = 'Additional fields in the delivery address, where "id"=1,2,3,... -  additional field code';

//Params
$_['params_colors'] = 'a:14:{i:0;s:0:"";i:1;a:2:{i:0;s:18:"rgb(255, 255, 203)";i:1;s:18:"rgb(255, 255, 203)";}i:2;a:2:{i:0;s:18:"rgb(255, 255, 203)";i:1;s:18:"rgb(255, 255, 203)";}i:3;a:2:{i:0;s:18:"rgb(187, 223, 141)";i:1;s:18:"rgb(187, 223, 141)";}i:4;s:0:"";i:5;a:2:{i:0;s:18:"rgb(187, 223, 141)";i:1;s:18:"rgb(187, 223, 141)";}i:6;s:0:"";i:7;a:2:{i:0;s:18:"rgb(255, 160, 153)";i:1;s:18:"rgb(255, 160, 153)";}i:8;a:2:{i:0;s:18:"rgb(255, 160, 153)";i:1;s:18:"rgb(255, 160, 153)";}i:9;a:2:{i:0;s:18:"rgb(255, 160, 153)";i:1;s:18:"rgb(255, 160, 153)";}i:10;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}i:11;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}i:12;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}i:13;a:2:{i:0;s:18:"rgb(255, 255, 255)";i:1;s:18:"rgb(255, 255, 255)";}}';
$_['params_num'] = array(0 => 'Even',
	1 => 'Odd'
);

// Error
$_['error_permission'] = 'You do not have the rights to manage this module!';
$_['error_download_logs'] = 'The log file is empty or missing!';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['error_delete'] = 'Error: You are trying to delete a nonexistent object!';
$_['mail_support'] = '';
$_['module_licence'] = '';