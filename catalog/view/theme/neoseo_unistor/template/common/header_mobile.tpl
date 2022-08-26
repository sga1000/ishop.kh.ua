
<div class="header-mobile">
    <div class="header-mobile__button-menu" onclick="mobileMenuToggle();return true;">
        <span></span>
        <span></span>
        <span></span>
    </div>
    <div class="header-mobile__logo">
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
        <h1><?php echo $name; ?></h1>
        <?php } else { ?>
        <a href="<?php echo $home; ?>"><?php echo $name; ?></a>
        <?php } ?>
        <?php } ?>
    </div>
    <div class="header-mobile__cart">
        <a class="header-mobile__cart-link" href="<?php echo $shopping_cart; ?>">
            <i class="fa fa-shopping-cart" aria-hidden="true"></i> <?php if( $unistor_cart_total > 0 ) { ?><span class="--total"><?php echo $unistor_cart_total; ?></span><?php } ?>
        </a>
    </div>
    <div class="header-mobile__search">
        <?php echo $search; ?>
    </div>
</div>

<div class="header-mobile-menu">
    <div class="header-mobile-menu__actions">
        <div class="header-mobile-menu__lang">
            <?php echo $language; ?>
        </div>
        <button class="header-mobile-menu__button-close" onclick="mobileMenuCatalogClose();return true;">
            <span></span>
            <span></span>
        </button>
    </div>
    <div class="header-mobile-menu__box">
        <?php if ($currency) { ?>
        <div class="header-mobile-menu__currency">
            <span><?php echo $text_currency_mobile; ?></span>
            <?php echo $currency; ?>
        </div>
        <?php } ?>
        <button class="header-mobile-menu__categories-button" onclick="mobileMenuCatalogShow()">
            <i class="fa fa-indent" aria-hidden="true"></i>
            <span><?php echo $text_menu_name; ?></span>
        </button>
        <div class="header-mobile-menu__quick-links">
            <a class="header-mobile-menu__account" href="<?php echo $account; ?>" title="<?php echo $text_account; ?>">
                <i class="fa fa-user"></i><span><?php echo $text_login; ?></span>
            </a>
            <a class="header-mobile-menu__wishlist" href="<?php echo $wishlist; ?>"title="<?php echo $text_wishlist_menu. ' ('.$unistor_wishlist_total.')'; ?>">
                <i class="fa fa-heart-o"></i>
                <span><?php echo $text_wishlist_mobile; ?><?php if( $unistor_wishlist_total > 0 ) { ?><span class="--total"><?php echo $unistor_wishlist_total; ?></span><?php } ?></span>
            </a>
            <a class="header-mobile-menu__compare" href="<?php echo $compare; ?>" title="<?php echo $text_compare_menu.' ('.$unistor_compare_total.')';?> ">
                <i class="fa fa-clone"></i>
                <span><?php echo $text_compare_mobile; ?><?php if( $unistor_compare_total > 0 ) { ?><span class="--total"><?php echo $unistor_compare_total; ?></span><?php } ?></span>

            </a>
            <a class="header-mobile-menu__cart" href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>">
                <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                <span><?php echo $text_cart_mobile; ?><?php if( $unistor_cart_total > 0 ) { ?><span class="--total"><?php echo $unistor_cart_total; ?></span><?php } ?></span>
            </a>
        </div>
        <ul class="header-mobile-menu__system-links">
            <?php foreach($top_menu_items as $item ) { ?>
            <li class="top-links-list_item ">
                <span class="<?php echo $item['top_icon_position']; ?>">
                    <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                    <?php if ($item['icon']) { ?>
                    <span class="-icon">
                        <img class="img-responsive" src="<?php echo $item['icon']; ?>" alt="<?php echo $item['icon']; ?>">
                    </span>
                    <?php } ?>
                </span>
            </li>
            <?php } ?>
        </ul>
        <div class="header-mobile-menu__phones">
            <a data-toggle="dropdown"  class="header-mobile-menu__phones-link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone1)));?>"><?php echo html_entity_decode($phone1); ?></a>
            <?php if( $phone2 ) { ?>
            <a class="header-mobile-menu__phones-link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone2)));?>"><?php echo html_entity_decode($phone2); ?></a>
            <?php } ?>

            <?php if( $phone3 ) { ?>
            <a class="header-mobile-menu__phones-link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone3)));?>"><?php echo html_entity_decode($phone3); ?></a>
            <?php } ?>
        </div>
        <?php if($neoseo_callback_status == 1){ ?>
        <a href="#" class="header-mobile-menu__callback" onclick="showCallback();return false;">
            <i class="ns-headphones-o"></i>
            <span><?php echo $text_callback; ?></span>
        </a>
        <?php }?>
    </div>

