<?php if ($all_bundle_columns) { ?>
<div class="module-slider">
    <?php foreach($all_bundle_columns as $key => $bundle_columns) { ?>
    <div class="module-slide">
        <h3><?php echo $heading_title; ?></h3>
        <div class="product-middle block-container block-container-set">

            <div class="set-buy-wrap set-buy-wrap<?php echo $key; ?>">
                <div class="set-list<?php echo $key; ?> set-list  set-list-product set-list-product<?php echo $key; ?>">
                    <div class="set-product-wrap" id="mainprice<?php echo $key; ?>" data-product-id="<?php echo $product_id[$key]; ?>" data-price="<?php echo $price_clear[$key]; ?>" data-oldprice="<?php echo $price_clear[$key]; ?>" data-required-options="<?php if(is_array($products_required_options[$key][$product_id[$key]]) && count($products_required_options[$key][$product_id[$key]]) > 0) echo '1'; else echo '0'; ?>">
                        <h4><?php echo $text_your_product; ?></h4>
                        <div class="set-slider-img">
                            <span><img src="<?php echo $thumb[$key]; ?>" alt=""/></span>
                        </div>
                        <div class="set-slider-price">
                            <div>
                                <?php if (!$special[$key]) { ?>
                                <span class="set-price-new"><?php echo $price[$key]; ?></span>
                                <?php } else { ?>
                                <span class="set-price-new"><?php echo $special[$key];?></span>
                                <span class="set-price-old" style="text-decoration: line-through;"><?php echo $price[$key];?></span>
                                <?php } ?>
                            </div>
                        </div>
                        <div class="set-slider-text">
                            <p><?php echo $product_name[$key]; ?></p>
                        </div>

                    </div>
                </div>
                <?php foreach ($bundle_columns as $column => $products) { ?>
                <div class="set-list set-list<?php echo $key; ?>">
                    <span class="set-close set-close<?php echo $key; ?>"></span>
                    <ul id="set-slider-<?php echo $key; ?>-<?php echo $column; ?>" class="set-slider set-slider<?php echo $key; ?>">
                        <?php foreach ($products as $product) { ?>
                        <li data-product-id="<?php echo $product['product_id']?>" data-name="<?php echo $product['name'];?>" data-price="<?php echo $product['price_special_clear'];?>" data-oldprice="<?php echo $product['price_clear'];?>" data-required-options="<?php if(is_array($products_required_options[$key][$product['product_id']]) && count($products_required_options[$key][$product['product_id']]) > 0) echo '1'; else echo '0'; ?>">
                            <span class="set-percent "><?php echo $product['special_mark'];?></span>
                            <div class="set-slider-content">
                                <a href="<?php echo $product['href'];?>">
                                    <div class="set-slider-img">
                                        <span><img src="<?php echo $product['thumb'];?>" alt=""/></span>
                                    </div>
                                    <div class="set-slider-price set-slider-price<?php echo $key; ?>">
                                        <div>
                                            <span class="set-price-new"><?php echo $product['price_special'];?></span>
                                            <span class="set-price-old"><?php echo $product['price'];?></span>
                                        </div>
                                    </div>
                                    <div class="set-slider-text">
                                        <p><?php echo $product['name'];?></p>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <?php } ?>
                    </ul>
                </div>
                <?php } ?>

                <div class="set-list set-list<?php echo $key; ?> set-buy-equally">
                    <div class="buy-equally">
                        <span class="set-price-old" id="oldoverprice<?php echo $key; ?>"><?php echo $bundle_price[$key]; ?></span>
                        <span class="set-price-new" id="overprice<?php echo $key; ?>"><?php echo $bundle_special[$key]; ?></span>

                        <p><?php echo $text_economy; ?><br/>
                            <span id="saveprice<?php echo $key; ?>"><?php echo $save_price[$key]; ?></span></p>
                        <button type="" class="set-buy-btn" id="addbuttonid" onclick="formSet2(<?php echo $key; ?>)"><?php echo $button_bundle_buy; ?></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <?php } /*foreach($all_bundle_columns as $key => $bundle_columns)*/ ?>
</div>

<!-- Hidden forms Begin -->
<?php foreach($all_bundle_columns as $key => $bundle_columns) { ?>
<?php foreach($products_required_options[$key] as $pid => $product_options) { { ?>
<!-- Modal -->
<div class="modal fade" id="modal<?php echo $pid; ?>" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title"><?php echo $text_required_options_head; ?></h4>
            </div>
            <div class="modal-body" id="productoptions<?php echo $pid; ?>-<?php echo $key; ?>">
                <p><input type="hidden" name="product_id" value="<?php echo $pid; ?>">
                <p><input type="hidden" name="bundle_id" value="<?php echo $key; ?>">
                <p><input type="hidden" name="bundle_action_id" value="" class="bundle_action_id">
                    <?php foreach ($product_options as $option) { ?>
                    <?php if ($option['type'] == 'select') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                        <option value=""><?php echo $text_select; ?></option>
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <option value="<?php echo $option_value['product_option_value_id']; ?>" <?php if(isset($current_options[$key][$pid][$option['product_option_id']]) && $current_options[$key][$pid][$option['product_option_id']] == $option_value['product_option_value_id']) echo 'selected'; ?>><?php echo $option_value['name']; ?>
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
                        <div class="radio">
                            <label>
                                <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>"  <?php if(isset($current_options[$key][$pid][$option['product_option_id']]) && $option_value['product_option_value_id'] == $current_options[$key][$pid][$option['product_option_id']]) echo " checked='checked'" ; ?>/>
                                <?php echo $option_value['name']; ?>
                                <?php if ($option_value['price']) { ?>
                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                <?php } ?>
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
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" <?php if(isset($current_options[$key][$pid][$option['product_option_id']])  && in_array($option_value['product_option_value_id'],$current_options[$key][$pid][$option['product_option_id']])) echo " checked='checked'" ; ?>/>
                                <?php echo $option_value['name']; ?>
                                <?php if ($option_value['price']) { ?>
                                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                <?php } ?>
                            </label>
                        </div>
                        <?php } ?>
                    </div>
                </div>
                <?php } ?>

                <?php if ($option['type'] == 'text') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php if(isset($current_options[$key][$pid][$option['product_option_id']])) echo $current_options[$key][$pid][$option['product_option_id']] ; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'textarea') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php if(isset($current_options[$key][$pid][$option['product_option_id']])) echo $current_options[$key][$pid][$option['product_option_id']] ; ?></textarea>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'date') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <div class="input-group date">
                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php if(isset($current_options[$key][$pid][$option['product_option_id']])) echo $current_options[$key][$pid][$option['product_option_id']] ; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                    <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                    </span></div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'datetime') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <div class="input-group datetime">
                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php if(isset($current_options[$key][$pid][$option['product_option_id']])) echo $current_options[$key][$pid][$option['product_option_id']] ; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                    </span></div>
                </div>
                <?php } ?>
                <?php if ($option['type'] == 'time') { ?>
                <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                    <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                    <div class="input-group time">
                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php if(isset($current_options[$key][$pid][$option['product_option_id']])) echo $current_options[$key][$pid][$option['product_option_id']] ; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                    <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                    </span></div>
                </div>
                <?php } ?>
                <?php } ?></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" onclick="confirmoptions(<?php echo $pid; ?>)"><?php echo $button_cart; ?></button>
            </div>
        </div>

    </div>
