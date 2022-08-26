<?php

// Heading
$_['heading_title'] = '<img width="24" height="24" src="view/image/neoseo.png" style="float: left;"><span style="margin:0;line-height: 24px;">NeoSeo SEO Filter Landing Page Generator</span>';
$_['heading_title_raw'] = 'NeoSeo SEO Filter Landing Page Generator';

//Tabs
$_['tab_general'] = 'Main settings';
$_['tab_generate_page'] = 'Landing paiges generating';
$_['tab_generate_rule'] = 'Rules generation';
$_['tab_logs'] = 'logs';
$_['tab_support'] = 'Support';
$_['tab_license'] = 'License';
$_['tab_patterns'] = 'Patterns descriptions';

// Text
$_['text_module_version'] = '';
$_['text_success'] = 'Module settings updated!';
$_['text_module'] = 'Modules';
$_['text_success_clear'] = 'Log file cleared successfully!';
$_['text_clear_log'] = 'Clear logs';
$_['text_clear'] = 'Clear';
$_['text_success_generate'] = 'Rules generation for landing page generator is complete!';
$_['text_pattern_name_default'] = '[page_category], [page_filters], [page_options], [page_option_values]';
$_['text_pattern_title_default'] = '[page_category], [page_filters], [page_options], [page_option_values]';
$_['text_pattern_meta_description_default'] = '[page_category], [page_filters], [page_options], [page_option_values]';
$_['text_pattern_url_default'] = '[page_title]';
$_['text_pattern_h1_default'] = '[page_title]';
$_['text_manufacturer_default'] = 'Manufacturer';
$_['text_pattern_description_default'] = '{h1}';

//Buttons
$_['button_save'] = 'Save';
$_['button_save_and_close'] = 'Save and Close';
$_['button_close'] = 'Close';
$_['button_recheck'] = 'Check again';
$_['button_clear_log'] = 'Clear log';
$_['button_download_log'] = 'Download log file';
$_['button_generate_rules'] = 'Generate';

// Entry
$_['entry_debug'] = 'Debug mode<br /><span class="help">Module logs will contain various information for module developer.</span>';
$_['entry_status'] = 'Status';
$_['entry_ip_list'] = 'Allowed IP Addresses';
$_['entry_ip_list_desc'] = 'IP addresses list from which generation is allowed. Each address is on a new line. Empty list - no limit.';
$_['entry_limit_pagination'] = 'Entries lomit per page';
$_['entry_cron'] = 'Scheduler';

$_['entry_page_status_default'] = 'Default landing page status';
$_['entry_limit_url'] = 'CNC landing page length';
$_['entry_limit_records'] = 'Number of entries for one iteration';
$_['entry_limit_records_desc'] = 'Used when manually generating landing pages for one rule';
$_['entry_pattern_manufacturer'] = 'Name for manufacturer';
$_['entry_pattern_manufacturer_desc'] = 'Specify name for the manufacturer if it is used in landing page';
$_['entry_pattern_name_default'] = ' landing page template name by default';
$_['entry_pattern_name_default_desc'] = 'Available templates: [page_category], [page_filters], [page_options], [page_option_values]';
$_['entry_pattern_title_default'] = 'Default Landing Page Title Template';
$_['entry_pattern_title_default_desc'] = 'Available templates: [page_category], [page_filters], [page_options], [page_option_values], [page_name]';
$_['entry_pattern_meta_description_default'] = 'Default Landing Page Meta Description Template';
$_['entry_pattern_meta_description_default_desc'] = 'Available templates: [page_category], [page_filters], [page_options], [page_option_values], [page_name]';
$_['entry_pattern_h1_default'] = 'The default H1 landing page template';
$_['entry_pattern_h1_default_desc'] = 'Available templates: [page_category], [page_filters], [page_options], [page_option_values], [page_name], [page_title]';
$_['entry_pattern_url_default'] = 'Default landing page URL template';
$_['entry_pattern_url_default_desc'] = 'Available templates: [page_category], [page_filters], [page_options], [page_option_values], [page_name], [page_title], [page_h1]';
$_['entry_separator_page_options'] = 'Filter Option Separator';
$_['entry_separator_page_options_desc'] = 'Applies when using a template [page_options]. <br> Default ",". <br> Example: colour, size';
$_['entry_separator_page_option_values'] = 'Separator for filter options';
$_['entry_separator_page_option_values_desc'] = 'Applies when using a template [page_option_values]. <br> Default ",". <br> Example: blue, green, XS';
$_['entry_separator_page_filters'] = 'Separator filter option + filter option value';
$_['entry_separator_page_filters_desc'] = 'Applies when using a template [page_filters]. Default ":". <br> Example: colour: blue, green';
$_['entry_separator_page_option_option_values'] = 'Separator of the set filter option + filter option value';
$_['entry_separator_page_option_option_values_desc'] = 'Applies when using a template [page_filters]. <br> Default ";". <br> Example: Цвет: blue, green; Size: XS';

$_['entry_use_direct_link_default'] = 'Use direct links Default';
$_['entry_use_direct_link_default_desc'] = 'Whether landing pages will be available through direct links "/filter-page-url" or along with a category "/category/filter-page-url"';
$_['entry_pattern_description_default'] = 'Landing page description template Default';
$_['entry_pattern_description_default_desc'] = 'Available templates: [page_category], [page_filters], [page_options], [page_option_values],[page_name],[page_title],[page_h1] {h1}, чтобы добавлять в описание содержимое поля h1';
$_['entry_use_end_slash_default'] = 'Use slash at the end of Landing Page URL';
$_['entry_use_end_slash_default_desc'] = 'When this option is enabled, / will be added at the end of the landing page URL. Example https://mysite.com/filterpage/ ';


$_['entry_generate_rules'] = 'Create a set of rules';
$_['entry_limit_categories'] = 'Number of categories for one iteration';
$_['entry_limit_categories_desc'] = 'Used when manually generating a rule set';
$_['entry_generate_rules_desc'] = 'Create a set of rules for generating landing pages based on existing filter options';

$_['entry_pattern_list_name'] = 'Template';
$_['entry_pattern_list_desc'] = 'Template description';

//fields_desc
$_['pattern_desc_page_category'] = 'Landing page category';
$_['pattern_desc_page_filters'] = 'A set of filter options with filter option values';
$_['pattern_desc_page_options'] = 'Filter option list';
$_['pattern_desc_page_option_values'] = 'Filter option values list';
$_['pattern_desc_page_name'] = 'Landing page name';
$_['pattern_desc_page_title'] = ' Landing page title';
$_['pattern_desc_page_page_h1'] = ' Landing page H1';


// Error
$_['error_permission'] = 'You do not have rights to manage this module!';
$_['error_download_logs'] = 'Log file is empty or missing!';
$_['error_no_filter_tables'] = ' For generate landing pages, module "SEO-Filter from NeoSeo Web Studio" must be installed in the system! ';
$_['error_ioncube_missing'] = '';
$_['error_license_missing'] = '';
$_['mail_support'] = '';
$_['module_licence'] = '';
