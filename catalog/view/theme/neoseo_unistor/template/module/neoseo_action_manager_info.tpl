<?php echo $header; ?>
<?php echo $content_top; ?>

<div class="container">
    <?php require_once(dirname(__FILE__) . '/../common/breadcrumbs.tpl'); ?>

    <div id="content" class="action-content">

        <?php if ( true ) { ?>
        <script type="text/javascript" src="catalog/view/theme/neoseo_unistor/javascript/jquery.responsive_countdown.min.js"></script>
        <?php } ?>

        <div class="container">
            <div class="row">

                <h1><?php echo $heading_title; ?></h1>

                <div class="action-item">
                    <div class="item">

                        <div class="item-top">
                            <div class="item-pic"><img alt="" src="<?php echo $image; ?>"></div>
                        </div>

                        <div class="item-bottom">
                            <div class="item-desc">

                                <?php if ( false ) { ?>
                                <div class="item-type"><?php echo $action_status_title; ?></div>
                                <?php } ?>

                                <?php if( $date_end != 'EXP'){  ?>
                                <div class="timer-title"><?php echo $till_finish; ?>:</div>
                                <script type="text/javascript">
                                    $(function () {
                                        $("#countdown-action").ResponsiveCountdown({
                                            target_date: "<?php echo $date_end; ?>",
                                            time_zone: 0, target_future: true,
                                            set_id: 0, pan_id: 0, day_digits: 2,
                                            fillStyleSymbol1: "rgba(255,255,255,1)",
                                            fillStyleSymbol2: "rgba(255,255,255,1)",
                                            fillStylesPanel_g1_1: "rgba(223,83,42,1)",
                                            fillStylesPanel_g1_2: "rgba(223,83,42,1)",
                                            fillStylesPanel_g2_1: "rgba(223,83,42,1)",
                                            fillStylesPanel_g2_2: "rgba(223,83,42,1)",
                                            text_color: "rgba(68, 68, 68, 1)",
                                            text_glow: "rgba(0,0,0,0)",
                                            show_ss: true, show_mm: true,
                                            show_hh: true, show_dd: true,
                                            f_family: "Arial", show_labels: true,
                                            type3d: "group", max_height: 100,
                                            days_long: "<?php echo $days_left; ?>", days_short: "dd",
                                            hours_long: "<?php echo $hours_left; ?>", hours_short: "hh",
                                            mins_long: "<?php echo $minutes_left; ?>", mins_short: "mm",
                                            secs_long: "<?php echo $seconds_left; ?>", secs_short: "ss",
                                            min_f_size: 11, max_f_size: 36,
                                            spacer: "circles", groups_spacing: 3, text_blur: 2,
                                            font_to_digit_ratio: 0.125, labels_space: 1.2
                                        });
                                    });
                                </script>
                                <div class="timer-time" id="countdown-action" style="position: relative; height:auto;"></div>
                                <?php } else {
                                            echo '<div class="timer-title">'.$action_finish.'</div>';
                            }?>

                            <?php echo $short_text; ?>
                        </div>

                    </div>
                </div>
                    <div class="item-text">
                        <?php echo $full_text; ?>
                    </div>


                </div>
            </div>

        </div>
    <div class="module">
        <h3 class="text-center"><?php echo $text_action_title; ?></h3>
        <div class="row">

            <?php if(isset($products)){  foreach ($products as $product) { ?>

            <div class="product-layout product-grid col-md-3 col-sm-6 col-xs-12">
                <div itemscore="" class="product-thumb box-shadow box-corner clearfix">
                    <div class="product-thumb_top">
                        <!-- NeoSeo Product Labels - begin -->
                        <?php if( isset($product['labels']) && count($product['labels'])>0 ) { ?>
                        <?php foreach($product['labels'] as $label_wrap => $group_label) { ?>
                        <div class="<?php echo $label_wrap; ?>">
                            <?php foreach($group_label as $label) { ?>
                            <div class="tag <?php echo $label['label_type']; ?> <?php echo $label['position']; ?> <?php echo $label['class']; ?>"><span style="<?php echo $label['style']; ?>"><?php echo $label['text']; ?></span></div>
                            <?php } ?>
                        </div>
                        <?php } ?>
                        <?php } ?>
                        <!-- NeoSeo Product Labels - end -->
                        <div class="image">
                            <a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>">
                                <?php if ($product['thumb']) { ?>
                                <img src="<?php echo $product['thumb']; ?>" width="200" height="200" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="hoverable img-responsive" itemprop="image" data-over="<?php echo $product['thumb1']; ?>" data-out="<?php echo $product['thumb']; ?>" />
                                <?php } else { ?>
                                <img src="<?php echo $product['thumb']; ?>" width="200" height="200" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" itemprop="image" class="img-responsive" />
                                <?php } ?>
                            </a>
                        </div>
                        <meta itemprop="url" content="<?php echo $product['href']; ?>" >
                    </div>
                    <div class="product-thumb_middle">
                        <div class="rating-container">
                            <div class="caption">
                                <h4 itemprop="name"><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></a></h4>
                                <?php if (isset($product['additional_attributes']) && $product['additional_attributes']) { ?>
                                <div class="attributes-top">
                                <?php $counter = 1; ?>
                                    <?php foreach ($product['additional_attributes'] as $key => $attribute) { ?>
                                        <span><b><?php echo $attribute['name']; ?></b> <?php echo $attribute['text']; ?></span><?php if ($counter < $product['total_attributes']) { echo $divider ? $divider : ''; } ?>
                                        <?php $counter++; } ?>
                                </div>
                                <?php } ?>
                            </div>
                            <span class="rating"  <?php if($product['rating']){ ?> itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"<?php }?> >
                            <?php if($product['rating']){ ?>
                            <meta itemprop="reviewCount" content="<?php echo $product['md_review_count']; ?>">
                            <meta itemprop="ratingValue" content="<?php echo $product['rating']; ?>">
                            <?php for ($i = 1; $i <= 5; $i++) { ?>
                            <?php if ($product['rating'] < $i) { ?>
                            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                            <?php } else { ?>
                            <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                            <?php }?>
                            <?php } ?>
                            <?php } ?>
                            </span>
                        </div>
                        <div class="caption">
                            <h4 itemprop="name"><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></a></h4>
                            <?php if (isset($product['additional_attributes']) && $product['additional_attributes']) { ?>
                            <div class="attributes-top">
                                <?php $counter = 1; ?>
                                <?php foreach ($product['additional_attributes'] as $key => $attribute) { ?>
                                <span><b><?php echo $attribute['name']; ?></b> <?php echo $attribute['text']; ?></span><?php if ($counter < $product['total_attributes']) { echo $divider ? $divider : ''; } ?>
                                <?php $counter++;} ?>
                            </div>
                            <?php } ?>
                        </div>
                        <?php if ($product['price']) { ?>
                        <div class="price-and-cart-add">
                            <div class="price-wrapper">
                                <p class="price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                                    <meta itemprop="price" content="<?php echo rtrim(preg_replace("/[^0-9\.]/", "", ($product['special'] ? $product['special'] : $product['price'])), '.'); ?>" />
                                    <meta itemprop="priceCurrency" content="<?php echo $md_currency ?>"/>
                                    <link itemprop="availability" href="http://schema.org/<?php echo ($product['md_availability'] ?'InStock' : 'OutOfStock') ?>" />
                                    <?php if (!$product['special']) { ?>
                                    <?php echo $product['price']; ?>
                                    <?php } else { ?>
                                    <span class="price-old"><?php echo $product['price']; ?></span><span class="price-new"><?php echo $product['special']; ?></span>
                                    <?php } ?>
                                    <?php if ($product['tax']) { ?>
                                    <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                                    <?php } ?>
                                </p>
                            </div>
                            <?php } ?>
                            <div class="input-group input-quantity-group" data-min-quantity="<?php echo $product['minimum']; ?>">
                                  <span class="input-group-btn">
                                    <button type="button" class="btn btn-default" data-type="minus" data-field="input-quantity">
                                        <span class="glyphicon glyphicon-minus"></span>
                                    </button>
                                  </span>
                                <input type="text" name="quantity" value="<?php echo $product['minimum']; ?>" size="2" class="form-control quantity">
                                <span class="input-group-btn">
                                    <button type="button" class="btn btn-default" data-type="plus" data-field="input-quantity">
                                        <span class="glyphicon glyphicon-plus"></span>
                                    </button>
                                </span>
                            </div>

                            <div class="button-group-cart">
                                <span class="text-right stock-status-text-<?php echo $product['stock_status_id']; ?>" style="color:<?php echo $product['stock_status_color'] ?>;"><?php echo $product['stock_status']; ?></span>
                                <button class="cart-add-button" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs"><?php echo $button_cart; ?></span></button>
                            </div>
                        </div>
                    </div>

                    <div class="description" itemprop="description">
                        <div class="description-top">
                            <?php echo $product['short_description']; ?>
                        </div>
                        <div class="description-bottom">
                            <div class="button-group">
                                <a class="wishlist-button" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
                                    <i class="fa fa-heart"></i>
                                    <span><?php echo $text_wishlist; ?></span>
                                </a>
                                <a class="compare-button"  onclick="compare.add('<?php echo $product['product_id']; ?>');">
                                    <i class="ns-clone"></i>
                                    <span><?php echo $text_compare; ?></span>
                                </a>
                                <?php if( $neoseo_quick_order_status ) { ?>
                                <a type="button" class="buy-one-click" onclick="showQuickOrder('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
                                    <i class="ns-mouse" aria-hidden="true"></i>
                                    <span><?php echo $text_one_click_buy; ?></span>
                                </a>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <?php } } ?>

        </div>
        <div class="row">
            <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
            <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
    </div>
    </div>


</div>
</div>

<?php echo $content_bottom; ?>

<?php echo $footer; ?>