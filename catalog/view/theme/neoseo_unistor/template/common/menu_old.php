<?php if (!$menu_main_type) { ?>
    <!-- НАЧАЛО ГОРИЗОНТАЛЬНОГО МЕНЮ -->
    <?php //Проверяем одиночное меню или нет по классу $categories[0]['class'] ?>
    <?php if ($categories && !preg_match('~single-menu-catalog~', $categories[0]['class']) ) { ?>
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
                                                        echo '<span class="ico-nav"><img src="'.$category["icon"].'" alt="'.$category["name"].'"></span>';
                                                    }
                                                } else {
                                                    if(($category['icon'] !='' )) {
                                                        echo '<span class="ico-nav"><img src="'.$category["icon"].'" alt="'.$category["name"].'"></span>';
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
                                                            src="'.$child["icon"].'"
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
                                                            <img src="'.$subchild["icon"].'"
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
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    <?php } else { ?>
        <div id="main-menu-catalog">
            <?php include(DIR_TEMPLATE . 'neoseo_unistor/template/common/single_menu_catalog.tpl');  ?>
        </div>
    <?php } ?>
    <!-- КОНЕЦ ГОРИЗОНТАЛЬНОГО МЕНЮ -->

<?php } else if ($menu_main_type == 1)  { ?>

    <!-- НАЧАЛО ВЕРТИКАЛЬНОГО МЕНЮ -->

    <!-- MOBILE -->
    <?php if ($categories) { ?>

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
                                                                <span class="show-child-hidden">Все категории ()</span>

                                                                <div class="child-menu-list-hidden">

                                                                    <?php foreach ($child2['children'] as $child3) { ?>
                                                                        <a href="<?php echo $child3['href']; ?>" class="<?php echo $child3['params']; echo ' menu-item-'.$child3['pid'] ; echo ' '.$child3['class'].' '; ?>" <?php if($child3['style'] != '' ){ echo 'style="'.$child3['style'].'" '; } ?> >
                                                                            <?php echo $child3['name']; ?>
                                                                        </a>
                                                                    <?php } ?>
                                                                    <span class="hide-child-hidden child-hidden">Скрыть</span>
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


        $(document).ready( function () {

            $('.all-category-show').each(function () {
                $(this).closest('.main-menu-category_item').addClass('all-category-show');
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