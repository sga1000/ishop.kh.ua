<div class="side-module filter box-shadow box-corner filter-horizontal">


	<div class="filter-button hidden-md hidden-lg" data-toggle="collapse" data-target="#filter-list">
		<span><?php echo $heading_title; ?></span>
		<i class="fa fa-bars"></i>
	</div>

	<div id="filter-list" class="">
		<h3 class="text-center hidden-sm hidden-xs"><b><?php echo $heading_title; ?></b></h3>
		<div class="neoseo-filter horizontal">

			<div class="options-box">
				<?php if ($use_price == 1 && $min_price != $max_price ) { ?>
				<div id="option-price" class="option horizontal">
					<div class="option-horizontal-box">
						<div class="option-name" data-target="#option-values-price">
							<?php echo $text_price; ?>
							<i class="fa fa-caret-down" aria-hidden="true"></i>
						</div>
						<div class="option-values horizontal-slide-price price-result_cont" id="option-values-price">
							<div></div>
						</div>
					</div>

				</div>
				<?php } ?>

				<?php foreach ($options as $option) { ?>

				<?php if ( $option['quantity'] <= 0 ) { continue; } ?>

				<div id="option-<?php echo $option['option_id']; ?>" class="option horizontal">

					<div class="option-horizontal-box">
						<div class="option-name" data-target="#option-values-<?php echo $option['option_id']; ?>">
							<?php echo $option['name']; ?>
							<i class="fa fa-caret-down" aria-hidden="true"></i>
						</div>

						<div id="option-values-<?php echo $option['option_id']; ?>" class="option-values">

							<?php foreach ($option['values'] as $key => $value) { ?>

							<?php if ( !$value['selected'] && $value['count'] <= 0 ) { continue; } ?>

							<div class="option-<?php echo $option['type']; ?> <?php echo $option['type']; ?> <?php if ($value['selected']) { ?> option-selected<?php } ?> option-description">

								<?php if( $option['type'] == "checkbox" ) { ?>

								<input id="option-value-<?php echo $value['option_value_id']; ?>" class="<?php echo $option['type']; ?>" type="checkbox" <?php if ($value['selected']) { ?>checked="checked"<?php } ?>/>

								<?php if ( $option['style'] == 'image' ) { ?>
								<label for="option-value-<?php echo $value['option_value_id']; ?>" class="option-position">
									<?php } else { ?>
									<label for="option-value-<?php echo $value['option_value_id']; ?>">
										<?php } ?>


										<a href="<?php echo $value['url']; ?>">

											<?php if ($option['style'] == 'color') { ?><div class="value-container"><?php } ?>

												<?php if ($option['style'] == 'color') { ?>
												<span class="option-color" style="background-color: <?php echo $value['color']; ?>;"></span>
												<?php } ?>

												<?php if ( $option['style'] == 'image' ) { ?>
												<div class="option-<?php echo $value['position'] ?>">
													<?php if ($value['image']) { ?><img src="/image/<?php echo $value['image']; ?>"/><?php } ?>
													<?php } ?>

													<span><?php echo $value['name']; ?></span><?php if ( $option['style'] == 'image' ) { ?>
												</div>
												<?php } ?>
												<?php if ($option['style'] == 'color') { ?></div><?php } ?>

											<?php if ( !$value['selected'] ) { ?>
											<span class="option-counter"><?php echo $value['count']; ?></span>
											<?php } ?>

										</a>

									</label>

									<?php } else if( $option['type'] == "radio" ) { ?>

									<input id="option-value-<?php echo $value['option_value_id']; ?>" class="<?php echo $option['type']; ?>"name="option-<?php echo $option['option_id']; ?>" type="radio" <?php if ($value['selected']) { ?>checked="checked"<?php } ?>/>
									<label for="option-value-<?php echo $value['option_value_id']; ?>">

										<a href="<?php echo $value['url']; ?>">

											<?php if ($option['style'] == 'color') { ?>
											<span class="option-color" style="background-color: <?php echo $value['color']; ?>;"></span>
											<?php } ?>

											<?php if ( $option['style'] == 'image' ) { ?>
											<img src="/image/<?php echo $value['image']; ?>"/>
											<?php } ?>

											<?php echo $value['name']; ?>

											<?php if ( !$value['selected'] ) { ?>
											<span class="option-counter"><?php echo $value['count']; ?></span>
											<?php } ?>

										</a>

									</label>

									<?php } else if( $option['type'] == "grid" ) { ?>

									<?php if ($option['style'] == 'color') { ?>
									<a class="color" href="<?php echo $value['url']; ?>" data-toggle="tooltip" data-placement="top" title="<?php echo $value['name']; ?>">
										<span class="option-color" style="background-color: <?php echo $value['color']; ?>;"></span>
									</a>
									<?php } else { ?>
									<a href="<?php echo $value['url']; ?>">
										<span class="option-square"><?php echo $value['name']; ?></span>
									</a>
									<?php } ?>

									<?php } // end option type switch ?>

							</div>

							<?php } // end values loop ?>

						</div>
					</div>

					<?php if( $option['selected'] ) {  ?>
					<?php foreach ($option['values'] as $option_value) { ?>
					<?php if( !$option_value['selected'] ) { continue; } ?>
					<div id="option-checked" class="option-checked">
						<span>
							<a rel="nofollow" href="<?php echo $option_value['url']; ?>">x</a>
						</span>
						<?php echo $option_value['name']; ?>
					</div>
					<?php } ?>
					<?php } ?>
				</div>

				<?php } // end options loop ?>
			</div>

			<?php if ( $selected_options_values_count > 0 ) { ?>
			<div class="selected-options">
				<a  rel="nofollow" href="<?php echo $cancel_all; ?>" class="reset-filter-button"><?php echo $text_cancel_all; ?></a>
			</div>
			<?php } ?>

			<div class="button-choice-group">
				<a rel="nofollow" href="#" class="pick-up-button"><?php echo $pickup_text ?></a>
				<a rel="nofollow" href="<?php echo $cancel_all; ?>" class="reset-button"><?php echo $text_reset; ?></a>
			</div>
		</div>
	</div>