</div>
<div class="header-mobile-menu-bg"></div>
<div class="header-mobile-catalog">
    <?php
    // Построение с колоноками
    // Пропускаем один ряд пунктов меню
    if ($menu_main_type == 1) { ?>
    <ul class="header-mobile-catalog__list">
        <?php foreach ($categories as $category) {  ?>
        <?php if ($category['children']) { ?>
        <li class="header-mobile-catalog__list-item <?php echo $category['params']; echo ' '.$category['menu_params']; echo ' menu-item-'.$category['pid'] ; echo ' '.$category['icon_position'] ; echo ' '.$category['class'].' ';?>">
            <a class="header-mobile-catalog__list-link" <?php if ($category['href']) { ?>href="<?php echo $category['href']; ?>" <?php } ?> class="header-mobile-catalog__list-item <?php echo $category['params']; echo ' menu-item-'.$category['pid'] ; ?> <?php if ($category['icon'])  { echo $icon_position; }?>" <?php if($category['style'] != '' ){ ?> style="<?php echo $category['style'];?>" <?php } ?>>
            <?php if($category['icon'] !='') { ?>
            <span class="ico-nav">
                    <img src="<?php echo $category['icon']; ?>" alt="<?php echo $category['name']; ?>">
                </span>
            <?php } ?>
            <span class="item-name"><?php echo $category['name']; ?></span>
            </a>
            <span class="children-icon" onclick="childrenMenuToggle(this);return false;"><i class="fa fa-angle-down"></i></span>
            <div class="header-mobile-catalog__children-list">
                <ul class="list-unstyled">
                    <?php foreach ($category['children'] as $child) { ?>
                    <?php foreach ($child['children'] as $child2) { ?>
                    <li class="header-mobile-catalog__children-list-item">
                        <a class="header-mobile-catalog__children-list-link" href="<?php echo $child2['href']; ?>">
                            <?php echo $child2['name']; ?>
                        </a>
                        <?php if ($child2['children']) { ?>
                        <span class="children-icon" onclick="childrenMenuToggle(this);return false;"><i class="fa fa-angle-down"></i></span>
                        <?php } ?>
                        <?php if ($child2['children']) { ?>
                        <div class="header-mobile-catalog__children2-list">
                            <ul class="list-unstyled">
                                <?php foreach ($child2['children'] as $child3){ ?>
                                <li class="header-mobile-catalog__children2-list-item">
                                    <a class="header-mobile-catalog__children2-list-link" href=" <?php echo $child3['href']; ?>"> <?php echo $child3['name']; ?></a>
                                </li>
                                <?php } ?>
                            </ul>
                        </div>
                        <?php } ?>
                    </li>
                    <?php } ?>
                    <?php } ?>
                </ul>
            </div>
        </li>
        <?php } else { ?>
        <li class="<?php  echo ' menu-item-'.$category['pid']; echo ' '.$category['params']; echo ' '.$category['menu_params']; echo ' '.$category['icon_position'] ;  echo ' '.$category['class']; ?>">
            <a href="<?php echo $category['href']; ?>"
               class="menu-image-link <?php echo $category['params']; echo ' menu-item-'.$category['pid']; ?> <?php if ($category['icon'])  { echo $icon_position; }?>"
            <?php
                                                        if($category['style'] != '' ){
                                                            echo 'style="'.$category['style'].'" ';
                                                        }
                                                    ?> >

            <?php if(($category['icon_position'] == 'icons-pos-right') || ($category['icon_position'] == 'icons-pos-bottom')){

                                                                echo '<span class="item-name">'.$category['name'].'</span>';
            if(($category['icon'] !='' )) {
            echo '<span class="ico-nav"><img src="'.$category["icon"].'" alt="'.$category["name"].'"></span>';
            }
            } else {
            if(($category['icon'] !='' )) {
            echo '<span class="ico-nav"><img src="'.$category["icon"].'" alt="'.$category["name"].'"></span>';
            }

            echo '<span class="item-name">'.$category['name'].'</span>';
            } ;?>
            </a>
        </li>
        <?php } ?>
        <?php } ?>
    </ul>
    <?php }
    // Построение без колонок
    else { ?>
    <ul class="header-mobile-catalog__list">
        <?php foreach ($categories as $category) {  ?>
        <?php if ($category['children']) { ?>
        <li class="header-mobile-catalog__list-item <?php echo $category['params']; echo ' '.$category['menu_params']; echo ' menu-item-'.$category['pid'] ; echo ' '.$category['icon_position'] ; echo ' '.$category['class'].' ';?>">
            <a class="header-mobile-catalog__list-link" <?php if ($category['href']) { ?>href="<?php echo $category['href']; ?>" <?php } ?> class="header-mobile-catalog__list-item <?php echo $category['params']; echo ' menu-item-'.$category['pid'] ; ?> <?php if ($category['icon'])  { echo $icon_position; }?>" <?php if($category['style'] != '' ){ ?> style="<?php echo $category['style'];?>" <?php } ?>>
            <span class="item-name"><?php echo $category['name']; ?></span>
            </a>
            <span class="children-icon" onclick="childrenMenuToggle(this);return false;"><i class="fa fa-angle-down"></i></span>
            <div class="header-mobile-catalog__children-list">
                <ul class="list-unstyled">
                    <?php foreach ($category['children'] as $child) { ?>
                    <li class="header-mobile-catalog__children-list-item">
                        <a class="header-mobile-catalog__children-list-link" href="<?php echo $child['href']; ?>">
                            <?php echo $child['name']; ?>
                        </a>
                        <?php if ($child['children']) { ?>
                        <span class="children-icon" onclick="childrenMenuToggle(this);return false;"><i class="fa fa-angle-down"></i></span>
                        <?php } ?>
                        <?php if ($child['children']) { ?>
                        <div class="header-mobile-catalog__children2-list">
                            <ul class="list-unstyled">
                                <?php foreach ($child['children'] as $child2){ ?>
                                <li class="header-mobile-catalog__children2-list-item">
                                    <a class="header-mobile-catalog__children2-list-link" href=" <?php echo $child2['href']; ?>"> <?php echo $child2['name']; ?></a>
                                </li>
                                <?php } ?>
                            </ul>
                        </div>
                        <?php } ?>
                    </li>
                    <?php } ?>
                </ul>
            </div>
        </li>
        <?php } else { ?>
        <li class="<?php  echo ' menu-item-'.$category['pid']; echo ' '.$category['params']; echo ' '.$category['menu_params']; echo ' '.$category['icon_position'] ;  echo ' '.$category['class']; ?>">
            <a href="<?php echo $category['href']; ?>"
               class="menu-image-link <?php echo $category['params']; echo ' menu-item-'.$category['pid']; ?> <?php if ($category['icon'])  { echo $icon_position; }?>"
            <?php
                                                        if($category['style'] != '' ){
                                                            echo 'style="'.$category['style'].'" ';
                                                        }
                                                    ?> >

            <?php if(($category['icon_position'] == 'icons-pos-right') || ($category['icon_position'] == 'icons-pos-bottom')){

                                                                echo '<span class="item-name">'.$category['name'].'</span>';
            if(($category['icon'] !='' )) {
            echo '<span class="ico-nav"><img src="'.$category["icon"].'" alt="'.$category["name"].'"></span>';
            }
            } else {
            if(($category['icon'] !='' )) {
            echo '<span class="ico-nav"><img src="'.$category["icon"].'" alt="'.$category["name"].'"></span>';
            }

            echo '<span class="item-name">'.$category['name'].'</span>';
            } ;?>
            </a>
        </li>
        <?php } ?>
        <?php } ?>
    </ul>
    <?php } ?>
