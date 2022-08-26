<div class="module">
    <h3><?php echo $heading_title; ?></h3>
    <h4><?php echo $description; ?></h4>
    <div class="category-tree-box">
        <div class="row category-grid">
            <?php foreach ($categories as $category) { ?>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="category-block">
                    <?php if ($category['image'] && $category['image'] != '') { ?>
                    <div class="image">
                        <a href="<?php echo $category['href'];?>">
                            <img class="img-responsive" src="<?php echo $category['image']; ?>"/>
                        </a>
                    </div>
                    <?php } ?>

                    <div class="list-box">
                        <div class="name-box">
                            <a href="<?php echo $category['href']; ?>">
                                <?php echo $category['name']; ?>
                            </a>
                            <i class="fa fa-chevron-down" onclick="listToggle(this);"></i>
                        </div>
                        <?php if ($category['children']) { ?>
                        <ul class="list-unstyled">
                            <?php foreach ($category['children'] as $children) { ?>
                            <li><i class="fa fa-caret-right"></i><a href="<?php echo $children['href']; ?>"><?php echo $children['name']; ?></a></li>
                            <?php } ?>
                        </ul>
                        <?php } ?>
                    </div>
                </div>

            </div>
            <?php } ?>
        </div>
    </div>
    <script>
        function listToggle(elem) {
            $(elem).parent('.name-box').next().slideToggle();
            $(elem).toggleClass('fa-chevron-down fa-chevron-up');
        }
    </script>
</div>