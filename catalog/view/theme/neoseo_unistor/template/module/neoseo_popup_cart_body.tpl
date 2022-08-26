<?php if ($show_last_product && isset($products[0])) { ?>
    <div class="row">
    <div class="col-sm-3">
        <img class="img-responsive" src="<?php echo $products[0]['image']; ?>">
    </div>
        <div class="col-sm-9">
            <h4><?php echo $products[0]["name"]; ?></h4>
            <div class="options">
                <?php if( count($products[0]["option"]) > 0 ) { foreach($products[0]["option"] as $option ) { ?>
                    - <?php echo $option["name"] . ": " .  $option["value"]; ?> <br>
                <?php } } ?>
            </div>
            <span><?php echo $products[0]["price"]; ?></span>
        </div>
    </div>
<?php } else { ?>
    <table class="table table-hover">
    <thead>
    <tr>
        <th colspan="2"><?php echo $column_name; ?></th>
        <th class="text-right"><?php echo $column_price; ?></th>
    </tr>
    </thead>
    <tbody>
    <?php foreach( $products as $product ) { ?>
    <tr id="product_<?php echo $product['key']; ?>">
        <td style="width:40px;">
            <img src="<?php echo $product['image']; ?>">
        </td>
        <td>
            <?php echo $product["name"]; ?>
            <div class="options">
                <?php if( count($product["option"]) > 0 ) { foreach($product["option"] as $option ) { ?>
                - <?php echo $option["name"] . ": " .  $option["value"]; ?> <br>
                <?php } } ?>
            </div>
        </td>
        <td class="text-right" style="width:140px;">
            <?php echo $product['quantity']; ?> x <?php echo $product["price"]; ?><br>
            <div class="btn-group btn-group-xs" role="group">
                <a class="btn btn-xs" onclick="popupCartMinus(<?php echo $product['key']; ?>,<?php echo $product['quantity']; ?>);"><i class="glyphicon glyphicon-minus"></i></a>
                <a class="btn btn-xs" onclick="popupCartTrash(<?php echo $product['key']; ?>);"><i class="glyphicon glyphicon-trash"></i></a>
                <a class="btn btn-xs" onclick="popupCartPlus(<?php echo $product['key']; ?>,<?php echo $product['quantity']; ?>);"><i class="glyphicon glyphicon-plus"></i></a>
            </div>
        </td>
    </tr>
    <?php } ?>
    </tbody>
    <?php if( count($products) > 0 ) { ?>
    <tfoot>
    <tr>
        <td colspan="2"><?php echo $text_subtotal; ?>:</td>
        <td class="text-right"><?php echo $subtotal; ?></td>
    </tr>
    </tfoot>
    <?php } ?>
</table>
<?php } ?>