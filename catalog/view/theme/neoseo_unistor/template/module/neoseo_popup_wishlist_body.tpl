<?php if( false ) { // table mode ?>
<?php if( $message ) { ?>
<?php echo $message; ?>
<?php } else { ?>
<table class="table table-hover">
    <?php foreach( $products as $product ) { ?>
    <tr id="product_<?php echo $product['key']; ?>">
        <td style="width:40px;">
            <img src="<?php echo $product['image']; ?>">
        </td>
        <td><?php echo $product["name"]; ?></td>
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
<?php } else { // single mode ?>
<div class="row">
    <div class="col-sm-3">
        <img src="<?php echo $product['image']; ?>">
    </div>
    <?php if( $message ) { ?>
    <div class="col-sm-9">
        <?php echo $message; ?>
    </div>
    <?php } else { ?>
    <div class="col-sm-9 price-wrapper">
            <h4><?php echo $product["name"]; ?></h4>
            <?php if (!$product["special"]) { ?>
            <span class="price"><?php echo $product["price"]; ?></span>
            <?php } else { ?>
            <span class="price-old"><?php echo $product["price"]; ?></span>
            <span class="price"><?php echo $product["special"]; ?></span>
            <?php } ?>
        </div>
    <?php } ?>
</div>
<?php } ?>

