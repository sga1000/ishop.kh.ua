<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
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
	<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js"></script>
	<script src="catalog/view/theme/neoseo_unistor/javascript/jquery-ui.min.js"></script>
	<link href="catalog/view/theme/neoseo_unistor/stylesheet/jquery-ui.css" rel="stylesheet"/>
	<script src="catalog/view/theme/neoseo_unistor/javascript/jquery.ui.touch-punch.min.js"></script>
	<link href="catalog/view/javascript/bootstrap/css/bootstrap.css" rel="stylesheet" media="screen"/>
	<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js"></script>
	<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

	<?php if ($main_stylesheet) { ?>
    <link href="catalog/view/theme/neoseo_unistor/stylesheet/<?php echo $main_stylesheet; ?>" rel="stylesheet" type="text/css">
	<?php } ?>

	<!-- the mousewheel plugin - optional to provide mousewheel support -->
	<script src="catalog/view/theme/neoseo_unistor/javascript/jquery.mousewheel.min.js"></script>

<?php foreach ($styles as $style) { ?>
	<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>"/>
<?php } ?>

<?php foreach ($links as $link) { ?>
	<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>"/>
<?php } ?>

	<script src="catalog/view/theme/neoseo_unistor/javascript/neoseo_unistor.js"></script>

<?php foreach ($scripts as $script) { ?>
	<script src="<?php echo $script; ?>"></script>
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

</head>

<body class="<?php echo $class; ?>">
    <!-- NeoSeo Informative Message - begin -->
    <?php if($neoseo_informative_message_status && $neoseo_informative_message) { ?>
    <div <?php echo $neoseo_informative_message_bg_color ? 'style="background-color:'.$neoseo_informative_message_bg_color.';"' : ''; ?> class="informative_message">
    	<?php echo $neoseo_informative_message; ?>
    	<?php if($neoseo_informative_message_show_close_button){ ?>
			<div class="informative_close" style="float: right;position: absolute;z-index: 20;top: 10px;right: 10px;">
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

<?php if($sticky_menu == 1 && $sticky_menu_items) { ?>
<?php if (!$sticky_menu_type) { ?>
<div id="stiky_box">
    <div class="container">
        <div class="row">
            <div class="stiky-logo col-md-2">
                    <?php if ( $logo || $unistor_logo ) { ?>
                    <?php if ($home == $og_url) { ?>
                    <img src="<?php echo $unistor_logo ? $unistor_logo : $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" width="<?php echo $logo_sizes[0]; ?>" height="<?php echo $logo_sizes[1]; ?>"/>
                    <?php } else { ?>
                    <a href="<?php echo $home; ?>">
                        <img src="<?php echo $unistor_logo ? $unistor_logo : $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" width="<?php echo $logo_sizes[0]; ?>" height="<?php echo $logo_sizes[1]; ?>">
                    </a>
                    <?php } ?>
                    <?php } else { ?>
                    <?php if ($home == $og_url) { ?>
                    <h3><?php echo $name; ?></h3>
                    <?php } else { ?>
                    <a href="<?php echo $home; ?>"><?php echo $name; ?></a>
                    <?php } ?>
                    <?php } ?>
            </div>
            <!-- <div class="stiky-phones col-md-2">
                <ul class="list-unstyled text-center">
                    <?php if( $phone1 ) { ?>
                    <li><a href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone1)));?>"><?php echo html_entity_decode($phone1); ?></a></li>
                    <?php } ?>

                    <?php if( $phone2 ) { ?>
                    <li><a href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone2)));?>"><?php echo html_entity_decode($phone2); ?></a></li>
                    <?php } ?>

                    <?php if( $phone3 ) { ?>
                    <li><a href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone3)));?>"><?php echo html_entity_decode($phone3); ?></a></li>
                    <?php } ?>
                </ul>
            </div> -->

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
    <?php } else { ?>
    <div id="stiky_box" class="sticky-catalog-box">
        <div class="container">
            <div class="row">
                <div class="stiky-catalog-toggle col-md-1">
                    <button class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-bars" aria-hidden="true"></i>
                        <i class="fa fa-close" aria-hidden="true"></i>
                    </button>
                    <div class="dropdown-menu">
                        <div class="container">
                            <?php if (!$menu_main_type) { ?>
                            <!-- ЛИПКОЕ МЕНЮ - НАЧАЛО ГОРИЗОНТАЛЬНОГО МЕНЮ -->

                            <div class="sticky-menu-catalog">
                                <div class="<?php echo $menu_class; ?>">
                                  <div class="main-menu box-shadow">
                                    <div class="container">
                                      <nav id="menu" class="navbar
                                              <?php
                                                if($menu_main_type == 1) {
                                                  echo 'vertical-menu ';
                                                } else {
                                                  echo 'gorizontal-menu ';
                                                }
                                              ?> ">
                                        <div class="navbar-header">
                                          <button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse"
                                              data-target=".navbar-ex1-collapse">
                                            <i class="fa fa-bars"></i>
                                          </button>
                                          <span id="category" class="visible-xs" data-toggle="collapse"
                                              data-target=".navbar-ex1-collapse"><?php echo $text_category; ?></span>
                                          <button type="button" id="ocfilter-button" class="btn btn-navbar navbar-toggle hidden-xs visible-xs"
                                              onclick="toggleFilter();">
                                            <i class="fa fa-filter"></i>
                                          </button>
                                        </div>
                                        <div class="collapse navbar-collapse navbar-ex1-collapse">
                                          <ul class="nav navbar-nav">
                                            <?php foreach ($categories as $category) {  ?>
                                            <?php if ($category['children']) { ?>
                                            <li class="dropdown <?php echo $category['params']; echo ' '.$category['menu_params']; echo ' menu-item-'.$category['pid'] ; echo ' '.$category['icon_position'] ; echo ' '.$category['class'].' ';?>">
                                
                                
                                              <a href="<?php echo $category['href']; ?>"
                                                 class="menu-image-link dropdown-toggle <?php echo $category['params']; echo ' menu-item-'.$category['pid'] ; ?> <?php if ($category['icon'])  { echo $icon_position; }?>"
                                              <?php
                                                        if($category['style'] != '' ){
                                                          echo 'style="'.$category['style'].'" ';
                                                        }
                                                      ?> data-toggle="dropdown">
                                
                                                            <script>
                                
                                                                $(function () {
                                
                                                                    $('.menu-image-link').each(function () {
                                                                       if ($(this).attr('href') == '') {
                                                                           $(this).attr('href','javascript.void(0)');
                                                                       }
                                                                    });
                                
                                                                });
                                
                                                            </script>
                                
                                              <?php if(($category['icon_position'] == 'icons-pos-right') || ($category['icon_position'] == 'icons-pos-bottom')){
                                
                                                        echo '<span class="item-name">'.$category['name'].'</span>';
                                              if(($category['icon'] !='' )) {
                                              echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                                              }
                                              } else {
                                              if(($category['icon'] !='' )) {
                                              echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                                              }
                                
                                              echo '<span class="item-name">'.$category['name'].'</span>';
                                              } ;?>
                                
                                              </a>
                                
                                              <div class="dropdown-menu <?php echo $category['params']; ?>">
                                                <div class="dropdown-inner <?php if($category['image']){ echo 'image-menu'; }?>">
                                                  <?php $items = 0; $automenu = ( strpos($category['params'],'auto') !== false ); ?>
                                                  <ul class="list-unstyled">
                                                    <?php foreach ($category['children'] as $child) {
                                                          if( $automenu ) {
                                                            if( $items == 0 ) {
                                                              echo "<li class=\"menu-group\">
                                                    <ul class=\"list-unstyled\">\n";
                                                      }
                                                      if( $items > 0 && $items % 6 == 0 ) {
                                                      echo "
                                                    </ul>
                                                    </li>
                                                    <li class=\"menu-group\">
                                                      <ul class=\"list-unstyled\">";
                                                        }
                                                        $items++;
                                                        } ?>
                                                        <li class="<?php
                                                                  if( $child['children'] ) {
                                                                    echo' menu-group';
                                                                  }else{
                                                                    echo' menu-alone';
                                                                  }
                                                                  echo ' '.$child['params']; echo ' '.$child['menu_params']; echo ' '.$child['class'];
                                                                ?>">
                                                          <?php if( trim($child['name']) ) { ?>
                                                          <a href="<?php echo $child['href']; ?>"
                                                             class="<?php echo $child['params'];  echo ' menu-item-'.$child['pid'];?>"
                                                          <?php
                                                                  if($child['style'] != '' ){
                                                                    echo 'style="'.$child['style'].'" ';
                                                                  }
                                                                ?>  >
                                
                                                          <?php if(($child['icon'] !='' )) {
                                                                  echo '<span class="ico-first-child"><img
                                                              src="../image/'.$child["icon"].'"
                                                          alt="'.$child["name"].'"></span>';
                                                          }?>
                                
                                                          <span> <?php echo $child['name']; ?> </span>
                                                          </a>
                                
                                                          <?php } ?>
                                                          <?php if( count($child['children']) > 0 ) { ?>
                                                          <ul class="list-unstyled">
                                                            <?php foreach ($child['children'] as $subchild) { ?>
                                                            <li class="<?php echo ' '.$subchild['params']; echo ' '.$subchild['menu_params']; echo ' '.$subchild['class'];
                                
                                                                          if( count($subchild['children']) > 0 ) {
                                                                            echo ' popup-wraper';
                                                                          }
                                
                                                                          ?>">
                                                              <a href="<?php echo $subchild['href']; ?>"
                                                                 class="dropdown-item <?php if( $subchild['children'] ) { ?>has-popup-menu<?php } echo ' menu-item-'.$subchild['pid'];  ?> "
                                                              <?php
                                                                          if($subchild['style'] != '' ){
                                                                            echo 'style="'.$subchild['style'].'" ';
                                                                          }
                                                                        ?> >
                                
                                                              <?php
                                                                          if(($subchild['icon'] !='' )) {
                                                                            echo '<span class="ico-second-child">
                                                              <img src="../image/'.$subchild["icon"].'"
                                                              alt="'.$subchild["name"].'"></span>';
                                                              }
                                                              ?>
                                                              <span> <?php echo $subchild['name']; ?> </span>
                                                              </a>
                                                              <?php if( count($subchild['children']) > 0 ) { ?>
                                                              <div class="popup-menu">
                                                                <ul class="list-unstyled">
                                                                  <?php foreach( $subchild['children'] as $subchildren ) { ?>
                                                                  <li class="<?php  echo ' '.$subchildren['menu_params']; echo ' '.$subchildren['menu_params'];  echo ' '.$subchildren['class']; ?>">
                                                                    <a href="<?php echo $subchildren['href']; ?>"
                                                                       class="<?php echo $subchildren['params']; echo ' menu-item-'.$subchildren['pid']; ?>"
                                                                    <?php
                                                                                    if($subchildren['style'] != '' ){
                                                                                      echo 'style="'.$subchildren['style'].'" ';
                                                                                    }
                                                                                  ?>>
                                                                    <?php echo $subchildren['name']; ?>
                                                                    </a>
                                                                  </li>
                                                                  <?php } ?>
                                                                </ul>
                                                              </div>
                                                              <?php } ?>
                                                            </li>
                                                            <?php } ?>
                                                          </ul>
                                                          <?php } ?>
                                                        </li>
                                                        <?php } ?>
                                                        <?php
                                                          if( $automenu ) {
                                                            if( $items != 0 ) {
                                                              echo "</ul></li>\n";
                                                        }
                                                        }
                                                        ?>
                                                      </ul>
                                                                            <?php if($category['image']){
                                                        // Картинка в меню
                                                        ?>
                                
                                                                        <div class="mega-image" >
                                                                            <a class="mega-image-link" href="<?php echo $category['href']; ?>">
                                                                                <img class="img-responsive" src="<?php echo $category['image']; ?>">
                                                                            </a>
                                                                        </div>
                                
                                                                        <?php }; ?>
                                                </div>
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
                                              echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                                              }
                                              } else {
                                              if(($category['icon'] !='' )) {
                                              echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                                              }
                                
                                              echo '<span class="item-name">'.$category['name'].'</span>';
                                              } ;?>
                                              </a>
                                            </li>
                                            <?php } ?>
                                            <?php  } ?>
                                          </ul>
                                        </div>
                                      </nav>
                                    </div>
                                  </div>
                                </div>
                            </div>

                            <!-- ЛИПКОЕ МЕНЮ - КОНЕЦ ГОРИЗОНТАЛЬНОГО МЕНЮ -->
                            <?php } else  { ?>

                            <div class="block-flex">

                                <!-- ЛИПКОЕ МЕНЮ - НАЧАЛО ВЕРТИКАЛЬНОГО МЕНЮ -->
                                <div class="main-vertical-menu">
                                    <div class="main-menu-title stiky-catalog">
                                        <i class="fa fa-bars" aria-hidden="true"></i>
                                        <span><?php echo($text_menu_name); ?></span>
                                    
                                         <div id="stickyCategoryV" class="main-menu-category col-md-3">
                                            <div class="main-menu-category_list box-shadow box-corner dropmenu<?php if (($home == $og_url)) { echo ' open'; }?>">
                    <?php foreach ($categories as $category) { ?>
                    <div class="main-menu-category_item <?php echo ' menu-item-'.$category['pid'] ; ?>">
                        <div class="item-line">
                            <?php $category_name = $category['name']; ?>
                            <a href="<?php echo $category['href']; ?>" class="<?php echo $category['params'];  echo ' '.$category['class'].' '; if ($category['icon']) { echo $icon_position; } ?>" <?php if($category['style'] != '' ){ echo 'style="'.$category['style'].'" '; } ?>>
                            <span class="item-name"><?php echo $category_name; ?></span>
                            <?php
                                    if(($category['icon'] !='' )) {
                                    echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
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
                            <?php foreach ($category['children'] as $child) { ?>
                            <?php if ($child['children']) { ?>
                            <div class="sub-child-menu-item">
                                <div class="sub-child-name" style="<?php echo $child['style']; ?>"><?php echo $child['name']; ?></div>
                                <?php if(($child['icon'] !='' )) { echo '<span class="ico-nav"><img src="../image/'.$child['icon'].'" alt="'.$child['name'].'"></span>';} ?>
                                <?php foreach ($child['children'] as $child2) { ?>
                                <?php if ($child2['image']) { ?>
                                <a class="sub-child-menu-image"  href="<?php echo $child2['href']; ?>">
                                    <img src="<?php echo $child2['image']; ?>" alt="<?php echo $child2['image']; ?>">
                                </a>
                                <?php } ?>
                                <a href="<?php echo $child2['href']; ?>" class="<?php echo $child2['params']; echo ' menu-item-'.$child2['pid'] ; echo ' '.$child2['class'].' '; ?>" <?php if($child2['style'] != '' ){ echo 'style="'.$child2['style'].'" '; } ?>>
                                <?php if(($child2['icon'] !='' )) {
                                    echo '<span class="ico-second-child"><img src="../image/'.$child2['icon'].'" alt="'.$child2['name'].'">'; } ?>

                                <span class="child-category"><?php echo $child2['name']; ?></span>
                                </a>
                                <?php if ($child2['children']) { ?>
                                <div class="sub-child2-menu-item">
                                    <?php foreach ($child2['children'] as $child3) { ?>
                                    <a href="<?php echo $child3['href']; ?>" class="<?php echo $child3['params']; echo ' menu-item-'.$child3['pid'] ; echo ' '.$child3['class'].' '; ?>" <?php if($child3['style'] != '' ){ echo 'style="'.$child3['style'].'" '; } ?> >
                                    <?php echo $child3['name']; ?>
                                    </a>
                                    <?php } ?>
                                </div>
                                <?php } ?>
                                <?php } ?>

                                <span class="show-child-hidden">Все категории ()</span>

                                <div class="child-menu-list-hidden">
                                    <div class="sub-child-name"><?php echo $child['name']; ?></div>
                                    <?php if(($child['icon'] !='' )) { echo '<span class="ico-nav"><img src="../image/'.$child['icon'].'" alt="'.$child['name'].'"></span>';} ?>
                                    <?php foreach ($child['children'] as $child2) { ?>
                                    <?php if ($child2['image']) { ?>
                                    <a class="sub-child-menu-image"  href="<?php echo $child2['href']; ?>">
                                        <img src="<?php echo $child2['image']; ?>" alt="<?php echo $child2['image']; ?>">
                                    </a>
                                    <?php } ?>
                                    <a href="<?php echo $child2['href']; ?>" class="<?php echo $child2['params']; echo ' menu-item-'.$child2['pid'] ; echo ' '.$child2['class'].' '; ?>" <?php if($child2['style'] != '' ){ echo 'style="'.$child2['style'].'" '; } ?>>
                                    <?php if(($child2['icon'] !='' )) {
                                        echo '<span class="ico-second-child"><img src="../image/'.$child2['icon'].'" alt="'.$child2['name'].'">'; } ?>

                                    <span class="child-category"><?php echo $child2['name']; ?></span>
                                    </a>
                                    <?php if ($child2['children']) { ?>
                                    <div class="sub-child2-menu-item">
                                        <?php foreach ($child2['children'] as $child3) { ?>
                                        <a href="<?php echo $child3['href']; ?>" class="<?php echo $child3['params']; echo ' menu-item-'.$child3['pid'] ; echo ' '.$child3['class'].' '; ?>" <?php if($child3['style'] != '' ){ echo 'style="'.$child3['style'].'" '; } ?> >
                                        <?php echo $child3['name']; ?>
                                        </a>
                                        <?php } ?>
                                    </div>
                                    <?php } ?>
                                    <?php } ?>

                                    <span class="hide-child-hidden child-hidden">Скрыть</span>
                                </div>

                            </div>
                            <?php } ?>

                            <?php } ?>
                            <?php if($category['image']){
                        // Картинка в меню
                        ?>

                            <div class="mega-image" >
                                <a href="<?php echo $category['href']; ?>">
                                    <img class="img-responsive" src="<?php echo $category['image']; ?>">
                                </a>
                            </div>
                            
                            <?php }; ?>
                        </div>
                        <?php } ?>
                    </div>
                    <?php } ?>
                </div>
                                           
                                        </div>
                                    
                                    </div>

                                    <script>

                                        $('.stiky-catalog-toggle .main-menu-title, .stiky-catalog-toggle .main-menu-category_list').hover(function () {
                                            $('#stickyCategoryV .dropmenu').addClass('open');
                                        }, function () {
                                            $('#stickyCategoryV .dropmenu').removeClass('open');
                                        });

                                    </script>
                                </div>

                                <?php if ($menu_main_type) { ?>

                                <!-- ЕСЛИ ВЕРТИКАЛЬНОЕ МЕНЮ, ТО ВЫВОДИМ И ВЕРХНЕЕ РЯДОМ С КАТАЛОГОМ-->
                                <div class="stiky-menu col-md-5">
                                    <div id="top-links" class=" dropdown">
                                        <ul class="list-inline">
                                            <?php foreach($sticky_menu_items as $item ) { ?>
                                            <?php if ( count($item['children']) > 0 ) { ?>
                                            <li class="dropdown">
                                                <div class="dropdown">
                                                    <a href="<?php echo $item['href']; ?>" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="dropdown-toggle"><span><?php echo $item['name']; ?></span><i class="fa fa-caret-down header-caret-down"></i></a>
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
                                            <li>
                                                <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                                            </li>
                                            <?php } ?>
                                            <?php } ?>
                                        </ul>
                                    </div>
                                </div>
                                <!-- КОНЕЦ ВЕРХНЕГО МЕНЮ  -->
                                <?php } ?>
                                <!-- ЛИПКОЕ МЕНЮ - КОНЕЦ ВЕРТИКАЛЬНОГО МЕНЮ -->
                            </div>
                            <?php } ?>
                        </div>
                    </div>
                </div>
                <div class="stiky-logo col-md-2">
                    <?php if ( $logo || $unistor_logo ) { ?>
                        <?php if ($home == $og_url) { ?>
                            <img src="<?php echo $unistor_logo ? $unistor_logo : $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" width="<?php echo $logo_sizes[0]; ?>" height="<?php echo $logo_sizes[1]; ?>"/>
                        <?php } else { ?>
                        <a href="<?php echo $home; ?>">
                            <img src="<?php echo $unistor_logo ? $unistor_logo : $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" width="<?php echo $logo_sizes[0]; ?>" height="<?php echo $logo_sizes[1]; ?>"/>
                        </a>
                        <?php } ?>
                        <?php } else { ?>
                            <?php if ($home == $og_url) { ?>
                            <h3><?php echo $name; ?></h3>
                        <?php } else { ?>
                            <a href="<?php echo $home; ?>"><?php echo $name; ?></a>
                        <?php } ?>
                    <?php } ?>
                </div>

                <?php if (!$menu_main_type) { ?>
                <!-- ЕСЛИ ГОРИЗОНТАЛЬНОЕ МЕНЮ, ТО ВЫВОДИМ ВЕРХНЕЕ МЕНЮ В ВЕРХНЕЙ СТРОКЕ-->    
                <!-- <div class="stiky-menu col-md-4">
                    <div id="top-links" class=" dropdown">
                        <ul class="list-inline">
                            <?php foreach($sticky_menu_items as $item ) { ?>
                            <?php if ( count($item['children']) > 0 ) { ?>
                            <li class="dropdown">
                                <div class="dropdown">
                                    <a href="<?php echo $item['href']; ?>" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="dropdown-toggle"><span><?php echo $item['name']; ?></span><i class="fa fa-caret-down header-caret-down"></i></a>
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
                            <li>
                                <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
                            </li>
                            <?php } ?>
                            <?php } ?>
                        </ul>
                    </div>
                </div> -->
                <div class="stiky-search col-md-6">
                    <?php echo $search; ?>
                </div>
                <?php } else  { ?>
                <!-- ЕСЛИ ВЕРТИКАЛЬНОЕ МЕНЮ, ТО ВЫВОДИМ ПОИСК В ВЕРХНЕЙ СТРОКЕ -->
                <div class="stiky-search col-md-6">
                    <?php echo $search; ?>
                </div>
                <?php } ?>

                <div class="stiky-icon-box col-md-1">
                    <div id="top_icons_box-stiky">
                        <a href="<?php echo $wishlist; ?>" class="unistor-wishlist-total-s" title="<?php echo $text_wishlist_menu. ' ('.$unistor_wishlist_total.')'; ?>">
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
    </div>

   <?php } ?>
