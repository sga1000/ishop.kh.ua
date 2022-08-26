<div class="<?php echo $menu_class; ?> <?php echo $menu_class_type; ?>">
    <div class="container">
        <nav id="menu" class="navbar
                                <?php
                                    if($menu_main_type == 1) {
                                        echo 'vertical-menu ';
                                    } else {
                                        echo 'gorizontal-menu ';
                                    }
                                ?> ">
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