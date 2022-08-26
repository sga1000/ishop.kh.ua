<div id="main-search">
    <div class="input-group search-panel <?php if ($menu_main_type) { ?>box-shadow box-corner<?php } ?>">

        <?php if( !isset($hide_categories) || !$hide_categories ) { ?>
        <div class="input-group-btn">
            <button onclick="return false;" type="button"  class="dropdown-toggle category-button" data-toggle="dropdown"><i class="fa fa-th-list stiky-list" aria-hidden="true"></i>
                <span data-categoryid="" class="category-list-title"><?php echo $text_all_categories; ?></span> <span class="caret"></span></button>
            <div class="dropdown-menu" role="menu">
                <div class="main-menu-category_item">
                    <a href="" class="item-search" onclick="return false;" data-categoryid="">
                        <?php echo $text_all_categories; ?>
                    </a>
                </div>
                <?php foreach ($categories as $category) { ?>
                <div class="main-menu-category_item">
                    <a href="" class="item-search" onclick="return false;" data-categoryid="<?php echo $category['category_id']; ?>">
                        <?php echo $category['name']; ?>
                    </a>
                </div>
                <?php } ?>
            </div>
        </div>
        <?php } ?>
        <input type="text" class="form-control" name="search" autocomplete="off" value="<?php echo $search; ?>" placeholder="<?php echo $text_search; ?>" >
        <span class="input-group-btn">
        <button type="button" class="btn btn-default btn-lg button-search ">
            <i class="fa fa-search button-search-icon"></i>
            <span class="button-search-title"><?php echo $button_search; ?></span>
        </button>
    </span>
    </div>
</div>

<script>
    $('.item-search').on('click', function () {
        var category = $(this);
        $('.category-list-title').text(category.text());
        $('.category-list-title').attr('data-categoryid',(category.data('categoryid')));
    })
</script>