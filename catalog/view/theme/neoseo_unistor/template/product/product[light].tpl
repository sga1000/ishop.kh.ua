<?php echo $header; ?>
<!-- NeoSeo Product Link - begin -->
<?php if (isset( $edit_link ) ) { ?>
<script>
    $(document).ready(function(){
        $("h1").after('<div class="edit"><a target="_blank" href="<?php echo $edit_link; ?>">Редактировать ( видит только админ )</a></div>');
    });
</script>
<?php } ?>
<!-- NeoSeo Product Link - end -->
<div class="container">
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <div id="light" class="row">
        <?php echo $column_left; ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>

            <div class="product-top box-shadow box-corner clearfix">
                <div class="">


                    <!-- product-img-block -->
                    <div class="col-xs-12 col-sm-6 col-md-8 product-img-block">
                        <h1 class="product-title"><?php echo $heading_title; ?></h1>
                        <div class="product-model-block">
                            <div class="share-and-stock-box">
                                <?php echo $sharing_code; ?>
                            </div>
                            <?php if($model) { ?>
                            <p class="text-left model-block"><strong><?php echo $text_model; ?></strong> &nbsp;<span class=""><?php echo $model; ?></span></p>
                            <?php } ?>
                        </div>

                        <?php if ( isset($images_360) && $images_360) { ?>
                        <?php echo $images_360; ?>
                        <?php } ?>
                        <?php if ($thumb || $images) { ?>
                        <ul class="thumbnails<?php if (!$images) echo ' no-img' ?>">
                            <?php if ($thumb) { ?>
                            <li class="big_image" <?php if ( isset($images_360) && $images_360) { ?>style="display: none;"<?php } ?>>
                            <div class="big_image-slide-nav">
                                <div class="slide-nav_prev">
                                    <i class="fa fa-chevron-left"></i>
                                </div>
                                <div class="slide-nav_next">
                                    <i class="fa fa-chevron-right"></i>
                                </div>
                            </div>
                            <a class="thumbnail thin-0" href="<?php echo $popup; ?>">
                                <!-- NeoSeo Product Labels - begin -->
                                <?php if( isset($labels) && count($labels)>0 ) { ?>
                                    <?php foreach($labels as $label_wrap => $group_label) { ?> 
                                        <?php foreach($group_label as $label) { ?>
                                            <div class="product-preview-label <?php echo $label['label_type']; ?> <?php echo $label['position']; ?> <?php echo $label['class']; ?>">
                                                <span style="<?php echo $label['style']; ?>">
                                                    <?php echo $label['text']; ?>
                                                </span>
                                            </div>
                                        <?php } ?>
                                    <?php } ?>
                                <?php } ?>
                                <!-- NeoSeo Product Labels - end -->
                                <img src="<?php echo $thumb; ?>" data-zoom-image="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"/>
                            </a>
                            </li>
                            <?php } ?>

                            <?php if ($thumb || $images) { $imgcnt=0; ?>
                            <li id='zgalery'>
                                <ul class="more-image">
                                    <?php if ( isset($images_360) && $images_360) { ?>
                                    <li class="image-additional">
                                        <a class="thumbnail active thumb_360">
                                            <img id='img-add-org-360' src="/image/360.png" alt="<?php echo $heading_title; ?>"/>
                                        </a>
                                    </li>
                                    <?php } ?>

                                    <li class="image-additional">
                                        <a class="thumbnail <?php if ( !isset($images_360) || !$images_360) { ?>active<?php } ?>" href="<?php echo $thumb; ?>" data-image="<?php echo $thumb; ?>" data-zoom-image="<?php echo $popup; ?>">
                                            <img id='img-add-org' src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>"/>
                                        </a>
                                    </li>


                                    <?php foreach ($images as $image) { $imgcnt++; ?>
                                    <li class="image-additional">
                                        <a class="thumbnail" data-image="<?php echo $image['popup']; ?>" data-zoom-image="<?php echo $image['popup']; ?>">
                                            <img id='img-add-<?php echo $imgcnt; ?>' src="<?php echo $image['thumb']; ?>" data-zoom-image="<?php echo $popup; ?>" alt="<?php echo $heading_title; ?>"/>
                                        </a>
                                    </li>
                                    <?php } ?>
                                </ul>
                            </li>
                            <?php } ?>
                        </ul>
                        <?php } ?>
                        <script>
                            $('.more-image').readmore({
                                maxHeight: 90,
                                moreLink: '<a class="moreLink" href="#"><span><?php echo $text_see_all; ?><i class="fa fa-caret-down"></i></span></a>',
                                lessLink: '<a class="moreLink" style=" background: none;" href="#"><span><?php echo $text_collapse_all; ?><i class="fa fa-caret-up"></i></span></a>'
                            });

                        </script>
                        <div class="col-xs-12 hidden-xs hidden-sm">
                            <div class="product-delivery-block light">
                                <?php if( trim(strip_tags($shipping_info) ) ) { ?>
                                <div class="panel panel-default">
                                    <div class="panel-body shipping_info">
                                        <div class="shipping_info-title">
                                            <i class="fa fa-truck"></i>
                                            <span><?php echo $text_shipping; ?></span>
                                        </div>
                                        <?php echo $shipping_info; ?>
                                    </div>
                                </div>
                                <?php } ?>
                                <?php if( trim(strip_tags($payment_info) ) ) { ?>
                                <div class="panel panel-default">
                                    <div class="panel-body payment_info">
                                        <div class="payment_info-title">
                                            <i class="fa fa-credit-card"></i>
                                            <span><?php echo $text_payment; ?></span>
                                        </div>
                                        <?php echo $payment_info; ?>
                                    </div>
                                </div>
                                <?php } ?>
                                <?php if( trim(strip_tags($guarantee_info) ) ) { ?>
                                <div class="panel panel-default">
                                    <div class="panel-body guarantee_info">
                                        <div class="guarantee_info-title">
                                            <i class="fa fa-file-o"></i>
                                            <span><?php echo $text_guarantee; ?></span>
                                        </div>
                                        <?php echo $guarantee_info; ?>
                                    </div>
                                </div>
                                <?php } ?>
                            </div>
                            <script>
                                $('.product-delivery-block').readmore({
                                    maxHeight: 146,
                                    moreLink: '<a class="moreLink"><span><?php echo $text_more; ?></span></a>',
                                    lessLink: '<a class="moreLink ended" style=" background: none;"><span><?php echo $text_collapse_all; ?></span></a>'
                                });
                            </script>
                        </div>

                    </div>
                    <!-- product-img-block end -->


                    <!-- product-info-block -->
                    <div class="col-xs-12 col-sm-6 col-md-4 product-info-block">

                        <div class="product-list_top">

                            <?php if ($special && $date_special ) { ?>
                            <div class="product-info-block_action">
                                <?php echo $text_product_action; ?>
                            </div>
                            <script src="catalog/view/theme/neoseo_unistor/javascript/flipclock.min.js"></script>
                            <div id="first_countdown" ></div>
                            <script>
                                var clock = $('#first_countdown').FlipClock(<?php echo $date_special; ?>, {
                                    clockFace: 'DailyCounter',
                                        countdown: true,
                                        langauge: 'ru'
                                });
                            </script>

                            <?php } ?>
                            <div class="quicklinks">
                                <?php if( $product_to_email ) { ?>
                                <a href="javascript:void(0);" class="quicklinks__item" onclick="showProductToEmail('<?php echo $product_id; ?>')"><i class="icon-new-email-interface-symbol-of-black-closed-envelope"></i><span>Отправить на почту</span></a>
                                <?php } ?>
                                <?php if(isset($neoseo_notify_price_change_status) && $neoseo_notify_price_change_status){ ?>
                                <a data-toggle="tooltip" class="quicklinks__item" onclick="showNotifyPriceChange('<?php echo $product_id; ?>',this);" data-checked="<?php echo $npc_requested ? 'true' : 'false'; ?>"><i class="fa <?php echo !$npc_requested ? 'fa-line-chart' : 'fa-check-square-o'?>"></i> <?php echo $text_subscribe_npc;?></a>
                                <?php } ?>
                                <a data-toggle="tooltip" class="quicklinks__item" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-heart-o"></i><?php echo $button_wishlist; ?></a>
                                <a data-toggle="tooltip" class="quicklinks__item" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-clone"></i><?php echo $button_compare; ?></a>
                            </div>
                            <?php if ($price) { ?>

                            <!-- stock-status-block -->
                            <div class="status-block stock-status-block-<?php echo $stock_status_id; ?>" id="price" data-price="<?php echo rtrim(preg_replace("/[^0-9\.]/", "", ($special ? $special : $price)), '.'); ?>">
                            <div class="col-xs-8 col-sm-8 price-block" >
                                <div class="clearfix" style="font-size: 2em;">
                                    <div class="price-block_price"><?php echo $text_price; ?></div>
                                </div>
                                <?php if (!$special) { ?>
                                <div class="price-area product-price" style=""><?php echo $price; ?></div>
                                <?php } else { ?>
                                <div class="price-area old-price"><?php echo $price; ?></div>
                                <div class="product-price" ><?php echo $special; ?></div>
                                <?php } ?>

                                <?php if (!$special) { ?>
                                <div class="stock-status-text-<?php echo $stock_status_id; ?> status-text" style="color:<?php echo $stock_status_color ?>;"><?php echo $stock_status; ?></div>
                                <?php } else { ?>
                                <div class="stock-status-text-<?php echo $stock_status_id; ?> status-text" style=" color:<?php echo $stock_status_color ?>;"><?php echo $stock_status; ?></div>
                                <?php } ?>
                            </div>

                            <div class="col-xs-4 rating-wrap">
                                <!-- rating -->
                                <?php if ($review_status) { ?>
                                <?php if ($short_reviews_status) { ?>
                                <div class="rating text-left">
                                    <p>
                                        <?php for ($i = 1; $i <= 5; $i++) { ?>
                                        <?php if ($rating < $i) { ?>
                                        <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                                        <?php } else { ?>
                                        <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                                        <?php } ?>
                                        <?php } ?>
                                    </p>
                                </div>
                                <?php } ?>
                                <?php } ?>
                                <!-- rating end -->

                                <?php if ($short_reviews_status) { ?>
                                <a href="javascript:void(0)" id='show_comments' ><i class="fa fa-commenting" aria-hidden="true"></i><?php echo $reviews; ?></a>
                                <?php } ?>
                            </div>

                        </div>
                        <?php } ?>

                    </div>

                    <div class="product-list_middle">
                        <div class="middle-options-box">
                            <!-- begin if -->
                            <!-- product begin -->
                            <div id="product" class="product-options-block">
                                <?php if ($options) { ?>
                                <script src="catalog/view/theme/neoseo_unistor/javascript/jquery.formstyler.js"></script>
                                <script>
                                    (function($) {
                                        $(function() {
                                            $('.product-options-block select').styler({
                                                selectSearch: true,
                                                selectPlaceholder:'<?php echo $text_select; ?>'
                                            });
                                        });
                                    })(jQuery);
                                </script>

                                <div class="options-container  options-block">
                                    <?php foreach ($options as $option) { ?>
                                    <?php if ($option['type'] == 'select') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                        <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                                            <option value=""><?php echo $text_select; ?></option>
                                            <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                            <option value="<?php echo $option_value['product_option_value_id']; ?>" data-price="<?php echo trim(preg_replace('/[^\d\.]/i', '', $option_value['price']),"."); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>"><?php echo $option_value['name']; ?>
                                            <?php if ($option_value['price']) { ?>
                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                            <?php } ?>
                                            </option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'radio') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label"><?php echo $option['name']; ?></label>
                                        <div id="input-option<?php echo $option['product_option_id']; ?>">
                                            <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                            <div class="radio radio-square">
                                                <?php $r=rand(1,1000); ?>
                                                <label for='r-<?php echo $option['product_option_id'].$r; ?>'>
                                                <input type="radio" id='r-<?php echo $option['product_option_id'].$r; ?>' name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-price="<?php echo trim(preg_replace('/[^\d\.]/i', '', $option_value['price']),"."); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" />
                                                <div class="square"><?php echo $option_value['name']; ?></div>
                                                </label>
                                            </div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'checkbox') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label"><?php echo $option['name']; ?></label>
                                        <div id="input-option<?php echo $option['product_option_id']; ?>">
                                            <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                            <div class="checkbox checkbox-primary">
                                                <?php $r=rand(1,1000); ?>
                                                <input class="checkbox" type="checkbox" id='ch-<?php echo $r; ?>' name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" data-price="<?php echo trim(preg_replace('/[^\d\.]/i', '', $option_value['price']),"."); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" />
                                                <label for='ch-<?php echo $r; ?>'>
                                                    <?php echo $option_value['name']; ?> <?php if ($option_value['price']) { ?> ( <?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?> ) <?php } ?>
                                                </label>
                                            </div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'image') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label"><?php echo $option['name']; ?></label>
                                        <div id="input-option<?php echo $option['product_option_id']; ?>">
                                            <?php if (count($option['product_option_value']) >= 5000 ) { ?>
                                            <div class="product-carousel-box">
                                                <div id="carousel-radio-wrapper" class="radio-wrapper">
                                                    <div class="radio-image-wrapper">
                                                        <?php } ?>
                                                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                                        <div class="<?php if (count($option['product_option_value']) >= 5000 ) { ?>radio-carousel-image <?php } else { ?>radio-product-image <?php } ?>">
                                                            <?php $r=rand(1,1000); ?>
                                                            <label for='r-<?php echo $option['product_option_id'].$r; ?>'>
                                                            <input type="radio" id='r-<?php echo $option['product_option_id'].$r; ?>' name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" data-price="<?php echo trim(preg_replace('/[^\d\.]/i', '', $option_value['price']),"."); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>"/>
                                                            <span class="radio-image-box"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>"/></span>
                                                            <!-- <span class="color-name"><?php echo $option_value['name']; ?></span> -->
                                                            </label>
                                                        </div>
                                                        <?php } ?>
                                                        <?php if (count($option['product_option_value']) >= 5000 ) { ?>
                                                    </div>
                                                </div>
                                            </div>
                                            <?php } ?>

                                        </div>
                                    </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'text') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" data-price="<?php echo trim(preg_replace('/[^\d\.]/i', '', $option_value['price']),"."); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>" />
                                    </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'textarea') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                        <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" data-price="<?php echo trim(preg_replace('/[^\d\.]/i', '', $option_value['price']),"."); ?>" data-prefix="<?php echo $option_value['price_prefix']; ?>"><?php echo $option['value']; ?></textarea>
                                    </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'file') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label"><?php echo $option['name']; ?></label>
                                        <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block">
                                            <i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                        <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>"/>
                                    </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'date') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                        <div class="input-group date">
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                            <span class="input-group-btn">
                                 <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                 </span>
                                        </div>
                                    </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'datetime') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                        <div class="input-group datetime">
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                            <span class="input-group-btn">
                                 <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                 </span>
                                        </div>
                                    </div>
                                    <?php } ?>
                                    <?php if ($option['type'] == 'time') { ?>
                                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                        <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                        <div class="input-group time">
                                            <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"/>
                                            <span class="input-group-btn">
                                 <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                 </span>
                                        </div>
                                    </div>
                                    <?php } ?>
                                    <?php } ?>
                                </div>

                                <!-- options-block end -->
                                <?php } ?>
                            </div>
                        </div>

                    </div>
                    <div class="product-list_bottom">
                        <input type="hidden" name="product_id" value="<?php echo $product_id; ?>">
                        <div class="col-sm-12 col-md-12 button-pcs-box">

                            <div class="pcs-box">
                                <div class="input-group" data-min-quantity="<?php echo $minimum; ?>">
                                  <span class="input-group-btn">
                                    <button type="button" class="btn btn-default" data-type="minus" data-field="input-quantity">
                                        <span class="glyphicon glyphicon-minus"></span>
                                    </button>
                                  </span>
                                    <input type="text" name="quantity" value="<?php echo $minimum; ?>" id="input-quantity" size="2" class="form-control quantity">
                                    <span class="input-group-btn">
                                    <button type="button" class="btn btn-default" data-type="plus" data-field="input-quantity">
                                        <span class="glyphicon glyphicon-plus"></span>
                                    </button>
                                </span>
                                </div>
                            </div>
                            <button type="button" id="button-cart" class="button-cart btn btn-primary">
                                <i class="fa fa-shopping-cart"></i>
                                <span><?php echo $button_cart; ?></span>
                            </button>
                        </div>

                        <!-- NeoSeo QuickOrder - begin -->
                        <?php if(isset($neoseo_quick_order_product_template) && empty($neoseo_notify_when_available_status)) echo $neoseo_quick_order_product_template; ?>
                        <!-- NeoSeo QuickOrder - end -->

                    </div>
                    <div class="product-list_manufacturer">

                        <?php if ($manufacturer) { ?>
                       
                        <div class="manufacturer-item">
                            <div class="manufacturer_left">
                                <b><?php echo $text_manufacturer; ?></b>
                            </div>
                            <div class="manufacturer_right">
                                <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a>
                            </div>
                        </div>
                        <?php } ?>
                        <?php if ($attribute_groups[0]["attribute"]) { ?>

                        <?php foreach ($attribute_groups as $attribute_group) { ?>
                            <?php $i = 1; foreach ($attribute_group['attribute'] as $attribute) { if ($i > 4) break; ?>
                            <div class="manufacturer-item">
                                <div class="manufacturer_left">
                                    <b><?php echo $attribute['name']; ?></b>
                                </div>
                                <div class="manufacturer_right">
                                    <span><?php echo $attribute['text']; ?></span>
                                </div>
                            </div>
                            <?php $i++;  } ?>
                        <?php } ?>
                        <?php } ?>

                        <?php if ($dimension) { ?>
                        <div class="manufacturer-item">
                            <div class="manufacturer_left">
                                <b><?php echo $text_dimension; ?></b>
                            </div>
                            <div class="manufacturer_right">
                                <span><?php echo $dimension; ?></span>
                            </div>
                        </div>
                        <?php } ?>

                        <?php if ($reward) { ?>
                        <div class="manufacturer-item">
                            <div class="manufacturer_left">
                                <b><?php echo $text_reward; ?></b>
                            </div>
                            <div class="manufacturer_right">
                                <span><?php echo $reward; ?></span>
                            </div>
                        </div>
                        <?php } ?>

                        <?php if ($tax) { ?>
                        <div class="manufacturer-item">
                            <div class="manufacturer_left">
                                <b><?php echo $text_tax; ?></b>
                            </div>
                            <div class="manufacturer_right">
                                <span><?php echo $tax; ?></span>
                            </div>
                        </div>
                        <?php } ?>

                        <?php if ($points) { ?>
                        <div class="manufacturer-item">
                            <div class="manufacturer_left">
                                <b><?php echo $text_points; ?></b>
                            </div>
                            <div class="manufacturer_right">
                                <span><?php echo $points; ?></span>
                            </div>
                        </div>
                        <?php } ?>
                    </div>
                    <?php if ($attribute_groups[0]["attribute"]) { ?>
                    <a href="#characteristics" class="see-all-characteristics">
                        <?php echo $text_all_characteristics; ?>
                    </a>
                    <?php } ?>
                </div>
                <div class="col-xs-12 hidden-md hidden-lg">
                    <div class="product-delivery-block light">
                        <?php if( trim(strip_tags($shipping_info) ) ) { ?>
                        <div class="panel panel-default">
                            <div class="panel-body shipping_info">
                                <div class="shipping_info-title">
                                    <i class="fa fa-truck"></i>
                                    <span><?php echo $text_shipping; ?></span>
                                </div>
                                <?php echo $shipping_info; ?>
                            </div>
                        </div>
                        <?php } ?>
                        <?php if( trim(strip_tags($payment_info) ) ) { ?>
                        <div class="panel panel-default">
                            <div class="panel-body payment_info">
                                <div class="payment_info-title">
                                    <i class="fa fa-credit-card"></i>
                                    <span><?php echo $text_payment; ?></span>
                                </div>
                                <?php echo $payment_info; ?>
                            </div>
                        </div>
                        <?php } ?>
                        <?php if( trim(strip_tags($guarantee_info) ) ) { ?>
                        <div class="panel panel-default">
                            <div class="panel-body guarantee_info">
                                <div class="guarantee_info-title">
                                    <i class="fa fa-file-o"></i>
                                    <span><?php echo $text_guarantee; ?></span>
                                </div>
                                <?php echo $guarantee_info; ?>
                            </div>
                        </div>
                        <?php } ?>
                    </div>
                    <script>
                        $('.product-delivery-block').readmore({
                            maxHeight: 146,
                            moreLink: '<a class="moreLink"><span><?php echo $text_more; ?></span></a>',
                            lessLink: '<a class="moreLink ended" style=" background: none;"><span><?php echo $text_collapse_all; ?></span></a>'
                        });
                    </script>
                </div>
                <div class="clearfix"></div>

            </div>

            <!-- delivery end-->
        </div>
        <div class="product-middle box-shadow box-corner">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-description" data-toggle="tab"><span><?php echo  $tab_description; ?></span></a></li>
                <?if ($attribute_groups[0]["attribute"]) { ?>
                <li><a href="#tab-attribute" data-toggle="tab"><span><?php echo  $tab_attribute; ?></span></a></li>
                <?php } ?>

                <?php if ($review_status) { ?>
                <li><a href="#tab-review" data-toggle="tab"><span><?php echo  $tab_review; ?></span></a></li>
                <?php } ?>

            </ul>
            <div class="tab-content">
                <div class="tab-pane active" id="tab-description">
                    <div class="row">
                        <div class="tab-description_left col-md-8">
                            <article class="product-description">
                                <?php echo $description; ?>
                            </article>

                            <script>
                                $('article').readmore({
                                    maxHeight: 130,
                                    moreLink: '<a class="moreLink" href="#"><span><?php echo $text_more; ?></span></a>',
                                    lessLink: '<a class="moreLink" style=" background: none;" href="#"><span><?php echo $text_collapse_all; ?></span></a>'
                                });
                            </script>
                            <pre class="hidden">
                            </pre>
                        </div>

                        <div class="tab-description_right col-md-4">
                            <div class="tab-description_right-top">
                                <?php if ($review_status) { ?>
                                <div class="top_total-comments"><span><?php echo $text_all_reviews; ?></span></div>
                                <?php if ($review_guest) { ?>
                                <div class="top_write-comment">
                                    <button href="#tab-review" data-toggle="tab"  type="button" id="button-review2" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary">
                                        <?php echo $text_give_feedback; ?>
                                    </button>
                                </div>
                                <?php } else { ?>
                                    <span class="col-xs-6"><?php echo $text_login; ?></span>
                                <?php } ?>
                            </div>
                            <form class="form-horizontal" id="form-review-2">
                                <div class="review-box"><?php echo $short_reviews;?> </div>
                            </form>
                            <?php } ?>
                            <?php if ($short_reviews_status) { ?>
                            <a href="#tab-review" data-toggle="tab" class="see-all-reviews">
                                <?php echo $text_see_all_reviews; ?>
                                <i class="fa fa-long-arrow-right"></i>
                            </a>
                            <?php } ?>
                        </div>
                    </div>


                </div>

                <?php if ($attribute_groups[0]["attribute"]) { ?>
                <div class="tab-pane" id="tab-attribute">
                    <table id="characteristics" class="table table-bordered">
                        <?php foreach ($attribute_groups as $attribute_group) { ?>

                        <thead>
                        <tr>
                            <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                        </tr>
                        </thead>
                        <tbody>
                        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                        <tr>
                            <td><?php echo $attribute['name']; ?></td>
                            <td><?php echo $attribute['text']; ?></td>
                        </tr>
                        <?php } ?>
                        </tbody>
                        <?php } ?>
                    </table>
                </div>
                <?php } ?>

                <?php if ($review_status) { ?>
                <div class="tab-pane" id="tab-review">
                    <form class="form-horizontal" id="form-review">
                        <div class="tab-review-container">
                            <div class="tab-review_left col-md-8">
                                <div id="review"><?php echo $static_reviews;?> </div>
                            </div>
                            <div class="tab-review_right col-md-4">
                                <h4><?php echo $text_write; ?></h4>
                                <?php if ($review_guest) { ?>
                                <div class="form-group required">
                                    <div class="col-sm-12">
                                        <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                                        <input type="text" name="name" value="" id="input-name" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <div class="col-sm-12">
                                        <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                                        <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                                        <?php if(0) { ?>
                                        <div class="help-block"><?php echo $text_note; ?></div>
                                        <?php } ?>
                                    </div>
                                </div>

                                <div class="reviews-nav">
                                    <div class="rating-fl">
                                        <div class="star-rating">
                                            <span class="fa fa-star-o" data-rating="1"></span>
                                            <span class="fa fa-star-o" data-rating="2"></span>
                                            <span class="fa fa-star-o" data-rating="3"></span>
                                            <span class="fa fa-star-o" data-rating="4"></span>
                                            <span class="fa fa-star-o" data-rating="5"></span>
                                            <input type="hidden" name="rating" class="rating-value" value="3">
                                        </div>
                                    </div>
                                    <?php echo $captcha; ?>
                                    <div class="reviews-button">
                                        <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_write; ?></button>
                                    </div>
                                    <?php } else { ?>
                                    <?php echo $text_login; ?>
                                    <?php } ?>
                                </div>

                            </div>
                        </div>

                    </form>
                </div>
                <?php } ?>
            </div>
        </div>
        <?php if ($products) { ?>
        <div class="module featured ">
            <h3><?php echo $text_related; ?></h3>
            <div class="product-previews-light module-grid-<?php echo  $limit; ?> default">
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
        </div>
        <?php } ?>

        <?php if ($tags) { ?>
        <p><?php echo $text_tags; ?>
            <?php for ($i = 0; $i < count($tags); $i++) { ?>
            <?php if ($i < (count($tags) - 1)) { ?>
            <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
            <?php } else { ?>
            <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
            <?php } ?>
            <?php } ?>
        </p>
        <?php } ?>
    </div>
    <?php echo $content_bottom; ?>
