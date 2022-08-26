<?php if ($products) { ?>
    <h3><?php echo $heading_title; ?></h3>
    <div class="row">
        <?php foreach ($products as $product) { ?>
            <div class="product-layout col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="product-thumb transition">
                    <!-- NeoSeo Product Labels - begin -->
                    <?php if (isset($product['labels']) && $product['labels']) { ?>
                        <?php foreach ($product['labels'] as $label_wrap => $group_label) { ?>
                            <div class="<?php echo $label_wrap; ?>">
                                <?php foreach ($group_label as $label) { ?>
                                    <div class="tag <?php echo $label['label_type']; ?> <?php echo $label['position']; ?> <?php echo $label['class']; ?>">
                                        <span style="<?php echo $label['style']; ?>"><?php echo $label['text']; ?></span>
                                    </div>
                                <?php } ?>
                            </div>
                        <?php } ?>
                    <?php } ?>
                    <!-- NeoSeo Product Labels - end -->
                    <div class="image">
                        <a href="<?php echo $product['href']; ?>">
                            <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive"/>
                        </a>
                    </div>
                    <div class="caption">
                        <h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                        <p><?php echo $product['description']; ?></p>
                        <?php if ($product['rating']) { ?>
                            <div class="rating">
                                <?php for ($i = 1; $i <= 5; $i++) { ?>
                                    <?php if ($product['rating'] < $i) { ?>
                                        <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                    <?php } else { ?>
                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i>
                                            <i class="fa fa-star-o fa-stack-2x"></i>
                                        </span>
                                    <?php } ?>
                                <?php } ?>
                            </div>
                        <?php } ?>
                        <?php if ($product['price']) { ?>
                            <p class="price">
                                <?php if (!$product['special']) { ?>
                                    <?php echo $product['price']; ?>
                                <?php } else { ?>
                                    <span class="price-new"><?php echo $product['special']; ?></span>
                                    <span class="price-old"><?php echo $product['price']; ?></span>
                                <?php } ?>
                                <?php if ($product['tax']) { ?>
                                    <span class="price-tax"><?php echo $text_tax; ?><?php echo $product['tax']; ?></span>
                                <?php } ?>
                            </p>
                        <?php } ?>
                    </div>
                    <div class="button-group">
                        <!-- NeoSeo Notify When Available - begin -->
                        <?php if (!$product['snwa_status'] && !$product['snwa_status']) { ?>
                            <!-- NeoSeo Notify When Available - end -->
                            <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');">
                                <i class="fa fa-shopping-cart"></i>
                                <span class="hidden-xs hidden-sm hidden-md"> <?php echo $button_cart; ?></span>
                            </button>
                            <!-- NeoSeo Notify When Available - begin -->
                        <?php } else { ?>
                            <button type="button" onclick="showNWA('<?php echo $product['product_id'] ?>',this);" data-checked="<?php echo $product['snwa_requested'] ? 'true' : 'false'; ?>">
                                <i class="fa fa-bell"></i>
                                <span class="hidden-xs hidden-sm hidden-md snwa_button_<?php echo $product['product_id'] ?>"><?php echo $product['snwa_requested'] ? $button_snwa_unsubscribe : $button_snwa_subscribe; ?></span>
                            </button>
                        <?php } ?>
                        <!-- NeoSeo Notify When Available - end -->
                        <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
                            <i class="fa fa-heart"></i>
                        </button>
                        <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');">
                            <i class="fa fa-clone"></i>
                        </button>
                    </div>
                </div>
            </div>
        <?php } ?>
    </div>
<?php } ?>