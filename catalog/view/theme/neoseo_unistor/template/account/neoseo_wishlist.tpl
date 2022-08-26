<?php echo $header; ?>
<div class="container">
   <?php if (file_exists(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl')) { ?>
   <?php require_once(DIR_MODIFICATION . '/catalog/view/theme/neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
   <?php } else { ?>
   <?php  require_once(DIR_TEMPLATE . 'neoseo_unistor/template/common/breadcrumbs.tpl'); ?>
   <?php } ?>
   <div class="row">
      <?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>">
         <?php echo $content_top; ?>
         <div class="account-container box-shadow box-corner">
            <h1><?php echo $heading_title; ?></h1>
         </div>
         <?php if ($products) { ?>
         <div class="filters-box box-shadow box-corner">
            <div class="sort-list col-sm-5">
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
            <div class="style-list col-sm-3 text-center ">
               <div class="btn-group">
                  <button type="button" id="list-view" class="btn btn-default<?php if ($cat_view_type == 'list') { echo ' active'; } ?>" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
                  <button type="button" id="grid-view" class="btn btn-default<?php if ($cat_view_type == 'grid') { echo ' active'; } ?>" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th-large" aria-hidden="true"></i></i></button>
                  <button type="button" id="table-view" class="btn btn-default<?php if ($cat_view_type == 'table') { echo ' active'; } ?>" data-toggle="tooltip" title="<?php echo $button_table; ?>"><i class="fa fa-list"></i></button>
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

         <div class="row products-content">
            <?php foreach ($products as $product) { ?>
            <div class="product-layout product-grid col-lg-3 col-md-3 col-sm-6 col-xs-12">
               <div itemscope="" class="product-thumb box-shadow box-corner clearfix">
                  <div class="product-thumb_top">
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
                     <div class="image">
                        <a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>">
                        <?php if ($product['thumb1']) { ?>
                        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="hoverable img-responsive" data-over="<?php echo $product['thumb1']; ?>" data-out="<?php echo $product['thumb']; ?>" />
                        <?php } else { ?>
                        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                        <?php } ?>
                        </a>
                     </div>
                  </div>
                  <div class="product-thumb_middle">
                     <div class="rating-container">
                        <div class="caption">
                           <h4><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></a></h4>
                        </div>
                        <span class="rating">
                           <?php if($product['rating']){ ?>
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
                        <h4><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></a></h4>
                     </div>
                     <?php if ($product['price']) { ?>
                     <div class="price-and-cart-add">
                        <div class="price-wrapper">
                           <p class="price">
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
                           <!-- NeoSeo Notify When Available - begin -->
                           <?php if(!$product['snwa_status']){ ?>
                           <!-- NeoSeo Notify When Available - end -->
                           <!-- Neoseo Product Options PRO - begin -->
                           <?php if($product_list_status == 1) { ?>
                           <button class="cart-add-button"  type="button" onclick="addToCart('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>', this);"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>
                           <?php } else { ?>
                           <button class="cart-add-button" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs"><?php echo $button_cart; ?></span></button>
                           <?php } ?>
                           <!-- Neoseo Product Options PRO - end -->
                           <!-- NeoSeo Notify When Available - begin -->
                           <?php } ?>
                           <!-- NeoSeo Notify When Available - end -->
                        </div>
                     </div>
                  </div>
                  <div class="labels-wrap-table">
    <!-- NeoSeo Product Labels - begin -->
                        <?php if( isset($product['labels']) && count($product['labels'])>0 ) { ?>
                            <?php foreach($product['labels'] as $label_wrap => $group_label) { ?>
                                    <div class="wr-tag <?php echo $label_wrap; ?>">
                                       <?php foreach($group_label as $label) { ?>
                                       <div class="tag <?php echo $label['label_type']; ?> <?php echo $label['position']; ?> <?php echo $label['class']; ?>"><span style="<?php echo $label['style']; ?>"><?php echo $label['text']; ?></span></div>
                                       <?php } ?>
                                    </div>
                            <?php } ?>
                        <?php } ?>
                        <!-- NeoSeo Product Labels - end -->
</div>
                  <div class="description">
                     <div class="description-top">
                        <?php if (isset($product['additional_attributes']) && $product['additional_attributes']) { ?>
                        <div class="attributes-top">
                           <?php $counter = 1; ?>
                           <?php foreach ($product['additional_attributes'] as $key => $attribute) { ?>
                           <span><b><?php echo $attribute['name']; ?></b> <?php echo $attribute['text']; ?></span><?php if ($counter < $product['total_attributes']) { echo $divider ? $divider : ''; } ?>
                           <?php $counter++;
								 } ?>
                        </div>
                        <?php } ?>
                        <!-- Neoseo Product Options PRO - begin -->
                        <?php if($product['options']) { ?>
                        <form id="product_options_form_<?php echo $product['product_id']; ?>" class="options_pro_form">
                           <input type="hidden" name="product_id" value="<?php echo $product['product_id']; ?>">
                           <input type="hidden" name="minimum" value="<?php echo $product['minimum']; ?>">
                           <div class="caption">
                              <?php foreach($product['options'] as $option) { ?>
                              <?php if ($option['type'] == 'select') { ?>
                              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                 <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                 <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                                    <option value=""><?php echo $text_select; ?></option>
                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?></option>
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
                                       <label>
                                       <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                       <span class="square"><?php echo $option_value['name']; ?></span>
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
                                       <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" /> <?php echo $option_value['name']; ?>
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
                                    <div class="radio-carousel-box">
                                       <div class="radio-wrapper">
                                          <div class="radio-image-wrapper">
                                             <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                             <div class="radio radio-image">
                                                <label>
                                                   <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                                   <span><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /></span>
                                                   <!-- <?php echo $option_value['name']; ?> -->
                                                </label>
                                             </div>
                                             <?php } ?>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <?php } ?>
                              <?php } ?>
                           </div>
                        </form>
                        <?php } ?>
                        <!-- Neoseo Product Options PRO - end -->
                        <?php echo $product['short_description']; ?>
                     </div>
                     <div class="description-bottom">
                        <div class="button-group">
                           <a href="<?php echo $product['remove']; ?>" class="wishlist-button remove_it">
                              <i class="fa fa-close"></i>
                              <span><?php echo $text_remove_it; ?></span>
                           </a>
                           <a class="compare-button" onclick="compare.add('<?php echo $product['product_id']; ?>');">
                           <i class="ns-clone"></i>
                           <span><?php echo $text_compare; ?></span>
                           </a>
                           <?php if(!$product['snwa_status'] && $neoseo_quick_order_status ) { ?>
                           <a class="buy-one-click" onclick="showQuickOrder('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
                           <i class="ns-mouse"></i>
                           <span><?php echo $text_one_click_buy; ?></span>
                           </a>
                           <?php } elseif($product['snwa_status']) { ?>
                           <!-- NeoSeo Notify When Available - begin -->
                           <a type="button" class="buy-one-click" data-checked="<?php echo $product['snwa_requested'] ? 'true' : 'false'; ?>" data-product="<?php echo $product['product_id']?>"  onclick="showNWA('<?php echo $product['product_id'] ?>',this);">
                           <i class="fa fa-bell"></i>
                           <span><?php echo $product['snwa_requested'] ? $button_snwa_unsubscribe : $button_snwa_subscribe; ?></span>
                           </a>
                           <!-- NeoSeo Notify When Available - end -->
                           <?php }  ?>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <?php } ?>
         </div>
      </div>
      <div class="row paginator">
         <div class="col-sm-7 col-md-12 col-lg-7 text-left"><?php echo $pagination; ?></div>
         <div class="col-sm-5 col-md-12 col-lg-5 text-right"><?php echo $results; ?></div>
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