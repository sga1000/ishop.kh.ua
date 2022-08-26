<?php if ($title) { ?>
<aside class="side-module box-shadow box-corner">
	<div class="blog-category">
		<div class="blog-category-button hidden-md hidden-lg" data-toggle="collapse" data-target="#category-list">
			<h3><?php echo $title; ?></h3>
			<i class="fa fa-bars"></i>
		</div>

		<h3 class="hidden-sm hidden-xs"><?php echo $title; ?></h3>

		<?php } ?>
		<div id="category-list" class="list-group">
			<?php foreach ($categories as $category) { ?>
			<?php if ($category['category_id'] == $blog_category_id || $category['category_id'] == $parent_id) { ?>
			<a href="<?php echo $category['href']; ?>" class="list-group-item item-category active"><?php echo $category['name']; ?></a>
			<?php if ($category['children']) { ?>
			<?php foreach ($category['children'] as $child) { ?>
			<?php if ($child['category_id'] == $blog_category_id) { ?>
			<a href="<?php echo $child['href']; ?>" class="list-group-item active"><i class="fa fa-caret-right"></i><?php echo $child['name']; ?></a>
			<?php } else { ?>
			<a href="<?php echo $child['href']; ?>" class="list-group-item"><i class="fa fa-caret-right"></i><?php echo $child['name']; ?></a>
			<?php } ?>
			<?php } ?>
			<?php } ?>
			<?php } else { ?>
			<a href="<?php echo $category['href']; ?>" class="list-group-item  item-category"><?php echo $category['name']; ?></a>
			<?php } ?>
			<?php } ?>
		</div>
	 </div>
</aside>
<script>

	$(window).resize(function () {
	var viewportWidth = $(window).width();
	if (viewportWidth <= 991) {
	$('#category-list').addClass('collapse');
	} else if (viewportWidth >= 992) {
	$('#category-list').removeClass('collapse').css('height', 'auto');;
	}
	});

	$(document).ready(function () {
	var viewportWidth = $(window).width();
	if (viewportWidth <= 991) {
	$('#category-list').addClass('collapse');
	} else if (viewportWidth >= 992) {
	$('#category-list').removeClass('collapse').css('height', 'auto');;
	}
	});
</script>