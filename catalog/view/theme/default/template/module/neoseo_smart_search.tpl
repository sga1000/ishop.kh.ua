<div id="search_block">

	<div id="search_header">
		<div id="search_close">x</div>
	</div>

	<div id="search_content">
<?php foreach($products as $product) { ?>
		<div class="search-item">
<?php if ( isset($product['image']) ) { ?>
			<a class="image" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['image']; ?>"/></a>
<?php } ?>
<?php if ( isset($product['rating']) ) { ?>
			<span class="rating-<?php echo $product['rating']; ?>"></span>
<?php } ?>
			<a class="name" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
<?php if ( isset($product['model']) ) { ?>
			<span class="model"><?php echo $result['model']; ?></span>
<?php } ?>
<?php if ( isset($product['sku']) ) { ?>
			<span class="sku"><?php echo $product['sku']; ?></span>
<?php } ?>
<?php if ( isset($product['price']) ) { ?>
			<span class="price"><?php echo $product['price']; ?></span>
<?php } ?>
<?php if ( isset($product['description']) ) { ?>
			<span class="description"><?php echo $product['description']; ?></span>
<?php } ?>
		</div>
<?php } ?>
		<div id="search_footer">
<?php if ($product_total > (int) $product_limit) { ?>
			<span class="pagination-text"><?php echo $text_search_page; ?></span>
<?php echo (($prevPage > 0) ? ' <span class="prevPage">' . $prevPage . '</span>' : ''); ?>
			<span class="curPage"><?php echo $page; ?></span>
<?php echo (($page < $totalPages) ? '  <span class="nextPage">' . $nextPage . '</span>' : ''); ?>
<?php } ?>
		</div>
	</div>
</div>

<script>
$(document).mouseup(function (e) {
	var container = $("#search_block");
	if (container.has(e.target).length === 0) {
		container.hide();
	}
});

var selector = '<?php echo $selector; ?>';
$('#search_close').click(function () {
	$('#search_main').hide()
});

$('#search_content .prevPage, #search_content .nextPage').click(function () {
	var value = $(selector).val();
	var page = $(this).html();
    var language = "";
    if( window.current_language ) {
        language = window.current_language;
    }
	$.ajax({
		url: language + 'index.php?route=module/neoseo_smart_search',
		type: 'get',
		dataType: 'json',
		data: 'filter_name=' + encodeURIComponent(value) + "&page=" + page,
		success: function (data) {
			if (data['content']) {
				$('#search_main').html(data['content']);
				$('#search_main').show();
			} else {
				$('#search_main').hide();
			}
		}
	});
	$(selector).focus();
});

$('#search_close').click(function () {
	$("#search_main").hide();
});
</script>