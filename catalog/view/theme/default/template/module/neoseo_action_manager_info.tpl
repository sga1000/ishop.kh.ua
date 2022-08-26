<?php echo $header; ?>
<?php echo $content_top; ?>

<div class="container">

    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>

    <div id="content" class="action-content">

        <?php if ( true ) { ?>
        <script type="text/javascript" src="catalog/view/theme/default/javascript/jquery.responsive_countdown.min.js"></script>
        <?php } ?>

        <div class="container">
            <div class="row">

                <h1><?php echo $heading_title; ?></h1>

                <div class="action-item">
                    <div class="item">

                        <div class="item-top">
                            <div class="item-pic"><img alt="" src="<?php echo $image; ?>"></div>
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
                                            fillStylesPanel_g1_1: "rgba(140,140,140,1)",
                                            fillStylesPanel_g1_2: "rgba(90,90,90,1)",
                                            fillStylesPanel_g2_1: "rgba(140,140,140,1)",
                                            fillStylesPanel_g2_2: "rgba(90,90,90,1)",
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

                        </div>

                    </div>
                    <div class="item-bottom">
                        <?php echo $full_text; ?>
                    </div>

                </div>
            </div>

        </div>
    </div>
    <div class="container short-container">
        <div class="row producte">

            <?php if(isset($products)){  foreach ($products as $product) { ?>

            <div class="product-layout product-grid col-xs-12 col-sm-4 col-md-3" itemscope itemtype="http://schema.org/Product" itemprop="itemListElement">
                <div class="product-thumb clearfix">
                    <div class="image">
                        <a href="<?php echo $product['href']; ?>" itemprop="url">
                            <?php if ($product['thumb1']) { ?>
                            <img class="hoverable" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" itemprop="image" over="<?php echo $product['thumb1']; ?>" out="<?php echo $product['thumb']; ?>" />
                            <?php } else { ?>
                            <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" itemprop="image"/>
                            <?php } ?>
                        </a></div>
                    <div>
                        <div class="caption">
                            <h4 itemprop="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                            <h5 class="text-center stock-status-text-<?php echo $product['stock_status_id']; ?>" <?php if( isset($colors_status[$product['stock_status_id']]) ) { echo "style=\"color: " . $colors_status[$product['stock_status_id']]['font_color'] . ";\""; } ?>><b><?php echo $product['stock_status']; ?></b></h5>

                            <div class="rating"   <?php if($product['rating']){ ?> itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"<?php }?> >
                            <?php if($product['rating']){ ?>
                            <meta itemprop="reviewCount" content="<?php echo $product['md_review_count']; ?>">
                            <meta itemprop="ratingValue" content="<?php echo $product['rating']; ?>">
                            <?php }?>
                            <?php for ($i = 1; $i <= 5; $i++) { ?>
                            <?php if ($product['rating'] < $i) { ?>
                            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                            <?php } else { ?>
                            <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                            <?php } ?>
                            <?php } ?>
                        </div>

                        <?php if ($product['price']) { ?>
                        <p class="price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                            <meta itemprop="price" content="<?php echo rtrim(preg_replace("/[^0-9\.]/", "", ($product['special'] ? $product['special'] : $product['price'])), '.'); ?>" />
                            <meta itemprop="priceCurrency" content="<?php echo $md_currency ?>"/>
                            <link itemprop="availability" href="http://schema.org/<?php echo ($product['md_availability'] ? " InStock" : "OutOfStock") ?>" />
                            <?php if (!$product['special']) { ?>
                            <?php echo $product['price']; ?>
                            <?php } else { ?>
                            <span class="price-old"><?php echo $product['price']; ?></span><span class="price-new"><?php echo $product['special']; ?></span>
                            <?php } ?>
                            <?php if ($product['tax']) { ?>
                            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                            <?php } ?>
                        </p>
                        <?php } ?>
                    </div>
                    <div class="button-group">
                        <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
                        <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
                        <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
                    </div>

                    <div class="description" itemprop="description"><?php echo $product['description']; ?></div>
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

<?php echo $content_bottom; ?>

<?php echo $footer; ?>