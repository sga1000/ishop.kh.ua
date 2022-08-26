<div class="tags side-module box-shadow box-corner">
	<?php if($heading_title) { ?>
	<h3 class="text-center"><?php echo $heading_title; ?></h3>
	<?php } ?>
	<div class="filter-tags-<?php echo $module; ?> collapsed">
		<div class="filter-tags__box">
			<?php foreach($tags as $tag){ ?>
			<a href="<?php echo $tag['url']; ?>"><?php echo $tag['name'];?></a>
			<?php } ?>
		</div>
	</div>
	<div class="tags-more collapsed"><a href="#"><span></span><i class="fa fa-caret-down"></i></a></div>
</div>

<script>

    $('.filter-tags-<?php echo $module; ?>').showMore({
        collapsed: '<?php echo $text_collapsed; ?>',
        incollapsed: '<?php echo $text_incollapsed; ?>'
    });


</script>
