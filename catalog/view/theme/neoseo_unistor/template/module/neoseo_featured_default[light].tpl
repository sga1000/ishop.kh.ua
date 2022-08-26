<div class="module">
    <?php if($heading_title){ ?>
    <h3><?php echo $heading_title; ?></h3>
    <?php } ?>
    <?php if($block_description != "" ){ ?>
    <div class="text-center action-term"><?php echo $block_description; ?></div>
    <?php } ?>
    <div class="product-previews-light --module module-grid-<?php echo $limit_p; ?> light">
        <?php foreach ($products as $product) { ?>
        <div class="product-preview__layout">
            <div class="product-preview__thumb box-shadow box-corner">
                <div class="product-preview__thumb-image">
                    <?php if( isset($product['labels']) && count($product['labels'])>0 ) { ?>
                    <!-- NeoSeo Product Labels - begin -->
                    <?php foreach($product['labels'] as $label_wrap => $group_label) { ?>
                    <?php foreach($group_label as $label) { ?>
                    <div class="product-preview-label <?php echo $label['label_type']; ?> <?php echo $label['position']; ?> <?php echo $label['class']; ?>">
                                            <span style="<?php echo $label['style']; ?>">
                                                <?php echo $label['text']; ?>
                                            </span>
                    </div>
                    <?php } ?>
                    <?php } ?>
                    <!-- NeoSeo Product Labels - end -->
                    <?php } ?>

                    <a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>">
                        <?php if ($product['thumb']) { ?>
                        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="hoverable img-responsive" data-over="<?php echo $product['thumb1']; ?>" data-out="<?php echo $product['thumb']; ?>" />
                        <?php } else { ?>
                        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                        <?php } ?>
                    </a>
                </div>
                <div class="product-preview__thumb-name">
                    <a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></a>
                </div>
                <?php if ($product['price']) { ?>
                <div class="product-preview__thumb-price">
                    <?php if (!$product['special']) { ?>
                    <span class="--price-default"><?php echo $product['price']; ?></span>
                    <?php } else { ?>
                    <span class="--price-old"><?php echo $product['price']; ?></span>
                    <span class="--price-new"><?php echo $product['special']; ?></span>
                    <?php } ?>
                    <?php if ($product['tax']) { ?>
                    <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                    <?php } ?>
                </div>
                <?php } ?>

                <div class="product-preview__thumb-bottom">
                    <?php if (isset($product['additional_attributes']) && $product['additional_attributes']) { ?>
                    <div class="product-preview__attributes">
                        <?php $counter = 1; ?>
                        <?php foreach ($product['additional_attributes'] as $key => $attribute) { ?>
                        <span><b><?php echo $attribute['name']; ?></b> <?php echo $attribute['text']; ?></span><?php if ($counter < $product['total_attributes']) { echo $divider ? $divider : ''; } ?>
                        <?php $counter++;
                                    } ?>
                    </div>
                    <?php } ?>
                    <div class="product-preview__thumb-buttons">
                        <button class="add-button" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><?php echo $button_cart; ?></button>
                        <?php if( $neoseo_quick_order_status ) { ?>
                        <a data-toggle="tooltip" title="<?php echo $text_one_click_buy; ?>" type="button" class="one-click" onclick="showQuickOrder('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
                            <i class="fa fa-mouse-pointer"></i>
                        </a>
                        <?php } ?>
                        <a data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" class="wishlist" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
                            <i class="fa fa-heart-o"></i>
                        </a>
                    </div>
                </div>

            </div>
        </div>
        <?php } ?>
    </div>
    <?php if($block_description != "" ){ ?>
    <p class="module__subtitle"><?php echo $block_description; ?></p>
    <?php } ?>
    <?php if($use_banner == 1) { ?>
    <div class="col-xs-12 col-sm-6 block-flex flex-stretch">
        <?php if($banner_link != "") { ?>
        <a href="<?php echo $banner_link; ?>" ><img src="<?php echo $image_banner; ?>" class="" style="width:<?php echo $banner_width; ?>px; height:<?php echo $banner_height; ?>px;"></a>
        <?php } else { ?>
        <img src="<?php echo $image_banner; ?>" class="" style="width:<?php echo $banner_width; ?>px; height:<?php echo $banner_height; ?>px;">
        <?php } ?>
    </div>
    <?php } ?>
</div>
