<div class="row" id="slideshow_wrap_<?php echo $module; ?>">
	<div class="col-xs-12  <?php if ($banners2) { ?>col-md-8<?php } ?>">
		<div id="slideshow<?php echo $module; ?>" class="owl-carousel" style="opacity: 1;">
		  <?php foreach ($banners as $banner) { ?>
		  <div class="item">
			<?php if ($banner['link']) { ?>
			<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
			<?php } else { ?>
			<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
			<?php } ?>
		  </div>
		  <?php } ?>
		</div>
	</div>
    <?php if ($banners2) { ?>
	<div class="col-xs-12 col-md-4">
		<div id="banner<?php echo $module; ?>">
			<?php foreach ($banners2 as $banner) { ?>
				<div class="hidden-xs col-md-12 col-sm-6 item owl-wrapper-outer">
					<?php if ($banner['link']) { ?>
						<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
					<?php } else { ?>
						<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
					<?php } ?>
				</div>
			<?php } ?>
		</div>
	</div>
    <?php } ?>
</div>
<script type="text/javascript"><!--
$('#slideshow<?php echo $module; ?>').owlCarousel({
	items: 6,
	autoPlay: 3000,
	singleItem: true,
	navigation: true,
	navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
	pagination: true
});
--></script>