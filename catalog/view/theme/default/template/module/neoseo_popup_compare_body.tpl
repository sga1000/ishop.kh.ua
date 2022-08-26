<table class="table table-hover">
    <?php foreach( $products as $product ) { ?>
    <tr id='product_<?php echo $product["id"]; ?>'>
        <td style="width:40px;">
            <img src="<?php echo $product["image"]; ?>">
        </td>
        <td>
            <?php echo $product["name"]; ?>
        </td>
        <td>
            <?php echo $product["price"]; ?>
        </td>
        <td class="text-right">
            <a href="#" onclick="popupCompareTrash(<?php echo $product['product_id']; ?>);return false;"><i class="glyphicon glyphicon-trash"></i></a>
        </td>
    </tr>
    <?php } ?>
</table>
