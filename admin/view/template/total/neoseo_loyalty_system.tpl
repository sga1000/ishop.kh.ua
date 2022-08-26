<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <?php if( !isset($license_error) ) { ?>
                <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                <button type="submit" name="action" value="save_and_close" form="form" data-toggle="tooltip" title="<?php echo $button_save_and_close; ?>" class="btn btn-default"><i class="fa fa-save"></i> <?php echo $button_save_and_close; ?></button>
                <?php } else { ?>
                <a href="<?php echo $recheck; ?>" data-toggle="tooltip" title="<?php echo $button_recheck; ?>" class="btn btn-primary"/><i class="fa fa-check"></i> <?php echo $button_recheck; ?></a>
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
            <div class="panel-heading ui-helper-clearfix" style="height: 55px">
                <div class="pull-left">
                    <h3 class="panel-title "><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
                </div>
                <div class="pull-right">
                    <?= $widgets->storesDropdown($stores) ?>
                </div>
            </div>

            <div class="panel-body">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                    <?php if( !isset($license_error) ) { ?>
                    <li><a href="#tab-discount-order" data-toggle="tab"><?php echo $tab_discount_order; ?></a></li>
                    <li><a href="#tab-logs" data-toggle="tab"><?php echo $tab_logs; ?></a></li>
                    <?php } ?>
                    <li><a href="#tab-support" data-toggle="tab"><?php echo $tab_support; ?></a></li>
                    <li><a href="#tab-license" data-toggle="tab"><?php echo $tab_license; ?></a></li>
                </ul>

                <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-general">
                            <?php if( !isset($license_error) ) { ?>

                            <?php $widgets->dropdown('status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdownMultiStore($stores, 'customer_discount_status',array( 0 =>
                            $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdownMultiStore($stores, 'group_discount_status',array( 0 =>
                            $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdownMultiStore($stores, 'cumulative_discount_status',array( 0 =>
                            $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdownMultiStore($stores, 'total_discount_status',array( 0 =>
                            $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->inputMultiStore($stores, 'cumulative_discount_gradation'); ?>
                            <?php $widgets->inputMultiStore($stores, 'total_discount_gradation'); ?>
                            <?php $widgets->dropdownMultiStore($stores,'incart_text_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->dropdownMultiStore($stores,'in_neoseo_checkout_text_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                            <?php $widgets->localeInputMultiStore($stores,'incart_text',$full_languages); ?>
                            <?php $widgets->localeInputMultiStore($stores,'in_neoseo_checkout_text',$full_languages); ?>
                            <?php $widgets->input('sort_order'); ?>
                            <?php $widgets->checklistMultiStore($stores, 'excluded_categories', $categories); ?>
                            <?php $widgets->checklistMultiStore($stores, 'excluded_manufacturers', $manufacturers); ?>

                            <div class="form-group">
                                <div class="col-sm-5">
                                    <label class="control-label" for="input-product"><?php echo $entry_excluded_products; ?></label>
                                </div>
                                <div class="col-sm-7">
                                    <?php foreach ($stores as $store_id => $store) { ?>
                                    <div class="stores-group store-<?php echo $store_id ?> <?php echo $store_id != 0 ? 'hidden' : '' ?>">
                                        <input type="text" name="neoseo_loyalty_system_excluded_products[<?php echo $store_id ?>]" value="" data-store="<?php echo $store_id ?>" placeholder="<?php echo $entry_excluded_products; ?>" id="input-product[<?php echo $store_id ?>]" class="form-control"/>
                                        <div id="product-excluded-<?php echo $store_id ?>" class="well well-sm" style="height: 150px; overflow: auto;">
                                            <?php foreach ($products[$store_id] as $product_id => $product_name) { ?>
                                            <div id="product-excluded-<?php echo $store_id. '-' .$product_id; ?>"><i class="fa fa-minus-circle"></i> <?php echo  $product_name; ?>
                                                <input type="hidden" name="neoseo_loyalty_system_excluded_products[<?php echo $store_id ?>][]" value="<?php echo $product_id; ?>"/>
                                            </div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <?php } ?>
                                </div>
                            </div>

                            <?php } else { ?>
                            <div>
                                <?php echo $license_error; ?>
                            </div>

                            <?php } ?>
                        </div>

                        <?php if( !isset($license_error) ) { ?>
                        <div class="tab-pane" id="tab-discount-order">
                            <?php $widgets->inputMultiStore($stores,'personal_sort_order'); ?>
                            <?php $widgets->inputMultiStore($stores,'group_sort_order'); ?>
                            <?php $widgets->inputMultiStore($stores,'accumulative_sort_order'); ?>
                            <?php $widgets->inputMultiStore($stores,'sum_sort_order'); ?>
                        </div>
                        <div class="tab-pane" id="tab-logs">
                            <?php $widgets->debug_download_logs('debug',array( 0 => $text_disabled, 1 => $text_enabled),
                            $clear, $download, $button_clear_log, $button_download_log); ?>
                            <textarea style="width: 98%; height: 300px; padding: 5px; border: 1px solid #CCCCCC; background: #FFFFFF; overflow: scroll;"><?php echo $logs; ?></textarea>
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
    $(document).ready(function () {
        let selected_store;

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
        // Related
        $('input[name^=\'neoseo_loyalty_system_excluded_products\']').autocomplete({
            'source': function (request, response) {
                selected_store = $(this).attr('data-store');

                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
                    dataType: 'json',
                    success: function (json) {
                        response($.map(json, function (item) {
                            return {
                                label: item['name'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            'select': function (item) {
                //$('input[name=\'excluded[product]\']').val('');

                $('#product-excluded-' + selected_store + '-' + item['value']).remove();

                $('#product-excluded-' + selected_store).append('<div id="product-excluded-' + selected_store + '-' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="neoseo_loyalty_system_excluded_products[' + selected_store + '][]" value="' + item['value'] + '" /></div>');
            }
        });

        $('div[id^="product-excluded"]').delegate('.fa-minus-circle', 'click', function () {
            $(this).parent().remove();
        });
    });
    //--></script>
<?php echo $footer; ?>