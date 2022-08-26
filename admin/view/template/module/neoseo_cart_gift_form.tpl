<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="save-gift-form" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
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
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="save-gift-form" class="form-horizontal">
                    <?php $widgets->dropdown('gift_status',array( 0 => $text_disabled, 1 => $text_enabled)); ?>
                    <?php $widgets->input('gift_name'); ?>
                    <?php if (isset($error_name)) { ?>
                    <div class="text-danger"><?php echo $error_name; ?></div>
                    <?php } ?>
                    <?php $widgets->input('min_price'); ?>
                    <?php if (isset($error_min_price)) { ?>
                    <div class="text-danger"><?php echo $error_min_price; ?></div>
                    <?php } ?>
                    <?php $widgets->checklist('customer_groups', $customer_groups); ?>
                    <?php $widgets->checklist('stores', $stores); ?>
                    <div class="form-group" style="display: inline-block; width: 100%;">
                        <div class="col-sm-5">
                            <label class="control-label" for="input-product"><?php echo $entry_product; ?></label>
                        </div>
                        <div class="col-sm-7">
                            <?php if ($filter_stock_status) { ?>
                            <input type="text" name="product" value="" id="input-product" class="form-control" />
                            <div id="gift-product" class="well well-sm" style="height: 150px; overflow: auto;">
                                <?php if (isset($products) && $products) { ?>
                                <?php foreach ($products as $product) { ?>
                                <div id="gift-product<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
                                    <input type="hidden" name="product[]" value="<?php echo $product['product_id']; ?>" />
                                </div>
                                <?php } ?>
                                <?php } ?>
                            </div>
                            <?php }else{ ?>
                            <p><?php echo $text_product_status_not_selected; ?></p>
                            <?php } ?>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script type="text/javascript"><!--
        $('input[name=\'product\']').autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request) + '&filter_stock_status=<?php echo $filter_stock_status; ?>&filter_status=0',
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            return {
                                label: item['name'],
                                value: item['product_id']
                            }
                        }));
                    }
                });
            },
            select: function(item) {
                $('input[name=\'product\']').val('');

                $('#gift-product' + item['value']).remove();

                $('#gift-product').append('<div id="gift-product' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product[]" value="' + item['value'] + '" /></div>');
            }
        });

        $('#gift-product').delegate('.fa-minus-circle', 'click', function() {
            $(this).parent().remove();
        });
//--></script>
</div>
<?php echo $footer; ?>