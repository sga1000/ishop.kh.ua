<div class="main-vertical-menu hidden-sm hidden-xs">
    <div class="container">
        <div class="row">
            <div class="main-menu-top">
                <div class="main-menu-title col-md-3">

                    <h4 class="box-shadow box-corner"><i class="fa fa-bars" aria-hidden="true"></i><?php echo($text_menu_name); ?></h4>
                </div>
                <?php if($menu_main_type) { ?>
                <div class="main-menu-search col-md-9">
                    <div class="vertical-search">
                        <?php echo $search; ?>
                    </div>
                </div>
                <?php } ?>
            </div>
        </div>
        <div class="row">
            <div id="menuCategoryV" class="main-menu-category col-md-3" <?php if ($home != $og_url) { ?>style="margin: 0;"<?php } ?>>
            <div class="main-menu-category_list box-shadow box-corner dropmenu<?php if (($home == $og_url)) { echo ' open'; }?>">
                <?php foreach ($categories as $category) { ?>
                <div class="main-menu-category_item <?php echo ' menu-item-'.$category['pid'] ; ?>">
                    <div class="item-line">
                        <?php $category_name = $category['name']; ?>
                        <a href="<?php echo $category['href']; ?>" class="<?php echo $category['params'];  echo ' '.$category['class'].' '; if ($category['icon']) { echo $icon_position; } ?>" <?php if($category['style'] != '' ){ echo 'style="'.$category['style'].'" '; } ?>>
                        <span class="item-name"><?php echo $category_name; ?></span>
                        <?php
                                        if(($category['icon'] !='' )) {
                                            echo '<span class="ico-nav"><img src="'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                        }?>
                        </a>
                        <?php if ($category['children']) { ?>
                        <i class="ns-arrow-right" aria-hidden="true"></i><?php } ?>
                    </div>
                    <?php if ($category['children']) { ?>
                    <div class="sub-menu-list"
                    <?php if($category['image']){ ?>
                    style="background-image: url('<?php echo $category['image']; ?>'); <?php echo $category['style']; ?>"
                    <?php } ?>
                    >
                    <div class="shaded-before"></div>
                    <!-- Инфоблок для меню BEGIN -->
                    <?php if(isset($category['infoblock_status'])&&$category['infoblock_status'] == 1) { ?>
                    <div class="<?php echo $category['infoblock_main_class']; ?>" style="float: <?php echo $category['infoblock_position']; ?>;">
                        <div class="infoblock-title"><a href="<?php echo $category['infoblock_link']; ?>"><?php echo $category['infoblock_title']; ?></a></div>
                        <div class="infoblock-image"><a href="<?php echo $category['infoblock_link']; ?>"><img src="<?php echo $category['infoblock_image']; ?>" style="<?php ($category['infoblock_image_width']>0)?"width:'{$category['infoblock_image_width']};'":"";?><?php ($category['infoblock_image_height']>0)?"height:'{$category['infoblock_image_height']};'":"";?>"></a></div>
                        <?php if($category['infoblock_show_by_button'] == 1 && $category['infoblock_product_id'] > 0 ) { ?>
                        <div class="infoblock-by-btn"><button class="cart-add-button" type="button" onclick="cart.add('<?php echo $category['infoblock_product_id']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs"><?php echo $button_cart; ?></span></button></div>
                        <?php } ?>
                    </div>
                    <?php } ?>
                    <!-- Инфоблок для меню END -->
                    <?php foreach ($category['children'] as $child) { ?>
                    <?php if ($child['children']) { ?>
                    <div class="sub-child-menu-item">
                        <div class="sub-child-name" style="<?php echo $child['style']; ?>"><?php echo $child['name']; ?></div>
                        <?php if(($child['icon'] !='' )) { echo '<span class="ico-nav"><img src="'.$child['icon'].'" alt="'.$child['name'].'"></span>';} ?>
                        <?php foreach ($child['children'] as $child2) { ?>
                        <?php if ($child2['image']) { ?>
                        <a class="sub-child-menu-image"  href="<?php echo $child2['href']; ?>">
                            <img src="<?php echo $child2['image']; ?>" alt="<?php echo $child2['image']; ?>">
                        </a>
                        <?php } ?>
                        <a href="<?php echo $child2['href']; ?>" class="<?php echo $child2['params']; echo ' menu-item-'.$child2['pid'] ; echo ' '.$child2['class'].' '; ?>" <?php if($child2['style'] != '' ){ echo 'style="'.$child2['style'].'" '; } ?>>
                        <?php if(($child2['icon'] !='' )) {
                                                                echo '<span class="ico-second-child"><img src="'.$child2['icon'].'" alt="'.$child2['name'].'">'; } ?>

                        <span class="child-category"><?php echo $child2['name']; ?></span>
                        </a>
                        <?php if ($child2['children']) { ?>
                        <div class="sub-child2-menu-item">
                            <?php foreach ($child2['children'] as $child3) { ?>
                            <a href="<?php echo $child3['href']; ?>" class="<?php echo $child3['params']; echo ' menu-item-'.$child3['pid'] ; echo ' '.$child3['class'].' '; ?>" <?php if($child3['style'] != '' ){ echo 'style="'.$child3['style'].'" '; } ?> >
                            <?php echo $child3['name']; ?>
                            </a>
                            <?php } ?>
                            <span class="show-child-hidden"><?php echo $text_all_categories; ?> ()</span>

                            <div class="child-menu-list-hidden">

                                <?php foreach ($child2['children'] as $child3) { ?>
                                <a href="<?php echo $child3['href']; ?>" class="<?php echo $child3['params']; echo ' menu-item-'.$child3['pid'] ; echo ' '.$child3['class'].' '; ?>" <?php if($child3['style'] != '' ){ echo 'style="'.$child3['style'].'" '; } ?> >
                                <?php echo $child3['name']; ?>
                                </a>
                                <?php } ?>
                                <span class="hide-child-hidden child-hidden"><?php echo $text_hide; ?></span>
                            </div>
                        </div>
                        <?php } ?>
                        <?php } ?>
                    </div>
                    <?php } ?>

                    <?php } ?>
                    <?php if($category['image']){
                                            // Картинка в меню
                                            ?>

                    <?php if ($category['image_position'] == 'image_box') { ?>
                    <div class="mega-image" >
                        <a href="<?php echo $category['href']; ?>">
                            <img class="img-responsive" src="<?php echo $category['image']; ?>">
                        </a></div>
                    <?php } ?>

                    <?php }; ?>
                </div>
                <?php } ?>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
</div>
</div>
<script>

    function menuResize() {
        if ($(window).width() < 992) {
            $('#main-menu-catalog .single-menu-catalog__children > li').each(function () {
                if ($(this).children('#main-menu-catalog .single-menu-catalog__submenu').length) {
                    $(this).children('a').removeAttr('href');
                }
            });

            $('#main-menu-catalog .single-menu-catalog__children2 > li').each(function () {
                if ($(this).children('#main-menu-catalog .single-menu-catalog__children3').length) {
                    $(this).children('a').removeAttr('href');
                }
            });

            $('#main-menu-catalog .single-menu-catalog__children2 > li > a').on('click', function () {
                $(this).children('#main-menu-catalog  .children2-item-box').find('.fa').toggleClass('fa-angle-down fa-angle-up');
            });


        } else {
            $('#main-menu-catalog  .single-menu-catalog__submenu').css('width', ( $('#main-menu-catalog .single-menu-catalog__menu').width() - 265));
            $('#stiky_box   .single-menu-catalog__submenu').css('width', ( $('#stiky_box .container').width() - 265));

            $(window).resize(function () {
                $('#main-menu-catalog  .single-menu-catalog__submenu').css('width', ( $('#main-menu-catalog .single-menu-catalog__menu').width() - 265));
                $('#stiky_box  .single-menu-catalog__submenu').css('width', ( $('#stiky_box  .single-menu-catalog__menu').width() - 265));
            });
        }
    }


    $(document).ready( function () {
        verticalMenuNav('<?php echo $main_menu_category_quantity ?>');

        $('.common-home .main-menu-category_list').css('height', $('[data-slideshow]').height() + 20);
        menuResize();

        $('.stiky-catalog-toggle .dropdown-toggle').on('click', function () {
            $('.single-menu-catalog__children > li').removeClass('active');
            $('.single-menu-catalog__children > li').eq(0).addClass('active');
            menuResize();
            setTimeout(() => {
                verticalStikyMenuNav('<?php echo $main_menu_category_quantity ?>');
                $(this).parent().removeClass('open');
                $(this).parent().toggleClass('active');
            },10)
        });

        $('.stiky-catalog-toggle .single-menu-catalog__children > li').mouseenter(function () {
            $('.single-menu-catalog__children > li').removeClass('active');
            $(this).addClass('active');
        });

        $('.bg-img').each(function () {
            $(this).closest('.main-menu-category_item').addClass('bg-img');
        });

        $('.all-category-show').each(function () {
            $(this).closest('.main-menu-category_item').addClass('all-category-show');
        });

        $('.mozaic-mega-menu').each(function () {
            $(this).closest('.main-menu-category_item').addClass('mozaic-mega-menu');
        });

        $('.triple-mega-menu').each(function () {
            $(this).closest('.main-menu-category_item').addClass('triple-mega-menu');
        });

        $('.table-mega-menu').each(function () {
            $(this).closest('.main-menu-category_item').addClass('table-mega-menu');
        });

        $('.header-mega-menu').each(function () {
            $(this).closest('.main-menu-category_item').addClass('header-mega-menu');
        });

        $('.action-mega-menu').each(function () {
            $(this).closest('.main-menu-category_item').addClass('action-mega-menu');
        });

        $('.center-img-mega-menu').each(function () {
            $(this).closest('.main-menu-category_item').addClass('center-img-mega-menu');
        });

        $('.side-img-mega-menu').each(function () {
            $(this).closest('.main-menu-category_item').addClass('side-img-mega-menu');
        });

        $('.brand-name').each(function () {
            $(this).prev().addClass('brand-name');
        });

        $('.sub-child2-menu-item').each( function () {
            if ($(this).find('a.child-hidden').length > 0 ) {

                $(this).addClass('have-hidden');
                $(this).find('.show-child-hidden').html('Все категории ('+($(this).children('a').length)+')')
            }
        });

        $('.sub-menu-list .shaded-before').on('click', function(event) {
            $(this).closest('.sub-menu-list').find('.child-show-mode').removeClass('child-show-mode').closest('.show-mode').removeClass('show-mode');
            $(this).closest('.sub-menu-list').removeClass('shaded');
        });

        $('.all-category-show .show-child-hidden').on('click', function (event) {
            event.preventDefault();
            $(this).closest('.sub-child2-menu-item').addClass('child-show-mode').closest('.sub-child-menu-item').addClass('show-mode');
            $(this).closest('.sub-menu-list').addClass('shaded');
        });

        $('.hide-child-hidden').on('click', function () {
            $(this).closest('.child-show-mode').removeClass('child-show-mode').closest('.show-mode').removeClass('show-mode');
            $(this).closest('.sub-menu-list').removeClass('shaded');

        });

        $('.main-menu-category_item').hover(function () {

        }, function () {
            $(this).find('.shaded').removeClass('shaded').find('.child-show-mode').removeClass('child-show-mode').find('.show-mode').removeClass('show-mode');
        })
    })

    $(document).ready( function () {

        $('.all-category-show').each(function () {
            $(this).closest('.main-menu-category_item').addClass('all-category-show');
        });
        $('.sub-child2-menu-item').each( function () {
            if ($(this).find('a.child-hidden').length > 0 ) {

                $(this).addClass('have-hidden');
                $(this).find('.show-child-hidden').html('<?php echo $text_all_categories; ?> ('+($(this).children('a').length)+')')
            }
        });

        $('.sub-menu-list .shaded-before').on('click', function(event) {
            $(this).closest('.sub-menu-list').find('.child-show-mode').removeClass('child-show-mode').closest('.show-mode').removeClass('show-mode');
            $(this).closest('.sub-menu-list').removeClass('shaded');
        });

        $('.show-child-hidden').on('click', function (event) {
            event.preventDefault();
            $(this).closest('.sub-child2-menu-item').addClass('child-show-mode').closest('.sub-child-menu-item').addClass('show-mode');
            $(this).closest('.sub-menu-list').addClass('shaded');
        });

        $('.hide-child-hidden').on('click', function () {
            $(this).closest('.child-show-mode').removeClass('child-show-mode').closest('.show-mode').removeClass('show-mode');
            $(this).closest('.sub-menu-list').removeClass('shaded');

        });

        $('.main-menu-category_item').hover(function () {

        }, function () {
            $(this).find('.shaded').removeClass('shaded').find('.child-show-mode').removeClass('child-show-mode').find('.show-mode').removeClass('show-mode');
        })
    })

</script>
<?php if ($menu_main_type && $home != $og_url) { ?>
<script>



    $('.main-menu-title, .main-menu-category_list').hover(function () {
        $('.dropmenu').addClass('open');
    }, function () {
        $('.dropmenu').removeClass('open');
    });



</script>
<?php } ?>
