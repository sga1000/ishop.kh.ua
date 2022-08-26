<div class="side-module filter box-shadow box-corner">
    <h3 class="text-center hidden-sm hidden-xs"><b><?php echo $heading_title; ?></b></h3>

    <div id="filter-list" class="filter-list">

        <div class="filter-list__close hidden-md hidden-lg">
            <span><?php echo $heading_title; ?></span>
            <button type="button">
                <span></span>
                <span></span>
            </button>
        </div>
        <?php if ( $selected_options_count > 0 ) { ?>

        <div class="selected-options">
            <h5 class="selected-title"><?php $you_choiced; ?></h5>
            <?php foreach ($options as $option) { ?>
            <?php if( !$option['selected'] ) { continue; } ?>
            <?php foreach ($option['values'] as $option_value) { ?>
            <?php if( !$option_value['selected'] ) { continue; } ?>
            <?php if( $option['type'] == "slider" ) { continue; } ?>
            <div class="selected-option">
                <a rel="nofollow" href="<?php echo $option_value['url']; ?>">
                    <b><?php echo $option['name']; ?>:</b> <?php echo $option_value['name']; ?>
                    <i class="fa fa-times" aria-hidden="true"></i>
                </a>
            </div>

            <?php } ?>
            <?php } ?>

            <?php if ( $selected_options_values_count > 1 ) { ?>
            <a  rel="nofollow" href="<?php echo $cancel_all; ?>" class="reset-filter-button"><!--<span>&times;</span>--><?php echo $text_cancel_all; ?></a>
            <?php } ?>
        </div>

        <?php } ?>

        <?php if ( $use_price == 1 && $min_price != $max_price ) { ?>

        <div id="option-price" class="option option-active option-slide">
            <div class="option-name" data-target="#option-values-price">
                <?php echo $text_price; ?>
            </div>
            <div class="option-values price-result_cont" id="option-values-price">
                <div></div>
            </div>

        </div>

        <?php } ?>

        <?php foreach ($options as $option) { ?>

        <?php if ( $option['quantity'] <= 0 ) { continue; } ?>

        <div class="option-name <?php if ($option['open'] || $option['selected']) { ?>option-active<?php } ?>" data-target="#option-values-<?php echo $option['option_id']; ?>">
            <?php echo $option['name']; ?>
            <i class="fa fa-caret-down" aria-hidden="true"></i>
        </div>

        <div id="option-values-<?php echo $option['option_id']; ?>" class="option-values">

            <?php if( $option['type'] == "slider" ) { ?>
            <?php if ( isset($slider_options)
                         && isset($slider_options[$option['option_id']]['values_min'])
                         && isset($slider_options[$option['option_id']]['values_max'])
                         && $slider_options[$option['option_id']]['values_min'] != $slider_options[$option['option_id']]['values_max'] ) { ?>

            <div id="option-slider" class="option option-active option-slide">
                <div class="option-values" id="option-values-slide-<?php echo $option['option_id']; ?>">
                    <div></div>
                </div>
            </div>

            <?php } ?>
            <?php } ?>

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
                    <a href="<?php echo $value['url']; ?>" data-toggle="tooltip" data-placement="top" title="<?php echo $value['name']; ?>">
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

        <?php } // end options loop ?>

        <div class="button-choice-group">
            <a rel="nofollow" href="#" class="pick-up-button"><?php echo $pickup_text ?></a>
            <a rel="nofollow" href="<?php echo $cancel_all; ?>" class="reset-button"><?php echo $text_reset; ?></a>
        </div>
    </div>

</div>

