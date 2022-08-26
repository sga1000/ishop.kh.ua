<div id="search_header">
    <div id="search_close">&times;</div>
</div>
<div id="search_content">
    <?php foreach ($products as $product) { ?>
    <div class="search-item clearfix">
        <a class="name" href="<?php echo $product['href']; ?>">
            <?php if (isset($product['image'])) { ?>
            <img src="<?php echo $product['image']; ?>"/>
            <?php } ?>
            <div class="search-column">
                <span class="product-title"><?php echo $product['name']; ?></span>


                <?php if ($product['rating']) { ?>
                <div class="rating">
                    <?php for ($i = 0; $i < 5; $i++) { ?>
                    <?php if ($i < $product['rating']) { ?>
                    <span class="fa fa-stack">
                                <i class="fa fa-star fa-stack-2x"></i>
                                <i class="fa fa-star-o fa-stack-2x"></i>
                            </span>
                    <?php } else { ?>
                    <span class="fa fa-stack">
                                <i class="fa fa-star-o fa-stack-2x"></i>
                            </span>
                    <?php } ?>
                    <?php } ?>
                </div>
                <?php } ?>

                <?php if (isset($product['model'])) { ?>
                <span class="model"><?php echo $result['model']; ?></span>
                <?php } ?>

                <?php if (isset($product['sku'])) { ?>
                <span class="sku"><?php echo $product['sku']; ?></span>
                <?php } ?>

                <?php if ($product['description']) { ?>
                <span class="description"><?php echo $product['description']; ?></span>
                <?php } ?>

                <?php if (isset($product['price'])) { ?>
                <?php if (!$product['special']) { ?>
                <span class="price"><?php echo $product['price']; ?></span>
                <?php } else { ?>
                        <div class="wrapper-price">
                            <span class="price-old"><?php echo $product['price']; ?></span>
                            <span class="price"><?php echo $product['special']; ?></span>
                        </div>
                <?php } ?>
                <?php } ?>
            </div>
        </a>

    </div>
    <?php } ?>
    <div id="search_footer">
        <a href="#" onclick="searchgoto(); return false;" id='goto_search'><?php echo $text_look_results; ?></a>
    </div>
</div>


<script>
    $('body, #search_close').on('click', () => {
        $('#search_main').hide();
    });

    var searchgoto = () => {
        //let url = $('base').attr('href') + 'index.php?route=product/search';

        let url = '';

        let current_language_code =  $('.language__compact-wrap li.active').attr('data-code');

        if (current_language_code === undefined || current_language_code === null) {
            url = 'index.php?route=product/search';
        } else {
            url = current_language_code + '/index.php?route=product/search';
        }

        if (value = $('<?php echo $selector; ?>').val()) {
            url += '&search=' + encodeURIComponent(value);

            if (filter_category = $('.category-list-title').data('categoryid')) {
                url += '&category_id=' + filter_category + '&sub_category=true';
            }
        }

        location = url;
    };
</script>