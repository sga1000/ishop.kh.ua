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
</head>

<body class="<?php echo $class; ?> <?php if ($use_wide_style) echo 'fullwidth-theme'; ?>">
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
        <div class="container header-top__box">
            <div class="header-top__information">
                <span><?php echo  $text_header_information; ?></span>
            </div>
            <ul class="header-top__menu">
                <?php foreach($top_menu_items as $item ) { ?>
                    <li>
                        <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                    </li>
                    <?php if ( count($item['children']) > 0 ) { ?>
                        <?php foreach ($item['children'] as $child) { ?>
                            <li>
                                <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                            </li>
                        <?php } ?>
                    <?php } ?>
                <?php } ?>
            </ul>
            <div class="header-top__user">
                <?php if (!$logged) { ?>
                <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>">
                    <?php echo $text_account; ?>
                </a>
                <?php } else { ?>
                <div class="admin-menu is-logged">
                    <ul class="list-inline" id="logged-box">
                        <li class="dropdown">
                            <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown">
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

    <div class="container header-middle__box">
        <div class="header-middle__worktime">
            <div class="header-middle__phones">
                <a data-toggle="dropdown"  class="phones__link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone1)));?>">
                    <?php echo html_entity_decode($phone1); ?>
                </a>
                <?php if( $phone2 || $phone3 ) { ?>
                    <?php if( $phone2 ) { ?>
                        <a class="phones__link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone2)));?>"><?php echo html_entity_decode($phone2); ?></a>
                    <?php } ?>
                <?php } ?>
            </div>
            <div class="header-middle__worktime-item">
                <div class="worktime__list"><?php echo html_entity_decode($work_time); ?></div>
            </div>

            <?php if($neoseo_callback_status == 1){ ?>
            <a href="#" class="header-middle__worktime-callback" onclick="showCallback();return false;">
                <span><?php echo $text_callback_2; ?></span>
            </a>
            <?php }?>
        </div>
        <div class="header-middle__logo">
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
        <div class="header-middle__cart">
            <?php echo  $cart; ?>
            <?php echo  $search; ?>
        </div>
    </div>


</header>
<?php echo $menu; ?>

<?php } else { ?>

<?php echo $mobile_header; ?>

<?php } ?>
