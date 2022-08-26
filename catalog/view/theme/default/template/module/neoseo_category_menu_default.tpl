<div class="sidebar-category<?= $collapse == 1 ? ' is-collapsed' : '';?><?= $hide == 1 ? ' collaps' : '';?><?= $full_height == 1 ? ' full-height' : '';?>">
    <h3 class="category-header"><?php echo $head_title; ?></h3>
    <div class="box-content">
        <ul id="nav-one" class="dropmenu">
            <?php foreach ($categories as $category) { ?>
                <?php if (!isset($category['category_id'])) {
                    continue;
                } else {  ?>
                    <li class="level0 <?php if ($category['active']) { ?>activeicon<?php } ?>">
                        <?php if ($category['active']) { ?>
                            <a href="<?php echo $category['href']; ?>"  class="active"><?php echo $category['name']; ?></a>
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
    $('.sidebar-category.is-collapsed .category-header').click(function(){
        $('.sidebar-category').toggleClass('collaps');
        if( $('.sidebar-category').hasClass('collaps') ){
            $('.sidebar-category .dropmenu').slideUp(200);
        } else {
            $('.sidebar-category .dropmenu').slideDown(300);
        }
    })
</script>