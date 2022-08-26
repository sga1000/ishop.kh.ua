<div id="stiky_box">
    <div class="container">
        <div class="row">
            <div class="stiky-logo col-md-2">
                <?php if ( $logo || $unistor_logo ) { ?>
                <?php if ($is_home) { ?>
                <img src="<?php echo $unistor_logo ? $unistor_logo : $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" width="<?php echo $logo_sizes[0]; ?>" height="<?php echo $logo_sizes[1]; ?>"/>
                <?php } else { ?>
                <a href="<?php echo $home; ?>">
                    <img src="<?php echo $unistor_logo ? $unistor_logo : $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" width="<?php echo $logo_sizes[0]; ?>" height="<?php echo $logo_sizes[1]; ?>"/>
                </a>
                <?php } ?>
                <?php } else { ?>
                <?php if ($is_home) { ?>
                <h3><?php echo $name; ?></h3>
                <?php } else { ?>
                <a href="<?php echo $home; ?>"><?php echo $name; ?></a>
                <?php } ?>
                <?php } ?>
            </div>

            <div class="stiky-phones col-md-2">

                <?php if( $phone1 ) { ?>
                <button class="btn btn-link dropdown-toggle" data-toggle="dropdown">
                    <a href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone1)));?>"><?php echo html_entity_decode($phone1); ?></a>
                    <i class="fa fa-caret-down"></i>
                </button>
                <?php } ?>

                <?php if( $phone2 ) { ?>


                <ul class="dropdown-menu">

                    <li><a href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone2)));?>"><?php echo html_entity_decode($phone2); ?></a></li>

                    <?php if( $phone3 ) { ?>
                    <li><a href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone3)));?>"><?php echo html_entity_decode($phone3); ?></a></li>
                    <?php } ?>
                </ul>

                <?php } ?>
            </div>
            <div class="stiky-search col-md-5">
                <?php echo $search; ?>
            </div>
            <div class="stiky-icon-box col-md-1">
                <div id="top_icons_box-stiky">
                    <a id="unistor-stiky-wishlist-total" href="<?php echo $wishlist; ?>" title="<?php echo $text_wishlist_menu. ' ('.$unistor_wishlist_total.')'; ?>">
                        <i class="fa fa-heart"></i> <?php if( $unistor_wishlist_total > 0 ) { ?><span><?php echo $unistor_wishlist_total; ?></span><?php } ?>
                    </a>
                    <a id="unistor-stiky-compare-total" href="<?php echo $compare; ?>" title="<?php echo $text_compare_menu.' ('.$unistor_compare_total.')';?> ">
                        <i class="ns-clone"></i> <?php if( $unistor_compare_total > 0 ) { ?><span><?php echo $unistor_compare_total; ?></span><?php } ?>
                    </a>
                    <?php if ( false && $tracking) { ?>
                    <a href="/orders" id="unistor-order-view" title="<?php echo $text_order; ?>">
                        <?php echo $text_track_order; ?>
                    </a>
                    <?php } ?>
                    <a href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>">
                        <i class="fa fa-shopping-cart"></i> <?php if( $unistor_cart_total > 0 ) { ?><span><?php echo $unistor_cart_total; ?></span><?php } ?>
                    </a>
                </div>
            </div>
            <div class="stiky-cart col-md-2">
                <?php echo $cart; ?>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {


        /* StikyMenu Search */
        $('.stiky-search .search input[name=\'search\']').parent().find('.button-search').on('click', function() {
            url = $('base').attr('href') + 'index.php?route=product/search';

            var value = $('.stiky-search input[name=\'search\']').val();
            var filter_category2 = $('.stiky-search .category-list-title').data('categoryid');

            if (value) {
                url += '&search=' + encodeURIComponent(value);
                if (filter_category2) {
                    url += '&category_id='+filter_category2+'&sub_category=true';
                }
            }

            location = url;
        });
        $('.stiky-search .search input[name=\'search\']').on('keydown', function(e) {
            if (e.keyCode == 13) {
                $('.button-search').trigger('click');
            }
        });
        setTimeout(function () {
            $('#stiky_box .search').addClass('hidden')
        }, 50);

    });
</script>