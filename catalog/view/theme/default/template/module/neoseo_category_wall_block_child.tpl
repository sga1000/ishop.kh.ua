<div class="category-tree-box">
    <?php if ($category_name) { ?>
        <div class="title">
            <div class="title-inner">
                <i class="icon-eye2"></i>
                <span><?php echo $category_name; ?></span>
            </div>
        </div>
    <?php } ?>
    <h4><?php echo $description; ?></h4>
    <div class="row">
        <?php foreach ($categories as $category) { ?>
        <div class="category-block col-lg-3 col-md-3 col-sm-6 col-xs-12">
            <div class="category-block-container box-shadow box-corner">
                <?php if ($category['image'] && $category['image'] != '') { ?>
                    <div class="image">
                        <a href="<?php echo $category['href'];?>">
                            <img src="<?php echo $category['image']; ?>"/>
                        </a>
                    </div>
                <?php } ?>
                <div class="list-box">
                    <a href="<?php echo $category['href']; ?>">
                        <?php echo $category['name']; ?>
                    </a>
                    <?php if ($category['children']) { ?>
                        <ul>
                            <?php foreach ($category['children'] as $children) { ?>
                                <li><a href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a></li>
                            <?php } ?>
                        </ul>
                    <?php } ?>
                </div>
                <div class="category-block-container box-shadow box-corner">
                </div>
                <?php } ?>
            </div>
        </div>