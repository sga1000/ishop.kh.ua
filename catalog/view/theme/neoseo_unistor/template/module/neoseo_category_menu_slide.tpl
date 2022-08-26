<div class="side-module box-shadow box-corner sidebar-category-accordeon<?php echo $collapse == 1 ? ' is-collapsed' : '';?><?php echo $hide == 1 ? ' collaps' : '';?><?php echo $full_height == 1 ? ' full-height' : '';?>">
    <h3 class="category-header"><?php echo $heading_title; ?></h3>
    <div class="box-content">
        <ul id="nav-one" class="dropmenu">
            <?php foreach ($categories as $category) { ?>
                <?php if (!isset($category['category_id'])) {
                    continue;
                } else {  ?>
                    <li class="level0 <?php if ($category['active']) { ?>activeicon<?php } ?>">
                        <?php if ($category['active']) { ?>
                            <a href="<?php echo $category['href']; ?>"  class="active category-link"><?php echo $category['name']; ?></a>
                        <?php } else { ?>
                            <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
                        <?php } ?>
                        <?php if ($category['children']) { ?>
                            <ul class="level1">
                                <?php foreach ($category['children'] as $child) { ?>
                                    <li class="<?php if ($child['active']) { ?>activeicon <?php } ?>">
                                        <?php if ($child['active']) { ?>
                                            <a href="<?php echo $child['href']; ?>"  class="active">
                                                <?php echo $child['name']; ?>
                                            </a>
                                        <?php } else { ?>
                                            <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
                                        <?php } ?>
                                        <?php if ($child['children']) { ?>
                                            <ul class="level2">
                                                <?php foreach ($child['children'] as $child2) { ?>
                                                    <li>
                                                        <?php if ($child2['active']) { ?>
                                                            <a href="<?php echo $child2['href']; ?>" class="active">
                                                                <?php echo $child2['name']; ?>
                                                            </a>
                                                        <?php } else { ?>
                                                            <a href="<?php echo $child2['href']; ?>">
                                                                <?php echo $child2['name']; ?>
                                                            </a>
                                                        <?php } ?>
                                                        <?php if ($child2['children']) { ?>
                                                            <ul class="level3">
                                                                <?php foreach ($child2['children'] as $child3) { ?>
                                                                    <li>
                                                                        <?php if ($child3['active']) { ?>
                                                                            <a href="<?php echo $child3['href']; ?>" class="active">
                                                                                <?php echo $child3['name']; ?>
                                                                            </a>
                                                                        <?php } else { ?>
                                                                            <a href="<?php echo $child3['href']; ?>" >
                                                                                <?php echo $child3['name']; ?>
                                                                            </a>
                                                                        <?php } ?>
                                                                    </li>
                                                                <?php } ?>
                                                            </ul>
                                                        <?php } ?>
                                                    </li>
                                                <?php } ?>
                                            </ul>
                                        <?php } ?>
                                    </li>
                                <?php } ?>
                            </ul>
                        <?php } ?>
                    </li>
                <?php } ?>
            <?php } ?>
        </ul>
    </div>
</div>
<script>
    $('.sidebar-category-accordeon .dropmenu li a.active').parent().parent().css('display', 'block');

    $(".sidebar-category-accordeon .dropmenu li").has("ul").addClass("with-child");

    $(".sidebar-category-accordeon .dropmenu li").has("ul").append('<span class="icon"><i class="fa fa-chevron-right"></i></span>');

    $('.sidebar-category-accordeon .dropmenu a').each(function () {
        if ($(this).hasClass('activSub')) {
            $(this).parent().append('<span class="icon"></span>');
        }
        if ($(this).hasClass('active')) {
            $(this).parent().addClass('open');
            $(this).siblings('ul').css('display', 'block');
        }
    });

    $('.sidebar-category-accordeon .active > ul').css('display', 'block');
    $('.sidebar-category-accordeon .activeicon > .icon').addClass('active').children('.fa').toggleClass('fa-chevron-right fa-chevron-down');
    $('.sidebar-category-accordeon .active > .icon').children('.fa').toggleClass('fa-chevron-down');
    $('.sidebar-category-accordeon .icon').click(function () {
        $(this).toggleClass('active');
        $(this).parent().toggleClass('open');
        if ($(this).parent().hasClass('open')) {
            $(this).children('.fa').toggleClass('fa-chevron-down fa-chevron-right');
            $(this).siblings('ul').slideDown(150);
        } else {
            $(this).children('.fa').toggleClass('fa-chevron-right fa-chevron-down ');
            $(this).siblings('ul').slideUp(150);
        }
    });

    $('.sidebar-category-accordeon .with-child').click(function () {
        $(this).toggleClass('act');
        $(this).toggleClass('op');
        if ($(this).hasClass('op')) {
            $(this).siblings('.level1').slideDown(150);
        } else {
            $(this).siblings('.level1').slideUp(150);
        }
    });
</script>