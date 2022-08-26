<?php echo $header; ?><?php echo $column_left; ?>

<?php
require_once(DIR_SYSTEM . '/engine/neoseo_view.php' );
$widgets = new NeoSeoWidgets('neoseo_cash_memo_',$params);
$widgets->text_select_all = $text_select_all;
$widgets->text_unselect_all = $text_unselect_all;
?>

    <div id="content">

        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <?php if( !isset($license_error) ) { ?>
                        <button type="submit" name="action" value="save" form="form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
                        <a onclick="$('#form').attr('action', '<?php echo $save_and_close; ?>'); $('#form').submit();" class="btn btn-primary"><i class="fa fa-save"></i>&nbsp;<?php echo $button_save_and_close; ?></a>
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
                        <?php if( !isset($license_error) ) { ?>
                            <li><a href="#tab-header-left" data-toggle="tab"><?php echo $tab_header_left; ?></a></li>
                            <li><a href="#tab-header-right" data-toggle="tab"><?php echo $tab_header_right; ?></a></li>
                            <li><a href="#tab-product" data-toggle="tab"><?php echo $tab_product; ?></a></li>
                            <li><a href="#tab-summ" data-toggle="tab"><?php echo $tab_summ; ?></a></li>
                            <li><a href="#tab-fields" data-toggle="tab"><?php echo $tab_fields; ?></a></li>
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
                                    <?php $widgets->dropdown('replace_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('invoice_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('client_side',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_order',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->dropdown('product_order_client',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->inputImage('print_img',$placeholder, $neoseo_cash_memo_print_img_logo ); ?>
                                    <?php $widgets->input('print_img_width'); ?>
                                    <?php $widgets->input('print_img_height'); ?>
                                    <?php $widgets->dropdown('order_date',array( "created" => $text_order_date_created, "modified" => $text_order_date_modified, "current" => $text_order_date_current)); ?>
                                    <?php $widgets->dropdown('show_comment',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->textarea('text',4); ?>

                                <?php } else { ?>

                                    <?php echo $license_error; ?>

                                <?php } ?>

                            </div>

                            <?php if( !isset($license_error) ) { ?>
                                <div class="tab-pane"  id="tab-header-left">
                                    <?php $widgets->textarea('supplier_info',3); ?>
                                    <?php $widgets->textarea('customer_info_format',3); ?>
                                    <?php $widgets->textarea('payment_info_format',3); ?>
                                    <?php $widgets->textarea('shipping_info_format',3); ?>
                                </div>

                                <div class="tab-pane"  id="tab-header-right">
                                    <?php $widgets->inputImage('print_img_store',$placeholder, $neoseo_cash_memo_print_logo_img_store ); ?>
                                    <?php $widgets->input('store_logo_width'); ?>
                                    <?php $widgets->input('store_logo_height'); ?>
                                    <?php $widgets->textarea('store_text',3); ?>
                                    <?php $widgets->input('store_name'); ?>
                                    <?php $widgets->input('store_phone'); ?>
                                    <?php $widgets->input('store_email'); ?>
                                    <?php $widgets->input('store_url'); ?>
                                </div>
                                <div class="tab-pane"  id="tab-product">
                                    <?php $widgets->dropdown('column_model_status',array( 0 => $text_disabled, 1 => $text_separate_column, 2 => $text_product_column)); ?>
                                    <?php $widgets->dropdown('column_sku_status',array( 0 => $text_disabled, 1 => $text_separate_column, 2 => $text_product_column)); ?>
                                    <?php $widgets->dropdown('column_unit_status',array( 0 => $text_disabled, 1 => $text_separate_column)); ?>
                                    <?php $widgets->dropdown('column_option_status',array( 0 => $text_disabled, 1 => $text_product_column, 2 => $text_product_name)); ?>
                                    <?php $widgets->input('column_quantity_field'); ?>
                                    <?php $widgets->dropdown('column_image_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->input('column_image_width'); ?>
                                    <?php $widgets->input('column_image_height'); ?>
                                    <?php $widgets->dropdown('sort_product', $sorts); ?>
                                </div>

                                <div class="tab-pane"  id="tab-summ">

                                    <?php $widgets->dropdown('status_sale',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                                    <?php $widgets->textarea('unit_option_null',2); ?>
                                    <?php $widgets->textarea('unit_option_one_nine',2); ?>
                                    <?php $widgets->textarea('unit_option_ten_nineteen',2); ?>
                                    <?php $widgets->textarea('tens_option',2); ?>
                                    <?php $widgets->textarea('hundreds_option',2); ?>
                                    <?php $widgets->textarea('money_option_coins',2); ?>
                                    <?php $widgets->textarea('money_option_currency',2); ?>
                                    <?php $widgets->textarea('unit_option_one_nine_thousand',2); ?>
                                    <?php $widgets->textarea('count_money_option_thousand',2); ?>
                                    <?php $widgets->textarea('unit_option_one_nine_millon',2); ?>
                                    <?php $widgets->textarea('count_money_option_millon',2); ?>
                                    <?php $widgets->textarea('unit_option_one_nine_billon',2); ?>
                                    <?php $widgets->textarea('count_money_option_billion',2); ?>

                                </div>

                                <div class="tab-pane" id="tab-fields">
                                    <table class="table table-bordered table-hover" id="items-table" width="90%">
                                        <thead>
                                        <tr>
                                            <td width="200px" class="left"><?php echo $entry_field_list_name; ?></td>
                                            <td><?php echo $entry_field_list_desc; ?></td>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <?php foreach( $fields as $field_name => $field_desc ) { ?>
                                            <tr>
                                                <td class="left">{<?php echo $field_name ?>}</td>
                                                <td><?php echo $field_desc ?></td>
                                            </tr>
                                        <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            <?php } ?>

                            <?php if( !isset($license_error) ) { ?>
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
<?php echo $footer; ?>