</div>
</div>

<?php echo $column_right; ?></div>
</div>
<script >



    $(document).ready(function() {
        $('.flip-clock-divider.days .flip-clock-label').text('<?php echo $text_days; ?>');
        $('.flip-clock-divider.hours .flip-clock-label').text('<?php echo $text_hours; ?>');
        $('.flip-clock-divider.minutes .flip-clock-label').text('<?php echo $text_minutes; ?>');
        $('.flip-clock-divider.seconds .flip-clock-label').text('<?php echo $text_seconds; ?>');

        setTimeout(function () {
            $('#input-phone-cart').focus();
        },500);
    });
    var $star_rating = $('.star-rating .fa');

    var SetRatingStar = function() {
        return $star_rating.each(function() {
            if (parseInt($star_rating.siblings('input.rating-value').val()) >= parseInt($(this).data('rating'))) {
                return $(this).removeClass('fa-star-o ').addClass('fa-star');
            } else {
                return $(this).removeClass('fa-star').addClass('fa-star-o');
            }
        });
    };

    $star_rating.hover(function() {
        $star_rating.siblings('input.rating-value').val($(this).data('rating'));
        return SetRatingStar();
    });

    SetRatingStar();

    $('select[name=\'recurring_id\'], input[name="quantity"]').change(function () {
        $.ajax({
            url: 'index.php?route=product/product/getRecurringDescription',
            type: 'post',
            data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
            dataType: 'json',
            beforeSend: function () {
                $('#recurring-description').html('');
            },
            success: function (json) {
                $('.alert, .text-danger').remove();

                if (json['success']) {
                    $('#recurring-description').html(json['success']);
                }
            }
        });
    });

    $('.input-group-btn button').on('click', function () {
        var field = $(this).attr('data-field');
        if( !field )
            return;

        var type = $(this).attr('data-type');
        if( !type )
            return;

        var value = Number($("#"+field).val());
        var v = $("#"+field).attr('value');
        if( type == "minus") {
            value -= 1;
        } else {
            value += 1;
        }
        if( value < v ) {
            value = v;
            setInvalid($("#"+field));
        }
        $("#"+field).val(value);
    });

    // input-quantity
    $('#input-quantity').keydown(function(e) {
        if(e.which == 38){ // plus
            var value = Number($(this).val());
            value++;
            if(value > 100) value = 100;
            $(this).val(value);
        }
        if(e.which == 40){ // minus
            var value = Number($(this).val());
            var v = $(this).attr('value');
            value--;
            if(value < v) { value = v; setInvalid($(this)) }
            $(this).val(value);
        }
    });

    function setInvalid(o){
        o.addClass('invalid');
        setTimeout(function(){
            o.removeClass('invalid');
        },100);
    }

    $('#button-cart').on('click', function () {

        var language = "";
        if (window.current_language) {
            language = window.current_language;
        }

        $.ajax({
            url: language + 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $('#product input[type=\'text\'], .product-list_bottom input[type=\'text\'] , .product-list_bottom input[type=\'hidden\'] ,#product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
            dataType: 'json',
            success: function (json) {
                $('.alert, .text-danger').remove();
                $('.form-group').removeClass('has-error');

                if (json['error']) {
                    if (json['error']['option']) {
                        for (i in json['error']['option']) {
                            var element = $('#input-option' + i.replace('_', '-'));

                            if (element.parent().hasClass('input-group')) {
                                element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            } else {
                                element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            }
                        }
                    }

                    if (json['error']['recurring']) {
                        $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
                    }

                    // Highlight any found errors
                    $('.text-danger').parent().addClass('has-error');
                }

                if (json['success']) {
                    /* NeoSeo Popup Cart - begin */
                    showCart(json);
                    // Need to set timeout otherwise it wont update the total
                    setTimeout(function () {
                        $('.cart__total-list').html(json['total']);
                        $('.cart__total-items').html(json['total_items']);
                        $('.cart').load('index.php?route=common/cart/info .cart > *');
                    }, 100);
                    /* NeoSeo Popup Cart - end */

                    $('.cart > ul').load('index.php?route=common/cart/info ul li');
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

    $('.date').datetimepicker({
        pickTime: false
    });

    $('.datetime').datetimepicker({
        pickDate: true,
        pickTime: true
    });

    $('.time').datetimepicker({
        pickDate: false
    });

    $('button[id^=\'button-upload\']').on('click', function () {
        var node = this;

        $('#form-upload').remove();

        $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

        $('#form-upload input[name=\'file\']').trigger('click');

        if (typeof timer != 'undefined') {
            clearInterval(timer);
        }

        timer = setInterval(function () {
            if ($('#form-upload input[name=\'file\']').val() != '') {
                clearInterval(timer);

                $.ajax({
                    url: 'index.php?route=tool/upload',
                    type: 'post',
                    dataType: 'json',
                    data: new FormData($('#form-upload')[0]),
                    cache: false,
                    contentType: false,
                    processData: false,
                    beforeSend: function () {
                        $(node).button('loading');
                    },
                    complete: function () {
                        $(node).button('reset');
                    },
                    success: function (json) {
                        $('.text-danger').remove();

                        if (json['error']) {
                            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
                        }

                        if (json['success']) {
                            alert(json['success']);

                            $(node).parent().find('input').attr('value', json['code']);
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        }, 500);
    });


    $('#button-review').on('click', function () {
        var language = "";
        if (window.current_language) {
            language = window.current_language;
        }
        $.ajax({
            url: language + 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
            type: 'post',
            dataType: 'json',
            data: $("#form-review").serialize(),
            beforeSend: function () {
                $('#button-review').button('loading');
            },
            complete: function () {
                $('#button-review').button('reset');
            },
            success: function (json) {
                $('.alert-success, .alert-danger').remove();

                if (json['error']) {
                    $('.reviews-nav').before('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
                }

                if (json['success']) {
                    $('.reviews-nav').before('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

                    $('input[name=\'name\']').val('');
                    $('textarea[name=\'text\']').val('');
                    $('input[name=\'rating\']:checked').prop('checked', false);
                }
            }
        });
    });

</script>

<?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/product/product_gallery.tpl'); ?>
<script>
    <?php if(!isset($image['video_url'])||!$image['video_url']) { ?>
    if( $(document).width() > 767 ) {
        popupGallery(['.big_image', '.image-additional'], {
            activeClass: '.thumbnail.active',
            title: '.product-title'
        });
    }
    <?php } ?>

    <?php if ($zoom) { ?>
    function initZoom(){
        if( $(document).width() < 751 ) return;
        // Zoom Big Thumb
        $(".popupGallery__image img").ezPlus({
            zoomType: "inner",
            cursor: "crosshair",
            zoomWindowWidth:1000,
            zoomWindowHeight:1000,
            zoomWindowFadeIn:300,
            zoomWindowFadeOut:200
        });
    }

    $('.thumbnails').on('click', (e) => {
        e.preventDefault();

            setTimeout(() => {
                initZoom();
            },300);

    });

    $('.popupGallery__imageList img').on('click', (e) => {
        e.preventDefault();

        initZoom();

    });

    <?php } ?>

    <?php if(isset($image['video_url'])&&$image['video_url']) { ?>
    $('.thumbnails .thumbnail').magnificPopup({
        items: [
        <?php if ($thumb) { ?>{src: '<?php echo $popup; ?>'},<?php } ?>
    <?php if ($images) { ?><?php foreach ($images as $image) { ?>{src: '<?php echo $image['popup']; ?>'},<?php } ?><?php } ?>
    ],
    gallery: { enabled: true },
    type: 'image',

    <?php if ($images) { ?>

        callbacks: {
            open: function() {
                var activeIndex = parseInt($('#zgalery .image-additional a.active').parent('.image-additional').index());
                var magnificPopup = $.magnificPopup.instance;

            <?php if( isset($images_360) && $images_360 ) { ?>

                    if( activeIndex > 0 ) {
                        magnificPopup.goTo(activeIndex - 1);
                    } else {
                        magnificPopup.goTo(0);
                    }

                <?php } else { ?>

                    magnificPopup.goTo(activeIndex);

                <?php } ?>

            }

        }

    <?php } ?>
    });
    <?php } ?>

    // ZYSH




    $('.image-additional a').mouseenter(function(e) {
        if($(this).hasClass('active'))
            return;
        if($(this).hasClass('thumb_360')) {
            $('.threesixty-block').show();
            $('.thumbnails .big_image').hide();
        } else {
            $('.big_image img').prop('style','');
            $('.thumbnails .big_image').show();
            $('.threesixty-block').hide();
        }
        $('.image-additional a.active').removeClass('active');
        let sr = $(this).attr('data-zoom-image');
        let hr = $(this).attr('href');
        $('.thumbnails li:first img:first').attr('data-zoom-image',sr);
        $('.thumbnails li:first a').attr('href',sr);
        $(this).addClass('active');
        $('.thin-0 img').attr('src', $(this).attr('data-image'));

    });
    $(".thin-0 img").click(function(){
        return false;
    });

    // STARs
    $('.z_stars span').mouseenter(function(e) {
        var n = $(this).index();
        $(this).siblings('span').each(function(index, element) {
            if( $(this).index() < n ) $(this).addClass('active');
            else $(this).removeClass('active');
        });
    });
    $('.z_stars span').mouseleave(function(e) {
        var n = $(this).index();
        var p = $(this).parent('.z_stars');
        var s = p.data('value');
        if( s ) {
            if( n == s - 1 ) { $(this).addClass('active');}
            else {
                p.find('span').each(function(index, element) {
                    if( $(this).index() < s ) $(this).addClass('active');
                    else $(this).removeClass('active');
                });
            }
        } else {
            $(this).siblings('span').each(function(index, element) {
                $(this).removeClass('active');
            });
        }
    });
    $('.z_stars span').click(function(e) {
        var i = $(this).index();
        $(this).parent('.z_stars').data('value', i + 1);
        $(this).parent('.z_stars').find('input.inp-rating').val(i+1);
        $(this).addClass('active');
        $('input[name="rating"]').val($('#zs_rate span.active').length);
    });
    $('.z_stars').mouseleave(function(e) {
        var s = $(this).data('value');
        if(s){
            $(this).find('span').each(function(index, element) {
                if( $(this).index() < s ) $(this).addClass('active');
            });
        }
    });
    $('.z_stars').data('value',3);
    $('.z_stars .inp-rating').val(3);
    $('.z_stars span:lt(3)').addClass('active');

    $(document).ready(function() {
        $('#product select, #product input').bind('change', function (e) {
            onChangeOption();
        });
    });

    $(function () {

        $('.see-all-characteristics').click(function(e){
            e.preventDefault();
            $('a[href="#tab-attribute"]').trigger('click');
            $('html, body').animate({
                scrollTop: $( $(this).attr('href') ).offset().top - 50
            }, 1200);
            return false;
        });

        $('.see-all-reviews, #button-review2').click(function (e) {

            e.preventDefault();
            $('.nav-tabs > li').removeClass('active');
            $('.nav-tabs > li:last-child').addClass('active');

        });

        var mainContainer = $('.more-image');
        var mainContainerWidth = $(mainContainer).width();
        var widthChild = 0;
        $(mainContainer).children().each(function () {
            widthChild+=$(this).width();
        });
        if (widthChild > mainContainerWidth) {
            $('.big_image-slide-nav').css('display','flex');
        }

        $('.slide-nav_next').click(function () {
            var lenghtItem = $('.image-additional').length;
            var activeImage = $('.image-additional').find('.active');
            var indexImage = $(activeImage).parent().index();
            if (indexImage != lenghtItem - 1) {
                var activeImageNext = $(activeImage).parent().next().children().addClass('active');
                $(activeImage).removeClass('active');
                var imageSrc = $(activeImageNext).attr('data-image');
                var imageData = $(activeImageNext).attr('data-zoom-image');
                var imageShow = $('.big_image').find('img').attr('src', imageSrc).attr('data-zoom-image',imageData);
            } else if (indexImage == lenghtItem - 1) {
                $(activeImage).removeClass('active');
                var firstImage = $('.image-additional').eq(0).children().addClass('active');
                var imageSrc = $(firstImage).attr('data-image');
                var imageData = $(firstImage).attr('data-zoom-image');
                var imageShow = $('.big_image').find('img').attr('src', imageSrc).attr('data-zoom-image',imageData);
            }
        });

        $('.slide-nav_prev').click(function () {
            var activeImage = $('.image-additional').find('.active');
            var indexImage = $(activeImage).parent().index();
            if (indexImage != 0) {
                var activeImageNext = $(activeImage).parent().prev().children().addClass('active');
                $(activeImage).removeClass('active');
                var imageSrc = $(activeImageNext).attr('data-image');
                var imageData = $(activeImageNext).attr('data-zoom-image');
                var imageShow = $('.big_image').find('img').attr('src', imageSrc).attr('data-zoom-image',imageData);
            } else if (indexImage == 0) {
                $(activeImage).removeClass('active');
                var lastImage = $('.image-additional').eq(-1).children().addClass('active');
                var imageSrc = $(lastImage).attr('data-image');
                var imageData = $(lastImage).attr('data-zoom-image');
                var imageShow = $('.big_image').find('img').attr('src', imageSrc).attr('data-zoom-image',imageData);
            }


        });

    });

</script>
<?php echo $footer; ?>