</div>

<script>
    $('.filter-button').click(function () {
        $(this).toggleClass('open')
    });

    $('.option-checkbox input, .option-radio input').click(function (e) {
        e.preventDefault();
        var id = $(this).attr('id');
        var href = $('label[for=' + id + '] a').attr('href');
        document.location = href;

    });

    $('.option .option-name').click(function (e) {
        if ($(window).width() < 992) {
            $(this).parents('.option').toggleClass('option-active');
        }

    });

	$(document).ready(function () {
		$('<span id="price-from"><?php echo $price_begin; ?></span><span id="price-to"><?php echo $price_end; ?></span>').appendTo('.price-result_cont:eq(0)');
	});

    <?php if ($use_price == 1) { ?>
        $('#option-values-price div').slider({
            range: true,
            min: Number('<?php echo $min_price; ?>'),
            max: Number('<?php echo $max_price; ?>'),
            valueBegin: Number('<?php echo $price_begin; ?>'),
            valueEnd: Number('<?php echo $price_end; ?>'),
            values: [Number('<?php echo $price_begin; ?>'), Number('<?php echo $price_end; ?>')],
            slide: function (event, ui) {
                $("#price-from").text(ui.values[ 0 ]);
                $("#price-to").text(ui.values[ 1 ]);
            },
            change: function (event, ui) {
                var min = $(this).slider('option', 'min');
                var max = $(this).slider('option', 'max');
                var valueBegin = $(this).slider('option', 'valueBegin');
                var valueEnd = $(this).slider('option', 'valueEnd');
                if (ui.values[ 0 ] == valueBegin && ui.values[ 1 ] == valueEnd) {
                    // nothing changed
                } else if (ui.values[ 0 ] == min && ui.values[ 1 ] == max) {
                    // default url without price
                    var url = "<?php echo htmlspecialchars_decode($url_priceless); ?>";
                    document.location = url;
                } else {
                    var url = "<?php echo htmlspecialchars_decode($url_for_price); ?>";
                    url = url.replace('PRICE_FROM', ui.values[ 0 ]);
                    url = url.replace('PRICE_TO', ui.values[ 1 ]);
                    document.location = url;
                }

            }
        });
    <?php } ?>

    $(window).resize(function () {
        var viewportWidth = $(window).width();
        if (viewportWidth <= 991) {
            $('#filter-list').addClass('collapse');
        } else if (viewportWidth >= 992) {
            $('#filter-list').removeClass('collapse');
        }
    });

    $(document).ready(function () {
        var viewportWidth = $(window).width();
        if (viewportWidth <= 991) {
            $('#filter-list').addClass('collapse');
        } else if (viewportWidth >= 992) {
            $('#filter-list').removeClass('collapse');
        }

        if (viewportWidth <= 991) {
            var $a = $('.option-color').parent();
            var $b = $a.parent();
            $b.css('padding', '0');
            var $c = $b.parent();
            $c.css({
                'padding': '10px',
                'text-align': 'center'
            });
        }
    });

</script>
