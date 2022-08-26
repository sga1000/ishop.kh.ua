<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_checkout_',$params);
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
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>" class="btn btn-primary" /><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
                <?php } ?>
                <a href="<?php echo $close; ?>" data-toggle="tooltip" title="<?php echo $button_close; ?>" class="btn btn-default"><i class="fa fa-close"></i> <?php echo $button_close; ?></a>
            </div>
            <img width="36" height="36" style="float:left;margin-right: 10px;" src="view/image/neoseo.png" alt=""> 
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
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-customer" data-toggle="tab"><?php echo $tab_customer; ?></a></li><?php } ?>
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-payment" data-toggle="tab"><?php echo $tab_payment; ?></a></li><?php } ?>
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-shipping" data-toggle="tab"><?php echo $tab_shipping; ?></a></li><?php } ?>
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-shipping_type" data-toggle="tab"><?php echo $tab_shipping_type; ?></a></li><?php } ?>
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-links" data-toggle="tab"><?php echo $tab_links; ?></a></li><?php } ?>
                    <?php if( !isset($license_error) ) { ?><li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li><?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>


                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <?php if( !isset($license_error) ) { ?>
                            <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('agreement_id',$information); ?>
                            <?php $widgets->dropdown('agreement_default',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('agreement_text',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('stock_control',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->input('min_amount'); ?>
                            <?php $widgets->dropdown('compact',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('dropped_cart_template',$dropped_cart_template); ?>
                            <?php $widgets->input('dropped_cart_email_subject'); ?>
                            <?php $widgets->dropdown('onestep', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('cart_redirect',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('hide_menu',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('hide_footer',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('use_international_phone_mask',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php } else { ?>
                            <?php echo $license_error; ?>
                            <?php } ?>
                        </div>


                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-customer">
                            <div style="margin:10px 0">
                                <?php echo $text_types_of_customers;?>
                                <table>
                                <?php $i = 0; foreach( $customer_groups as $value => $name) { $i++;?>
                                    <tr>
                                        <td>
                                            <input id="type-<?php echo $value;?>" type="radio" <?php if( $i==1) { ?> checked="checked" <?php } ?> name="customer_group" value="<?php echo $value; ?>">
                                            <label for="type-<?php echo $value;?>"><?php echo $name; ?></label>
                                        </td>
                                    </tr>
                                <?php } ?>
                                </table>
                            </div>

                            <div class="buttons_head">
                                <span><?php echo $text_block_customers;?> </span>
                                <a class="add-field btn btn-default btn-sm"><i class="fa fa-plus"></i></a>
                            </div>

                            <?php $j = 0; foreach( $customer_groups as $type => $name ) { $j++; ?>
                            <ul class="ui-sortable customer-type type-<?php echo $type;?>" data-count="<?php echo isset($neoseo_checkout_customer_fields[$type]) ? count($neoseo_checkout_customer_fields[$type]) : 0; ?>" style="<?php if ( $j > 1 ) { ?>display:none<?php } ?>">
                                <?php if( isset($neoseo_checkout_customer_fields[$type]) ) { $i = 0; foreach( $neoseo_checkout_customer_fields[$type] as $field ) { $i++; ?>
                                    <li id="customer_field_<?php echo $type;?>_<?php echo $i; ?>"></li>
                                <?php } } ?>
                            </ul>
                            <?php } ?>

                            <div class="buttons_head">
                                <a class="add-field btn btn-default btn-sm"><i class="fa fa-plus"></i></a>
                            </div>

                        </div>

                        <div class="tab-pane" id="tab-payment">

                            <?php $widgets->dropdown('payment_logo', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('payment_control', array( 0 => $text_select_type, 1 => $text_radio_type)); ?>
                            <?php $widgets->dropdown('payment_reloads_cart', array( 0 => $text_disabled, 1 => $text_enabled)); ?>

                            <div class="buttons_head">
                                <?php echo $text_block_payment;?>
                                <select id="payment_methods">
                                <?php foreach( $payment_methods as $method) { ?>
                                <option value="<?php echo $method['code']; ?>"><?php echo $method['name']; ?></option>
                                <?php } ?>
                                </select>
                                <a class="add-field btn btn-default btn-sm"><i class="fa fa-plus"></i></a>
                            </div>

                            <?php foreach( $payment_methods as $method) { ?>
                                <ul id="payment_fields_<?php echo str_replace('.','_',$method['code']); ?>" class="ui-sortable payment_fields fields" data-count="<?php echo ( isset($neoseo_checkout_payment_fields[$method['code']]) ? count($neoseo_checkout_payment_fields[$method['code']]) : 0 ); ?>" style="display:none">
                            <?php $i = 0; if( isset($neoseo_checkout_payment_fields[$method['code']]) ) foreach( $neoseo_checkout_payment_fields[$method['code']] as $field ) { $i++; ?>
                                    <li id="payment_field_<?php echo str_replace('.','_',$method['code']); ?>_<?php echo $i; ?>"></li>
                            <?php } ?>
                                </ul>
                            <?php } ?>

                            <div class="buttons_head">
                                <a class="add-field btn btn-default btn-sm"><i class="fa fa-plus"></i></a>
                            </div>

                        </div>

                        <div class="tab-pane" id="tab-shipping">

                            <?php $widgets->dropdown('shipping_control', array( 0 => $text_select_type, 1 => $text_radio_type)); ?>
                            <?php $widgets->dropdown('aways_show_delivery_block', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->checklist('shipping_require_city', $shipping_methods_list); ?>
                            <?php $widgets->dropdown('shipping_city_select', array( "default" => $text_city_select_default, "cities" => $text_city_select_cities, "disabled" => $text_disabled)); ?>
                            <?php $widgets->dropdown('shipping_country_select', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('shipping_country_default', $countries); ?>
                            <?php $widgets->dropdown('shipping_zone_default', array(0 => $text_select)); ?>
                            <?php $widgets->input('shipping_city_default'); ?>
                            <?php if($novaposhtan_need_city) { ?>
                                <?php $widgets->input('novaposhta_city_name'); ?>
                                <input type="hidden" name="<?php echo $module_sysname; ?>_shipping_novaposhta_city_default" id="<?php echo $module_sysname; ?>_shipping_novaposhta_city_default" value="<?php echo ${$module_sysname.'_shipping_novaposhta_city_default'}; ?>">
                            <?php } ?>
                            <?php $widgets->dropdown('shipping_reloads_cart', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdown('shipping_title', array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->input('api_key'); ?>
                            <?php $widgets->checklist('shipping_novaposhta', $shipping_methods_list); ?>
                            <?php if ($warehouse_types){ ?>
                            <?php $widgets->checklist('warehouse_types', $warehouse_types); ?>
                            <?php } else { ?>
                            <label class="control-label"><?php echo $error_warehouse_types ?></label>
                            <?php } ?>
                            <div class="buttons_head">
                                <?php echo $text_block_shipping; ?>
                                <select id="shipping_methods">
                                    <?php foreach( $shipping_methods as $method) { ?>
                                    <option value="<?php echo $method['code']; ?>"><?php echo $method['name']; ?></option>
                                    <?php } ?>
                                </select>
                                <a class="add-field btn btn-default btn-sm"><i class="fa fa-plus"></i></a>
                            </div>

                            <?php foreach( $shipping_methods as $method) { ?>
                            <ul id="shipping_fields_<?php echo str_replace('.','_',$method['code']); ?>" class="ui-sortable shipping_fields fields" data-count="<?php echo ( isset($neoseo_checkout_shipping_fields[$method['code']]) ? count($neoseo_checkout_shipping_fields[$method['code']]) : 0 ); ?>" style="display:none">
                                <?php $i = 0; if( isset($neoseo_checkout_shipping_fields[$method['code']]) ) foreach( $neoseo_checkout_shipping_fields[$method['code']] as $field ) { $i++; ?>
                                <li id="shipping_field_<?php echo str_replace('.','_',$method['code']); ?>_<?php echo $i; ?>" ></li>
                                <?php } ?>
                            </ul>
                            <?php } ?>

                            <div class="buttons_head">
                                <a class="add-field btn btn-default btn-sm"><i class="fa fa-plus"></i></a>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-shipping_type">

                            <?php $widgets->dropdown('use_shipping_type', array( 0 => $text_disabled, 1 => $text_enabled)); ?>

                            <table class="list">
                                <thead>
                                <tr>
                                    <td><?php echo $text_shipping; ?></td>
                                    <td><?php echo $text_type_shipping; ?></td>
                                </tr>
                                </thead>
                                <?php foreach( $shipping_methods as $method) { ?>
                                <tr>
                                    <td><?php echo $method['name']; ?></td>
                                    <td>
                                        <?php
                                        $name = 'neoseo_checkout_shipping_type[' . $method['code'] . ']';
                                        $value = "address";
                                        if( isset($neoseo_checkout_shipping_type[$method['code']]) )
                                            $value = $neoseo_checkout_shipping_type[$method['code']];
                                        ?>
                                        <label for="<?php echo $name; ?>_pickpoint"><?php echo $text_pick_your_own; ?></label> <input id="<?php echo $name; ?>_pickpoint" type="radio" name="<?php echo $name; ?>" <?php if( $value == "pickpoint" ) echo 'checked="checked"'; ?> value="pickpoint" />
                                        <label for="<?php echo $name; ?>_address"><?php echo $text_order_delivery; ?></label> <input id="<?php echo $name; ?>_address" type="radio" name="<?php echo $name; ?>" <?php if( $value == "address" ) echo 'checked="checked"'; ?> value="address" />
                                    </td>
                                </tr>
                                <?php } ?>
                            </table>
                        </div>

                        <div class="tab-pane" id="tab-links">

                            <?php $widgets->dropdown('dependency_type', array( "none" => $text_dependency_disabled, "payment_for_shipping" => $text_dependency_payment_for_shipping, "shipping_for_payment" => $text_dependency_shipping_for_payment)); ?>

                            <div id="payment_for_shipping" style="display:none">
                                <table class="list">
                                    <thead>
                                    <tr>
                                        <td>
                                            <label for="select_shipping_method"><?php echo $text_shipping; ?></label>
                                            <select id="select_shipping_method">
                                                <option value="all">---</option>
                                                <?php foreach( $shipping_methods as $method) { ?>
                                                <option value="payment_for_shipping_<?php echo $method['code']; ?>"><?php echo $method['name']; ?></option>
                                                <?php } ?>
                                            </select>
                                        </td>
                                        <td><?php echo $text_payment;?> ( <input id="select_all_payment" class="select_all" type="checkbox" data-target="payment_for_shipping"> <label for="select_all_payment"><b><?php echo $text_select_all;?> </b></label> ) </td>
                                    </tr>
                                    </thead>
                                    <?php foreach( $shipping_methods as $method) { ?>
                                    <tr id="payment_for_shipping_<?php echo str_replace('.','_',$method['code']); ?>">
                                        <td><?php echo $method['name']; ?></td>
                                        <td>
                                            <input id="select_all_payment_<?php echo str_replace('.','_',$method['code']); ?>" class="select_all" type="checkbox" data-target="payment_for_shipping_<?php echo str_replace('.','_',$method['code']); ?>"> <label for="select_all_payment_<?php echo str_replace('.','_',$method['code']); ?>" ><b><?php echo $text_select_all;?></b></label><br>
                                            <?php foreach( $payment_methods as $pmethod) { ?>
                                            <input type="checkbox" id="payment_<?php echo $pmethod['code']; ?>_for_shipping_<?php echo $method['code']; ?>" name="neoseo_checkout_payment_for_shipping[<?php echo $method['code']; ?>][<?php echo $pmethod['code']; ?>]" <?php if( $neoseo_checkout_payment_for_shipping[$method['code']][$pmethod['code']] ) echo 'checked="checked"'; ?> />
                                            <label for="payment_<?php echo $pmethod['code']; ?>_for_shipping_<?php echo $method['code']; ?>"><?php echo strip_tags($pmethod['name']); ?></label>
                                            <br>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <?php } ?>
                                </table>
                            </div>

                            <div id="shipping_for_payment" style="display:none">
                                <table class="list">
                                    <thead>
                                        <tr>
                                            <td>
                                                <label for="select_payment_method"><?php echo $text_payment; ?></label>
                                                <select id="select_payment_method">
                                                    <option value="all">---</option>
                                                    <?php foreach( $payment_methods as $method) { ?>
                                                    <option value="shipping_for_payment_<?php echo $method['code']; ?>"><?php echo $method['name']; ?></option>
                                                    <?php } ?>
                                                </select>
                                            </td>
                                            <td><?php echo $text_shipping; ?> ( <input id="select_all_shipping" class="select_all" type="checkbox" data-target="shipping_for_payment"> <label for="select_all_shipping"><b>Выделить все</b></label> ) </td>
                                        </tr>
                                    </thead>
                                    <?php foreach( $payment_methods as $method) { ?>
                                    <tr id="shipping_for_payment_<?php echo str_replace('.','_',$method['code']); ?>">
                                        <td><?php echo $method['name']; ?></td>
                                        <td>
                                            <input id="select_all_shipping_<?php echo str_replace('.','_',$method['code']); ?>" class="select_all" type="checkbox" data-target="shipping_for_payment_<?php echo str_replace('.','_',$method['code']); ?>"> <label for="select_all_shipping_<?php echo str_replace('.','_',$method['code']); ?>" ><b><?php echo $text_select_all;?></b></label><br>
                                            <?php foreach( $shipping_methods as $smethod) { ?>
                                            <input type="checkbox" id="shipping_<?php echo str_replace('.','_',$smethod['code']); ?>_for_payment_<?php echo $method['code']; ?>" name="neoseo_checkout_shipping_for_payment[<?php echo $method['code']; ?>][<?php echo $smethod['code']; ?>]" <?php if( $neoseo_checkout_shipping_for_payment[$method['code']][$smethod['code']] ) echo 'checked="checked"'; ?> />
                                            <label for="shipping_<?php echo $smethod['code']; ?>_for_payment_<?php echo str_replace('.','_',$method['code']); ?>"><?php echo strip_tags($smethod['name']); ?></label>
                                            <br>
                                            <?php } ?>
                                        </td>
                                    </tr>
                                    <?php } ?>
                                </table>
                            </div>
                        </div>

                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_and_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled), $clear, $button_clear_log ); ?>
                            <textarea style="width: 100%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
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

<script id="fieldTmpl" type="text/x-jsrender">
    <div class="handler"><i class="fa fa-bars"></i></div>
    <div class="title">
        {{if display && required }}
        <span class="required">*</span>
        {{/if}}
    {{if display }}
        <span>
        {{else }}
        <span class="disabled">
        {{/if}}
    {{>label[<?php echo $config_language_id; ?>]}}
        </span>
        <a class="edit btn btn-primary btn-sm" toggle="{{>table_prefix}}_table_{{>i}}"><i class="fa fa-pencil"></i></a>
        <a class="delete btn btn-danger btn-sm"><i class="fa fa-trash-o"></i></a>
    </div>
    <div class="fields">
        <div id="{{>table_prefix}}_table_{{>i}}" style="display:none">

            <div style="display: inline-block; width: 100%;">
                <div class="col-sm-5">
                    <label class="control-label" for="{{>table_prefix}}_field_{{>i}}_label"><?php echo $text_name; ?></label>
                </div>
                <div class="col-sm-7">
                    <?php foreach( $languages as $language ) { ?>
                    <div class="input-group">
                        <input id="{{>table_prefix}}_field_{{>i}}_label" type="text" class="value-name form-control" name="{{>html_field}}[label][<?php echo $language['language_id']; ?>]" value="{{>label[<?php echo $language['language_id']; ?>]}}">
                        <span class="input-group-addon">
                            <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" >
                        </span>
                    </div>
                    <?php } ?>
                </div>
            </div>

            <div style="display: inline-block; width: 100%;">
                <div class="col-sm-5">
                    <label class="control-label" for="{{>table_prefix}}_field_{{>i}}_field"><?php echo $text_field; ?></label>
                </div>
                <div class="col-sm-7">
                    <select id="{{>table_prefix}}_field_{{>i}}_field" name="{{>html_field}}[field]" class="select_field_name form-control">
                    <?php foreach( $field_fields as $field => $name ) { ?>
                    <option value="<?php echo $field; ?>"><?php echo $name; ?></option>
                    <?php } ?>
                    </select>
                </div>
            </div>

            <div style="display: inline-block; width: 100%;">
                <div class="col-sm-5">
                    <label class="control-label" for="{{>table_prefix}}_field_{{>i}}_type"><?php echo $text_type; ?></label>
                </div>
                <div class="col-sm-7">
                    <select id="{{>table_prefix}}_field_{{>i}}_type" name="{{>html_field}}[type]" class="select_field_type form-control">
                    <?php foreach( $field_types as $type => $name ) { ?>
                    <option value="<?php echo $type; ?>"><?php echo $name; ?></option>
                    <?php } ?>
                </select>
                </div>
            </div>

            <div style="display: inline-block; width: 100%;">
                <div class="col-sm-5">
                    <label class="control-label" for="{{>table_prefix}}_field_{{>i}}_name"><?php echo $text_identifier; ?></label>
                </div>
                <div class="col-sm-7">
                    <input id="{{>table_prefix}}_field_{{>i}}_name" type="text" class="value-name form-control" name="{{>html_field}}[name]" value="{{>name}}">
                </select>
                </div>
            </div>

            <div style="display: inline-block; width: 100%;">
                <div class="col-sm-5">
                    <label class="control-label" for="{{>table_prefix}}_field_{{>i}}_mask"><?php echo $text_mask; ?></label>
                </div>
                <div class="col-sm-7">
                    <input id="{{>table_prefix}}_field_{{>i}}_mask" type="text" class="value-name form-control" name="{{>html_field}}[mask]" value="{{>mask}}">
                </select>
                </div>
            </div>

            <div style="display: inline-block; width: 100%;">
                <div class="col-sm-5">
                    <label class="control-label" for="{{>table_prefix}}_field_{{>i}}_default"><?php echo $text_initial_value; ?></label>
                </div>
                <div class="col-sm-7">
                    <input id="{{>table_prefix}}_field_{{>i}}_default" type="text" class="value-name form-control" name="{{>html_field}}[default]" value="{{>default}}">
                </select>
                </div>
            </div>

            <div style="display: inline-block; width: 100%;">
                <div class="col-sm-5">
                    <label class="control-label" for="{{>table_prefix}}_field_{{>i}}_display"><?php echo $text_show; ?></label>
                </div>
                <div class="col-sm-7">
                    <select id="{{>table_prefix}}_field_{{>i}}_display" name="{{>html_field}}[display]" class="select_field_display form-control">
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <option value="1"><?php echo $text_enabled; ?></option>
                    </select>
                </div>
            </div>

            <div style="display: inline-block; width: 100%;">
                <div class="col-sm-5">
                    <label class="control-label" for="{{>table_prefix}}_field_{{>i}}_only_register"><?php echo $text_only_register; ?></label>
                </div>
                <div class="col-sm-7">
                    <select id="{{>table_prefix}}_field_{{>i}}_only_register" name="{{>html_field}}[only_register]" class="select_field_display form-control">
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <option value="1"><?php echo $text_enabled; ?></option>
                    </select>
                </div>
            </div>

            <div style="display: inline-block; width: 100%;">
                <div class="col-sm-5">
                    <label class="control-label" for="{{>table_prefix}}_field_{{>i}}_required"><?php echo $text_required; ?></label>
                </div>
                <div class="col-sm-7">
                    <select id="{{>table_prefix}}_field_{{>i}}_required" name="{{>html_field}}[required]" class="select_field_display form-control">
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <option value="1"><?php echo $text_enabled; ?></option>
                    </select>
                </div>
            </div>

        </div>
    </div>
</script>

<script>

$('[name=customer_group]').change(function(e){
    $('ul.customer-type').hide();
    $('ul.' + $(this).attr('id')).show();
});

$('a.type-add').click(function(e) {
    e.preventDefault();
    var name = prompt('Введите название типа покупателя');
    if( name ) {
        $.ajax({
            url: 'index.php?route=module/neoseo_checkout/typeadd&token=<?php echo $token; ?>&name=' + name,
            dataType: 'json',
            success: function(json) {
                if( json['status'] == 0 ) {
                    location.reload();
                }
            }
        });
    }
});

$('a.type-edit').click(function(e) {
    e.preventDefault();
    var id = $(this).attr('href').replace("#","");
    var name = prompt('Введите название типа покупателя');
    if( name ) {
        $.ajax({
            url: 'index.php?route=module/neoseo_checkout/typeedit&token=<?php echo $token; ?>&name=' + name + '&id=' + id,
            dataType: 'json',
            success: function(json) {
                if( json['status'] == 0 ) {
                    location.reload();
                }
            }
        });
    }
});

$('a.type-del').click(function(e) {
    e.preventDefault();
    var id = $(this).attr('href').replace("#","");
    if( id ) {
        $.ajax({
            url: 'index.php?route=module/neoseo_checkout/typedel&token=<?php echo $token; ?>&id=' + id,
            dataType: 'json',
            success: function(json) {
                if( json['status'] == 0 ) {
                    location.reload();
                }
            }
        });
    }
});

<?php $i = 0; foreach( $neoseo_checkout_customer_fields as $type => $fields ) { ?>
<?php $i = 0; foreach( $fields as $field ) {
    if( !isset($field["field"]) )
        continue;
    $i++; ?>
    setFieldData("#customer_field_" + <?php echo $type; ?> + "_" + <?php echo $i; ?>,{
        i: <?php echo $type; ?> + "_" + <?php echo $i; ?>,
        html_field: 'neoseo_checkout_customer_fields[<?php echo $type; ?>][<?php echo $i; ?>]',
        table_prefix: 'neoseo_checkout_customer_fields',
        label: <?php echo json_encode($field['label']); ?>,
        field: '<?php echo $field['field']; ?>',
        type: '<?php echo $field['type']; ?>',
        name: '<?php echo $field['name']; ?>',
        mask: '<?php echo $field['mask']; ?>',
        default: '<?php echo strtr(html_entity_decode($field['default']),array("\r" => "\\r", "\n" => "\\n")); ?>',
        display: <?php echo $field['display']; ?>,
        only_register: <?php echo $field['only_register']; ?>,
        required: <?php echo $field['required']; ?>,
    });
<?php } ?>
<?php } ?>

<?php foreach( $payment_methods as $method) { ?>
<?php $i = 0; if( isset($neoseo_checkout_payment_fields[$method['code']]) ) foreach( $neoseo_checkout_payment_fields[$method['code']] as $field ) {
        if( !isset($field["field"]) )
            continue;
        $i++; ?>
    setFieldData("#payment_field_<?php echo str_replace('.','_',$method["code"]); ?>_" + <?php echo $i; ?>,{
        i: <?php echo $i; ?>,
        table_prefix: 'neoseo_checkout_payment_fields_<?php echo str_replace(".","_",$method["code"]); ?>',
        html_field: 'neoseo_checkout_payment_fields[<?php echo $method["code"]; ?>][<?php echo $i; ?>]',
        label: <?php echo json_encode($field['label']); ?>,
        field: '<?php echo $field['field']; ?>',
        type: '<?php echo $field['type']; ?>',
        name: '<?php echo $field['name']; ?>',
        mask: '<?php echo $field['mask']; ?>',
        default: '<?php echo strtr(html_entity_decode($field['default']),array("\r" => "\\r", "\n" => "\\n")); ?>',
        only_register: <?php echo isset($field['only_register']) ? $field['only_register'] : 0; ?>,
        display: <?php echo $field['display']; ?>,
        required: <?php echo $field['required']; ?>,
    });
<?php } ?>
<?php } ?>

<?php foreach( $shipping_methods as $method) { ?>
<?php $i = 0; if( isset($neoseo_checkout_shipping_fields[$method['code']]) ) foreach( $neoseo_checkout_shipping_fields[$method['code']] as $field ) {
        if( !isset($field["field"]) )
            continue;
        $i++; ?>
    setFieldData("#shipping_field_<?php echo str_replace('.','_',$method["code"]); ?>_" + <?php echo $i; ?>,{
        i: <?php echo $i; ?>,
        table_prefix: 'neoseo_checkout_shipping_fields_<?php echo str_replace(".","_",$method["code"]); ?>',
        html_field: 'neoseo_checkout_shipping_fields[<?php echo $method["code"]; ?>][<?php echo $i; ?>]',
        label: <?php echo json_encode($field['label']); ?>,
        field: '<?php echo $field['field']; ?>',
        type: '<?php echo $field['type']; ?>',
        name: '<?php echo $field['name']; ?>',
        mask: '<?php echo $field['mask']; ?>',
        default: '<?php echo strtr(html_entity_decode($field['default']),array("\r" => "\\r", "\n" => "\\n")); ?>',
        only_register: <?php echo isset($field['only_register']) ? $field['only_register'] : 0; ?>,
        display: <?php echo $field['display']; ?>,
        required: <?php echo $field['required']; ?>,
    });
<?php } ?>
<?php } ?>


$(document).ready(function() {
    $("#payment_methods").trigger("change");
    $("#shipping_methods").trigger("change");
    $(".select_all").click(function(){
        target = $("#" + this.id).attr("data-target");
        if( $("#" + this.id).prop("checked") ){
            $("#" + target + " input[type=checkbox]").prop("checked","checked");
        } else {
            $("#" + target + " input[type=checkbox]").prop("checked",false);
        }
    });
    $("#select_shipping_method").change(function(){
        if( this.value == "all") {
            $("#payment_for_shipping tbody tr").show();
        } else {
            $("#payment_for_shipping tbody tr").hide();
            $("#payment_for_shipping tbody tr#" + this.value.replace(/\./g,"_")).show();
        }
    });
    $("select[name=neoseo_checkout_dependency_type]").change(function(){
        $("#payment_for_shipping").hide();
        $("#shipping_for_payment").hide();
        if( this.value != "none") {
            $("#" + this.value).show();
        }
    });
    $("select[name=neoseo_checkout_dependency_type]").trigger("change");

    $(".select_field_type").change(function(){
        var baseId = this.id.substr(0,this.id.length-4);
        if( this.value == "html") {
            $("#" + baseId + "name").parents("tr").hide();
            $("#" + baseId + "mask").parents("tr").hide();
            $("#" + baseId + "required").parents("tr").hide();
        } else {
            $("#" + baseId + "name").parents("tr").show();
            $("#" + baseId + "mask").parents("tr").show();
            $("#" + baseId + "required").parents("tr").show();
        }
    });

    $(".select_field_name").change(function(){
        var baseId = this.id.substr(0,this.id.length-5);
        if ( this.value == "custom") {
            $("#" + baseId + "type").parents("tr").show();
            $("#" + baseId + "name").parents("tr").show();
            $("#" + baseId + "mask").parents("tr").show();
            $("#" + baseId + "type").trigger("change");
        } else if ( this.value == "password" || this.value == "password2" ) {
            $("#" + baseId + "type").parents("tr").hide();
            $("#" + baseId + "name").parents("tr").hide();
            $("#" + baseId + "mask").parents("tr").hide();
        } else {
            $("#" + baseId + "type").parents("tr").hide();
            $("#" + baseId + "name").parents("tr").hide();
            $("#" + baseId + "mask").parents("tr").show();
        }
    });
    $(".select_field_name").trigger("change");
});

    $('#<?php echo $module_sysname; ?>_shipping_zone_default').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=<?php echo ${$module_sysname . '_shipping_country_default'} ;?>&zone_id=<?php echo ${$module_sysname . '_shipping_zone_default'} ;?>');

    $('#<?php echo $module_sysname; ?>_shipping_country_default').on('change', function () {
        $('#<?php echo $module_sysname; ?>_shipping_zone_default').load('index.php?route=localisation/geo_zone/zone&token=<?php echo $token; ?>&country_id=' + this.value + '&zone_id=0');
    });

    $('#<?php echo $module_sysname; ?>_shipping_city_default').autocomplete({
        source: function( request, response ) {
            $.ajax({
                url: "index.php?route=localisation/neoseo_city/autocomplete_city",
                dataType: "json",
                data: {
                    country_id: $('#<?php echo $module_sysname; ?>_shipping_country_default').val(),
                    zone_id: $('#<?php echo $module_sysname; ?>_shipping_zone_default option:selected').val(),
                    name: request['term'],
                    token: '<?php echo $token; ?>',
                },
                success: function(json) {
                    response($.map(json, function(item) {
                        return {
                            label: item['value'],
                            value: item['value'],
                            country_id: item['country_id'],
                            zone_id: item['zone_id'],
                            city: item['city'],
                        }
                    }));
                }
            });
        },
        minLength: 2,
        select: function (item) {
            if( item ) {
                $("#<?php echo $module_sysname; ?>_shipping_city_default").val(item.city);
            }
        },
    });

$('#<?php echo $module_sysname; ?>_novaposhta_city_name').autocomplete({
    source: function( request, response ) {
        $.ajax({
            url: "index.php?route=shipping/neoseo_novaposhta/cityautocomplete",
            dataType: "json",
            data: {
                filter_name: request['term'],
                token: '<?php echo $token; ?>',
            },
            success: function(json) {
                response($.map(json, function(item) {
                    return {
                        label: item['name'],
                        value: item['name'],
                        city: item['id'],
                    }
                }));
            }
        });
    },
    minLength: 2,
    select: function (item,ui) {
            console.log(ui.item.city);
            $('#<?php echo $module_sysname; ?>_shipping_novaposhta_city_default').val(ui.item.city);
    },
});
</script>

<?php echo $footer; ?>