</div>
<script>

    $(window).bind('scroll', function() {
        if ($(window).scrollTop() >= 150) {
            $('.header-mobile__search').addClass('active')
        } else {
            $('.header-mobile__search').removeClass('active');
        }
    });

    function mobileMenuToggle() {
        $('.header-mobile-menu').toggleClass('active');
        $('body').toggleClass('mobile-menu-active');
        $('.header-mobile-catalog').removeClass('active');
        if ($(window).scrollTop() < 151) {
            $('.header-mobile__search').removeClass('active');
        }

    }

    function childrenMenuToggle(object) {
        $(object).next().slideToggle();
        $(object).children('.fa').toggleClass('fa-angle-down fa-angle-up');
    }

    function mobileMenuCatalogShow() {
        $('.header-mobile-menu').removeClass('active');
        $('.header-mobile-catalog').addClass('active');
        $('.header-mobile__search').addClass('active');
        $('.header-mobile-menu__button-close').addClass('active');
    }

    function mobileMenuCatalogClose() {
        $('.header-mobile-menu').removeClass('active');
        $('.header-mobile-catalog').removeClass('active');
        $('body').removeClass('mobile-menu-active');
        $('.header-mobile-menu__button-close').removeClass('active');
        if ($(window).scrollTop() < 151) {
            $('.header-mobile__search').removeClass('active');
        }
    }


</script>
