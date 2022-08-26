<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><p style="margin:0;line-height: 24px;">NeoSeo Импорт из YML</p>';
$_['heading_title_raw'] = 'NeoSeo Импорт из YML';

//Tab
$_['tab_general'] = 'General';
$_['tab_import'] = 'Imports';
$_['tab_support'] = 'Support';
$_['tab_logs'] = 'Logs';
$_['tab_license'] = 'License';

//Button
$_['button_save'] = 'Save';
$_['button_save_and_close'] = 'Save and Close';
$_['button_close'] = 'Close';
$_['button_recheck'] = 'Check again';
$_['button_clear_log'] = 'Clear logs';
$_['button_imports'] = 'Run imports';
$_['button_import'] = ' Run import';
$_['button_clear_database'] = 'Clear database';
// Text
$_['text_module_version'] = '';
$_['text_edit'] = 'Options';
$_['text_success'] = 'Module settings updated successfully!';
$_['text_success_clear'] = 'Logs deleted successfully';
$_['text_module'] = 'Modules';
$_['text_success_database_clear'] = 'Database cleaned successfully';
$_['text_success_clear'] = 'Logs cleaned successfully';
$_['text_success_import'] = 'Import completed successfully';
$_['text_error_import'] = 'Import can not be completed. There are no imports!';
$_['text_success_imports'] = 'Imports completed successfully';
$_['text_error_imports'] = 'Imports cannot be completed. There are no imports!';
$_['text_success_delete'] = 'Import deleted successfully!';
$_['text_new_import'] = 'New import';
$_['text_del_import'] = 'Delete import';
$_['text_only_empty'] = ' If empty fild';

$_['text_generate_common'] = 'Systemic';
$_['text_generate_field'] = 'From URL import tag';

