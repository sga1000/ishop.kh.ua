<nav id="single-menu-catalog" >
    <div class="container">
        <?php if ($categories) { ?>
        <ul class="single-menu-catalog__menu">
            <?php $catalog = true; foreach ($categories as $category) {  ?>
            <?php if ($catalog) { $catalog = false; ?>
            <li class="single-menu-catalog__title <?php echo $category['class']?>" style="<?php echo $category['style']?>" >
                <span><i class="fa fa-bars hidden-xs hidden-sm"></i><?php echo $category['name'] ?><i class="fa fa-angle-down hidden-md hidden-lg"></i></span>
                <?php if ($category['children']) { ?>
                <ul class="single-menu-catalog__children">
                    <?php foreach($category['children'] as $children) { ?>
                    <li
                    <?php if ($children['class']) { ?>
                    class="<?php echo $children['class']; ?>"
                    <?php } ?> >
                    <a href="<?php echo $children['href']; ?>"
                    <?php if ($children['style']) { ?>
                    style="<?php echo $children['style']?>"
                    <?php } ?>>
                    <?php // Проверяем есть ли иконка(изображение) у этого пункта ?>
                    <?php if ($children['icon']) { ?>
                    <img src="<?php echo  $children['icon']; ?>" alt="<?php echo $children['name']; ?>">
                    <?php } ?>

                    <?php echo  $children['name']; ?>

                    <?php // Проверяем есть ли дочерние элементы ?>
                    <?php if ($children['children']) { ?>
                    <i class="fa fa-angle-right"></i>
                    <?php } ?>
                    </a>

                    <?php if ($children['children']) { ?>
                    <div class="single-menu-catalog__submenu">
                        <ul class="single-menu-catalog__children2 <?php echo $children['class']?>">
                            <?php foreach($children['children'] as $children2) { ?>
                            <li
                            <?php if ($children2['class']) { ?>
                            class="<?php echo $children2['class']; ?>"
                            <?php } ?> >
                            <?php if ($children2['href']) { ?>
                                <a href="<?php echo $children2['href']; ?>"
                                <?php if ($children2['style']) { ?>
                                style="<?php echo $children2['style']?>"
                                <?php } ?>>
                            <?php } else { ?>
                                <span class="no-link">
                            <?php } ?>
                            <?php // Проверяем есть ли изображение у этого пункта ?>
                            <?php if ($children2['image']) { ?>
                            <img class="children2-image" src="<?php echo  $children2['image']; ?>" alt="<?php echo $children2['name']; ?>">
                            <?php } ?>
                            <span class="children2-item-box">
                                                                           <?php // Проверяем есть ли иконка(изображение) у этого пункта ?>
                                <?php if ($children2['icon']) { ?>
                                <img src="<?php echo  $children2['icon']; ?>" alt="<?php echo $children2['name']; ?>">
                                <?php } ?>
                                <?php echo $children2['name']; ?>

                                <?php if ($children2['children']) { ?>
                                <i class="fa fa-angle-down hidden-md hidden-lg"></i>
                                <?php } ?>
                                                                    </span>
                            <?php if ($children2['href']) { ?>
                            </a>
                            <?php } else { ?>
                            </span>
                            <?php } ?>

                            <?php if ($children2['children']) { ?>
                            <ul class="single-menu-catalog__children3">
                                <?php foreach($children2['children'] as $children3) { ?>
                                <li
                                <?php if ($children3['class']) { ?>
                                class="<?php echo $children3['class']; ?>"
                                <?php } ?> >
                                <?php // Проверяем есть ли изображение у этого пункта ?>
                                <?php if ($children3['image']) { ?>
                                <a class="--image" href="<?php echo $children3['href']; ?>">
                                    <img class="children3-image" src="<?php echo  $children3['image']; ?>" alt="<?php echo $children3['name']; ?>">
                                </a>
                                <?php } ?>
                                    <?php if ($children3['href']) { ?>
                                        <a href="<?php echo $children3['href']; ?>"  style="<?php echo $children3['style']; ?>">
                                    <?php } else { ?><span class="no-link"><?php } ?>
                                <?php // Проверяем есть ли иконка(изображение) у этого пункта ?>
                                <?php if ($children3['icon']) { ?>
                                <img src="<?php echo  $children3['icon']; ?>" alt="<?php echo $children3['name']; ?>">
                                <?php } ?>
                                <?php echo $children3['name']; ?>
                                    <?php if ($children3['href']) { ?>
                                        </a>
                                    <?php } else { ?>
                                        </span>
                                    <?php } ?>
                                </li>
                                <?php } ?>
                            </ul>
                            <?php } ?>
                            </li>
                            <?php } ?>
                            <?php if ($children['image']) { ?>
                            <li class="hidden-xs hidden-sm" <?php if ($children['style']) { ?>style="<?php echo $children['style']; ?>"<?php } ?> >
                            <img src="<?php echo $children['image']; ?>" alt="<?php echo $children['name']; ?>">
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
            <?php } else { ?>
            <li>
                <a href="<?php echo $category['href']; ?>">
                    <?php if($category['icon']) { ?>
                    <img src="<?php echo $category['icon']; ?>" alt="<?php echo $category['name']; ?>" class="main-menu-icon">
                    <?php } ?>
                    <span class="single-menu-catalog__span"><?php echo $category['name']; ?></span>
                </a>
            </li>
            <?php } ?>
            <?php $i++; } ?>
        </ul>
        <?php } ?>
    </div>
</nav>

<script>

    $('#single-menu-catalog  .single-menu-catalog__submenu').css('width', ( $('#single-menu-catalog .single-menu-catalog__menu').width() - 298));
    $('#stiky_box   .single-menu-catalog__submenu').css('width', ( $('#stiky_box .container').width() - 298));

    $(window).resize(function () {
        $('#single-menu-catalog  .single-menu-catalog__submenu').css('width', ( $('#single-menu-catalog .single-menu-catalog__menu').width() - 298));
        $('#stiky_box  .single-menu-catalog__submenu').css('width', ( $('#stiky_box  .single-menu-catalog__menu').width() - 298));

    });

    $('.single-menu-catalog__children3').each(function () {
        if ($(this).find('.child-hidden').length) {
            if (!$('.popup-hidden-bg').length) {
                $('.single-menu-catalog__submenu').prepend('<li class="popup-hidden-bg"></li>')
            }
            $(this).append('<li><span class="popup-link"><?php echo $text_all_categories; ?> (' + $(this).find('.child-hidden').length + ')</span></li>');
            $(this).append('<ul class="popup-child"></ul>');
            $($(this).find('.popup-child')).append($(this).find('.child-hidden')).append('<li><span class="popup-link"><?php echo $text_hide; ?></span></li>');
        }
    });

    $('.single-menu-catalog__submenu').mouseleave(function () {
        $('.popup-hidden-bg').fadeOut(300);
        $('.popup-child').fadeOut(300);
    });
  
    $('.popup-hidden-bg').on('click', function() {
        $('.popup-hidden-bg').fadeOut(300);
        $('.popup-child').fadeOut(300)   
    });  

    $('.popup-link').on('click', function () {
        let mainParent = $(this).parents('.single-menu-catalog__submenu');
        let parentUl = $(this).parents('.single-menu-catalog__children3');

        mainParent.find('.popup-hidden-bg').fadeIn(300);
        parentUl.find('.popup-child').fadeIn(300);
    });

    $('.popup-child .popup-link').on('click', function () {
        $('.popup-hidden-bg').fadeOut(300);
        $('.popup-child').fadeOut(300);
    });

</script>