<?php } ?>

<?php if ($unistor_banner && $top_banner) { ?>
<div id='general-banner' style="background:<?php if ($top_banner_background) { echo $top_banner_background; } ?> url(<?php echo $unistor_banner;?>) center top no-repeat; <?php if ($top_banner_height) { echo "height: ".$top_banner_height."px;"; } ?>"><?php if ($top_banner_link) { ?><a href='<?php echo $top_banner_link; ?>'></a><?php } ?></div>
<?php } ?>

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
                                        <a href="<?php echo $item['href']; ?>" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="dropdown-toggle">
                                            <span><?php echo $item['name']; ?></span>
                                            <i class="fa fa-caret-down header-caret-down"></i>
                                        </a>
                                        <?php if ($item['icon']) { ?>
                                        <span class="top-icon"><img class="img-responsive" src="../image/<?php echo $item['icon']; ?>" alt="<?php echo $item['icon']; ?>"></span>
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
                                        <span class="top-icon"><img class="img-responsive" src="../image/<?php echo $item['icon']; ?>" alt="<?php echo $item['icon']; ?>"></span>
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
                    <div class="top-links-container_center">
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
                        <?php echo $currency; ?>
                        <?php echo $language; ?>
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
            <div class="header-middle__content">

                <div class="logo-search <?php if ($menu_main_type) { ?>vertical<?php } else { ?>horizontal<?php } ?>">
                    <div class="logo">
                        <div class="logo-container">
                            <?php if ( $logo || $unistor_logo ) { ?>
                            <?php if ($home == $og_url) { ?>
                            <img src="<?php echo $unistor_logo ? $unistor_logo : $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" width="<?php echo $logo_sizes[0]; ?>" height="<?php echo $logo_sizes[1]; ?>"/>
                            <?php } else { ?>
                            <a href="<?php echo $home; ?>">
                                <img src="<?php echo $unistor_logo ? $unistor_logo : $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" width="<?php echo $logo_sizes[0]; ?>" height="<?php echo $logo_sizes[1]; ?>"/>
                            </a>
                            <?php } ?>
                            <?php } else { ?>
                            <?php if ($home == $og_url) { ?>
                            <h1><?php echo $name; ?></h1>
                            <?php } else { ?>
                            <a href="<?php echo $home; ?>"><?php echo $name; ?></a>
                            <?php } ?>
                            <?php } ?>
                        </div>

                    </div>

                    <div class="search-container hidden-xs">
                        <div class="worktime <?php if ($menu_main_type) { ?>vertical<?php } ?>">
                            <i class="fa fa-clock-o" aria-hidden="true"></i>
                            <div class="worktime__list"><?php echo html_entity_decode($work_time); ?></div>
                            <?php if($neoseo_callback_status == 1){ ?>
                            <a href="#" class="phones__callback hidden-md hidden-lg <?php if ($menu_main_type){ ?> hidden-md hidden-lg <?php } ?>" onclick="showCallback();return false;">
                                <i class="ns-headphones"></i>
                                <span><?php echo $text_callback; ?></span>
                            </a>
                            <?php }?>
                        </div>

                        <?php if(!$menu_main_type) { ?>
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
                    <div class="phones">
                        <div class="phones__list dropdown">
                            <a data-toggle="dropdown"  class="phones__link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone1)));?>">
                            <?php echo html_entity_decode($phone1); ?>
                            <i class="fa fa-caret-down" ></i>
                            </a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                                <?php if( $phone2 ) { ?>
                                <li class="phones__item"><a class="phones__link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone2)));?>"><?php echo html_entity_decode($phone2); ?></a></li>
                                <?php } ?>

                                <?php if( $phone3 ) { ?>
                                <li class="phones__item"><a class="phones__link" href="tel:<?php echo preg_replace("/[^0-9+]/","",strip_tags(html_entity_decode($phone3)));?>"><?php echo html_entity_decode($phone3); ?></a></li>
                                <?php } ?>
                            </ul>
                            <?php if($neoseo_callback_status == 1){ ?>
                            <li class="phones__item <?php if(!$menu_main_type) { ?>hidden-sm <?} else { ?> hidden-sm <?php } ?>">
                                <a href="#" class="phones__callback" onclick="showCallback();return false;">
                                    <i class="ns-headphones" aria-hidden="true"></i>
                                    <span><?php echo $text_callback; ?></span>
                                </a>
                            </li>
                            <?php } ?>
                        </div>
                    </div>

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

<?php if (!$menu_main_type) { ?>
<!-- НАЧАЛО ГОРИЗОНТАЛЬНОГО МЕНЮ -->
<?php if ($categories) { ?>
<div class="<?php echo $menu_class; ?>">
	<div class="main-menu box-shadow">
		<div class="container">
			<nav id="menu" class="navbar
							<?php
								if($menu_main_type == 1) {
									echo 'vertical-menu ';
								} else {
									echo 'gorizontal-menu ';
								}
							?> ">
				<div class="navbar-header">
					<button type="button" class="btn btn-navbar navbar-toggle" data-toggle="collapse"
							data-target=".navbar-ex1-collapse">
						<i class="fa fa-bars"></i>
					</button>
					<span id="category" class="visible-xs" data-toggle="collapse"
						  data-target=".navbar-ex1-collapse"><?php echo $text_category; ?></span>
					<button type="button" id="ocfilter-button" class="btn btn-navbar navbar-toggle hidden-xs visible-xs"
							onclick="toggleFilter();">
						<i class="fa fa-filter"></i>
					</button>
				</div>
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					<ul class="nav navbar-nav">
						<?php foreach ($categories as $category) {  ?>
						<?php if ($category['children']) { ?>
						<li class="dropdown <?php echo $category['params']; echo ' '.$category['menu_params']; echo ' menu-item-'.$category['pid'] ; echo ' '.$category['icon_position'] ; echo ' '.$category['class'].' ';?>">


							<a href="<?php echo $category['href']; ?>"
							   class="menu-image-link dropdown-toggle <?php echo $category['params']; echo ' menu-item-'.$category['pid'] ; ?> <?php if ($category['icon'])  { echo $icon_position; }?>"
							<?php
												if($category['style'] != '' ){
													echo 'style="'.$category['style'].'" ';
												}
											?> data-toggle="dropdown">

                            <script>

                                $(function () {

                                    $('.menu-image-link').each(function () {
                                       if ($(this).attr('href') == '') {
                                           $(this).attr('href','javascript.void(0)');
                                       }
                                    });

                                });

                            </script>

							<?php if(($category['icon_position'] == 'icons-pos-right') || ($category['icon_position'] == 'icons-pos-bottom')){

												echo '<span class="item-name">'.$category['name'].'</span>';
							if(($category['icon'] !='' )) {
							echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
							}
							} else {
							if(($category['icon'] !='' )) {
							echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
							}

							echo '<span class="item-name">'.$category['name'].'</span>';
							} ;?>

							</a>

							<div class="dropdown-menu <?php echo $category['params']; ?>">
								<div class="dropdown-inner <?php if($category['image']){ echo 'image-menu'; }?>">
									<?php $items = 0; $automenu = ( strpos($category['params'],'auto') !== false ); ?>
									<ul class="list-unstyled">
										<?php foreach ($category['children'] as $child) {
													if( $automenu ) {
														if( $items == 0 ) {
															echo "<li class=\"menu-group\">
										<ul class=\"list-unstyled\">\n";
											}
											if( $items > 0 && $items % 6 == 0 ) {
											echo "
										</ul>
										</li>
										<li class=\"menu-group\">
											<ul class=\"list-unstyled\">";
												}
												$items++;
												} ?>
												<li class="<?php
																	if( $child['children'] ) {
																		echo' menu-group';
																	}else{
																		echo' menu-alone';
																	}
																	echo ' '.$child['params']; echo ' '.$child['menu_params']; echo ' '.$child['class'];
																?>">
													<?php if( trim($child['name']) ) { ?>
													<a href="<?php echo $child['href']; ?>"
													   class="<?php echo $child['params'];  echo ' menu-item-'.$child['pid'];?>"
													<?php
																	if($child['style'] != '' ){
																		echo 'style="'.$child['style'].'" ';
																	}
																?>  >

													<?php if(($child['icon'] !='' )) {
																	echo '<span class="ico-first-child"><img
															src="../image/'.$child["icon"].'"
													alt="'.$child["name"].'"></span>';
													}?>

													<span> <?php echo $child['name']; ?> </span>
													</a>

													<?php } ?>
													<?php if( count($child['children']) > 0 ) { ?>
													<ul class="list-unstyled">
														<?php foreach ($child['children'] as $subchild) { ?>
														<li class="<?php echo ' '.$subchild['params']; echo ' '.$subchild['menu_params']; echo ' '.$subchild['class'];

																					if( count($subchild['children']) > 0 ) {
																						echo ' popup-wraper';
																					}

																					?>">
															<a href="<?php echo $subchild['href']; ?>"
															   class="dropdown-item <?php if( $subchild['children'] ) { ?>has-popup-menu<?php } echo ' menu-item-'.$subchild['pid'];  ?> "
															<?php
																					if($subchild['style'] != '' ){
																						echo 'style="'.$subchild['style'].'" ';
																					}
																				?> >

															<?php
																					if(($subchild['icon'] !='' )) {
																						echo '<span class="ico-second-child">
															<img src="../image/'.$subchild["icon"].'"
															alt="'.$subchild["name"].'"></span>';
															}
															?>
															<span> <?php echo $subchild['name']; ?> </span>
															</a>
															<?php if( count($subchild['children']) > 0 ) { ?>
															<div class="popup-menu">
																<ul class="list-unstyled">
																	<?php foreach( $subchild['children'] as $subchildren ) { ?>
																	<li class="<?php  echo ' '.$subchildren['menu_params']; echo ' '.$subchildren['menu_params'];  echo ' '.$subchildren['class']; ?>">
																		<a href="<?php echo $subchildren['href']; ?>"
																		   class="<?php echo $subchildren['params']; echo ' menu-item-'.$subchildren['pid']; ?>"
																		<?php
																										if($subchildren['style'] != '' ){
																											echo 'style="'.$subchildren['style'].'" ';
																										}
																									?>>
																		<?php echo $subchildren['name']; ?>
																		</a>
																	</li>
																	<?php } ?>
																</ul>
															</div>
															<?php } ?>
														</li>
														<?php } ?>
													</ul>
													<?php } ?>
												</li>
												<?php } ?>
												<?php
													if( $automenu ) {
														if( $items != 0 ) {
															echo "</ul></li>\n";
												}
												}
												?>
											</ul>
                                            <?php if($category['image']){
												// Картинка в меню
												?>

                                        <div class="mega-image" >
                                            <a class="mega-image-link" href="<?php echo $category['href']; ?>">
                                                <img class="img-responsive" src="<?php echo $category['image']; ?>">
                                            </a>
                                        </div>

                                        <?php }; ?>
								</div>
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
							echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
							}
							} else {
							if(($category['icon'] !='' )) {
							echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
							}

							echo '<span class="item-name">'.$category['name'].'</span>';
							} ;?>
							</a>
						</li>
						<?php } ?>
						<?php  } ?>
					</ul>
				</div>
			</nav>
		</div>
	</div>
</div>
<?php } ?>
<!-- КОНЕЦ ГОРИЗОНТАЛЬНОГО МЕНЮ -->

<?php } else  { ?>

<!-- НАЧАЛО ВЕРТИКАЛЬНОГО МЕНЮ -->

<!-- MOBILE -->
<?php if ($categories) { ?>
<div class="main-vertical-menu-mobile visible-xs visible-sm">
    <div class="navbar-header-vertical box-shadow">
        <div class="container">
            <div class="btn menu-button" data-toggle="collapse" data-target="#mobileMenu">
                <i class="fa fa-bars"></i>
                <span>Каталог</span>
            </div>
        </div>
    </div>
    <div id="mobileMenu" class="collapse mobile-menu-category box-shadow">
        <?php foreach ($categories as $category) {  ?>
        <?php if ($category['children']) { ?>
        <div data-toggle="collapse" data-target="#category<?php echo $category['pid']; ?>" class="menu-image-link <?php echo $category['params']; echo ' menu-item-'.$category['pid'] ; echo ' '.$category['class'].' '; ?>" >


            <?php
                                                    if($category['style'] != '' ){
                                                        echo 'style="'.$category['style'].'" ';
                                                    }
                                                ?>
            <div class="item-line <?php if ($category['icon']) { echo $icon_position; } ?>">
                <?php if(($category['icon_position'] == 'icons-pos-right') || ($category['icon_position'] == 'icons-pos-bottom')){

                                                    echo "<span>".$category['name']."</span>";
                if(($category['icon'] !='' )) {
                echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                }
                } else {
                if(($category['icon'] !='' )) {
                echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                }

                echo "<span>".$category['name']."</span>";
                } ;?>
            </div>
            <i class="fa fa-chevron-down"></i>
        </div>
        <div id="category<?php echo $category['pid']; ?>" class="collapse mobile-menu-child-category">
            <?php foreach ($category['children'] as $child) { ?>
            <?php if ($child['children']) { ?>
            <?php foreach ($child['children'] as $child2) { ?>
            <?php if ($child2['children']) { ?>
            <div data-toggle="collapse" data-target="#category<?php echo $child2['pid']; ?>" class="menu-image-sub-link <?php echo $child2['params']; echo ' menu-item-'.$child2['pid'] ; echo ' '.$child2['class'].' '; ?>" >
                <?php
                                    if($child2['style'] != '' ){
                                        echo 'style="'.$child2['style'].'" ';
                                    }
                                    ?>
                <?php if(($child2['icon_position'] == 'icons-pos-right') || ($child2['icon_position'] == 'icons-pos-bottom')){
                                        echo "<span>".$child2['name']."</span>";
                if(($child2['icon'] !='' )) {
                echo '<span class="ico-nav"><img src="../image/'.$child2["icon"].'" alt="'.$child2["name"].'"></span>';
                }
                } else {
                if(($child2['icon'] !='' )) {
                echo '<span class="ico-nav"><img src="../image/'.$child2["icon"].'" alt="'.$child2["name"].'"></span>';
                }
                echo "<span>".$child2['name']."</span>";
                } ;?>
                <i class="fa fa-chevron-down" aria-hidden="true"></i>
            </div>
            <div id="category<?php echo $child2['pid']; ?>" class="collapse mobile-menu-child-category">
                <?php foreach ($child2['children'] as $child3) { ?>
                <a href="<?php echo $child3['href']; ?>"><?php echo $child3['name']; ?></a>
                <?php } ?>
            </div>
            <?php } else { ?>
            <div class="menu-image-sub-link <?php echo $child2['params']; echo ' menu-item-'.$child2['pid'] ; echo ' '.$child2['class'].' '; ?>">
                <?php
                                    if($child2['style'] != '' ){
                                        echo 'style="'.$child2['style'].'" ';
                                    }
                                    ?>
                <?php if(($child2['icon_position'] == 'icons-pos-right') || ($child2['icon_position'] == 'icons-pos-bottom')){
                                        echo "<a href='".$child2['href']."'>".$child2['name']."</a>";
                if(($child2['icon'] !='' )) {
                echo '<span class="ico-nav"><img src="../image/'.$child2["icon"].'" alt="'.$child2["name"].'"></span>';
                }
                } else {
                if(($child2['icon'] !='' )) {
                echo '<span class="ico-nav"><img src="../image/'.$child2["icon"].'" alt="'.$child2["name"].'"></span>';
                }
                echo "<a href='".$child2['href']."'>".$child2['name']."</a>";
                } ; ?>
            </div>
            <?php } ?>
            <?php } ?>
            <?php } ?>
            <?php } ?>
        </div>
        <?php } else { ?>
        <div class="menu-image-link <?php echo $category['params']; echo ' menu-item-'.$category['pid'] ; echo ' '.$category['class'].' '; ?>" >
            <?php
                        if($category['style'] != '' ){
                            echo 'style="'.$category['style'].'" ';
                        }
                        ?>
            <div class="item-line <?php if ($category['icon']) { echo $icon_position; } ?>">
                <?php if(($category['icon_position'] == 'icons-pos-right') || ($category['icon_position'] == 'icons-pos-bottom')){

                            echo "<a href='".$category['href']."'>".$category['name']."</a>";
                if(($category['icon'] !='' )) {
                echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                }
                } else {
                if(($category['icon'] !='' )) {
                echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                }

                echo "<a href='".$category['href']."'>".$category['name']."</a>";
                } ;?>
            </div>
        </div>
        <?php } ?>
        <?php } ?>
    </div>
</div>
<script>
    $('.menu-image-link, .menu-image-sub-link').click(function () {
        $(this).children('.fa').toggleClass('fa-chevron-down fa-chevron-up');
    });

    $('.navbar-header-vertical').click(function () {
        $('.mobile-menu-category').find('.in').removeClass('in');
        $('.mobile-menu-category').find('.fa-chevron-up').removeClass('fa-chevron-up').addClass('fa-chevron-down');
    })


</script>


<!-- DESKTOP -->
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


            <div id="menuCategoryV" class="main-menu-category col-md-3">
                <div class="main-menu-category_list box-shadow box-corner dropmenu<?php if (($home == $og_url)) { echo ' open'; }?>">
                    <?php foreach ($categories as $category) { ?>
                    <div class="main-menu-category_item <?php echo ' menu-item-'.$category['pid'] ; ?>">
                        <div class="item-line">
                            <?php $category_name = $category['name']; ?>
                            <a href="<?php echo $category['href']; ?>" class="<?php echo $category['params'];  echo ' '.$category['class'].' '; if ($category['icon']) { echo $icon_position; } ?>" <?php if($category['style'] != '' ){ echo 'style="'.$category['style'].'" '; } ?>>
                            <span class="item-name"><?php echo $category_name; ?></span>
                            <?php
                                    if(($category['icon'] !='' )) {
                                    echo '<span class="ico-nav"><img src="../image/'.$category["icon"].'" alt="'.$category["name"].'"></span>';
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
                            <?php foreach ($category['children'] as $child) { ?>
                            <?php if ($child['children']) { ?>
                            <div class="sub-child-menu-item">
                                <div class="sub-child-name" style="<?php echo $child['style']; ?>"><?php echo $child['name']; ?></div>
                                <?php if(($child['icon'] !='' )) { echo '<span class="ico-nav"><img src="../image/'.$child['icon'].'" alt="'.$child['name'].'"></span>';} ?>
                                <?php foreach ($child['children'] as $child2) { ?>
                                <?php if ($child2['image']) { ?>
                                <a class="sub-child-menu-image"  href="<?php echo $child2['href']; ?>">
                                    <img src="<?php echo $child2['image']; ?>" alt="<?php echo $child2['image']; ?>">
                                </a>
                                <?php } ?>
                                <a href="<?php echo $child2['href']; ?>" class="<?php echo $child2['params']; echo ' menu-item-'.$child2['pid'] ; echo ' '.$child2['class'].' '; ?>" <?php if($child2['style'] != '' ){ echo 'style="'.$child2['style'].'" '; } ?>>
                                <?php if(($child2['icon'] !='' )) {
                                    echo '<span class="ico-second-child"><img src="../image/'.$child2['icon'].'" alt="'.$child2['name'].'">'; } ?>

                                <span class="child-category"><?php echo $child2['name']; ?></span>
                                </a>
                                <?php if ($child2['children']) { ?>
                                <div class="sub-child2-menu-item">
                                    <?php foreach ($child2['children'] as $child3) { ?>
                                    <a href="<?php echo $child3['href']; ?>" class="<?php echo $child3['params']; echo ' menu-item-'.$child3['pid'] ; echo ' '.$child3['class'].' '; ?>" <?php if($child3['style'] != '' ){ echo 'style="'.$child3['style'].'" '; } ?> >
                                    <?php echo $child3['name']; ?>
                                    </a>
                                    <?php } ?>
                                </div>
                                <?php } ?>
                                <?php } ?>

                                <span class="show-child-hidden">Все категории ()</span>

                                <div class="child-menu-list-hidden">
                                    <div class="sub-child-name"><?php echo $child['name']; ?></div>
                                    <?php if(($child['icon'] !='' )) { echo '<span class="ico-nav"><img src="../image/'.$child['icon'].'" alt="'.$child['name'].'"></span>';} ?>
                                    <?php foreach ($child['children'] as $child2) { ?>
                                    <?php if ($child2['image']) { ?>
                                    <a class="sub-child-menu-image"  href="<?php echo $child2['href']; ?>">
                                        <img src="<?php echo $child2['image']; ?>" alt="<?php echo $child2['image']; ?>">
                                    </a>
                                    <?php } ?>
                                    <a href="<?php echo $child2['href']; ?>" class="<?php echo $child2['params']; echo ' menu-item-'.$child2['pid'] ; echo ' '.$child2['class'].' '; ?>" <?php if($child2['style'] != '' ){ echo 'style="'.$child2['style'].'" '; } ?>>
                                    <?php if(($child2['icon'] !='' )) {
                                        echo '<span class="ico-second-child"><img src="../image/'.$child2['icon'].'" alt="'.$child2['name'].'">'; } ?>

                                    <span class="child-category"><?php echo $child2['name']; ?></span>
                                    </a>
                                    <?php if ($child2['children']) { ?>
                                    <div class="sub-child2-menu-item">
                                        <?php foreach ($child2['children'] as $child3) { ?>
                                        <a href="<?php echo $child3['href']; ?>" class="<?php echo $child3['params']; echo ' menu-item-'.$child3['pid'] ; echo ' '.$child3['class'].' '; ?>" <?php if($child3['style'] != '' ){ echo 'style="'.$child3['style'].'" '; } ?> >
                                        <?php echo $child3['name']; ?>
                                        </a>
                                        <?php } ?>
                                    </div>
                                    <?php } ?>
                                    <?php } ?>

                                    <span class="hide-child-hidden child-hidden">Скрыть</span>
                                </div>

                            </div>
                            <?php } ?>

                            <?php } ?>
                            <?php if($category['image']){
												// Картинка в меню
												?>

                            <div class="mega-image" >
                                <a href="<?php echo $category['href']; ?>">
                                    <img class="img-responsive" src="<?php echo $category['image']; ?>">
                                </a>
                            </div>
                            
                            <?php }; ?>
                        </div>
                        <?php } ?>
                    </div>
                    <?php } ?>
                </div>
                <!-- <?php } ?> -->
            </div>

<?php } ?> 
        </div>
    </div>
