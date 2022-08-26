<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $language; ?>" xml:lang="<?php echo $language; ?>">
<head>
    <title><?php echo $title; ?></title>
    <base href="<?php echo $base; ?>" />
    <link rel="stylesheet" type="text/css" href="view/stylesheet/neoseo_cash_memo.css" />
</head>
<body>
<div style="width: 700px">
    <?php $order_count = count($orders); $order_index = 0; foreach ($orders as $order) { $order_index=$order_index+1; ?>
    <?php if ( $order_index > 0 && $order_index < $order_count ) { ?>
    <div style="page-break-after: always;" >
        <?php } else { ?>
        <div>
            <?php } ?>
            <table width="100%">
                <tr>
                    <td>
                        <table>
                            <?php if( $order['store_owner'] ) { ?>
                                <tr><th align="right">Поставщик:</th><td><?php echo $order['store_owner']; ?></td></tr>
                            <?php } ?>
                            <tr><th align="right">Покупатель:</th><td><?php echo $order['customer_info']; ?></td></tr>
                            <tr><th align="right">Оплата:</th><td><?php echo $order['payment_info']; ?></td></tr>
                            <tr><th align="right">Доставка:</th><td><?php echo $order['shipping_info']; ?></td></tr>
                        </table>
                    </td>

                </tr>
            </table>
            <br />
            <br />
            <center>
                <h3><?php echo $text_product_order . " №" . $order['order_id'] . " от " . $order['date']; ?></h3>
            </center>
            <br />
            <br />
            <table class="product">
                <tr class="heading">
                    <td><?php echo $column_id; ?></td>
                    <td><?php echo $column_product; ?></td>
                    <?php if( $neoseo_cash_memo_column_sku_status == 1 ) { ?>
                        <td align="right"><?php echo $column_sku; ?></td>
                    <?php } ?>
                    <?php if( $neoseo_cash_memo_column_model_status == 1 ) { ?>
                        <td align="right"><?php echo $column_model; ?></td>
                    <?php } ?>
                    <td align="right"><?php echo $column_count; ?></td>
                    <?php if( $neoseo_cash_memo_column_unit_status == 1 ) { ?>
                        <td align="right"><?php echo $column_weight_class; ?></td>
                    <?php } ?>
                    <td align="right"><?php echo $column_price; ?></td>
                    <td align="right"><?php echo $column_sum; ?></td>
                </tr>
                <?php $i = 0; foreach ($order['product'] as $product) { $i = $i + 1;?>
                    <tr>
                        <td><?php echo $i; ?></td>
                        <td>
                            <?php if( isset($neoseo_cash_memo_column_image_status) && $neoseo_cash_memo_column_image_status == 1 ) { ?>
                                <img src="<?php echo $product['image']; ?>" style="float:left">
                            <?php } ?>

                            <?php echo $product['name']; ?>
                            <?php foreach ($product['option'] as $option) { ?>

                                <?php if( $neoseo_cash_memo_column_option_status == 1 ) { ?>
                                    <br />
                                    &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                <?php } else if( $neoseo_cash_memo_column_option_status == 2 ) { ?>
                                    <?php echo " : " . $option['value']; ?>

                                <?php } ?>
                            <?php } ?>

                            <?php if( $neoseo_cash_memo_column_sku_status == 2 && $product['sku'] ) { ?>
                                <br />
                                &nbsp;<small> - <?php echo $text_sku; ?>: <?php echo $product['sku']; ?></small>
                            <?php } ?>

                            <?php if( $neoseo_cash_memo_column_model_status == 2 && $product['model'] ) { ?>
                                <br />
                                &nbsp;<small> - <?php echo $text_model; ?>: <?php echo $product['model']; ?></small>
                            <?php } ?>
                        </td>
                        <?php if( $neoseo_cash_memo_column_sku_status == 1 ) { ?>
                            <td align="right"><?php echo $product['sku']; ?></td>
                        <?php } ?>
                        <?php if( $neoseo_cash_memo_column_model_status == 1 ) { ?>
                            <td align="right"><?php echo $product['model']; ?></td>
                        <?php } ?>
                        <td align="right"><?php echo $product['quantity']; ?></td>
                        <?php if( $neoseo_cash_memo_column_unit_status == 1 ) { ?>
                            <td align="right"><?php echo print_r($product['weight_class'],true); ?></td>
                        <?php } ?>
                        <td align="right"><nobr><?php echo $product['price']; ?></nobr></td>
                        <td align="right"><nobr><?php echo $product['total']; ?></nobr></td>
                    </tr>
                <?php } ?>
                <?php foreach ($order['voucher'] as $voucher) { ?>
                    <tr>
                        <td align="left"><?php echo $voucher['description']; ?></td>
                        <td align="left"></td>
                        <td align="right">1</td>
                        <td align="right"><?php echo $voucher['amount']; ?></td>
                        <td align="right"><?php echo $voucher['amount']; ?></td>
                    </tr>
                <?php } ?>
                <?php foreach ($order['total'] as $total) { ?>

                    <tr>
                        <?php
                        $colspan = 4;
                        if( $neoseo_cash_memo_column_sku_status == 1 )
                            $colspan +=1;
                        if( $neoseo_cash_memo_column_model_status == 1 )
                            $colspan +=1;
                        if( $neoseo_cash_memo_column_unit_status == 1 )
                            $colspan +=1;
                        ?>
                        <td align="right" colspan="<?php echo $colspan; ?>"><b><?php echo $total['title']; ?>:</b></td>
                        <td align="right"><?php echo $total['text']; ?></td>
                    </tr>
                <?php } ?>
            </table>

        </div>
        <?php } ?>
    </div>
</body>
</html>