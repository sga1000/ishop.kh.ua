<div class="table-responsive">
    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <td class="text-right"><?php echo $column_order_id; ?></td>
            <td class="text-center"><?php echo $column_date_added; ?></td>
            <td class="text-right"><?php echo $column_status; ?></td>
            <td class="text-left"><?php echo $column_product; ?></td>
            <td class="text-right"><?php echo $column_quantity; ?></td>
            <td class="text-right"><?php echo $column_price; ?></td>
            <td class="text-right"><?php echo $column_total; ?></td>
            <td class="text-right"><?php echo $column_action; ?></td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <?php if ($orders) { ?>
            <?php foreach ($orders as $order) { ?>
        <tr>
            <td class="text-right"><?php echo $order['order_detail']['order_id']; ?></td>
            <td class="text-center"><?php echo $order['order_detail']['date_added']; ?></td>
            <td class="text-right"><?php echo $order['order_detail']['order_status']; ?></td>
            <td class="text-left">
                <?php echo $order['product_detail']['name']; ?>
                <?php foreach ($order['option_detail'] as $option) { ?>
                <br />
                <?php if ($option['type'] != 'file') { ?>
                &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                <?php } else { ?>
                &nbsp;<small> - <?php echo $option['name']; ?>: <a href="<?php echo $option['href']; ?>"><?php echo $option['value']; ?></a></small>
                <?php } ?>
                <?php } ?>
            </td>
            <td class="text-right"><?php echo $order['product_detail']['quantity']; ?></td>
            <td class="text-right"><?php echo $order['product_detail']['price_currency']; ?></td>
            <td class="text-right"><?php echo $order['product_detail']['total_currency']; ?></td>
            <td class="text-right"><a target="_blank" href="/admin/index.php?route=sale/order/info&order_id=<?php echo $order['order_detail']['order_id']; ?>&token=<?php echo $token; ?>" data-toggle="tooltip" title="<?php echo $text_view; ?>" class="btn btn-info"><i class="fa fa-eye"></i></a></td>
        </tr>
        <?php } ?>
        <?php } else { ?>
        <tr>
            <td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
        </tr>
        <?php } ?>
        </tr>
        </tbody>
    </table>
</div>
