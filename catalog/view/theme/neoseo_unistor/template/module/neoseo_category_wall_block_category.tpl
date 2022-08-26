<div class="module">
    <h3><?php echo $heading_title; ?></h3>
    <h4><?php echo $description; ?></h4>
    <div class="category-tree-box">
        <div class="category-tree-mosaic">
            <?php foreach ($categories as $category) { ?>

            <div class="category-block ">
                
                <div id="category-<?php echo $category['category_id']; ?>" class="">
                    <?php if ($category['image'] && $category['image'] != '') { ?>
                    <div class="list-box">
                        <a href="<?php echo $category['href']; ?>">
                            <span class=""><?php echo $category['name']; ?></span>
                        </a>
                    </div>
                    <div class="image">
                        <a href="<?php echo $category['href'];?>" title="<?php echo $category['name']; ?>">
                            <img src="<?php echo $category['image']; ?>" width="200" height="200" alt="<?php echo $category['name']; ?>"/>
                        </a>
                    </div>
                    <?php } ?>

                </div>
            </div>
            <?php } ?>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var viewportWidth = $(window).width();
        if (viewportWidth <= 767) {
            $('.collapse-category').addClass('collapse');
        } else if (viewportWidth >= 768){
            $('.collapse-category').removeClass('collapse');
        }
    });

    $(window).resize(function () {
        var viewportWidth = $(window).width();
        if (viewportWidth <= 767) {
            $('.collapse-category').addClass('collapse');
        } else if (viewportWidth >= 768){
            $('.collapse-category').removeClass('collapse');
        }
    });

    $('.category-button').click(function () {
        $(this).children('i').toggleClass('fa-chevron-down fa-chevron-up');
    });
</script>