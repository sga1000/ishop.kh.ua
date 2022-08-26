<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" name="action" value="save" form="form-attribute" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button type="submit" name="action" value="save_and_close" form="form-attribute" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close;?></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
            </div>
            <div class="panel-body">

                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general;?></a></li>
                    <li><a href="#tab-product" data-toggle="tab"><?php echo $tab_product;?></a></li>
                    <li><a href="#tab-quantity" data-toggle="tab"><?php echo $tab_quantity;?></a></li>
                    <li><a href="#tab-price" data-toggle="tab"><?php echo $tab_price;?></a></li>
                    <li><a href="#tab-option" data-toggle="tab"><?php echo $tab_option;?></a></li>
                    <li><a href="#tab-attributes" data-toggle="tab"><?php echo $tab_attributes;?></a></li>
                    <li><a href="#tab-category" data-toggle="tab"><?php echo $tab_category;?></a></li>
                    <li><a href="#tab-manufacturer" data-toggle="tab"><?php echo $tab_manufacturer;?></a></li>
                </ul>

                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-attribute" class="form-horizontal">
                    <div class="tab-content">

                        <div class="tab-pane active" id="tab-general">
                            <div class="form-group required" >
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_code; ?></label>
                                    <br><?php echo $entry_code_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 5px;">
                                    <input type="text" name="item[code]" value="<?php echo $item['code']; ?>" id="input-code" class="form-control" />
                                    <?php if ($error_code) { ?>
                                    <div class="text-danger"><?php echo $error_code; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group required" >
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_name; ?></label>
                                    <br><?php echo $entry_name_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 5px;">
                                    <input type="text" name="item[name]" value="<?php echo $item['name']; ?>" id="input-name" class="form-control" />
                                    <?php if ($error_name) { ?>
                                    <div class="text-danger"><?php echo $error_name; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_type; ?></label>
                                    <br><?php echo $entry_type_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="type" name="item[type]" class="form-control">
                                        <?php foreach($type_data_processing as $key => $type) { ?>
                                        <option value="<?php echo $key; ?>" <?php echo ($item['type']==$key)? "selected='selected'": '' ;?>><?php echo $type; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_list; ?></label>
                                    <br><?php echo $entry_list_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[list]" value="<?php echo $item['list']; ?>" id="input-list" class="form-control" />
                                    <?php if ($error_list) { ?>
                                    <div class="text-danger"><?php echo $error_list; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_product_row; ?></label>
                                    <br><?php echo $entry_product_row_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[product_row]" value="<?php echo $item['product_row']; ?>" id="input-product_row" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_url; ?></label>
                                    <br><?php echo $entry_url_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[url]" id="input-url" class="form-control"><?php echo $item['url']; ?></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-product">
                            <div class="form-group required">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_sku; ?></label>
                                    <br><?php echo $entry_sku_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_sku]" value="<?php echo $item['column_sku']; ?>" id="input-column_sku" class="form-control" />
                                    <?php if ($error_column_sku) { ?>
                                    <div class="text-danger"><?php echo $error_column_sku; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_barcode; ?></label>
                                    <br><?php echo $entry_barcode_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_barcode]" value="<?php echo $item['column_barcode']; ?>" id="input-column_barcode" class="form-control" />
                                    <?php if ($error_column_barcode) { ?>
                                    <div class="text-danger"><?php echo $error_column_barcode; ?></div>
                                    <?php } ?>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_model; ?></label>
                                    <br><?php echo $entry_model_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_model]" value="<?php echo $item['column_model']; ?>" id="input-column-model" class="form-control" />
                                    <?php if ($error_column_model) { ?>
                                    <div class="text-danger"><?php echo $error_column_model; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_add; ?></label>
                                    <br><?php echo $entry_add_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="add" name="item[add]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['add']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_add_status; ?></label>
                                    <br><?php echo $entry_add_status_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="ro_variant" name="item[add_status]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['add_status']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_disable_product; ?></label>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="disable_product" name="item[disable_product]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['disable_product']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_images; ?></label>
                                    <br><?php echo $entry_images_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[images]" value="<?php echo $item['images']; ?>" id="input-images" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_image_delimiter; ?></label>
                                    <br><?php echo $entry_image_delimiter_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[image_delimiter]" value="<?php echo $item['image_delimiter']; ?>" id="input-image-delimiter" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_image_local; ?></label>
                                    <br><?php echo $entry_image_local_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="image_local" name="item[image_local]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['image_local']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_image_local_direction; ?></label>
                                    <br><?php echo $entry_image_local_direction_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[image_local_direction]" value="<?php echo $item['image_local_direction']; ?>" id="input-image-delimiter" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_image_local_exten; ?></label>
                                    <br><?php echo $entry_image_local_exten_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[image_local_exten]" value="<?php echo $item['image_local_exten']; ?>" id="input-image-delimiter" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_defaults; ?></label>
                                    <br><?php echo $entry_defaults_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[defaults]" id="input-defaults" class="form-control"><?php echo $item['defaults']; ?></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_fields; ?></label>
                                    <br><?php echo $entry_fields_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[fields]" id="input-fields" class="form-control"><?php echo $item['fields']; ?></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_update_fields; ?></label>
                                    <br><?php echo $entry_update_fields_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[update_fields]" id="input-fields" class="form-control"><?php echo $item['update_fields']; ?></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_filter; ?></label>
                                    <br><?php echo $entry_filter_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[filter]" id="input-filter" class="form-control"><?php echo $item['filter']; ?></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-quantity">
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_quantity; ?></label>
                                    <br><?php echo $entry_column_quantity_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_quantity]" value="<?php echo $item['column_quantity']; ?>" id="input-column_quantity" class="form-control" />
                                    <?php if ($error_column_quantity) { ?>
                                    <div class="text-danger"><?php echo $error_column_quantity; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_stock_status; ?></label>
                                    <br><?php echo $entry_column_stock_status_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_stock_status]" value="<?php echo $item['column_stock_status']; ?>" id="input-column_sku" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_sum_quantity; ?></label>
                                    <br><?php echo $entry_sum_quantity_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="sum_quantity" name="item[sum_quantity]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['sum_quantity']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-price">
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_update_price; ?></label>
                                    <br><?php echo $entry_update_price_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="update_price" name="item[update_price]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['update_price']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_price; ?></label>
                                    <br><?php echo $entry_column_price_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_price]" value="<?php echo $item['column_price']; ?>" id="input-column_price" class="form-control" />
                                    <?php if ($error_column_price) { ?>
                                    <div class="text-danger"><?php echo $error_column_price; ?></div>
                                    <?php } ?>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_special; ?></label>
                                    <br><?php echo $entry_column_special_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_special]" value="<?php echo $item['column_special']; ?>" id="input-column_special" class="form-control" />
                                    <?php if ($error_column_special) { ?>
                                    <div class="text-danger"><?php echo $error_column_special; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_special_quantity; ?></label>
                                    <br><?php echo $entry_column_special_quantity_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_special_quantity]" value="<?php echo $item['column_special_quantity']; ?>" id="input-column_special_quantity" class="form-control" />
                                    <?php if ($error_column_special_quantity) { ?>
                                    <div class="text-danger"><?php echo $error_column_special_quantity; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_special_customer_group_id; ?></label>
                                    <br><?php echo $entry_column_special_customer_group_id_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_special_customer_group_id]" value="<?php echo $item['column_special_customer_group_id']; ?>" id="input-column_special_customer_group_id" class="form-control" />
                                    <?php if ($error_column_special_customer_group_id) { ?>
                                    <div class="text-danger"><?php echo $error_column_special_customer_group_id; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_column_use_special_groups; ?></label>
                                    <br><?php echo $entry_column_use_special_groups_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="column_use_special_groups" name="item[column_use_special_groups]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['column_use_special_groups']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_column_special_by_groups; ?></label>
                                    <br><?php echo $entry_column_special_by_groups_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[column_special_by_groups]" id="input-column_special_by_groups" class="form-control"><?php echo $item['column_special_by_groups']; ?></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_discount; ?></label>
                                    <br><?php echo $entry_column_discount_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_discount]" value="<?php echo $item['column_discount']; ?>" id="input-column_discount" class="form-control" />
                                    <?php if ($error_column_discount) { ?>
                                    <div class="text-danger"><?php echo $error_column_discount; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_discount_customer_group_id; ?></label>
                                    <br><?php echo $entry_column_discount_customer_group_id_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_discount_customer_group_id]" value="<?php echo $item['column_discount_customer_group_id']; ?>" id="input-column_discount_customer_group_id" class="form-control" />
                                    <?php if ($error_column_discount_customer_group_id) { ?>
                                    <div class="text-danger"><?php echo $error_column_discount_customer_group_id; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_column_use_discount_groups; ?></label>
                                    <br><?php echo $entry_column_use_discount_groups_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="column_use_discount_groups" name="item[column_use_discount_groups]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['column_use_discount_groups']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_column_discount_by_groups; ?></label>
                                    <br><?php echo $entry_column_discount_by_groups_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[column_discount_by_groups]" id="input-column_discount_by_groups" class="form-control"><?php echo $item['column_discount_by_groups']; ?></textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_price_opt; ?></label>
                                    <br><?php echo $entry_column_price_opt_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_price_opt]" value="<?php echo $item['column_price_opt']; ?>" id="input-column_price_opt" class="form-control" />
                                    <?php if ($error_column_price_opt) { ?>
                                    <div class="text-danger"><?php echo $error_column_price_opt; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-option">
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_options; ?></label>
                                    <br><?php echo $entry_options_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[options]" id="input-options" class="form-control"><?php echo $item['options']; ?></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_related_options; ?></label>
                                    <br><?php echo $entry_related_options_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[related_options]" id="input-related_options" class="form-control"><?php echo $item['related_options']; ?></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-attributes">
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_add_attributes; ?></label>
                                    <br><?php echo $entry_add_attributes_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="add_attributes" name="item[add_attributes]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['add_attributes']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_grid_attributes; ?></label>
                                    <br><?php echo $entry_grid_attributes_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[grid_attributes]" value="<?php echo $item['grid_attributes']; ?>" id="grid-attributes" class="form-control" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-4"><?php echo $entry_grid_attributes_lang; ?></label>
                                <div class="col-sm-5">
                                    <div class="well well-sm" style="height: 150px; overflow: auto;">
                                        <table class="table table-striped">
                                            <?php foreach ($languages as $language) { ?>
                                            <tr>
                                                <td class="checkbox">
                                                    <label>
                                                        <?php if (in_array($language['language_id'], $item['grid_attributes_lang'])) { ?>
                                                        <input type="checkbox"  id="input-attributes-lang" name="item[grid_attributes_lang][]" value="<?php echo $language['language_id']; ?>" checked="checked" />
                                                        <?php echo $language['name']; ?>
                                                        <?php } else { ?>
                                                        <input type="checkbox" id="input-attributes-lang" name="item[grid_attributes_lang][]" value="<?php echo $language['language_id']; ?>" />
                                                        <?php echo $language['name']; ?>
                                                        <?php } ?>
                                                    </label>
                                                </td>
                                            </tr>
                                            <?php } ?>
                                        </table>
                                    </div>
                                    <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a></div>
                            </div>

                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_attributes; ?></label>
                                    <br><?php echo $entry_attributes_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <textarea rows="8" name="item[attributes]" id="input-attributes" class="form-control"><?php echo $item['attributes']; ?></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-category">
                            <div class="form-group">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_category_from_file; ?></label>
                                    <br><?php echo $entry_category_from_file_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="category_from_file" name="item[category_from_file]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['category_from_file']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group category_from_file">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_column_category; ?></label>
                                    <br><?php echo $entry_column_category_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_category]" value="<?php echo $item['column_category']; ?>" id="column-category" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group category_from_file">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_create_category; ?></label>
                                    <br><?php echo $entry_create_category_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="create_category" name="item[create_category]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['create_category']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group category_from_file">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_get_category_column; ?></label>
                                    <br><?php echo $entry_get_category_column_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="get_category_column" name="item[get_category_column]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['get_category_column']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group category_from_file">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_update_categories; ?></label>
                                    <br><?php echo $entry_update_categories_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="update_categories" name="item[update_categories]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['update_categories']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group category_from_file">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_update_main_categorie; ?></label>

                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="update_main_categorie" name="item[update_main_categorie]" class="form-control">
                                        <?php foreach($statuses as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['update_main_categorie']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group add_category">
                                <div class="col-sm-4">
                                    <label class="control-label"><?php echo $entry_add_category_id; ?></label>
                                    <br><?php echo $entry_add_category_id_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <select id="add_category_id" name="item[add_category_id]" class="form-control">
                                        <?php foreach($categories as $value => $name) { ?>
                                        <option value="<?php echo $value; ?>" <?php echo ($item['add_category_id']==$value)? "selected='selected'": '' ;?>><?php echo $name; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                            <div class="category_from_file">
                                <legend><?php echo $text_category_relations; ?></legend>
                                <table id="category_relation" class="table table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <td class="left"><?php echo $text_category_site; ?></td>
                                        <td class="left"><?php echo $text_category_site; ?></td>
                                        <td></td>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <?php $category_row = 0; ?>
                                    <?php if(isset($item['category_relations'])){ ?>
                                    <?php foreach ($item['category_relations'] as $relation) { ?>
                                    <tr id="category_relation_row<?php echo $category_row; ?>">
                                        <td class="left">
                                            <select class="form-control" name="item[category_relations][<?php echo $category_row; ?>][category_id]">
                                                <?php foreach ($categories as $category_id => $category_name) { ?>
                                                <?php if ($category_id == $relation['category_id']) { ?>
                                                <option value="<?php echo $category_id; ?>" selected="selected"><?php echo $category_name; ?></option>
                                                <?php } else { ?>
                                                <option value="<?php echo $category_id; ?>"><?php echo $category_name; ?></option>
                                                <?php } ?>
                                                <?php } ?>
                                            </select>
                                        </td>
                                        <td class="left">
                                            <input class="form-control" type="text" name="item[category_relations][<?php echo $category_row; ?>][category_name]" value="<?php echo $relation['category_name']; ?>" />
                                        </td>
                                        <td class="center">
                                            <a onclick="$('#category_relation_row<?php echo $category_row; ?>').remove();" class="btn btn-danger"><?php echo $button_remove; ?></a>
                                        </td>
                                    </tr>
                                    <?php $category_row++; ?>
                                    <?php } ?>
                                    <?php } ?>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <td colspan="2"></td>
                                        <td class="left"><a onclick="addCategoryRelations();" class="btn btn-primary"><?php echo $button_add; ?></a></td>
                                    </tr>
                                    </tfoot>
                                </table>
                                <script>$("#tab-category table tr:first td:first").css("width", "40%");</script>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-manufacturer">
                            <div class="form-group required">
                                <div class="col-sm-4">
                                    <label class="control-label" ><?php echo $entry_column_manufacturer; ?></label>
                                    <br><?php echo $entry_column_manufacturer_desc; ?>
                                </div>
                                <div class="col-sm-5" style="padding-top: 12px;">
                                    <input type="text" name="item[column_manufacturer]" value="<?php echo $item['column_manufacturer']; ?>" id="input-column_sku" class="form-control" />
                                    <?php if ($error_column_manufacturer) { ?>
                                    <div class="text-danger"><?php echo $error_column_manufacturer; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    $('.date').datetimepicker({
        pickTime: false
    });
    $(function(){
        switchCategory($('#category_from_file').val());
    });
    $('#category_from_file').on('change',function(){
        switchCategory($(this).val());
    });

    function  switchCategory(val){
        if(val == 0){
            $('.category_from_file').hide();
            $('.add_category').show();
        }else{

            $('.category_from_file').show();
            $('.add_category').hide();
        }
    }
</script>
<script type="text/javascript"><!--
    if (window.location.hash.indexOf('#tab') == 0 && $("[href=" + window.location.hash + "]").length) {
        $(".panel-body > .nav-tabs li").removeClass("active");
        $("[href=" + window.location.hash + "]").parents('li').addClass("active");
        $(".panel-body:first .tab-content:first .tab-pane:first").removeClass("active");
        $(window.location.hash).addClass("active");
    }
    $(".nav-tabs li a").click(function () {
        var url = $(this).prop('href');
        window.location.hash = url.substring(url.indexOf('#'));
    });

    // Специальный фикс системной функции, поскольку даниель понятия не имеет о том что в url может быть еще и hash
    // и по итогу этот hash становится частью token
    function getURLVar(key) {
        var value = [];

        var url = String(document.location);
        if( url.indexOf('#') != -1 ) {
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
<script type="text/javascript"><!--
    var category_row = <?php echo $category_row; ?>;
    function addCategoryRelations() {
        html  = '';
        html += '  <tr id="category_relation_row' + category_row + '">';
        html += '    <td class="left"><select class="form-control" name="item[category_relations][' + category_row + '][category_id]">';
    <?php foreach ($categories as $category_id => $category_name) { ?>
            html += '      <option value="<?php echo $category_id; ?>"><?php echo $category_name; ?></option>';
        <?php } ?>
        html += '    </select></td>';
        html += '    <td class="left"><input type="text" class="form-control" name="item[category_relations][' + category_row + '][category_name]" value="" /></td>';
        html += '    <td class="center"><a onclick="$(\'#category_relation_row' + category_row + '\').remove();" class="btn btn-danger"><?php echo $button_remove; ?></a></td>';
        html += '  </tr>';

        $('#category_relation tbody').append(html);

        category_row++;
    }
    //--></script>
<?php echo $footer; ?>
