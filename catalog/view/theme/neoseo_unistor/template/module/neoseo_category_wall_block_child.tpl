<div class="module">
    <h3><?php echo $heading_title; ?></h3>
    <h4><?php echo $description; ?></h4>
    <div class="category-tree-box">
        <div class="row category-tree-child">
            <?php foreach ($categories as $category) { ?>
            <div class="category-block col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <?php if ($category['image'] && $category['image'] != '') { ?>
                <div class="image">
                    <a href="<?php echo $category['href'];?>" title="<?php echo $category['name']; ?>">
                        <img src="<?php echo $category['image']; ?>" width="200" height="200" alt="<?php echo $category['name']; ?>"/>
                    </a>
                </div>
                <?php } ?>
                    
                <div class="list-box">
                    <div class="name-box">
                        <a href="<?php echo $category['href']; ?>">
                            <?php echo $category['name']; ?>
                        </a>
                    </div>
                    <?php if ($category['children']) { ?>
                    <ul>
                        <?php foreach ($category['children'] as $children) { ?>
                        <li><a href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a></li>
                        <?php } ?>
                    </ul>
                    <?php } ?>
                </div>
            </div>
            <?php } ?>
        </div>
    </div>
</div>