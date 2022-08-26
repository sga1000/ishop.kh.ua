<?php if ($show_last_product) { ?>
    <div class="row">
        <div class="col-sm-3">
            <img class="img-responsive" src="<?php echo $products[0]['image']; ?>">
        </div>
        <div class="col-sm-9 price-wrapper">
            <h4><?php echo $products[0]["name"]; ?></h4>
            <?php if (!$products[0]["special"]) { ?>
            <span class="price"><?php echo $products[0]["price"]; ?></span>
            <?php } else { ?>
            <span class="price-old"><?php echo $products[0]["price"]; ?></span>
            <span class="price"><?php echo $products[0]["special"]; ?></span>
            <?php } ?>
        </div>
    </div>
<?php } else { ?>

<table class="table table-hover">
    <?php foreach( $products as $product ) { ?>
    <tr id="product_<?php echo $product['id']; ?>">
        <td style="width:40px;">
            <img class="img-responsive" src="<?php echo $product['image']; ?>">
        </td>
        <td>
            <?php echo $product["name"]; ?>
        </td>
        <td>
            <?php if (!$product["special"]) { ?>
                <span><?php echo $product["price"]; ?></span>
            <?php } else { ?>
                <span><?php echo $product["price"]; ?></span>
                <span><?php echo $product["special"]; ?></span>
            <?php } ?>
        </td>
        <td class="text-right">
            <a href="#" onclick="popupCompareTrash(<?php echo $product['product_id']; ?>);return false;"><i class="glyphicon glyphicon-trash"></i></a>
        </td>
    </tr>
    <?php } ?>
</table>
<?php } ?>