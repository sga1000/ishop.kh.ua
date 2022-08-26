<div class="<?php echo $is_home && $menu_type == 'menu_vertical' ? 'side-slideshow ' : ''; ?>">
	<div id="slideshow_wrap_<?php echo $module; ?>">
		<div class="row">
			<div class="slideshow-container col-xs-12 <?php if ($banners2) { ?>col-md-8<?php } ?>">
				<div data-slideshow id="simpleSlideshow<?php echo $module; ?>" class="simple-slideshow">
					<div class="simple-slideshow-wrapper">
						<?php foreach ($banners as $banner) { ?>
						<div class="simple-slideshow__item">
							<?php if ($banner['link']) { ?>
							<a href="<?php echo $banner['link']; ?>"><img width="<?php echo $slide_width; ?>" height="<?php echo $slide_height; ?>" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
							<?php } else { ?>
							<img width="<?php echo $slide_width; ?>" height="<?php echo $slide_height; ?>"  src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
							<?php } ?>
						</div>
						<?php } ?>
					</div>
					<div class="simple-slideshow__buttons">
						<button class="simple-slideshow__buttons-btn btn-prev" aria-label="Left slide"><i class="fa fa-angle-left"></i></button>
						<button class="simple-slideshow__buttons-btn btn-next" aria-label="Right slide"><i class="fa fa-angle-right"></i></button>
					</div>
				</div>
			</div>
			<?php if ($banners2) { ?>
			<div class="col-xs-12 col-md-4 hidden-xs">
				<div id="banner<?php echo $module; ?>" class="banner-<?php echo count($banners2) ; ?>">
					<?php foreach ($banners2 as $banner) { ?>
					<div class="hidden-xs col-md-12 col-sm-6 item owl-wrapper-outer">
						<?php if ($banner['link']) { ?>
						<a href="<?php echo $banner['link']; ?>"><img width="<?php echo $banner_width; ?>" height="<?php echo $banner_height; ?>"  src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
						<?php } else { ?>
						<img width="<?php echo $banner_width; ?>" height="<?php echo $banner_height; ?>"  src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
						<?php } ?>
					</div>
					<?php } ?>
				</div>
			</div>
			<?php } ?>
		</div>
	</div>
</div>
<?php if ($header_type === "type-3") { ?>
<script>
	$('#simpleSlideshow<?php echo $module; ?>').appendTo('#rz-menu .slideshow');
</script>
<?php } ?>
<script>

	function SimpleSlideshow (target, options) {

		const slideShow = $(target).find('.simple-slideshow-wrapper');
		let interval;

		$(target).find('.simple-slideshow__item:gt(0)').hide();

		const toggleSlidePrev = () => {
			slideShow.find('.simple-slideshow__item').eq(-1)
					.prependTo(slideShow)
					.fadeIn(options.fadeIn)
					.next()
					.fadeOut(options.fadeOut)
					.end();
		}

		const toggleSlideNext = () => {
			slideShow.find('.simple-slideshow__item').eq(0)
					.fadeOut(options.fadeOut)
					.next()
					.fadeIn(options.fadeIn)
					.end()
					.appendTo(slideShow);
		}

		const slideshowRun = () => {
			if (undefined !== options.autoplay && options.autoplay) {
				interval = setInterval(() => {
					toggleSlideNext();
				}, options.interval)
			}
		}

		slideshowRun();


		$(target).find(options.btnPrev).on('click', () => {
			clearInterval(interval);
			toggleSlidePrev();

			slideshowRun();

		});

		$(target).find(options.btnNext).on('click', () => {
			clearInterval(interval);
			toggleSlideNext();

			slideshowRun();

		});


		slideShow.css('height', $('.simple-slideshow__item img').height());

	}

	new SimpleSlideshow("#simpleSlideshow<?php echo $module; ?>", {
		autoplay: false,
		interval: 5000,
		fadeIn: 750,
		fadeOut: 750,
		btnPrev: '.btn-prev',
		btnNext: '.btn-next',
	})

</script>
