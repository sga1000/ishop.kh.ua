<div class="side-module box-shadow box-corner sidebar-category-accordeon<?php echo $collapse == 1 ? ' is-collapsed' : '';?><?php echo $hide == 1 ? ' collaps' : '';?><?php echo $full_height == 1 ? ' full-height' : '';?>">
    <h3 class="category-header"><?php echo $heading_title; ?></h3>
    <div class="box-content">
        <div id="nav-one" class="dropmenu">
            <?php foreach ($categories as $category) { ?>
            <?php if (!isset($category['category_id'])) {
                    continue;
                } else {  ?>
            <div class="level0 <?php if ($category['active']) { ?>activeicon<?php } ?>">
                <?php if($hide == 0) $category['opened'] = 1; else $category['opened'] = 0; ?>
                <?php if ($category['active'] || $category['opened'] ) { ?>
                <?php if (!$category['children']) { ?><a href="<?php echo $category['href']; ?>"  class="<?php echo $category['active'] == 1 ? 'active' : '';?>"> <?php } else { ?><span class="<?php echo $category['active'] == 1 ? 'active' : '';?>" data-toggle="<?php echo $collapse == 1 ? 'collapse' : '';?>" data-target="#category-menu<?php echo $category['category_id']; ?>"><?php } ?><?php echo $category['name']; ?><?php if (!$category['children']) { ?></a> <?php } else { ?></span><?php } ?>
                <?php if ($category['children'] ){ ?><!-- <?php echo $hide; ?> chevron-down --><i class="fa fa-chevron-down"  data-toggle="<?php echo $collapse == 1 ? 'collapse' : '';?>" data-target="#category-menu<?php echo $category['category_id']; ?>" <?php if($collapse == 0) { ?> style="display:none;" <?php } ?> ></i><?php } ?>
                <?php } else { ?>

                <?php if (!$category['children']) { ?><a href="<?php echo $category['href']; ?>"><?php } else { ?><span data-toggle="<?php echo $collapse == 1 ? 'collapse' : '';?>" data-target="#category-menu<?php echo $category['category_id']; ?>"><?php } ?><?php echo $category['name']; ?><?php if (!$category['children']) { ?></a><?php } else { ?></span><?php } ?>

                <?php if ($category['children']) { ?><!-- <?php echo $hide; ?> fa-chevron-right --><i class="fa fa-chevron-right"  data-toggle="<?php echo $collapse == 1 ? 'collapse' : '';?>" data-target="#category-menu<?php echo $category['category_id']; ?>"  <?php if($collapse == 0) { ?> style="display:none;" <?php } ?> ></i><?php } ?>

                <?php } ?>
            </div>
            <?php if ($category['children']) { ?>
            <div id="category-menu<?php echo $category['category_id']; ?>" class="level1 <?php echo ($hide == 1) && ($collapse == 1 ) ? ' collapse' : '';?> <?php if ($category['active']) { ?>in<?php } ?>" <?php if ($category['active']) { ?> aria-expanded="true"<?php } ?>>
            <?php foreach ($category['children'] as $child) { ?>
            <div class="<?php if ($child['active']) { ?>activeicon <?php } ?> child-item">
                <?php if ($child['active']) { ?>
                <?php if ($child['children']) { ?><i class="fa fa-caret-up"  data-toggle="collapse" data-target="#category-menu<?php echo $child['category_id']; ?>"></i><?php } ?>
                <?php if (!$child['children']) { ?><a href="<?php echo $child['href']; ?>"  class="active"><?php } else { ?><span class="active"  data-toggle="collapse" data-target="#category-menu<?php echo $child['category_id']; ?>" ><?php } ?><?php echo $child['name']; ?> <?php if (!$child['children']) { ?></a><?php } else { ?></span><?php } ?>
                <?php } else { ?>
                <?php if ($child['children']) { ?><i class="fa fa-caret-down" data-toggle="collapse" data-target="#category-menu<?php echo $child['category_id']; ?>" ></i><?php } ?>
                <?php if (!$child['children']) { ?><a href="<?php echo $child['href']; ?>"><?php } else { ?><span  data-toggle="collapse" data-target="#category-menu<?php echo $child['category_id']; ?>" ><?php } ?><?php echo $child['name']; ?> <?php if (!$child['children']) { ?></a><?php } else { ?></span><?php } ?>
                <?php } ?>
            </div>
            <?php if ($child['children']) { ?>
            <div id="category-menu<?php echo $child['category_id']; ?>" class="level2 collapse <?php if ($child['active']) { ?>in<?php } ?>" <?php if ($child['active']) { ?> aria-expanded="true"<?php } ?>>
            <?php foreach ($child['children'] as $child2) { ?>
            <div class="<?php if ($child2['active']) { ?>activeicon <?php } ?>child-sub-item">
                <?php if ($child2['active']) { ?>
                <?php if (!$child2['children']) { ?><a href="<?php echo $child2['href']; ?>"  class="active"><?php } else { ?><span class="active" data-toggle="collapse" data-target="#category-menu<?php echo $child2['category_id']; ?>" ><?php } ?><?php echo $child2['name']; ?> <?php if (!$child2['children']) { ?></a><?php } else { ?></span><?php } ?>
                <?php if ($child2['children']) { ?><i class="fa fa-caret-up" data-toggle="collapse" data-target="#category-menu<?php echo $child2['category_id']; ?>"></i><?php } ?>
                <?php } else { ?>
                <?php if (!$child2['children']) { ?><a href="<?php echo $child2['href']; ?>"><?php } else { ?><span data-toggle="collapse" data-target="#category-menu<?php echo $child2['category_id']; ?>" ><?php } ?><?php echo $child2['name']; ?><?php if (!$child2['children']) { ?></a><?php } else { ?></span><?php } ?>
                <?php if ($child2['children']) { ?><i class="fa fa-caret-down" data-toggle="collapse" data-target="#category-menu<?php echo $child2['category_id']; ?>" ></i><?php } ?>
                <?php } ?>
            </div>
            <?php if ($child2['children']) { ?>
            <div id="category-menu<?php echo $child2['category_id']; ?>" class="level3 collapse <?php if ($child2['active']) { ?>in<?php } ?>" <?php if ($child2['active']) { ?> aria-expanded="true"<?php } ?>>
            <?php foreach ($child2['children'] as $child3) { ?>
            <div class="<?php if ($child3['active']) { ?>activeicon <?php } ?> child3-item">
                <?php if ($child3['active']) { ?>
                <a href="<?php echo $child3['href']; ?>"  class="active" data-toggle="collapse" data-target="#category-menu<?php echo $child3['category_id']; ?>"><?php echo $child3['name']; ?></a>
                <?php if ($child3['children']) { ?><i class="fa fa-chevron-down" data-toggle="collapse" data-target="#category-menu<?php echo $child3['category_id']; ?>"></i><?php } ?>
                <?php } else { ?>
                <a href="<?php echo $child3['href']; ?>" data-toggle="collapse" data-target="#category-menu<?php echo $child3['category_id']; ?>" ><?php echo $child3['name']; ?></a>
                <?php if ($child3['children']) { ?><i class="fa fa-chevron-right" data-toggle="collapse" data-target="#category-menu<?php echo $child3['category_id']; ?>"></i><?php } ?>
                <?php } ?>
            </div>
            <?php } ?>
        </div>
        <?php } ?>

        <?php } ?>
    </div>
    <?php } ?>

    <?php } ?>
</div>
<?php } ?>

<?php } ?>
<?php } ?>
</div>
</div>
</div>
<script>

    $('.level0 > span').click(function () {
        $(this).siblings('.fa').toggleClass('fa-chevron-right fa-chevron-down')
    });
    $('.child-item > span, .child-sub-item > span').click(function () {
        $(this).siblings('.fa').toggleClass('fa-caret-down fa-caret-up')
    });
    $('.level0 > i').click(function () {
        $(this).toggleClass('fa-chevron-right fa-chevron-down')
    });
    $('.child-item > i, .child-sub-item > i').click(function () {
        $(this).toggleClass('fa-caret-down fa-caret-up')
    });
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