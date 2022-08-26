<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php');
$widgets = new NeoSeoWidgets('neoseo_exchange1c_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <?php if( !isset($license_error) ) { ?>
                        <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                        <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                    <?php } else { ?>
                        <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>"class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                    <?php } ?>
                    <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
                </div>
                <img width="36" height="36" style="float:left" src="view/image/neoseo.png" alt=""/>
                <h1><?php echo $heading_title_raw . " " . $text_module_version; ?></h1>
                <ul class="breadcrumb">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                    <?php } ?>
                </ul>
            </div>
        </div>

        <div class="container-fluid">
            <?php if ($error_warning) { ?>
                <div class="alert alert-danger">
                    <i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
            <?php } ?>
            <?php if (isset($success) && $success) { ?>
                <div class="alert alert-success">
                    <i class="fa fa-check-circle"></i>
                    <?php echo $success; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
            <?php } ?>
            <div class="panel panel-default">
                <div class="panel-body">

                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-order" data-toggle="tab"><?php echo $tab_order; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-product" data-toggle="tab"><?php echo $tab_product; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-price" data-toggle="tab"><?php echo $tab_price; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-quantity" data-toggle="tab"><?php echo $tab_quantity; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-category" data-toggle="tab"><?php echo $tab_category; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-manufacturer" data-toggle="tab"><?php echo $tab_manufacturer; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-attribute" data-toggle="tab"><?php echo $tab_attribute; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-option" data-toggle="tab"><?php echo $tab_option; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-filter" data-toggle="tab"><?php echo $tab_filter; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-counterparties" data-toggle="tab"><?php echo $tab_counterparties; ?></a></li><?php } ?>
                        <?php if( !isset($license_error) ) { ?><li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li><?php } ?>
                        <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                        <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                    </ul>

                    <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab-general">
                                <?php if( !isset($license_error) ) { ?>

                                    <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('enable_zip',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('commerce_ml_version',array( 2 => "V2", 3 => "V3")); ?>
                                    <?php $widgets->dropdown('commerce_ml_version_order',array( 2 => "V2", 3 => "V3")); ?>
                                    <?php $widgets->dropdown('decimal_separator',array( 'dot' => $text_dot, 'comma' => $text_comma)); ?>
                                    <?php $widgets->dropdown('delete_offers',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('user_answer_for_moy_sklad',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('wait_import_command',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('clear_system_cache',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('clear_image_cache',array( 0 => $text_disabled, 1 => $text_enabled)); ?>

                                    <?php $widgets->text('link'); ?>
                                    <?php $widgets->input('username'); ?>
                                    <?php $widgets->password('password'); ?>
                                    <?php $widgets->text('cron_command'); ?>
                                    <?php $widgets->textarea('ip_list'); ?>

                                    <?php $widgets->textarea('sql_before'); ?>
                                    <?php $widgets->textarea('sql_after'); ?>

                                <?php } else { ?>

                                    <?php echo $license_error; ?>

                                <?php } ?>
                            </div>

                            <?php if( !isset($license_error) ) { ?>
                                <div class="tab-pane" id="tab-logs">
                                    <?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $download, $button_clear_log, $button_download_log); ?>
                                    <textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
                                </div>
                            <?php } ?>

                            <?php if( !isset($license_error) ) { ?>
                                <div class="tab-pane" id="tab-order">
                                    <?php $widgets->dropdown('order_export_type', array( 0 => $text_export_status, 1 => $text_export_mark)); ?>
                                    <?php $widgets->checklist('order_statuses',$order_statuses); ?>
                                    <?php $widgets->dropdown('final_order_status',$order_statuses); ?>
                                    <?php $widgets->textarea('final_list_order_statuses'); ?>
                                    <?php $widgets->input('order_comment'); ?>
                                    <?php $widgets->input('limit_orders'); ?>
                                    <?php $widgets->dropdown('set_auto_tag_order',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->checklist('exclude_auto_tag_order',$order_statuses); ?>
                                    <?php $widgets->dropdown('totals_positive', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('extra_comment', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('customer_phone', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('order_utf8', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('order_utf8_bom', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('get_from_naclad',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('order_status_notify', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('order_status_override', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('order_manufacturer', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('order_category', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('model_in_id', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('transaction_status', $transaction_statuses); ?>
                                    <?php $widgets->dropdown('get_orders_from_1c', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('use_two_side_products_exchange', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('import_external_orders', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('external_orders_status', $order_statuses); ?>
                                    <?php $widgets->dropdown('options_as_product',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('options_in_product',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('export_discount_as_element',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('tax_list', $tax_list); ?>
                                    <?php $widgets->input('order_currency'); ?>
                                    <?php $widgets->input('order_customer'); ?>
                                    <?php $widgets->textarea('extra_document_tag'); ?>
                                    <?php $widgets->textarea('extra_customer'); ?>
                                    <?php $widgets->textarea('extra_property'); ?>
                                    <?php $widgets->textarea('extra_totals_property'); ?>
                                    <?php $widgets->textarea('extra_address'); ?>
                                    <?php $widgets->textarea('product_extra_property'); ?>
                                    <?php $widgets->textarea('order_status_marge_list'); ?>
                                    <?php $widgets->textarea('order_shipping_links'); ?>
                                    <?php $widgets->textarea('order_payment_links'); ?>
                                    <?php $widgets->textarea('order_total_links'); ?>
                                    <?php $widgets->textarea('unit_links'); ?>
                                    <?php $widgets->dropdown('import_orders_disable_curl', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('skip_without_id', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('import_orders_comment_field'); ?>
                                    <?php $widgets->input('field_for_1c_order_id'); ?>
                                    <?php $widgets->input('export_order_special_price_tag'); ?>
                                    <?php $widgets->dropdown('no_address', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->button($export, $button_export); ?>
                                    <?php $widgets->button($delete_orders, $button_delete_orders); ?>
                                    <div class="form-group" style="display: inline-block; width: 100%;">
                                        <div class="col-sm-12">
                                            <a class="btn btn-default" id="delete_export_list_orders"><?php echo $button_delete_export_list_orders; ?></a>
                                        </div>
                                    </div>
                                </div>

                                <div class="tab-pane" id="tab-product">
                                    <?php $widgets->dropdown('lookup_product', array( 3 => $text_disabled, 0 => $text_bysku, 1 => $text_byname, 2 => $text_bymodel, 4 => $text_bycode, 5 => $text_bycode_name, 6 => $text_byean )); ?>
                                    <?php $widgets->dropdown('create_product', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_status', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_stock_status', $stock_statuses); ?>
                                    <?php $widgets->input('sync_missing_status'); ?>
                                    <br>
                                    <?php $widgets->dropdown('default_missing_status', $stock_statuses); ?>
                                    <?php $widgets->dropdown('update_name', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_description', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('description_column', $product_description_columns); ?>
                                    <?php $widgets->input('unit_field'); ?>
                                    <?php $widgets->dropdown('unit_field_offer', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('code_field'); ?>
                                    <?php $widgets->input('barcode_field'); ?>
                                    <?php $widgets->input('seo_url_field'); ?>
                                    <?php $widgets->dropdown('update_sku', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_images', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('use_tree_delete',array(0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_related_products',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_related_products_mode',array( 0 => $text_byupc, 1 => $text_bymodel, 2 => $text_bysku)); ?>
                                    <?php $widgets->dropdown('product_fullname',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_fulldescription',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_dimension',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_export_model_to_sku',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('zero_quantity_missing_goods',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('disable_missing_tag'); ?>
                                    <?php $widgets->dropdown('delete_by_mark',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->textarea('export_product_field_attr'); ?>
                                    <?php $widgets->textarea('export_product_field_color'); ?>
                                    <?php $widgets->dropdown('product_kit_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('product_kit_tag'); ?>
                                    <?php $widgets->input('product_kit_field'); ?>
                                    <?php $widgets->checklist('disable_missing',$disable_missing); ?>
                                    <?php $widgets->checklist('product_languages',$product_languages); ?>
                                    <?php echo $text_tools; ?>

                                    <div class="form-group" style="display: inline-block; width: 100%;">
                                        <div class="col-sm-12">
                                            <div style="float:left">
                                                <input type="file" name="filename" />
                                            </div>
                                            <a class="btn btn-default" onclick="if (confirm('<?php echo $text_import_warning; ?>')) { $('#form').attr('action', '<?php echo $import; ?>'); $('#form').submit() }"><?php echo $button_import; ?></a>
                                            <a class="btn btn-default" href="<?php echo $export_product; ?>"><span><?php echo $button_export_product; ?></span></a>
                                        </div>
                                    </div>

                                    <div id="progress-orders" class="progress" style="margin-top:20px; display:none">
                                        <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%">0%</div>
                                    </div>
                                    <?php $widgets->button($delete_products, $button_delete_products); ?>
                                    <?php $widgets->button($delete_1c_products, $button_delete_1c_products); ?>
                                    <?php $widgets->button($delete_links, $button_delete_links); ?>
                                </div>


                                <div class="tab-pane" id="tab-category">
                                    <?php $widgets->dropdown('create_category',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('group_or_category',array( 'group' => $text_group, 'category' => $text_category)); ?>
                                    <?php $widgets->dropdown('category_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('category_top_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('category_update_name',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->checklist('category_languages',$product_languages); ?>
                                    <?php $widgets->dropdown('update_categories',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_only_main_product_category',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('fill_parent_cats',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_parent_cats',array(0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('category_forced',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('category_forced_id',$categories); ?>
                                    <?php $widgets->textarea('category_links'); ?>

                                    <?php $widgets->button($delete_categories, $button_delete_categories); ?>
                                </div>


                                <div class="tab-pane" id="tab-manufacturer">
                                    <?php $widgets->dropdown('create_manufacturer',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('add_manufacturer_to_attribute',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('alternative_manufacturer_tag'); ?>

                                    <?php $widgets->button($delete_manufacturers, $button_delete_manufacturers); ?>
                                </div>

                                <div class="tab-pane" id="tab-counterparties">
                                    <?php $widgets->dropdown('counterparties_exchange',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('counterparties_update_fio',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('counterparties_create_new',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('counterparties_import_address',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('counterparties_method',array( 'phone' => $text_counterparties_method_phone, 'email' => $text_counterparties_method_email, 'fio' => $text_counterparties_fio , 'mixed' =>  $text_counterparties_mixed)); ?>
                                    <?php $widgets->input('counterparties_fio_field'); ?>
                                    <?php $widgets->input('counterparties_phone_field'); ?>
                                    <?php $widgets->input('counterparties_email_field'); ?>
                                    <?php $widgets->dropdown('counterparties_new_group',$customer_groups_special); ?>
                                    <?php $widgets->textarea('counterparties_custom_field'); ?>
                                    <?php $widgets->button($counterparties_download, $text_counterparties_download); ?>
                                    <?php $widgets->button($counterparties_delete, $text_counterparties_delete); ?>
                                    <?php $widgets->button($counterparties_delete_links, $text_counterparties_delete_links); ?>
                                </div>

                                <div class="tab-pane" id="tab-attribute">
                                    <?php $widgets->dropdown('create_attribute',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_attribute',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_attribute_group',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_attribute_product_sort',array(0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('attribute_group_prefix'); ?>
                                    <?php $widgets->textarea('ignore_attributes'); ?>
                                    <?php $widgets->textarea('attribute_routing'); ?>
                                    <?php $widgets->textarea('attribute_label'); ?>
                                    <?php $widgets->input('attribute_file_name'); ?>
                                    <?php $widgets->textarea('attribute_links'); ?>
                                    <?php $widgets->textarea('attribute_routing_download_files'); ?>
                                    <?php $widgets->button($delete_attributes, $button_delete_attributes); ?>
                                </div>

                                <div class="tab-pane" id="tab-option">
                                    <?php $widgets->dropdown('create_option',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_option',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_option_images',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->textarea('forbidden_options'); ?>
                                    <?php $widgets->dropdown('save_forbidden_options',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('delete_zero_option',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('use_related_options',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('option_price',array( 0 => $text_default, 1 => $text_product_min, 2 => $text_product_max)); ?>
                                    <?php $widgets->dropdown('option_type',array( 0 => $text_option_type_select, 1 => $text_option_type_radio)); ?>
                                    <?php $widgets->dropdown('option_required',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('option_quantity',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('option_source',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('option_by_box',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('search_option_for_sku',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_for_option_discount_price',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('option_field_sku'); ?>
                                    <?php $widgets->input('option_field_ean'); ?>
                                    <?php $widgets->dropdown('option_sku_add_product_sku',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('option_sku_symbol_add_product_sku'); ?>
                                    <span <?php if(!$isOptionsHasSpecial) { ?> style="display:none;" <?php } ?>>
                                    <?php $widgets->dropdown('use_options_special',array(0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('options_special_price'); ?>
                                    </span>

                                    <legend><?php echo $text_setting_option_discount_price_type; ?></legend>
                                    <?php echo $text_setting_option_discount_price_type_desc; ?>
                                    <table id="exchange1c_option_discount_price_type_id" class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <td class="left"><?php echo $entry_config_price_type; ?></td>
                                                <td class="left"><?php echo $entry_customer_group; ?></td>
                                                <td class="right"><?php echo $entry_priority; ?></td>
                                                <td></td>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php $option_discount_price_row = 0; ?>
                                            <?php if(isset($neoseo_exchange1c_option_discount_price_type) && $neoseo_exchange1c_option_discount_price_type){ ?>
                                            <?php foreach ($neoseo_exchange1c_option_discount_price_type as $obj) { ?>
                                            <tr id="exchange1c_option_discount_price_type_row<?php echo $option_discount_price_row; ?>">
                                                <td class="left"><input class="form-control" type="text" name="neoseo_exchange1c_option_discount_price_type[<?php echo $option_discount_price_row; ?>][keyword]" value="<?php echo $obj['keyword']; ?>" /></td>
                                                <td class="left">
                                                    <select class="form-control" name="neoseo_exchange1c_option_discount_price_type[<?php echo $option_discount_price_row; ?>][customer_group_id]">
                                                    <?php foreach ($customer_groups as $customer_group) { ?>
                                                        <?php if ($customer_group['customer_group_id'] == $obj['customer_group_id']) { ?>
                                                            <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                                                        <?php } else { ?>
                                                            <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                                                        <?php } ?>
                                                    <?php } ?>
                                                    </select>
                                                </td>
                                                <td class="center"><input class="form-control" type="text" name="neoseo_exchange1c_option_discount_price_type[<?php echo $option_discount_price_row; ?>][priority]" value="<?php echo $obj['priority']; ?>" size="5" /></td>
                                                <td class="center"><a onclick="$('#exchange1c_option_discount_price_type_row<?php echo $option_discount_price_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                                            </tr>
                                            <?php $option_discount_price_row++; ?>
                                            <?php } ?>
                                            <?php } ?>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3"></td>
                                                <td class="left"><a onclick="addOptionDiscountPriceType();" class="btn btn-primary"><?php echo $button_insert; ?></a></td>
                                            </tr>
                                        </tfoot>
                                    </table>

                                    <?php $widgets->button($delete_options, $button_delete_options); ?>
                                </div>

                                <div class="tab-pane" id="tab-price">
                                        <?php $widgets->dropdown('update_price',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->input('currency_convertor'); ?>
                                        <?php $widgets->dropdown('update_currency_plus',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->input('new_price_column'); ?>
                                        <?php $widgets->dropdown('delete_special_price',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdown('delete_discount_price',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdown('zero_special_discount',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdown('multy_currency', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdown('multy_currency_price', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->input('currency_convertor_multy'); ?>
                                        <?php $widgets->input('currency_convertor_multy_main_price'); ?>
                                        <?php $widgets->dropdown('ignore_table_quantities',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdown('update_price_installment',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <?php $widgets->dropdown('update_price_special_option',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                        <legend><?php echo $text_setting_price_type; ?></legend>
                                        <table id="exchange1c_price_type_id" class="table table-bordered table-hover">
                                            <thead>
                                            <tr>
                                                <td class="left"><?php echo $entry_config_price_type; ?></td>
                                                <td class="left"><?php echo $entry_customer_group; ?></td>
                                                <td class="right"><?php echo $entry_quantity; ?></td>
                                                <td class="right"><?php echo $entry_priority; ?></td>
                                                <td></td>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <?php $price_row = 0; ?>
                                            <?php foreach ($neoseo_exchange1c_price_type as $obj) { ?>
                                                <?php if ($price_row == 0) {?>
                                                    <tr id="exchange1c_price_type_row<?php echo $price_row; ?>">
                                                        <td class="left"><input type="text" class="form-control" name="neoseo_exchange1c_price_type[<?php echo $price_row; ?>][keyword]" value="<?php echo $obj['keyword']; ?>" /></td>
                                                        <td class="left"><?php  echo $text_price_default; ?><input type="hidden" name="neoseo_exchange1c_price_type[<?php echo $price_row; ?>][customer_group_id]" value="0" /></td>
                                                        <td class="center">-<input type="hidden" name="neoseo_exchange1c_price_type[<?php echo $price_row; ?>][quantity]" value="0" /></td>
                                                        <td class="center">-<input type="hidden" name="neoseo_exchange1c_price_type[<?php echo $price_row; ?>][priority]" value="0" /></td>
                                                        <td class="left">&nbsp;</td>
                                                    </tr>
                                                <?php } else { ?>
                                                    <tr id="exchange1c_price_type_row<?php echo $price_row; ?>">
                                                        <td class="left"><input class="form-control" type="text" name="neoseo_exchange1c_price_type[<?php echo $price_row; ?>][keyword]" value="<?php echo $obj['keyword']; ?>" /></td>
                                                        <td class="left">
                                                            <select class="form-control" name="neoseo_exchange1c_price_type[<?php echo $price_row; ?>][customer_group_id]">
                                                                <?php foreach ($customer_groups as $customer_group) { ?>
                                                                    <?php if ($customer_group['customer_group_id'] == $obj['customer_group_id']) { ?>
                                                                        <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                                                                    <?php } else { ?>
                                                                        <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                                                                    <?php } ?>
                                                                <?php } ?>
                                                            </select></td>
                                                        <td class="center"><input class="form-control" type="text" name="neoseo_exchange1c_price_type[<?php echo $price_row; ?>][quantity]" value="<?php echo $obj['quantity']; ?>" size="10" /></td>
                                                        <td class="center"><input class="form-control" type="text" name="neoseo_exchange1c_price_type[<?php echo $price_row; ?>][priority]" value="<?php echo $obj['priority']; ?>" size="5" /></td>
                                                        <td class="center"><a onclick="$('#exchange1c_price_type_row<?php echo $price_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                                                    </tr>
                                                <?php } ?>
                                                <?php $price_row++; ?>
                                            <?php } ?>
                                            </tbody>
                                            <tfoot>
                                            <tr>
                                                <td colspan="4"></td>
                                                <td class="left"><a onclick="addConfigPriceType();" class="btn btn-primary"><?php echo $button_insert; ?></a></td>
                                            </tr>
                                            </tfoot>
                                        </table>

                                        <legend><?php echo $text_setting_special_price_type; ?></legend>
                                        <?php $widgets->input('special_price_tag_date_start'); ?>
                                        <?php $widgets->input('special_price_tag_date_end'); ?>
                                        <table id="exchange1c_special_price_type_id" class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <td class="left"><?php echo $entry_config_price_type; ?></td>
                                                    <td class="left"><?php echo $entry_customer_group; ?></td>
                                                    <td class="right"><?php echo $entry_priority; ?></td>
                                                    <td></td>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php $special_price_row = 0; ?>
                                                <?php foreach ($neoseo_exchange1c_special_price_type as $obj) { ?>
                                                <tr id="exchange1c_special_price_type_row<?php echo $special_price_row; ?>">
                                                    <td class="left"><input class="form-control" type="text" name="neoseo_exchange1c_special_price_type[<?php echo $special_price_row; ?>][keyword]" value="<?php echo $obj['keyword']; ?>" /></td>
                                                    <td class="left">
                                                        <select class="form-control" name="neoseo_exchange1c_special_price_type[<?php echo $special_price_row; ?>][customer_group_id]">
                                                        <?php foreach ($customer_groups as $customer_group) { ?>
                                                            <?php if ($customer_group['customer_group_id'] == $obj['customer_group_id']) { ?>
                                                                <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                                                            <?php } else { ?>
                                                                <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                                                            <?php } ?>
                                                        <?php } ?>
                                                        </select>
                                                    </td>
                                                    <td class="center"><input class="form-control" type="text" name="neoseo_exchange1c_special_price_type[<?php echo $special_price_row; ?>][priority]" value="<?php echo $obj['priority']; ?>" size="5" /></td>
                                                    <td class="center"><a onclick="$('#exchange1c_special_price_type_row<?php echo $special_price_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
                                                </tr>
                                                <?php $special_price_row++; ?>
                                                <?php } ?>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="3"></td>
                                                    <td class="left"><a onclick="addSpecialPriceType();" class="btn btn-primary"><?php echo $button_insert; ?></a></td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                        <script>$("#tab-price table tr:first td:first").css("width", "40%");</script>
                                </div>

                                <div class="tab-pane" id="tab-quantity">

                                    <?php $widgets->dropdown('update_quantity',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('use_fraction_quantity',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_subtract',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('missing_quantity_is_zero',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('use_warehouse',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->textarea('exclude_warehouses'); ?>
                                    <?php $widgets->textarea('warehouses_multistore'); ?>
                                    <?php $widgets->dropdown('update_date',array(0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('main_warehouse'); ?>
                                    <?php $widgets->checkList('categories_reset_quantity', $categories); ?>

                                    <?php $widgets->button($delete_products_warehouses, $button_delete_products_warehouses); ?>
                                    <script>$("#tab-quantity table tr:first td:first").css("width", "40%");</script>
                                </div>

                                <div class="tab-pane" id="tab-filter">
                                    <?php $widgets->dropdown('use_filter', $filters); ?>
                                    <?php $widgets->dropdown('update_filter',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_option_product_filter',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('clear_neoseo_filter_cache',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_auto_filter',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('update_auto_neoseo_filter_warehouse',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->textarea('option_product_filter'); ?>
                                </div>

                            <?php } ?>

                            <div class="tab-pane" id="tab-support">
                                <?php echo $mail_support; ?>
                            </div>

                            <div class="tab-pane" id="tab-license">
                                <?php echo $module_licence; ?>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript"><!--
        if( window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length ) {
            $(".panel-body > .nav-tabs li").removeClass("active");
            $("[href=" + window.location.hash + "]").parents('li').addClass("active");
            $(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
            $(window.location.hash).addClass("active");
        }
        $(".nav-tabs li a").click(function(){
            var url = $(this).prop('href');
            window.location.hash = url.substring(url.indexOf('#'));
        });
        // Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash
        // и по итогу этот hash становится частью token
        function getURLVar(key) {
            var value = [];

            var url = String(document.location);
            if (url.indexOf('#') != -1) {
                url = url.substring(0, url.indexOf('#'));
            }
            var query = url.split('?');

            if (query[1]) {
                var part = query[1].split('&');

                for (i = 0; i < part.length; i++) {
                    var data = part[i].split('=');

                    if (data[0] && data[1]) {
                        value[data[0]] = data[1];
                    }
                }

                if (value[key]) {
                    return value[key];
                } else {
                    return '';
                }
            }
        }
//--></script>
    <script>

        $(document).delegate('#button-ip-add', 'click', function() {
            $.ajax({
                url: 'index.php?route=user/api/addip&token=<?php echo $token; ?>&api_id=<?php echo $api_id; ?>',
                type: 'post',
                data: 'ip=<?php echo $api_ip; ?>',
                dataType: 'json',
                beforeSend: function() {
                    $('#button-ip-add').button('loading');
                },
                complete: function() {
                    $('#button-ip-add').button('reset');
                },
                success: function(json) {
                    $('.alert').remove();

                    if (json['error']) {
                        $('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    }

                    if (json['success']) {
                        $('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                        $('#button-edit').removeAttr('disabled');
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        });

        var api_token = '';
        $.ajax({
            url: '<?php echo $store; ?>index.php?route=api/login',
            type: 'post',
            data: 'key=<?php echo $api_key; ?>',
            dataType: 'json',
            crossDomain: true,
            success: function(json) {

                if (json['error']) {
                    $('.alert').remove();
                    if (json['error']['key']) {
                        $('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['key'] + ' <button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    }

                    if (json['error']['ip']) {
                        $('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['ip'] + ' <button type="button" id="button-ip-add" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-danger btn-xs pull-right"><i class="fa fa-plus"></i> <?php echo $button_ip_add; ?></button></div>');
                        $('#button-edit').attr('disabled', 'disabled');
                    }
                }

                if (json['token']) {
                    api_token = json['token'];
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });

        var orders = [];
        var ordersCurrent = [];
        var generateProgressId = 0;
        function deleteNext() {
            var order = ordersCurrent.shift();
            if (!order) {
                $(generateProgressId).hide();
                return;
            }

            var index = orders.length - ordersCurrent.length;
            var total = orders.length;
            var percent = Number(index * 100 / total).toFixed(0);
            $(generateProgressId + " .progress-bar").prop("aria-valuenow", percent);
            $(generateProgressId + " .progress-bar").css("width", percent + "%");
            $(generateProgressId + " .progress-bar").html(index + " из " + total);

            $.ajax({
                url: '<?php echo $store; ?>index.php?route=api/order/delete&token=' + api_token + '&order_id=' + order,
                dataType: 'json',
                crossDomain: true
            }).done(function () {
                deleteNext();
            });
        }

        $('[href*=delete_orders]').on('click', function(e) {
            e.preventDefault();
            if (confirm('<?php echo $text_confirm; ?>')) {

                var generateUrl = '<?php echo str_replace("&amp;","&",$get_orders); ?>';
                generateProgressId = '#progress-orders';
                $(generateProgressId).show();

                $.ajax({
                    url: generateUrl,
                    dataType: 'json'
                }).done(function (json) {
                    orders = json;
                    ordersCurrent = orders.slice(0);
                    deleteNext();
                });
            }
        });


        $('#delete_export_list_orders').on('click', function(e) {
            e.preventDefault();
            if (confirm('<?php echo $text_confirm; ?>')) {
                $.ajax({
                    'type': "POST",
                    'url': "<?php echo htmlspecialchars_decode($delete_export_list_orders); ?>",
                    'data': {
                        orders: "all"
                    },
                    'dataType': 'json',
                    success: function (response) {
                        alert(response.message);
                    }
                });
            }
        });

        var price_row = <?php echo $price_row; ?>;
        function addConfigPriceType() {
            html  = '';
            html += '  <tr id="exchange1c_price_type_row' + price_row + '">';
            html += '    <td class="left"><input type="text" class="form-control" name="neoseo_exchange1c_price_type[' + price_row + '][keyword]" value="" /></td>';
            html += '    <td class="left"><select class="form-control" name="neoseo_exchange1c_price_type[' + price_row + '][customer_group_id]">';
            <?php foreach ($customer_groups as $customer_group) { ?>
            html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
            <?php } ?>
            html += '    </select></td>';
            html += '    <td class="center"><input type="text" class="form-control" name="neoseo_exchange1c_price_type[' + price_row + '][quantity]" value="0" size="10" /></td>';
            html += '    <td class="center"><input type="text" class="form-control" name="neoseo_exchange1c_price_type[' + price_row + '][priority]" value="0" size="5" /></td>';
            html += '    <td class="center"><a onclick="$(\'#exchange1c_price_type_row' + price_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
            html += '  </tr>';

            $('#exchange1c_price_type_id tbody').append(html);

            price_row++;
        }

        var special_price_row = <?php echo $special_price_row; ?>;
        function addSpecialPriceType() {
            html  = '';
            html += '  <tr id="exchange1c_special_price_type_row' + special_price_row + '">';
            html += '    <td class="left"><input type="text" class="form-control" name="neoseo_exchange1c_special_price_type[' + special_price_row + '][keyword]" value="" /></td>';
            html += '    <td class="left"><select class="form-control" name="neoseo_exchange1c_special_price_type[' + special_price_row + '][customer_group_id]">';
            <?php foreach ($customer_groups as $customer_group) { ?>
            html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
            <?php } ?>
            html += '    </select></td>';
            html += '    <td class="center"><input type="text" class="form-control" name="neoseo_exchange1c_special_price_type[' + special_price_row + '][priority]" value="0" size="5" /></td>';
            html += '    <td class="center"><a onclick="$(\'#exchange1c_special_price_type_row' + special_price_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
            html += '  </tr>';

            $('#exchange1c_special_price_type_id tbody').append(html);

            special_price_row++;
        }

        var option_discount_price_row = <?php echo $option_discount_price_row; ?>;
        function addOptionDiscountPriceType() {
            html  = '';
            html += '  <tr id="exchange1c_option_discount_price_type_row' + option_discount_price_row + '">';
            html += '    <td class="left"><input type="text" class="form-control" name="neoseo_exchange1c_option_discount_price_type[' + option_discount_price_row + '][keyword]" value="" /></td>';
            html += '    <td class="left"><select class="form-control" name="neoseo_exchange1c_option_discount_price_type[' + option_discount_price_row + '][customer_group_id]">';
            <?php foreach ($customer_groups as $customer_group) { ?>
            html += '      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>';
            <?php } ?>
            html += '    </select></td>';
            html += '    <td class="center"><input type="text" class="form-control" name="neoseo_exchange1c_option_discount_price_type[' + option_discount_price_row + '][priority]" value="0" size="5" /></td>';
            html += '    <td class="center"><a onclick="$(\'#exchange1c_option_discount_price_type_row' + option_discount_price_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
            html += '  </tr>';

            $('#exchange1c_option_discount_price_type_id tbody').append(html);

            option_discount_price_row++;
        }

        $(document).ready(function(){
            if($('#neoseo_exchange1c_order_export_type').val() == '1'){
                $('#field_order_statuses').hide();
                $('#field_final_order_status').hide();

            }else{
                $('#field_order_statuses').show();
                $('#field_final_order_status').show();
            }
        });

        $('#neoseo_exchange1c_order_export_type').on('change', function(e){
            if($(this).val() == '1'){
                $('#field_order_statuses').hide();
                $('#field_final_order_status').hide();
            }else{
                $('#field_order_statuses').show();
                $('#field_final_order_status').show();
            }
        });

        $('a:contains("Удалить")').click(function(){
            return confirm("<?php echo $text_confirm; ?>");
        })
    </script>
<?php echo $footer; ?>