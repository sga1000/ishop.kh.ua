

<div class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="modal-close-button close" data-dismiss="modal">
                    <span></span>
                    <span></span>
                </button>
                <div class="row">
                    <div class="col-sm-5 body-left">
                        <h3 class="modal-title visible-xs"><?php echo $heading_title; ?></h3>
                        <div class="product-model-block">
                            <?php if($model) { ?>
                            <p class="text-left model-block"><strong><?php echo $text_model; ?></strong> <span class=""><?php echo $model; ?></span></p>
                            <?php } ?>
                        </div>
                        <?php if ($image || $images) { ?>
                        <ul class="thumbnails <?php if (count($images) > 3) { ?>hide-images<?php } ?>">
                            <?php if ($image) { ?>
                            <li>
                                <a class="thumbnail-quickview main-image" title="<?php echo $heading_title; ?>">
                                    <img src="<?php echo $image; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"/>
                                </a>
                            </li>
                            <?php if (!$images) { ?>
                            <li class="image-additional">
                                <a class="thumbnail-quickview" data-target="<?php echo $image; ?>" title="<?php echo $heading_title; ?>">
                                    <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"/>
                                </a>
                            </li>
                            <?php } ?>

                            <!-- Neoseo Product Options PRO - begin -->
                            <?php //Переопеределяем переменную, т.к. значение image будет изменено ниже в цикле ?>
                            <?php $main_image = $image; ?>
                            <!-- Neoseo Product Options PRO - end -->
                            <?php } ?>
                            <?php if ($images) { ?>
                            <?php foreach ($images as $image) { ?>
                            <li class="image-additional">
                                <a class="thumbnail-quickview" data-target="<?php echo $image['image']; ?>" title="<?php echo $heading_title; ?>">
                                    <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"/></a>
                            </li>
                            <?php } ?>
                            <?php } ?>

                        </ul>
                        <?php if (count($images) > 3) { ?>
                        <div class="popup-see-all-box">
                            <a href="javascript:void(0)" class="popup-see-all see-all"><?php echo $text_see_all; ?><i class="fa fa-caret-down"></i></a>
                            <a href="javascript:void(0)" class="popup-see-all hide-all"><?php echo $text_collapse_all; ?><i class="fa fa-caret-up"></i></a>
                        </div>

                        <script>

                          $('.popup-see-all').on('click', function () {

                              $('.thumbnails').toggleClass('hide-images show-images');

                          });

                          setTimeout(function () {
                              var vW = $(window).width();
                              var parent = $('.thumbnails ').width() - 30;
                              var item = 0;
                              if (vW < 768) {
                                  $('.image-additional').each(function () {
                                      item+=$(this).width();
                                  });

                                  if (item < parent) {
                                      $('.popup-see-all-box').hide();
                                      $('.body-left').css('margin-bottom','15px');
                                  }
                              }




                          },500);

                          $(window).resize(function () {
                              var vW = $(window).width();
                              var parent = $('.body-left').width() - 10;
                              var item = 0;
                              if (vW < 768) {
                                  $('.image-additional').each(function () {
                                      item+=$(this).width();
                                  });

                                  if (item < parent) {
                                      $('.popup-see-all-box').hide();
                                      $('.body-left').css('margin-bottom','15px');
                                  }
                                  else if (item > parent) {
                                      $('.popup-see-all-box').show();
                                      $('.body-left').css('margin-bottom','0');
                                  }
                              }
                          });

                        </script>
                        <?php } ?>

                        <?php } ?>
                    </div>
                    <div class="col-sm-7 body-right">
                        <h3 class="modal-title hidden-xs"><?php echo $heading_title; ?></h3>

                        <?php if ($special && $date_special ) { ?>
                        <div class="action">
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

                        <div class="price-area-box">
                        <?php if ($price) { ?>
                            <ul class="list-unstyled" id="price_clear" data-price="<?php echo rtrim(preg_replace("/[^0-9\.]/", "", ($special ? $special : $price)), '.'); ?>">
                                <div class="price-text">
                                    <?php echo $text_price; ?>
                                </div>
                                <?php if (!$special) { ?>
                                <li>
                                    <h2 class="price-area-quick"><?php echo $price; ?></h2>
                                </li>
                                <?php } else { ?>
                                <li><span style="text-decoration: line-through;" class="price-old"><?php echo $price; ?></span></li>
                                <li>
                                    <h2 class="price-area-quick"><?php echo $special; ?></h2>
                                </li>
                                <?php } ?>
                                <?php if ($tax) { ?>
                                <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
                                <?php } ?>
                                <?php if ($points) { ?>
                                <li><?php echo $text_points; ?> <?php echo $points; ?></li>
                                <?php } ?>
                                <?php if ($discounts) { ?>
                                <li>
                                    <hr>
                                </li>
                                <?php foreach ($discounts as $discount) { ?>
                                <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
                                <?php } ?>
                                <?php } ?>
                            </ul>
                            <?php } ?>
                            <?php if ($total_reviews) { ?>
                            <div class="rating">
                                <p>
                                <?php if ($review_status) { ?>
                                <?php for ($i = 1; $i <= 5; $i++) { ?>
                                <?php if ($rating < $i) { ?>
                                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                                <?php } else { ?>
                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                                <?php } ?>
                                <?php } ?>
                                <?php } ?>
                            </p>
                                <div class="total-reviews"><i class="fa fa-commenting"></i><span><?php echo $reviews; ?></span></div>
                            </div>
                            <?php } ?>
                            <?php ?>
                        </div>

                        <div  class="modal-status stock-status-text" style="color: <?php echo $stock_status_color; ?>"><?php echo $stock; ?></div>

                        <div id="product" class="modal-options-block">
                            <?php if ($options) { ?>
                            <script src="catalog/view/theme/neoseo_unistor/javascript/jquery.formstyler.js"></script>
                            <script>
                                (function($) {
                                    $(function() {
                                        $('.product-options-block select').styler({
                                            selectSearch: true
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


                            <?php } ?>

                            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>"/>

                            <div class="links-group">
                                <a href="javascript:void(0)" data-toggle="tooltip" class="links-group__wishlist" onclick="wishlist.add('<?php echo $product_id; ?>');">
                                    <i class="fa fa-heart-o"></i>
                                    <span><?php echo $button_wishlist; ?></span>
                                </a>
                                <a href="javascript:void(0)" data-toggle="tooltip" class="links-group__compare" onclick="compare.add('<?php echo $product_id; ?>');">
                                    <i class="ns-clone"></i>
                                    <span><?php echo $button_compare; ?></span>
                                </a>
                            </div>

                            <div class="button-pcs-box">
                                <div class="modal-pcs-box">
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
                        <?php foreach( $attribute_groups as $attribute_group ) { ?>
                        <?php foreach( $attribute_group['attribute'] as $attribute ) { ?>
                        <div class="manufacturer-item">
                            <div class="manufacturer_left">
                                <b><?php echo $attribute['name'] ?>:</b>
                            </div>
                            <div class="manufacturer_right">
                                <?php echo $attribute['text'] ?>
                            </div>
                        </div>
                        <?php } ?>
                        <?php } ?>

                    </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script><!--
    $('body').on('click', '.image-additional a.thumbnail-quickview', function() {
        $('.thumbnail-quickview:first img').attr('src', $(this).attr('data-target'));
    });
    $('#button-cart').on('click', function() {
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $('#popup-quickview #product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-cart').button('loading');
            },
            complete: function() {
                $('#button-cart').button('reset');
            },
            success: function(json) {
                $('.alert, .text-danger').remove();
                $('#popup-quickview .form-group').removeClass('has-error');

                console.log(json);

                if (json['error']) {
                    if (json['error']['option']) {
                        for (i in json['error']['option']) {
                            var element = $('#popup-quickview #input-option' + i.replace('_', '-'));

                            if (element.parent().hasClass('input-group')) {
                                element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            } else {
                                element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            }
                        }
                    }

                    if (json['error']['recurring']) {
                        $('#popup-quickview select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
                    }

                    // Highlight any found errors
                   element.parent().addClass('has-error')
                }

                if (json['success']) {
                    $('#popup-quickview > div').modal('hide');
                    showCart(json);

                    // Need to set timeout otherwise it wont update the total
                    setTimeout(function() {
                        $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                    }, 100);

                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });
    //--></script>
<?php if($product_options_pro_status == 1) { ?>
<script>
    $(function () {
        $("<a onClick='clearOptions(this);'>Очистить параметры</a>").appendTo($(".options_pro_quickview_form"));
    });
</script>

<script>
    var quickview_options_pro = {};
    var quickview_ajax_ready = [];
    var quickview_current_option_value; //Текущее значение опции
    var quickview_current_product_option_id; //Текущая опция

    $(document).ready(function () {

        $('#product select,#product input').bind('change', function (e) {

            var form_data = $(this).parents('form').serialize();
            var product_id = $(this).parents('form').find('input[name="product_id"]').val();
            var parentLayer = $(this).parents('#popup-quickview');

            //Определяем ведующую опцию
            if ($(this).prop('checked') == true) {
                quickview_current_option_value = $(this).val();
                quickview_current_product_option_id = $(this).attr('name').replace(/\D+/g, "");
            }

            $('#popup-quickview .text-danger').parent().removeClass('has-error');
            $('#popup-quickview .text-danger').remove();

            if (quickview_ajax_ready[product_id] === undefined) {
                quickview_ajax_ready[product_id] = true;
            }
            if (typeof quickview_options_pro[product_id] === 'undefined' && quickview_ajax_ready[product_id]) {
                quickview_ajax_ready[product_id] = false;
                $.ajax({
                    url: 'index.php?route=module/neoseo_product_options_pro/getProductOptions',
                    type: 'post',
                    data: form_data,
                    dataType: 'json',
                    success: function (json) {
                        if (json['success']) {
                            quickview_options_pro[product_id] = json[product_id];
                            updateQuickProductData(product_id, parentLayer);
                        } else {
                            quickview_options_pro[product_id] = false;
                            return;
                        }
                        quickview_ajax_ready[product_id] = true;
                    }
                });
            } else if (quickview_options_pro[product_id] !== undefined && quickview_options_pro[product_id] !== false) {
                updateQuickProductData(product_id, parentLayer);
            }
        });
    });


    function updateQuickProductData(product_id, parentLayer) {

        var product_id = product_id;
        var product_option_values = [];


        parentLayer.find('#product_options_form_' + product_id + ' [name^="option"]:checked, #product_options_form_' + product_id + ' [name^="option"]:selected').each(function () {
            var product_option_id = $(this).attr('name').replace(/\D+/g, "");
            if (product_option_id == quickview_current_product_option_id) {
                quickview_current_option_value = $(this).val();
            }
            product_option_values.push($(this).val());
        });

        //Определяем зависимость опций
        var quickview_dependent_options = [];
        $.each(quickview_options_pro[product_id], function (key, value) {
            var options = key.split('_');

            if (options.length >= 2 && options.indexOf(quickview_current_option_value) != -1) {
                if (quickview_options_pro[product_id][key]['quantity'] > 0 || quickview_options_pro[product_id][key]['snwa_status'] == true || quickview_options_pro[product_id][key]['stock_checkout'] == 1) {
                    $.each(options, function (index, val) {
                        if (val != quickview_current_option_value) {
                            quickview_dependent_options.push(val);
                        }
                    });
                }
            }
        });

        product_option_values.sort();
        var key = product_option_values.join('_');
        var price_changed = false;

        parentLayer.find('#product_options_form_' + product_id + ' [name^="option"]').each(function () {
            var product_option_id = $(this).attr('name').replace(/\D+/g, "");

            if (product_option_id != quickview_current_product_option_id) {
                if (quickview_current_product_option_id) {
                    if (quickview_dependent_options.indexOf($(this).val()) == -1) {
                        $(this).attr('disabled', true);
                    } else {
                        $(this).attr('disabled', false);

                    }
                }
            } else {
                quickview_current_product_option_id = product_option_id;
            }

            $('#button-cart').attr('disabled', false);
        });

        if (typeof quickview_options_pro[product_id][key] != "undefined") {
            if (quickview_options_pro[product_id][key]['article'] != "") {
                parentLayer.find('.articul').text(quickview_options_pro[product_id][key]['article']);
            }
            if (quickview_options_pro[product_id][key]['model'] != "") {
                parentLayer.find('.model').text(quickview_options_pro[product_id][key]['model']);
            }
            if (quickview_options_pro[product_id][key]['quantity'] >0 || quickview_options_pro[product_id]['stock_checkout'] == 1) {
                parentLayer.find('.status').text('<?php echo $product_status_instock; ?>');
                showAddToCartProductQuickView(parentLayer);
            }  else if(quickview_options_pro[product_id][key]['snwa_status'] == true){
                getProductQuickViewOptionStatusNWA(product_id, key, parentLayer);
            }else {
                parentLayer.find('.status').text('<?php echo $product_status; ?>');
                parentLayer.find('#button-cart').attr('disabled', true);
            }

            var price = parseFloat(quickview_options_pro[product_id][key].price);

            if (!isNaN(price) && price != 0) {
                price_changed = true;
            }

            if (parentLayer.find('.price-area-quick').length != 0) {
                var label_price = parentLayer.find('.price-area-quick');
            } else {
                var label_price = parentLayer.find('.price-old');
            }
            if (price_changed) {
                label_price.unbind('price_change').bind('price_change', function (e, l, p, s, step) {
                    if (l > p) {
                        l = l - step;
                        if (l < p)
                            l = p;
                    } else if (l < p) {
                        l = l + step;
                        if (l > p)
                            l = p;
                    }
                    $(this).text($(this).text().replace(/^[\d\s]+/, (l != p ? Math.round(l).toLocaleString() : l.toLocaleString()) + ' '));
                    if (l != p) {
                        setTimeout(function () {
                            label_price.trigger('price_change', [l, p, s, step]);
                        }, s);
                    }
                });
                var l_price = parseFloat(label_price.text().replace(/[^\d\.]+/, ''));
                if (l_price != price) {
                    label_price.trigger('price_change', [l_price, price, 25, Math.abs((l_price - price) / 10)]);
                }
            }
        }

        getQuickProductOptionImage(product_option_values, product_id, parentLayer);

        return;
    }

    function getQuickProductOptionImage(product_option_values, product_id, parentLayer) {

        var images = [];

        if (product_option_values.length > 0 && typeof quickview_options_pro[product_id] != "undefined") {
            if (quickview_options_pro[product_id]['image_priority'].length != 0) {
                var keys = quickview_options_pro[product_id]['image_priority'];
            } else {
                var keys = product_option_values.join('_');
            }
        } else {
            return;
        }

        $(product_option_values).each(function () {
            if (quickview_options_pro[product_id][this] !== undefined && quickview_options_pro[product_id][this].images.length > 0) {
                if (keys.indexOf(String(this)) != -1) {
                    for (var i = 0; i < quickview_options_pro[product_id][this].images.length; i++) {
                        images.push(quickview_options_pro[product_id][this].images[i]);
                    }
                }
            }
        });

        if (images.length > 0) {
            var html = '';
            parentLayer.find('.image-additional').remove();
            for (var j = 0; j < images.length; j++) {
                if (j == 0) {
                    parentLayer.find('.thumbnails li:not(.image-additional) img').attr('src', images[j].main);
                    html += '<li class="image-additional">';
                    html += '<a class="thumbnail-quickview" data-target="' + images[j].main + '" title="<?php echo $heading_title; ?>">';
                    html += '<img src="' + images[j].thumb + '" title="<?php echo $heading_title; ?>" alt=""></a></li>';
                } else {
                    html += '<li class="image-additional">';
                    html += '<a class="thumbnail-quickview" data-target="' + images[j].main + '" title="<?php echo $heading_title; ?>">';
                    html += '<img src="' + images[j].thumb + '" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"></a></li>';
                }
            }


            parentLayer.find('.thumbnails li:not(.image-additional)').after(html);
        } else {
            setDefaultProductImages(parentLayer);
        }

        return true;
    }

    function setDefaultProductImages(parentLayer) {

        var html = '';

        parentLayer.find('.image-additional').remove();

    <?php if ($main_image) { ?>
            parentLayer.find('.thumbnails li:not(.image-additional) img').attr('src', '<?php echo $main_image; ?>');
            html += '<li class="image-additional">';
            html += '<a class="thumbnail-quickview" data-target="<?php echo $main_image; ?>" title="<?php echo $heading_title; ?>">';
            html += '<img src="<?php echo $main_image; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"/></a></li>';
        <?php } ?>

    <?php if ($images) { ?>
        <?php foreach ($images as $image) { ?>
                html += '<li class="image-additional">';
                html += '<a class="thumbnail-quickview" data-target="<?php echo $image['image']; ?>" title="<?php echo $heading_title; ?>">';
                html += '<img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"/></a></li>';
            <?php } ?>
        <?php } ?>

        parentLayer.find('.thumbnails li:not(.image-additional)').after(html);

    }

    function getProductQuickViewOptionStatusNWA(product_id, option_key, parentLayer) {
        $.ajax({
            url: 'index.php?route=module/neoseo_notify_when_available/getNotifyProductOptionStatus',
            type: 'post',
            data: {'product_id': product_id, 'options': option_key},
            dataType: 'json',
            success: function (json) {
                if (json.result == 'true') {
                    hideAddToCartProductQuickView(product_id, option_key, json['snwa_requests'][product_id], parentLayer);
                }
            },
            error: function (xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    function showAddToCartProductQuickView(parentLayer) {
        parentLayer.find('#button-cart').parents('.form-group').show();
        parentLayer.find('#button-cart').attr('disabled', false);
        parentLayer.find('.snwa-send-btn').parent().remove();
    }

    function hideAddToCartProductQuickView(product_id, option_key, snwa_request, parentLayer) {
        var html = '';
        var checked = false;

        if (snwa_request['status'] == true) {
            checked = true;
        }
        parentLayer.find('#button-cart').parents('.form-group').hide();
        parentLayer.find('.snwa-send-btn').parent().remove();

        html = '<div><button type="button" onclick="showNWA(' + product_id + ',this);" data-checked="' + checked + '" data-option-id="' + option_key + '" class="btn btn-primary snwa-send-btn">';
        html += '<i class="fa fa-bell"></i>';
        html += ' <span class="hidden-xs hidden-sm hidden-md snwa_button_' + product_id + '">' + snwa_request['text_button'] + '</span>';
        html += '</button></div>';

        parentLayer.find('#product .input-group').after(html);
    }
</script>

<?php }else { ?>

<script>
    $(document).ready(function() {
        $('#popup-quickview #product select, #popup-quickview #product input').bind('change', function (e) {
			onChangeOptionQW();
        });
    });
</script>
<?php } ?>

<script>

    $(document).ready(function() {
        $('.flip-clock-divider.days .flip-clock-label').text('<?php echo $text_days; ?>');
        $('.flip-clock-divider.hours .flip-clock-label').text('<?php echo $text_hours; ?>');
        $('.flip-clock-divider.minutes .flip-clock-label').text('<?php echo $text_minutes; ?>');
        $('.flip-clock-divider.seconds .flip-clock-label').text('<?php echo $text_seconds; ?>');

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

    $('.image-additional a').mouseenter(function() {
        $('.image-additional a').removeClass('active');
        $(this).addClass('active');

        var image = $(this).attr('data-target');

        $('.main-image > img').attr('src',image);
    });

</script>
