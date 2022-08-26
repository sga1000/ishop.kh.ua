<div id="stiky_box" class="sticky-catalog-box">
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
            <div class="stiky-catalog-toggle col-md-2">
                <button class="dropdown-toggle" data-toggle="dropdown">
                    <i class="fa fa-bars" aria-hidden="true"></i>
                    <i class="fa fa-close" aria-hidden="true"></i>
                    <span><?php echo $text_menu; ?></span>
                </button>
                <?php if ($menu_type == 'menu_hybrid' ) { ?>
                <div id="sticky-single-menu-catalog" class="sticky-catalog-menu"></div>
                <script>
                    $('.stiky-catalog-toggle .dropdown-toggle').on('click', function () {
                        //console.log('toggle');                      
                        if (!$('.sticky-catalog-menu').children().length) {
                            $('.single-menu-catalog__children').clone().appendTo('.sticky-catalog-menu');
                        }
                    });

                    $('#sticky-single-menu-catalog').on('click', '.popup-link', function (e) {
                        e.stopPropagation(); // This replace if conditional.
                        let mainParent = $(this).parents('.single-menu-catalog__submenu');
                        let parentUl = $(this).parents('.single-menu-catalog__children3');

                        mainParent.find('.popup-hidden-bg').fadeIn(300);
                        parentUl.find('.popup-child').fadeIn(300);
                    }); 

                    $('#sticky-single-menu-catalog').on('click', '.popup-child .popup-link', function (e) {                  
                      e.stopPropagation(); 
                      $('.popup-hidden-bg').fadeOut(300);
                      $('.popup-child').fadeOut(300);
                    });
                  
                    $('#sticky-single-menu-catalog').on('click', '.popup-hidden-bg', function() {
                        $('.popup-hidden-bg').fadeOut(300);
                        $('.popup-child').fadeOut(300); 
                    });                   
                </script>
                <?php } ?>
                <?php if ($menu_type == 'menu_vertical' ) { ?>
                <div id="sticky-vertical-menu-catalog" class="sticky-catalog-menu main-vertical-menu"></div>
                <script>
                    $('.stiky-catalog-toggle .dropdown-toggle').on('click', function () {
                        if (!$('.sticky-catalog-menu').children().length) {
                            $('.main-menu-category_list').clone().appendTo('.sticky-catalog-menu');
                        }
                    });
                  
                    $('#sticky-single-menu-catalog').on('click', '.popup-link', function (e) {
                        e.stopPropagation(); // This replace if conditional.
                        let mainParent = $(this).parents('.single-menu-catalog__submenu');
                        let parentUl = $(this).parents('.single-menu-catalog__children3');

                        mainParent.find('.popup-hidden-bg').fadeIn(300);
                        parentUl.find('.popup-child').fadeIn(300);
                    }); 

                    $('#sticky-single-menu-catalog').on('click', '.popup-child .popup-link', function (e) {                  
                      e.stopPropagation(); 
                      $('.popup-hidden-bg').fadeOut(300);
                      $('.popup-child').fadeOut(300);
                    }); 
                  
                    $('#sticky-single-menu-catalog').on('click', '.popup-hidden-bg', function() {
                        $('.popup-hidden-bg').fadeOut(300);
                        $('.popup-child').fadeOut(300);   
                    });                   
                </script>
                <?php } ?>
            </div>
            <div class="stiky-search col-md-5 col-lg-5">
                <?php echo $search; ?>
            </div>
            <div class="stiky-icon-box col-md-2 col-lg-1">
                <div id="top_icons_box-stiky">
                    <a href="<?php echo $wishlist; ?>" class="unistor-wishlist-total" title="<?php echo $text_wishlist_menu. ' ('.$unistor_wishlist_total.')'; ?>">
                        <i class="fa fa-heart"></i> <?php if( $unistor_wishlist_total > 0 ) { ?><span><?php echo $unistor_wishlist_total; ?></span><?php } ?>
                    </a>
                    <a href="<?php echo $compare; ?>" id="unistor-compare-total" title="<?php echo $text_compare_menu.' ('.$unistor_compare_total.')';?> ">
                        <i class="ns-clone"></i> <?php if( $unistor_compare_total > 0 ) { ?><span><?php echo $unistor_compare_total; ?></span><?php } ?>
                    </a>
                    <?php if ( false && $tracking) { ?>
                    <a href="/orders" id="unistor-order-view" title="<?php echo $text_order; ?>">
                        <?php echo $text_track_order; ?>
                    </a>
                    <?php } ?>
                    <a href="<?php echo $shopping_cart; ?>" id="unistor-cart-total" title="<?php echo $text_shopping_cart; ?>">
                        <i class="fa fa-shopping-cart"></i> <?php if( $unistor_cart_total > 0 ) { ?><span><?php echo $unistor_cart_total; ?></span><?php } ?>
                    </a>
                </div>
            </div>
            <div class="stiky-cart col-md-2">
                <?php echo $cart; ?>
            </div>
        </div>
    </div>
    <?php if ($menu_type == 'menu_horizontal' ) { ?>
    <div id="sticky-horizontal-menu-catalog" class="sticky-catalog-menu" style="width: 100%"></div>
    <script>
        $('.stiky-catalog-toggle .dropdown-toggle').on('click', function () {
            if (!$('.sticky-catalog-menu').children().length) {
                $('.menu_full_width').clone().appendTo('.sticky-catalog-menu');
            }
            setTimeout(() => {
                if ($(this).hasClass('open')) {
                    $('.sticky-catalog-menu .main-menu').show();
                } else {
                    $('.sticky-catalog-menu .main-menu').hide();
                }
            },50);

        });
    </script>
    <?php } ?>
</div>