</div>

<script>

$(document).ready( function () {
    $('.sub-child-menu-item').each( function () {
        if ($(this).children('.child-hidden').length > 0 ) {
            $(this).addClass('have-hidden');
            $(this).find('.show-child-hidden').html('Все категории ('+$(this).children('a').length+')')
        }
    })

    $('.sub-menu-list .shaded-before').on('click', function(event) {
        $(this).closest('.sub-menu-list').find('.child-show-mode').removeClass('child-show-mode');
        $(this).closest('.sub-menu-list').removeClass('shaded');
    })
})
    
    $('.show-child-hidden').on('click', function () {
        $(this).closest('.sub-child-menu-item').addClass('child-show-mode');
        $(this).closest('.sub-menu-list').addClass('shaded');
    })

    $('.hide-child-hidden').on('click', function () {
        $(this).closest('.sub-child-menu-item').removeClass('child-show-mode');
        $(this).closest('.sub-menu-list').removeClass('shaded');

    })

    $('.main-menu-category_item').hover(function () {

    }, function () {
        $(this).find('.shaded').removeClass('shaded').find('.child-show-mode').removeClass('child-show-mode');
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
<!--<div class="city-box dropdown col-md-3 hidden-xs hidden-sm">
                    <div class='header dropdown-toggle' role="button" data-toggle="dropdown">
                        <span>Ваш город:</span>
                        <span><b>Киев</b></span>
                    </div>
                    <div class="dropdown-menu" role="menu">
                        <div class='dropdown-title'>
                            Ваш город: <a class='cur-city'>Днепр</a>?
                            <button type="button" class='button'>Да!</button>
                        </div>
                        <div class='dropdown-inner'>
                            <ul id='city-list'>
                                <li><a>Киев</a></li>
                                <li><a>Харьков</a></li>
                                <li><a>Одесса</a></li>
                                <li><a>Днепр</a></li>
                                <li><a>Львов</a></li>
                                <li><a>Запорожье</a></li>
                                <li><a>Винница</a></li>
                                <li><a>Сумы</a></li>
                            </ul>
                            <div id='city-input'>
                                <div class='title'>Вашего города нет в списке? Введите ваш населенный пункт</div>
                                <input type="text" class='' />
                                <div class='bottom'>Выбор города поможет предоставить актуальную информацию о наличии товара, его цены и способов доставки в вашем городе! Это поможет сохранить вам свободное время.</div>
                            </div>
                        </div>
                    </div>
                </div>-->
<?php if (false && $locations) { ?>
<!--<div id="city-box" class="pull-left dropdown">
    <div class='header dropdown-toggle' role="button" data-toggle="dropdown"><i class="fa fa-map-marker" aria-hidden="true"></i> <span>Ивано-Франковск</span></div>
    <div class="dropdown-menu" role="menu">
        <div class='dropdown-title'>
            Ваш город: <a class='cur-city'>Днепр</a>?
            <button type="button" class='button'>Да!</button>
        </div>
        <div class='dropdown-inner'>
            <ul id='city-list'>
                <li><a>Киев</a></li>
                <li><a>Харьков</a></li>
                <li><a>Одесса</a></li>
                <li><a>Днепр</a></li>
                <li><a>Львов</a></li>
                <li><a>Запорожье</a></li>
                <li><a>Винница</a></li>
                <li><a>Сумы</a></li>
            </ul>
            <div id='city-input'>
                <div class='title'>Вашего города нет в списке? Введите ваш населенный пункт</div>
                <input type="text" class='' />
                <div class='bottom'>Выбор города поможет предоставить актуальную информацию о наличии товара, его цены и способов доставки в вашем городе! Это поможет сохранить вам свободное время.</div>
            </div>
        </div>
    </div>
</div>-->
<?php } ?>
<?php } ?>

<script>
    // verticalMenuNav('<?php echo $main_menu_category_quantity ?>');

</script>

<script>

$(document).ready( function () {
    $('.bg-img').each(function () {
        $(this).closest('.main-menu-category_item').addClass('bg-img');
    });

    $('.all-category-show').each(function () {
        $(this).closest('.main-menu-category_item').addClass('all-category-show');
    });

    $('.mozaic-mega-menu').each(function () {
        $(this).closest('.main-menu-category_item').addClass('mozaic-mega-menu');
    })

    $('.triple-mega-menu').each(function () {
        $(this).closest('.main-menu-category_item').addClass('triple-mega-menu');
    })

    $('.table-mega-menu').each(function () {
        $(this).closest('.main-menu-category_item').addClass('table-mega-menu');
    })

    $('.header-mega-menu').each(function () {
        $(this).closest('.main-menu-category_item').addClass('header-mega-menu');
    })

    $('.action-mega-menu').each(function () {
        $(this).closest('.main-menu-category_item').addClass('action-mega-menu');
    })

    $('.center-img-mega-menu').each(function () {
        $(this).closest('.main-menu-category_item').addClass('center-img-mega-menu');
    });

    $('.side-img-mega-menu').each(function () {
        $(this).closest('.main-menu-category_item').addClass('side-img-mega-menu');
    })

    $('.brand-name').each(function () {
        $(this).prev().addClass('brand-name');
    })

    $('.sub-child2-menu-item').each( function () {
        if ($(this).find('a.child-hidden').length > 0 ) {

            $(this).addClass('have-hidden');
            $(this).find('.show-child-hidden').html('Все категории ('+($(this).children('a').length-1)+')')
        }
    })

    $('.sub-menu-list .shaded-before').on('click', function(event) {
        $(this).closest('.sub-menu-list').find('.child-show-mode').removeClass('child-show-mode').closest('.show-mode').removeClass('show-mode');
        $(this).closest('.sub-menu-list').removeClass('shaded');
    })

    $('.all-category-show .show-child-hidden').on('click', function (event) {
        event.preventDefault();
        $(this).closest('.sub-child2-menu-item').addClass('child-show-mode').closest('.sub-child-menu-item').addClass('show-mode');
        $(this).closest('.sub-menu-list').addClass('shaded');
    })

    $('.hide-child-hidden').on('click', function () {
        $(this).closest('.child-show-mode').removeClass('child-show-mode').closest('.show-mode').removeClass('show-mode');
        $(this).closest('.sub-menu-list').removeClass('shaded');

    })

    $('.main-menu-category_item').hover(function () {

    }, function () {
        $(this).find('.shaded').removeClass('shaded').find('.child-show-mode').removeClass('child-show-mode').find('.show-mode').removeClass('show-mode');
    })
})
    
    
</script>

<!-- КОНЕЦ ВЕРТИКАЛЬНОГО МЕНЮ -->