</div>
<?php } ?>
<?php } ?>

<!-- Foreach scripts  BEGIN-->
<script>
    $(document).ready(function () {
        $('#set-slider-<?php echo $key; ?>-1').bxSlider({
            mode: 'vertical',
            infiniteLoop: true,
            slideMargin: 5,
            moveSlides: 1,
            touchEnabled: false,
            onSliderLoad: function(currentIndex) {
                //console.log(currentIndex)
                $('#set-slider-<?php echo $key; ?>-1').children().eq(currentIndex).addClass('active-slide');
                reloadSum(<?php echo $key; ?>);
            },
            onSlideBefore: function($slideElement){
                $slideElement.siblings().removeClass('active-slide');
                $slideElement.addClass('active-slide');
            },
            onSlideAfter: function(){
                reloadSum(<?php echo $key; ?>)
            }
        });
        $('#set-slider-<?php echo $key; ?>-2').bxSlider({
            mode: 'vertical',
            infiniteLoop: true,
            slideMargin: 5,
            moveSlides: 1,
            touchEnabled: false,
            onSliderLoad: function(currentIndex) {
                $('#set-slider-<?php echo $key; ?>-2').children().eq(currentIndex).addClass('active-slide');
                reloadSum(<?php echo $key; ?>);
            },
            onSlideBefore: function($slideElement){
                $slideElement.siblings().removeClass('active-slide');
                $slideElement.addClass('active-slide');
            },
            onSlideAfter: function(){
                reloadSum(<?php echo $key; ?>)
            }
        });

        $('#set-slider-<?php echo $key; ?>-3').bxSlider({
            mode: 'vertical',
            infiniteLoop: true,
            slideMargin: 5,
            moveSlides: 1,
            touchEnabled: false,
            onSliderLoad: function(currentIndex) {
                $('#set-slider-<?php echo $key; ?>-3').children().eq(currentIndex).addClass('active-slide');
                reloadSum(<?php echo $key; ?>);
            },
            onSlideBefore: function($slideElement){
                $slideElement.siblings().removeClass('active-slide');
                $slideElement.addClass('active-slide');
            },
            onSlideAfter: function(){
                reloadSum(<?php echo $key; ?>);
            }
        });
        $('.set-buy-wrap<?php echo $key; ?> .set-list<?php echo $key; ?> .set-close<?php echo $key; ?>').click(function () {
            $(this).parent().toggleClass('none');
            $(this).toggleClass('active');
            $(this).parent().find('ul .active-slide').toggleClass('none');
            reloadSum(<?php echo $key; ?>);
        });
        $('.set-list<?php echo $key; ?>').each(function(){
            if ($(this).find('.set-slider<?php echo $key; ?>').children('li:not(.bx-clone)').length == 1) {
                $(this).addClass('single');
            }
        })

    });
