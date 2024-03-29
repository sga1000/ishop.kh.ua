<?php echo $header; ?>
<div class="container">
    <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
    <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } else { ?>
    <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
    <?php } ?>
    <div class="row"><?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <div class="content-top box-shadow box-corner">
                <h1><?php echo $heading_title; ?></h1>
                <?php echo $sharing_code; ?>
            </div>
            <?php if ($products) { ?>
            <div class="filters-box box-shadow box-corner" style="margin-bottom: 0;">
                <div class="sort-list col-sm-5 col-md-6 col-lg-5">
                    <div class="col-md-5 text-right sort-div">
                        <label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
                    </div>
                    <div class="col-md-7 text-left">
                        <select id="input-sort" class="selectpicker" onchange="location = this.value;">
                            <?php foreach ($sorts as $sorts) { ?>
                            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                <div class="show-list col-sm-4">
                    <div class="col-md-6 text-right limit-div">
                        <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
                    </div>
                    <div class="col-md-6 text-right">
                        <select id="input-limit" class="selectpicker" onchange="location = this.value;">
                            <?php foreach ($limits as $limits) { ?>
                            <?php if ($limits['value'] == $limit) { ?>
                            <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                            <?php } else { ?>
                            <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                            <?php } ?>
                            <?php } ?>
                        </select>
                    </div>
                </div>
            </div>
            <script type="text/javascript" src="catalog/view/theme/neoseo_unistor/javascript/jquery.formstyler.js"></script>
            <script>
                (function($) {
                    $(function() {
                        $('.filters-box .selectpicker').styler({
                            selectSearch: true
                        });
                    });
                })(jQuery);
            </script>

            <div class="product-previews-light module-grid-<?php echo $limit_p; ?> light">
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
            <div class="row paginator">
                <div class="col-sm-7 col-md-12 col-lg-7 text-left"><?php echo $pagination; ?></div>
                <div class="col-sm-5 col-md-12 col-lg-5 text-right"><?php echo $results; ?></div>
            </div>
        </div>

        <?php } else { ?>
        <div class="empty-box box-shadow box-corner">
            <p class="empty-title"><?php echo $text_empty; ?></p>
        </div>

        <?php } ?>
        <?php echo $content_bottom; ?>
    </div>
    <?php echo $column_right; ?>
</div>
<script>// input-quantity
    $('.input-quantity-group .input-group-btn button').on('click', function () {
        var field = $(this).attr('data-field');
        if( !field ) return;
        var type = $(this).attr('data-type');
        if( !type ) return;

        var I = $(this).parent().siblings('input:first');
        var o = $(this).parents('.input-quantity-group');
        var min = $(this).parents('.input-quantity-group').attr('data-min-quantity');
        var value = Number(I.val());
        if( type == "minus") {
            value -= 1;
        } else {
            value += 1;
        }
        if( value < min ) { setInvalid(I); value = min; }
        I.val(value);
        setQuantity(value,o);
    });
    $('.input-quantity-group input.quantity').keydown(function(e) {
        if(e.which == 38){ // plus
            var value = Number($(this).val());
            var o = $(this).parents('.input-quantity-group');
            value++;
            if(value > 100) value = 100;
            $(this).val(value);
            setQuantity(value, o);
        }
        if(e.which == 40){ // minus
            var value = Number($(this).val());
            var o = $(this).parents('.input-quantity-group');
            var min = $(this).parents('.input-quantity-group').attr('data-min-quantity');
            value--;
            if(value < min) { setInvalid($(this)); value = min; }
            $(this).val(value);
            setQuantity(value, o);
        }
    });
    function setQuantity(v,o){
        o.siblings('.button-group').find('button').each(function(){
            var t = $(this).attr('onclick');
            if( t.indexOf('cart.add') > -1 ){
                var i = t.slice(9,-2).split(',')[0].slice(1,-1);
                var q = "c = cart;c.add('" + i + "', '" + v + "');";
                $(this).attr("onclick",q);
            }
        })
    }
    function setInvalid(o){
        o.addClass('invalid');
        setTimeout(function(){
            o.removeClass('invalid');
        },120);
    }
</script>
<?php echo $footer; ?>
