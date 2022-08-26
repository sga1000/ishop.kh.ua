<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<?php $detect = new Mobile_Detect(); ?>
<head>

    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<meta name="facebook-domain-verification" content="2gjdprfar4ytv2wjt7xtr58wji6lw1" />
	
	<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests" />


    <meta name="theme-color" content="#317EFB"/>

    <title><?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?></title>
    <base href="<?php echo $base; ?>"/>
    <?php if ($description) { ?>
    <meta name="description" content="<?php echo $description; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
    <meta name="keywords" content="<?php echo $keywords; ?>"/>
    <?php } ?>
    <meta property="og:title" content="<?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="<?php echo $og_url; ?>"/>
    <?php if ($og_image) { ?>
    <meta property="og:image" content="<?php echo $og_image; ?>"/>
    <?php } else { ?>
    <meta property="og:image" content="<?php echo $logo; ?>"/>
    <?php } ?>
    <meta property="og:site_name" content="<?php echo $name; ?>"/>
    <?php if($use_wide_style) { ?>
    <!-- Use Widescreeen styles -->
    <?php } else { ?>
    <!-- Use regular styles -->
    <?php } ?>
    <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" ></script>
    <script src="catalog/view/theme/neoseo_unistor/javascript/jquery-ui.min.js" ></script>
    <link href="catalog/view/theme/neoseo_unistor/stylesheet/jquery-ui.css" rel="stylesheet" />
    <script src="catalog/view/theme/neoseo_unistor/javascript/jquery.ui.touch-punch.min.js" ></script>
    <link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
	
	<?php if ($main_stylesheet) { ?>
    <link href="catalog/view/theme/neoseo_unistor/stylesheet/<?php echo $main_stylesheet; ?>" rel="stylesheet" type="text/css" >
    <?php } ?>

    <!-- the mousewheel plugin - optional to provide mousewheel support -->
    <script src="catalog/view/theme/neoseo_unistor/javascript/jquery.mousewheel.min.js" ></script>

    <?php foreach ($styles as $style) { ?>
    <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>

    <?php foreach ($links as $link) { ?>
    <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>

    <script src="catalog/view/theme/neoseo_unistor/javascript/neoseo_unistor.js" ></script>

    <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" ></script>
    <?php } ?>

    <?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
    <?php } ?>

    <!-- NeoSeo Unistor - begin -->
    <script>window.column_count = '<?php echo $neoseo_unistor_column_count; ?>';</script>
    <!-- NeoSeo Unistor - end -->
    <!-- NeoSeo SEO Languages - begin -->
    <script>window.current_language = '<?php echo $current_language; ?>';</script>
    <!-- NeoSeo SEO Languages - begin -->

    <style>
        <?php echo $categories_style; ?>
    </style>
    <?php (!isset($detect)) ? $detected = false : $detected = $detect->isMobile(); ?>
	<!-- Google Tag Manager -->
	<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
	new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
	j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
	'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
	})(window,document,'script','dataLayer','GTM-MRFWRW7');</script>
	<!-- End Google Tag Manager -->
	<style>
     #logo-text {fill:black; font-size: 60px; font-family: Yanone; font-weight: 100;}
     #cellar, #arcs {stroke:red; stroke-width:10px; fill:none;}
  </style>
</head>

<body class="<?php echo $class; ?><?php if ($use_wide_style) echo ' fullwidth-theme'; ?><?php if ($detected) { ?> portable<?php } ?><?php if ($unistor_banner && $top_banner) { ?> has-banner<?php } ?>">
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-MRFWRW7"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
<!-- NeoSeo Informative Message - begin -->
<?php if($neoseo_informative_message_status && $neoseo_informative_message) { ?>
<div <?php echo $neoseo_informative_message_bg_color ? 'style="background-color:'.$neoseo_informative_message_bg_color.';"' : ''; ?> class="informative_message">
<?php echo $neoseo_informative_message; ?>
<?php if($neoseo_informative_message_show_close_button){ ?>
<div class="informative_close" >
    <button <?php echo $neoseo_informative_message_close_btn_color ? 'style="background-color:'.$neoseo_informative_message_close_btn_color.';"' : ''; ?> class="btn btn-primary" onclick="informerClose();"><?php echo $neoseo_informative_message_button; ?></button>
</div>
<?php } ?>
</div>
<?php } ?>
<script>
    function informerClose(){
        $('.informative_message').hide();
        $.ajax({
            'type': "POST",
            'url': "index.php?route=module/neoseo_informative_message/closeInformer",
            'data': {
                change_status: 1
            },
            'dataType': 'json',
            success: function (response) {
            }
        });
    };
