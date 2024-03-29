<?php echo $header; ?>
<div class="container">
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <div class="personal-area-container">
                <h2><?php echo $heading_title; ?></h2>
                <?php if ($invoice_no) { ?>
                <b><?php echo $text_invoice_no; ?></b> <?php echo $invoice_no; ?><br/>
                <?php } ?>
                <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?><br/>
                <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br/>
                <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>, <?php echo $shipping_zone; ?>, <?php echo $shipping_city; ?>, <?php echo $shipping_address_1; ?>  <?php echo $shipping_address_2; ?>
                <br/><br/>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <td class="text-left"><?php echo $column_name; ?></td>
                            <td class="text-left"><?php echo $column_model; ?></td>
                            <td class="text-right"><?php echo $column_quantity; ?></td>
                            <td class="text-right"><?php echo $column_price; ?></td>
                            <td class="text-right"><?php echo $column_total; ?></td>
                            <?php if ($products) { ?>
                            <td style="width: 20px;"></td>
                            <?php } ?>
                        </tr>
                        </thead>
                        <tbody>
                        <?php foreach ($products as $product) { ?>
                        <tr>
                            <td class="text-left"><?php echo $product['name']; ?>
                                <?php foreach ($product['option'] as $option) { ?>
                                <br/>
                                &nbsp;
                                <small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                <?php } ?></td>
                            <td class="text-left"><?php echo $product['model']; ?></td>
                            <td class="text-right"><?php echo $product['quantity']; ?></td>
                            <td class="text-right"><?php echo $product['price']; ?></td>
                            <td class="text-right"><?php echo $product['total']; ?></td>
                            <td class="text-right" style="white-space: nowrap;"><?php if ($product['reorder']) { ?>
                                <a onclick="popupCartReorder('<?php echo $product['reorder']; ?>')" data-toggle="tooltip" title="<?php echo $button_reorder; ?>" class="btn btn-primary"><i class="fa fa-shopping-cart"></i></a>
                                <?php } ?>
                            </td>
                        </tr>
                        <?php } ?>
                        <?php foreach ($vouchers as $voucher) { ?>
                        <tr>
                            <td class="text-left"><?php echo $voucher['description']; ?></td>
                            <td class="text-left"></td>
                            <td class="text-right">1</td>
                            <td class="text-right"><?php echo $voucher['amount']; ?></td>
                            <td class="text-right"><?php echo $voucher['amount']; ?></td>
                            <?php if ($products) { ?>
                            <td></td>
                            <?php } ?>
                        </tr>
                        <?php } ?>
                        </tbody>
                        <tfoot>
                        <?php foreach ($totals as $total) { if ( floatval($total['text']) == 0 ) continue; ?>
                        <tr>
                            <td colspan="3"></td>
                            <td class="text-right"><b><?php echo $total['title']; ?></b></td>
                            <td class="text-right"><?php echo $total['text']; ?></td>
                            <?php if ($products) { ?>
                            <td></td>
                            <?php } ?>
                        </tr>
                        <?php } ?>
                        </tfoot>
                    </table>
                </div>
                <?php if ($comment) { ?>
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <td class="text-left"><?php echo $text_comment; ?></td>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="text-left"><?php echo $comment; ?></td>
                    </tr>
                    </tbody>
                </table>
                <?php } ?>
                <?php if ($histories) { ?>
                <h3><?php echo $text_history; ?></h3>
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <td class="text-left"><?php echo $column_date_added; ?></td>
                        <td class="text-left"><?php echo $column_status; ?></td>
                        <td class="text-left"><?php echo $column_comment; ?></td>
                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($histories as $history) { ?>
                    <tr>
                        <td class="text-left"><?php echo $history['date_added']; ?></td>
                        <td class="text-left"><?php echo $history['status']; ?></td>
                        <td class="text-left"><?php echo $history['comment']; ?></td>
                    </tr>
                    <?php } ?>
                    </tbody>
                </table>
                <?php } ?>
                <div class="buttons text-right clearfix">
                    <div class="continue">
                        <a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a>
                    </div>
                </div>
            </div>
            <?php echo $content_bottom; ?></div>
        <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>