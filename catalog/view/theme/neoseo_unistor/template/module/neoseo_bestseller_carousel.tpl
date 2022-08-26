<div class="module-carousel">
   <?php if( $products ) { ?>
   <h3><?php echo $heading_title; ?></h3>
   <div class="row">
      <div class="carousel-nav">
         <div class="prev"><i class="fa fa-angle-left"></i></div>
         <div class="next"><i class="fa fa-angle-right"></i></div>
      </div>
      <div id="similar-carousel-<?php echo $module; ?>">
         <div class="carousel-wrapper">
            <?php foreach ($products as $product) { ?>
            <div class="carousel-item">
               <div class="product-layout product-grid">
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
                              <img src="<?php echo $product['thumb']; ?>" width="200" height="200" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="hoverable img-responsive" data-over="<?php echo $product['thumb1']; ?>" data-out="<?php echo $product['thumb']; ?>" />
                              <?php } else { ?>
                              <img src="<?php echo $product['thumb']; ?>"  width="200" height="200" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
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
                           <div class="description-text"><?php echo $product['short_description']; ?></div>
                        </div>
                        <div class="description-bottom">
                           <div class="button-group">
                              <a class="wishlist-button" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
                                 <i class="fa fa-heart"></i>
                                 <span><?php echo $text_wishlist; ?></span>
                              </a>
                              <a class="compare-button" onclick="compare.add('<?php echo $product['product_id']; ?>');">
                                 <i class="ns-clone"></i>
                                 <span><?php echo $text_compare; ?></span>
                              </a>
                              <?php if(!$product['snwa_status'] && $neoseo_quick_order_status) { ?>
                              <a class="buy-one-click" onclick="showQuickOrder('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
                                 <i class="ns-mouse"></i>
                                 <span><?php echo $text_one_click_buy; ?></span>
                              </a>
                              <?php } else { ?>
                              <!-- NeoSeo Notify When Available - begin -->
                              <a type="button" class="buy-one-click" data-checked="<?php echo $product['snwa_requested'] ? 'false' : 'true'; ?>" onclick="showNWA('<?php echo $product['product_id'] ?>',this);">
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
            </div>
            <?php } ?>
         </div>
      </div>
   </div>
   <?php } ?>
</div>
<script>
   $(document).ready(function () {

      $('#similar-carousel-<?php echo $module; ?>').Carousel({
         autoPlay         : true,
         playTime         : 3,
         desktop          : <?php echo $limit_p; ?>,
      tablet           : 1,
              phone           : 1
   });

   });

</script>