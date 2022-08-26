<?php if($neoseo_quick_order_status){ ?>
<a href="javascript:void(0)" class="product-template-quick" onclick="showQuickOrderProduct();">
    <i class="fa fa-shopping-cart"></i>
    <span><?php echo $button_quick_order?></span> 
</a>
<script>
	function showQuickOrderProduct(){
	var quantity = $('input[name="quantity"]').val(); 
	showQuickOrder(<?php echo $product_id; ?>, quantity);
	}
</script>
<?php } ?>