</script>
<!-- NeoSeo Informative Message - end -->
<?php if (!$detected) { ?>
    <?php if($sticky_menu == 1 && $sticky_menu_items) { ?>
        <?php echo $sticky; ?>
    <?php } ?>
<?php } ?>

<?php if ($unistor_banner && $top_banner) { ?>
<div id='general-banner' style="background:<?php if ($top_banner_background) { echo $top_banner_background; } ?> url(<?php echo $unistor_banner;?>) center top no-repeat; <?php if ($top_banner_height) { echo "height: ".$top_banner_height."px;"; } ?>"><?php if ($top_banner_link) { ?><a href='<?php echo $top_banner_link; ?>'></a><?php } ?></div>
<?php } ?>
<?php if (!$detected) { ?>

<header class="box-shadow box-corner">
    <div class="header-top">
        <div class="header-top__navigation">
            <div class="container">
                <div class="top-links-container">
                    <div class="top-links-container_left">
                        <div class="compact-top-links">
                            <div class="header" data-toggle="collapse" data-target="#header__top--drop-links">
                                <i class="fa fa-bars" aria-hidden="true"></i>
                            </div>
                        </div>
                        <script>
                            $('.header').click(function () {
                                $('.dropdown-main-menu').toggleClass('dropdown-open', '');
                                $('.panel-body').parent().removeClass('in');
                            });

                        </script>
                        <div class="main-top-links dropdown main ">
                            <ul class="top-links-list list">
                                <?php foreach($top_menu_items as $item ) { ?>
                                <?php if ( count($item['children']) > 0 ) { ?>
                                <li class="dropdown top-links-list_item">
                                    <div class="dropdown <?php echo $item['top_icon_position']; ?>">
                                        <button data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="dropdown-toggle">
                                            <span><?php echo $item['name']; ?></span>
                                            <i class="fa fa-caret-down header-caret-down"></i>
                                        </button>
                                        <?php if ($item['icon']) { ?>
                                        <span class="top-icon"><img class="img-responsive" src="<?php echo $item['icon']; ?>" alt="<?php echo $item['icon']; ?>"></span>
                                        <?php } ?>
                                        <ul class="dropdown-menu dropdown-menu-right">
                                            <?php foreach ($item['children'] as $child) { ?>
                                            <li>
                                                <a class="dropdown-item" href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                                            </li>
                                            <?php } ?>
                                        </ul>
                                    </div>
                                </li>
                                <?php } else { ?>
                                <li class="top-links-list_item ">
                                        <span class="<?php echo $item['top_icon_position']; ?>">
                                              <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                                            <?php if ($item['icon']) { ?>
                                            <span class="top-icon"><img class="img-responsive" src="<?php echo $item['icon']; ?>" alt="<?php echo $item['icon']; ?>"></span>
                                            <?php } ?>
                                        </span>
                                </li>
                                <?php } ?>
                                <?php } ?>
                            </ul>
                        </div>
                        <script>
                            var parentWidth = $('.main').innerWidth();
                            var childWidth = 0;
                            $(".main .list > li").each(function(){
                                childWidth+=$(this).innerWidth();
                            });
                            var buttonWidth = $('.drop-list-button').width();
                            var itemWidth = $('.drop-list').children('li:first-child').width();
                            if ( childWidth > parentWidth) {
                                // Вставляем меню и кнопку
                                $('<div class="main-drop-list" data-ripple="#fff">\n' +
                                    '<div class="open-list-button">' +
                                    '<i class="fa fa-circle" aria-hidden="true"></i>\n' +
                                    '<i class="fa fa-circle" aria-hidden="true"></i>\n' +
                                    '<i class="fa fa-circle" aria-hidden="true"></i>\n' +
                                    '</div>' +
                                    '<div class="drop-main">' +
                                    '<ul class="drop-list">' +
                                    '</ul>' +
                                    '</div>' +
                                    '</div>' ).appendTo('.main');

                                do {
                                    var parent = 0;
                                    var child = 0;
                                    var buttonWidth = $('.drop-list-button').width();
                                    parent = $('.main').width();

                                    $(".main .list > li").each(function () {
                                        child += $(this).innerWidth();
                                    });


                                    if (child + buttonWidth > parent) {
                                        $('.main .list').children('li:last-child').prependTo('.drop-list');
                                    } else {
                                        break;
                                    }
                                } while (child + buttonWidth > parent)

                                $('.open-list-button').click(function () {
                                    $(this).toggleClass('open');
                                    $('.drop-main').toggleClass('open');
                                });
                            }
                        </script>
                    </div>
                    <div class="phones phones-top hidden-xs hidden-sm">
                    <div class="phones__list dropdown">
                        <a data-toggle="dropdown"  class="phones__link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone1)));?>">
                        <?php echo html_entity_decode($phone1); ?>
                        <?php if( $phone2 || $phone3 ) { ?>
                            <i class="fa fa-angle-down"></i>
                        <?php } ?>
                        </a>
                        
                        <?php if( $phone2 || $phone3 ) { ?>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                            <?php if( $phone2 ) { ?>
                            <li class="phones__item">
                                <a class="phones__link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone2)));?>"><?php echo html_entity_decode($phone2); ?></a>
                            </li>
                            <?php } ?>
                            <?php if( $phone3 ) { ?>
                            <li class="phones__item">
                                <a class="phones__link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone3)));?>"><?php echo html_entity_decode($phone3); ?></a>

                            </li>
                            <?php } ?>
                        </ul>
                        <?php } ?>
                    </div>
                </div>
                    <div class="top-links-container_center">
                    <?php if ($currency_status) { echo $currency; } ?>
                        <?php echo $language; ?>
                        <div class="top_icons_box">
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
                    <div class="top-links-container_right">
                        <?php if (!$logged) { ?>
                        <div class="admin-menu">
                            <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>">
                                <i class="fa fa-user"></i><span class="hidden-xs hidden-md"> <?php echo $text_account; ?></span>
                            </a>
                        </div>
                        <?php } else { ?>
                        <div class="admin-menu is-logged">
                            <ul class="list-inline" id="logged-box">
                                <li class="dropdown">
                                    <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown">
                                        <i class="fa fa-user"></i>
                                        <span class="hidden-xs hidden-md"> <?php echo $text_account; ?></span>
                                        <i class="fa fa-angle-down carets"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-right">
                                        <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                                        <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                                        <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist_menu; ?></a></li>
                                        <li><a href="<?php echo $compare; ?>"><?php echo $text_compare_menu; ?></a></li>
                                        <?php if ( 1 ) { ?>
                                        <li><a href="<?php echo $watched; ?>"><?php echo $text_watched; ?></a></li>
                                        <?php } ?>
                                        <li class='separate'></li>
                                        <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
                                    </ul>
                                </li>
                            </ul>
                            <script>$('body').addClass('user-logged');</script>
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
        <div id="header__top--drop-links" class="dropdown-main-menu collapse">
            <?php if (!$logged) { ?>
            <div  class="admin-menu text-right hidden-sm">
                <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>">
                    <i class="fa fa-user"></i><span><?php echo $text_account; ?></span>
                </a>
            </div>
            <?php } else { ?>
            <div class="admin-menu is-logged text-right hidden-sm">
                <ul class="list-inline" id="logged-box">
                    <li class="dropdown">
                        <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-user"></i><span><?php echo $text_account; ?></span> <i class="fa fa-angle-down carets"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-right">
                            <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                            <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist_menu; ?></a></li>
                            <li><a href="<?php echo $compare; ?>"><?php echo $text_compare_menu; ?></a></li>
                            <?php if ( 1 ) { ?>
                            <li><a href="<?php echo $watched; ?>"><?php echo $text_watched; ?></a></li>
                            <?php } ?>
                            <li class='separate'></li>
                            <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
                        </ul>
                    </li>
                </ul>
                <script>$('body').addClass('user-logged');</script>
            </div>
            <?php } ?>
            <div class="panel-group" id="accordion">
                <ul class="panel panel-default">
                    <?php foreach($top_menu_items as $item ) { ?>
                    <?php if ( count($item['children']) > 0 ) { ?>
                    <div class="panel-title dropdown-item">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseDropdownMenu<?php echo $item['pid']; ?>" >
                            <span><?php echo $item['name']; ?></span>
                            <i class="fa fa-caret-down header-caret-down"></i>
                        </a>
                    </div>
                    <?php } else { ?>
                    <li class="dropdown-item">
                        <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                    </li>
                    <?php } ?>
                    <?php } ?>
                </ul>
                <div id="collapseDropdownMenu<?php echo $item['pid']; ?>" class="panel-collapse collapse">
                    <div class="panel-body">
                        <?php foreach ($item['children'] as $child) { ?>
                        <div class="dropdown-list">
                            <a class="dropdown-item" href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                        </div>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="header-middle">
        <div class="container">
            <div class="header-middle__content <?php if ($menu_type == 'menu_vertical') { ?>vertical<?php } else { ?>horizontal<?php } ?>">

                <div class="logo-search <?php if ($menu_type == 'menu_vertical') { ?>vertical<?php } else { ?>horizontal<?php } ?>">
                    <div class="logo">
                        <div class="logo-container">
                            <?php if ( $logo || $unistor_logo ) { ?>
                            <?php if ($is_home) { ?>
							      <div class="band-name">
									<svg class="logo-name" width="185" height="60" title="<?php echo $name; ?>" alt="<?php echo $name; ?>">
									  <symbol id="logo-inside">
										<g id="cellar" transform="scale(0.155), translate(50, 50)">
										  <circle cx="100" cy="100" r="95"/>
										  <circle cx="100" cy="100" r="8" stroke-width="0" fill="black"/>
										  <circle cx="75" cy="75" r="8" stroke-width="0" fill="black"/>
										  <circle cx="100" cy="65" r="8" stroke-width="0" fill="black"/>
										  <circle cx="125" cy="75" r="8" stroke-width="0" fill="black"/>
										  <circle cx="75" cy="125" r="8" stroke-width="0" fill="black"/>
										  <circle cx="125" cy="125" r="8" stroke-width="0" fill="black"/>
										  <circle cx="100" cy="135" r="8" stroke-width="0" fill="black"/>
										  <circle cx="135" cy="100" r="8" stroke-width="0" fill="black"/>
										  <circle cx="65" cy="100" r="8" stroke-width="0" fill="black"/>
										  <g id="arcs-2">
										  <path d="M 45 85 Q 10 150, 45 215 M 85 45 Q 150 10, 215 45 M 255 85 Q 290 150, 255 215 M 85 255 Q 150 290, 215 255" transform="translate(-50, -50)"/>
										  </g>
										</g>
									  </symbol>
									  <g transform="translate(0,10)">
										<text id="logo-text" x="0" y="35">I</text>
										<text id="logo-text" x="25" y="35">S</text>
										<text id="logo-text" x="60" y="35">H</text>
										<text id="logo-text" x="150" y="35">P</text>
										<g transform="translate(103,-9)">
										  <use xlink:href="#logo-inside">
										</g>
									  </g>
									</svg>
								  </div> <!-- END links -->
                            <?php } else { ?>
                            <a href="<?php echo $home; ?>">
                                <div class="band-name">
									<svg class="logo-name" width="185" height="60" title="<?php echo $name; ?>" alt="<?php echo $name; ?>">
									  <symbol id="logo-inside">
										<g id="cellar" transform="scale(0.155), translate(50, 50)">
										  <circle cx="100" cy="100" r="95"/>
										  <circle cx="100" cy="100" r="8" stroke-width="0" fill="black"/>
										  <circle cx="75" cy="75" r="8" stroke-width="0" fill="black"/>
										  <circle cx="100" cy="65" r="8" stroke-width="0" fill="black"/>
										  <circle cx="125" cy="75" r="8" stroke-width="0" fill="black"/>
										  <circle cx="75" cy="125" r="8" stroke-width="0" fill="black"/>
										  <circle cx="125" cy="125" r="8" stroke-width="0" fill="black"/>
										  <circle cx="100" cy="135" r="8" stroke-width="0" fill="black"/>
										  <circle cx="135" cy="100" r="8" stroke-width="0" fill="black"/>
										  <circle cx="65" cy="100" r="8" stroke-width="0" fill="black"/>
										  <g id="arcs-2">
										  <path d="M 45 85 Q 10 150, 45 215 M 85 45 Q 150 10, 215 45 M 255 85 Q 290 150, 255 215 M 85 255 Q 150 290, 215 255" transform="translate(-50, -50)"/>
										  </g>
										</g>
									  </symbol>
									  <g transform="translate(0,10)">
										<text id="logo-text" x="0" y="35">I</text>
										<text id="logo-text" x="25" y="35">S</text>
										<text id="logo-text" x="60" y="35">H</text>
										<text id="logo-text" x="150" y="35">P</text>
										<g transform="translate(103,-9)">
										  <use xlink:href="#logo-inside">
										</g>
									  </g>
									</svg>
								  </div> <!-- END links -->
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

                    </div>

                    <div class="search-container hidden-xs">
                        <div class="worktime <?php if ($menu_type == 'menu_vertical') { ?>vertical<?php } ?>">
                            <i class="ns-clock-o" aria-hidden="true"></i>
                            <div class="worktime__list"><?php echo html_entity_decode($work_time); ?></div>
                            <?php if($neoseo_callback_status == 1){ ?>
                            <a href="#" class="phones__callback" onclick="showCallback();return false;">
                                <i class="ns-headphones-o"></i>
                                <span><?php echo $text_callback; ?></span>
                            </a>
                            <?php }?>
                        </div>


                        <?php if($menu_type == 'menu_horizontal' || $menu_type == 'menu_hybrid') { ?>
                        <div class="search">
                            <?php echo $search; ?>
                        </div>
                        <?php } else { ?>
                        <div class="search hidden-md hidden-lg">
                            <?php echo $search; ?>
                        </div>
                        <?php }?>
                        <?php  if ($recent_search[0] != '') { ?>
                        <div class="most-popular-search  <?php if ($menu_main_type) { ?> hidden-md hidden-lg <?php } ?>">
                            <?php foreach($recent_search as $result_search) { ?>
                            <a href="#"><?php echo $result_search; ?></a>
                            <?php } ?>
                        </div>
                        <?php } ?>
                    </div>
                </div>



                <div class="phones-cart <?php if ($menu_main_type) { ?>vertical<?php } else { ?>horizontal<?php } ?>">
                    <?php echo $cart; ?>
                </div>


            </div>

            <div class="header-middle__search visible-xs">
                <?php if(!$menu_main_type) { ?>
                <div class="search">
                    <?php echo $search; ?>
                </div>
                <?php } else { ?>
                <div class="search hidden-md hidden-lg">
                    <?php echo $search; ?>
                </div>
                <?php }?>

            </div>
        </div>
    </div>


</header>
<?php echo $menu; ?>

<?php } else { ?>

<?php echo $mobile_header; ?>

<?php } ?>


<?php if ($menu_type == 'menu_horizontal' ) { ?>
<div id="sticky-horizontal-menu-catalog" class="sticky-catalog-menu" style="width: 100%"></div>
<script>
    $('.stiky-catalog-toggle').on('click', function () {
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