</script>
<!-- Foreach scripts  END-->

<?php } /* foreach */?>
<!-- Hidden forms End -->


<?php } /* if ($all_bundle_columns) */?>
<script type="text/javascript">
    $(document).ready(function () {
    <?php if(count($all_bundle_columns) > 1) { ?>
            $('.module-slider').owlCarousel({
                // mode: 'horizontal'
                items: 1
            });
        <?php } ?>
    });
    jQuery.exists = function(selector) {
        return ($(selector).length > 0);
    }
    function confirmoptions(product_id,key)
    {
//productoptions
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $('#productoptions'+product_id+'-'+key+' input[type=\'text\'], #productoptions'+product_id+'-'+key+' input[type=\'hidden\'], #productoptions'+product_id+'-'+key+' input[type=\'radio\'][checked=\'checked\'], #productoptions'+product_id+'-'+key+' input[type=\'checkbox\']:checked, #productoptions'+product_id+'-'+key+' select, #productoptions'+product_id+'-'+key+' textarea'),
            dataType: 'json',
            success: function(json) {
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
                    if (typeof window['showCart'] != 'undefined') {
                        setTimeout(function () {
                            showCart(json);
                            $('.cart__total-list').html(json['total']);
                            $('.cart__total-items').html(json['total_items']);
                            $('.cart').load('index.php?route=common/cart/info .cart > *');
                        }, 300);
                    }else{
                        $('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                    }
                    $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');
                    $('html, body').animate({ scrollTop: 0 }, 'slow');
                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                    $('#modal'+product_id).modal('hide');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    function formSet2(key) {
        $('.bundle_action_id').val(Math.floor(Math.random() * 1000000));
        var product1_id = parseInt($('#mainprice'+key).attr('data-product-id'));
        confirmoptions(product1_id,key);

        if ($.exists($('ul#set-slider-'+key+'-1 li.active-slide')) && !($('ul#set-slider-'+key+'-1 li.active-slide').hasClass('none'))) {
            var product2_id = parseInt($('ul#set-slider-'+key+'-1 li.active-slide').attr('data-product-id'));
            confirmoptions(product2_id,key);
        }

        if ($.exists($('ul#set-slider-'+key+'-2 li.active-slide')) && !($('ul#set-slider-'+key+'-2 li.active-slide').hasClass('none'))) {
            var product3_id = Number($('ul#set-slider-'+key+'-2 li.active-slide').attr('data-product-id'));
            confirmoptions(product3_id,key);
        }
        if ($.exists($('ul#set-slider-'+key+'-3 li.active-slide')) && !($('ul#set-slider-'+key+'-3 li.active-slide').hasClass('none'))) {
            var product4_id = Number($('ul#set-slider-'+key+'-3 li.active-slide').attr('data-product-id'));
            confirmoptions(product4_id,key);
        }
    }

    function reloadSum(key){
        var price1 = $('#mainprice'+key).attr('data-price');
        var oldprice1 = $('#mainprice'+key).attr('data-oldprice');

        if($.exists($('ul#set-slider-'+key+'-1 li.active-slide')) && !($('ul#set-slider-'+key+'-1 li.active-slide').hasClass('none'))) {
            var price2 = $('ul#set-slider-'+key+'-1 li.active-slide').attr('data-price');
            var oldprice2 = $('ul#set-slider-'+key+'-1 li.active-slide').attr('data-oldprice');
        } else {
            var price2 = 0;
            var oldprice2 = 0;
        }
        if ($.exists($('ul#set-slider-'+key+'-2 li.active-slide')) && !($('ul#set-slider-'+key+'-2 li.active-slide').hasClass('none'))) {
            var price3 = $('ul#set-slider-'+key+'-2 li.active-slide').attr('data-price');
            var oldprice3 = $('ul#set-slider-'+key+'-2 li.active-slide').attr('data-oldprice');
        } else {
            price3 = 0;
            oldprice3 = 0;
        }
        if ($.exists($('ul#set-slider-'+key+'-3 li.active-slide'))  && !($('ul#set-slider-'+key+'-3 li.active-slide').hasClass('none'))) {
            var price4 =  $('ul#set-slider-'+key+'-3 li.active-slide').attr('data-price');
            var oldprice4 = $('ul#set-slider-'+key+'-3 li.active-slide').attr('data-oldprice');
        } else {
            price4 = 0;
            oldprice4 = 0;
        }
        oversum = parseFloat(oldprice1)+parseFloat(oldprice2)+parseFloat(oldprice4)+parseFloat(oldprice3);
        sum = parseFloat(price1) + parseFloat(price2) + parseFloat(price3) + parseFloat(price4);
        sumsave = parseFloat(oversum) - parseFloat(sum);

        <?php if ($symbolleft) { ?>
            $('#oldoverprice'+key).html("<?php echo $symbolleft; ?>" + oversum.toLocaleString());
            $('#overprice'+key).html("<?php echo $symbolleft; ?>" + sum.toLocaleString());
            $('#saveprice'+key).html("<?php echo $symbolleft; ?>" + sumsave.toLocaleString());
        <?php } else { ?>
            $('#oldoverprice'+key).html(oversum.toLocaleString() + " <?php echo $symbolright; ?>");
            $('#overprice'+key).html(sum.toLocaleString() + " <?php echo $symbolright; ?>");
            $('#saveprice'+key).html(sumsave.toLocaleString() + " <?php echo $symbolright; ?>");
        <?php } ?>

    }


</script>

<!-- NeoSeo Product Bundle - end -->