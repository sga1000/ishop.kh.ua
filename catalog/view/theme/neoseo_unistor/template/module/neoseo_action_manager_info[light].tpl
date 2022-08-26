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
        <div class="product-previews-light module-grid-<?php echo $limit_p; ?> light">
            <?php if(isset($products)){  foreach ($products as $product) { ?>
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