// Entry
$_['entry_status'] = 'Status:';
$_['entry_debug'] = 'Debug mode:';
$_['entry_import_url'] = 'YML link';
$_['entry_cron'] = 'Task for planner';
$_['entry_update_name'] = 'Update name';
$_['entry_update_description'] = 'Update description';
$_['entry_update_price'] = 'Update price';
$_['entry_update_image'] = 'Update imagen';
$_['entry_update_manufacturer'] = 'Update manufacturer';
$_['entry_update_attribute'] = 'Update attribute';
$_['entry_import_name'] = 'Import name';
$_['entry_import_name_desc'] = 'Import name, will be displayed in export tab';
$_['entry_import_status'] = 'Import status';
$_['entry_import_categories'] = 'Categories';
$_['entry_import_categories_desc'] = 'Specify the categories that you want to exclude, products included in this category will not be loaded. Each category name on a new line';
$_['entry_update_category'] = 'Update category';
$_['entry_add_category'] = ' Do not import categories';
$_['entry_update_category_skip'] = 'Skip categories if they have no links';
$_['entry_update_category_skip_desc'] = 'If source has incorrect links with parent categories or there are no parent categories - we skip such, products will be added';
$_['entry_update_model'] = 'Update model';
$_['entry_update_meta_tag'] = 'Update meta-tag';
$_['entry_top_category_level'] = 'No parent category';
$_['entry_parent_category'] = 'Parent category';
$_['entry_price_charge'] = 'Product markup (%)';
$_['entry_price_gradation'] = 'Graduated markup';
$_['entry_price_gradation_desc'] = 'Example: 500:0;2000:1.5;5000:1.25 - means that products with price less than 500 do not load, from 500 to 2000 multiply price by 1.5, from 2000 to 5000 multiply by 1.25, over 5000 price does not change. <br>Nested formula supported: 2000:<b>-100|1.25|0</b>; - means that for products with a price up to 2000, subtract 100, then multiply by 1.25 and add 0';
$_['entry_generate_url'] = 'Generating CNC links for products';
$_['entry_import_currency'] = 'Import currency';
$_['entry_import_convert_currency'] = 'Convert currency';
$_['entry_import_convert_currency_desc'] = 'If offer currency matches one of the list, it will be automatically converted according to exchange rate in the store. On the left is import currency, on the right is store\'s currency. <br><b>Example</b> list of matches:<br>Руб:RUB,Дол:USD';
$_['entry_no_currency'] = 'Currency not defined, coefficient 1';
$_['entry_stock_status_true'] = 'Item status "in stock"';
$_['entry_stock_status_false'] = 'Item status "out of stock"';
$_['entry_exclude_by_name'] = 'Exclude products by name';
$_['entry_exclude_by_name_desc'] = 'Each product name on new line';
$_['entry_only_update_product'] = 'Products only update';
$_['entry_only_update_product_desc'] = 'No new items will be added';
$_['entry_create_discount_price'] = 'Create promotional prices';
$_['entry_create_discount_price_desc'] = 'Price from import will be recorded as a promotion price, and the base price will be formed according to the rule Promotional price * Percentage%';
$_['entry_discount_price_percent'] = 'Percentage to create a promotional price';
$_['entry_available_control'] = 'Product availability control';
$_['entry_available_control_desc'] = 'If you need to track absence of an item in the price list, enable this option. If the item is not available, it will be disabled in the store.';
$_['entry_use_quantity'] = 'Use balance when adding and updating an item';
$_['entry_use_quantity_desc'] = 'If you leave 0, the rest of the product will be taken from the quantity tag, if it is also missing, the remaining 999 will be specified';
$_['entry_sku_tag'] = 'Specify SKU tag:';
$_['entry_sku_tag_desc'] = 'Specify tag that will be responsible for SKU field in the upload (sku). This field will be used to search for products in the store, if no such product is found, a new product will be created. <br> If tag is not found, offer id tag will be used as SKU.';
$_['entry_set_miss_quantity'] = 'Set quantity 0 for missing items';
$_['entry_set_miss_quantity_desc'] = 'Set for products that are not in the import file, quantity 0. Will be applied only for products that were created / updated as a result of importing the current source.';
$_['entry_price_tag'] = 'Specify price tag';
$_['entry_price_tag_desc'] = 'If left blank, the standard price tag will be used.';
$_['entry_fill_parent_categories'] = 'Display product in parent categories';
$_['entry_fill_parent_categories_desc'] = 'If, for example, the product enter into the category Players -> mp3, then it will be aslo displayed in "Players" category';
$_['entry_name_tag'] = 'Specify tag where to get the names from';
$_['entry_name_tag_desc'] = 'If field is left blank, product name will be taken according to the standard - name';
$_['entry_description_tag'] = 'Specify tag where to get the description';
$_['entry_description_tag_desc'] = 'If field is left blank, the product description will be taken according to the standard - description';
$_['entry_sql_before'] = 'SQL before import processing:';
$_['entry_sql_before_desc'] = 'If you have any specific logic for updating the database before importing data from YML - you can implement it using a series of SQL queries separated by semicolons - ";"';
$_['entry_sql_after'] = 'SQL after processing imports:';
$_['entry_sql_after_desc'] = 'If you have any specific logic for updating the database after importing data from YML - you can implement it using a series of SQL queries separated by semicolons - ";"';
$_['entry_switch_category'] = 'Switch category filter mode';
$_['entry_switch_category_desc'] = 'If enabled - categories will be loaded only those specified in the list above, if disabled - such categories will be excluded from loading. Products included in these categories will also be excluded';
$_['entry_ignore_attributes'] = 'Ignoring attributes';
$_['entry_ignore_attributes_desc'] = "List of attributes to exclude. Each attribute on a separate line";
$_['entry_route_attributes'] = 'Redirecting attributes';
$_['entry_route_attributes_desc'] = "If you need to write some property specifically in the product, and not in the list of properties, then indicate property name and product table field using equal sign.<br><b>Example</b> list of matches:<br>Weight=weight<br>SKU=modelе";
$_['entry_sku_prefix'] = 'SKU prefix';
$_['entry_sku_prefix_desc'] = 'This prefix will be added to the product in store. If you have several suppliers with the same SKU, use prefix so that they are two different products';
$_['entry_update_additions'] = 'Update additional fields';
$_['entry_update_additions_desc'] = 'Disable parameter if you do not need to update data with weight, barcode tag. If such tags are present in the import, they will be updated in the product card ';
$_['entry_update_additions'] = 'Update additional fields';
$_['entry_update_additions_desc'] = 'Disable parameter if you do not need to update data with weight, barcode tag. If such tags are present in the import, they will be updated in the product card ';
$_['entry_import_ftp_server'] = 'FTP Server address';
$_['entry_import_ftp_server_desc'] = 'If you are using an FTP server as a price list source, the "Link to YML" field is ignored';
$_['entry_import_ftp_login'] = 'FTP Server login';
$_['entry_import_ftp_password'] = 'FTP Server password';
$_['entry_import_ftp_path'] = 'FTP path to import file';
$_['entry_import_ftp_path_desc'] = 'You must specify full path, name and file extension.<br> Example /download/import.xml';
$_['entry_create_price_action'] = 'Promotional price by tag';
$_['entry_create_price_action_desc'] = 'Specify tag name from which you want to take price for the promotion, this field will be compared with the main one and if it is less than it will be assigned to the group by default by a perpetual promotion, if promotion is equal to the main one - all promotions are cleared';
$_['entry_available_status_via_stock'] = 'Matching tag name for product status with status in store';
$_['entry_available_status_via_stock_desc'] = 'Specify correspondence of tag name for product status with status in the store, as well as the dependence of the balance if required. Each rule is on a new line. Formula [Tag name] = [its value]: [status name in the store]:product balance <br> Example:<br> available=in stock:In stock:500 <br> available=Not available:Out of the stock:0 <br> available=Specify:Pre-order:0';
$_['entry_reload_image'] = 'Force images update even if they are already downloaded';
$_['entry_main_tag'] = 'Main import tag';
$_['entry_main_tag_desc'] = 'Specify main tag name in the import file, for example offers';
$_['entry_item_tag'] = 'Product tag in import file';
$_['entry_item_tag_desc'] = 'Specify tag name that is an element of the product in the import file, for example, offer';

// Error
$_['error_permission'] = 'You do not have sufficient rights to manage this module!';
$_['error_ioncube_missing'] = "";
$_['error_license_missing'] = "";
$_['mail_support'] = "";
$_['module_licence'] = "";
