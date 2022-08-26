<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_import_yml_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

<?php $widgets->dropdownA('import_status', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->inputA('import_name', 'imports',$max_id); ?>
<?php $widgets->inputA('import_url', 'imports',$max_id); ?>
<?php $widgets->inputA('import_ftp_server', 'imports', $max_id); ?>
<?php $widgets->inputA('import_ftp_login', 'imports', $max_id); ?>
<?php $widgets->inputA('import_ftp_password', 'imports', $max_id); ?>
<?php $widgets->inputA('import_ftp_path', 'imports', $max_id); ?>
<?php $widgets->dropdownA('parent_category', 'imports', $max_id, $categories); ?>
<?php $widgets->dropdownA('inner_tag', 'imports', $max_id, array( 0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->inputA('main_tag', 'imports', $max_id); ?>
<?php $widgets->inputA('item_tag', 'imports', $max_id); ?>
<?php $widgets->inputA('price_tag', 'imports',$max_id); ?>
<?php $widgets->inputA('price_charge', 'imports',$max_id); ?>
<?php $widgets->inputA('price_gradation', 'imports',$max_id); ?>
<?php $widgets->dropdownA('import_currency', 'imports', $max_id, $currencies); ?>
<?php $widgets->inputA('import_convert_currency', 'imports', $max_id); ?>
<?php $widgets->dropdownA('generate_url', 'imports', $max_id, array(  0 => $text_generate_common, 1 => $text_generate_field )); ?>
<?php $widgets->dropdownA('stock_status_true', 'imports',$max_id, $stock_statuses); ?>
<?php $widgets->dropdownA('stock_status_false', 'imports',$max_id, $stock_statuses); ?>
<?php $widgets->inputA('field_sync', 'imports',$max_id); ?>
<?php $widgets->inputA('sku_prefix', 'imports',$max_id); ?>
<?php $widgets->inputA('sku_tag', 'imports',$max_id); ?>
<?php $widgets->dropdownA('update_name', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->inputA('name_tag', 'imports',$max_id); ?>
<?php $widgets->dropdownA('update_description', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled, 2 => $text_only_empty )); ?>
<?php $widgets->inputA('description_tag', 'imports',$max_id); ?>
<?php $widgets->dropdownA('update_attribute', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('update_additions', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('update_image', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('reload_image', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('update_manufacturer', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('update_price', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->inputA('create_price_action', 'imports',$max_id); ?>
<?php $widgets->dropdownA('create_discount_price', 'imports',$max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->inputA('discount_price_percent', 'imports',$max_id); ?>
<?php $widgets->dropdownA('update_category', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('fill_parent_categories', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('update_category_skip', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('update_model', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('update_meta_tag', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled, 2 => $text_only_empty)); ?>
<?php $widgets->dropdownA('add_category', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('only_update_product', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('available_control', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->dropdownA('set_miss_quantity', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->inputA('use_quantity', 'imports',$max_id); ?>
<?php $widgets->inputA('use_quantity_tag', 'imports',$max_id); ?>
<?php $widgets->textareaA('available_status_via_stock', 'imports', $max_id); ?>
<?php $widgets->textareaA('import_categories', 'imports',$max_id); ?>
<?php $widgets->dropdownA('switch_category', 'imports', $max_id, array(  0 => $text_disabled, 1 => $text_enabled )); ?>
<?php $widgets->textareaA('exclude_by_name', 'imports', $max_id); ?>
<?php $widgets->textareaA('ignore_attributes', 'imports', $max_id); ?>
<?php $widgets->textareaA('route_attributes', 'imports', $max_id); ?>