<script>

    function showFilter() {
        $('#filter-list').show();
        $('html,body').css('overflow-y','hidden');
    }

    $('.filter-list__close button').on('click', function () {
        $('#filter-list').hide();
        $('html,body').css('overflow-y','visible');
    });

    $('.option-checkbox input, .option-radio input').click(function(e){
        e.preventDefault();
        var id = $(this).attr('id');
        var href = $('label[for=' + id + '] a').attr('href');
        document.location = href;

    });

    $('.option-name').click(function (e) {
        $(this).toggleClass('option-active');
        $(this).children('.fa').toggleClass('fa-caret-down fa-caret-up');
    });

    $('.option .option-name').click(function (e) {
        $(this).toggleClass('option-active');
        $(this).children('.fa').toggleClass('fa-caret-down fa-caret-up');
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
        values: [ Number('<?php echo $price_begin; ?>'), Number('<?php echo $price_end; ?>') ],
        slide: function( event, ui ) {
            $( "#price-from" ).text( ui.values[ 0 ] );
            $( "#price-to" ).text( ui.values[ 1 ] );
        },
        change: function(event, ui) {
            var min = $(this).slider('option','min');
            var max = $(this).slider('option','max');
			var valueBegin = $(this).slider('option','valueBegin');
			var valueEnd = $(this).slider('option','valueEnd');
            if ( ui.values[ 0 ] == valueBegin && ui.values[ 1 ] == valueEnd ) {
            	// nothing changed
			} else if( ui.values[ 0 ] == min && ui.values[ 1 ] == max ) {
				// default url without price
				var url = "<?php echo htmlspecialchars_decode($url_priceless); ?>";
				document.location = url;
			} else {
				var url = "<?php echo htmlspecialchars_decode($url_for_price); ?>";
				url = url.replace('PRICE_FROM',ui.values[ 0 ]);
				url = url.replace('PRICE_TO',ui.values[ 1 ]);
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

        if(viewportWidth <= 991) {
            var $a = $('.option-color').parent();
            var $b = $a.parent();
            $b.css('padding','0');
            var $c = $b.parent();
            $c.css({
                'padding': '10px',
                'text-align': 'center'
            });
        }
    });

    <?php if (isset($slider_options)) { ?>
    <?php foreach ($slider_options as $key => $value) {

            $values_list = array();
            foreach ($value['values'] as $val_key => $val){
                $values_list[$val_key] = $val['val'];
            }
            $js_values_list = json_encode($values_list);
            //echo "var js_values_list = ". $js_values_list . ";\n";
                ?>

            var js_values_list_<?php echo $key ?> = JSON.parse('<?php echo json_encode($values_list);?>');

            $(document).ready(function () {
                $('<span id="slider-from-<?php echo $key ?>"><?php echo $value["values_begin"]; ?></span>').appendTo('#option-values-slide-<?php echo $key ?>>.ui-slider-handle:eq(0)');
                $('<span id="slider-to-<?php echo $key ?>"><?php echo $value["values_end"]; ?></span>').appendTo('#option-values-slide-<?php echo $key ?>>.ui-slider-handle:eq(1)');
            });

            $('#option-values-slide-<?php echo $key ?>').slider({
                range: true,
                min: Number("<?php echo $value['values_min']; ?>"),
                max: Number("<?php echo $value['values_max']; ?>"),
                valueBegin: Number("<?php echo $value['values_begin']; ?>"),
                valueEnd: Number("<?php echo $value['values_end']; ?>"),
                values: [ Number("<?php echo $value['values_begin']; ?>"), Number("<?php echo $value['values_end']; ?>") ],
                slide: function( event, ui ) {
                    $( "#slider-from-<?php echo $key ?>" ).text( ui.values[ 0 ] );
                    $( "#slider-to-<?php echo $key ?>" ).text( ui.values[ 1 ] );
                },
                change: function(event, ui) {
                    var min = $(this).slider('option','min');
                    var max = $(this).slider('option','max');
                    var valueBegin = $(this).slider('option','valueBegin');
                    var valueEnd = $(this).slider('option','valueEnd');
                    if ( ui.values[ 0 ] == valueBegin && ui.values[ 1 ] == valueEnd ) {
                        // nothing changed
                    } else if( ui.values[ 0 ] == min && ui.values[ 1 ] == max ) {
                        // default url without price
                        var url = "<?php echo htmlspecialchars_decode($value['url_for_slider']); ?>";
                        document.location = url;
                    } else {
                        var url = "index.php?route=product/category&<?php echo htmlspecialchars_decode($value['url_for_slider_clear']); ?>";
                        var slider_url = '';

                        if(url.indexOf("nsf") == -1 ){
                            url = url + '&nsf=<?php echo $key ?>:';
                        }else{
                            url = url + ';<?php echo $key ?>:';
                        }

                        for(ArrVal in js_values_list_<?php echo $key ?>) if (js_values_list_<?php echo $key ?>.hasOwnProperty(ArrVal)) {

                            if((js_values_list_<?php echo $key ?>[ArrVal] >= ui.values[ 0 ])
                        && (js_values_list_<?php echo $key ?>[ArrVal] <= ui.values[ 1 ])
                        && (slider_url.indexOf(ArrVal) == -1) ){
                                slider_url = slider_url  + ArrVal + ',';

                            }
                        }

                        slider_url = slider_url.substring(0, slider_url.length - 1);
                        url = url + slider_url;
                        //console.log(js_values_list_<?php echo $key ?>);
                        document.location = url;
                    }
                }
            });

        <?php } ?>
    <?php } ?>


</script>