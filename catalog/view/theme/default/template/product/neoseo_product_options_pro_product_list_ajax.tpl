   
	    <?php if($category_options_enabled) { ?>
<script>
  var options_pro = {};
  var ajax_ready = [];

  $(document).on('change', '.options_pro_form [name^="option"]', function() {
      var form_data = $(this).parents('form').serialize();
      var product_id = $(this).parents('form').find('input[name="product_id"]').val();
      if (ajax_ready[product_id] === undefined) {
          ajax_ready[product_id] = true;
      }
      if (typeof options_pro[product_id] === 'undefined' && ajax_ready[product_id]) {
          ajax_ready[product_id] = false;
          $.ajax({
              url: 'index.php?route=module/neoseo_product_options_pro/getProductOptions',
              type: 'post',
              data: form_data,
              dataType: 'json',
              success: function(json) {
                  if (json['success']) {
                      options_pro[product_id] = json[product_id];
                      updateProductData(product_id);
                  } else {
                      options_pro[product_id] = false;
                      return;
                  }
                  ajax_ready[product_id] = true;
              }
          });
      } else if (options_pro[product_id] !== undefined && options_pro[product_id] !== false) {
          updateProductData(product_id);
      }
  });

  function updateProductData(product_id) {
      var product_id = product_id;

      var product_option_values = [];
      $('#product_options_form_' + product_id + ' [name^="option"]:checked, #product_options_form_' + product_id + ' [name^="option"]:selected').each(function() {
          product_option_values.push($(this).val());
      });

      product_option_values.sort();
      var key = product_option_values.join('_');
      var article_changed = false;
      var price_changed = false;
      if (typeof options_pro[product_id][key] != "undefined") {
          if (options_pro[product_id][key]['article'] != "") {
              $('.articul').text(options_pro[product_id][key]['article']);
              article_changed = true;
          }

          if (options_pro[product_id][key]['quantity'] <= 0) {
              return;
          }
          var price = parseFloat(options_pro[product_id][key].price);

          if (!isNaN(price) && price != 0) {
              price_changed = true;
          }

          if ($('#product_options_form_' + product_id).parents('.product-thumb').find('.price-new').length != 0) {
              var label_price = $('#product_options_form_' + product_id).parents('.product-thumb').find('.price-new');
          } else {
              var label_price = $('#product_options_form_' + product_id).parents('.product-thumb').find('.price');
          }
          if (price_changed) {
              label_price.unbind('price_change').bind('price_change', function(e, l, p, s, step) {
                  if (l > p) {
                      l = l - step;
                      if (l < p) l = p;
                  } else if (l < p) {
                      l = l + step;
                      if (l > p) l = p;
                  }
                  $(this).text($(this).text().replace(/^[\d\s]+/, (l != p ? Math.round(l).toLocaleString() : l.toLocaleString())));
                  if (l != p) {
                      setTimeout(function() {
                          label_price.trigger('price_change', [l, p, s, step]);
                      }, s);
                  }
              });
              var l_price = parseFloat(label_price.text().replace(/[^\d\.]+/, ''));
              if (l_price != price) {
                  label_price.trigger('price_change', [l_price, price, 20, Math.abs((l_price - price) / 10)]);
              }
          }
      }

      mineOptionImages(product_option_values, product_id);

      return;
  }

  function mineOptionImages(product_option_values, product_id) {

      var images = [];

      if (product_option_values.length > 0 && typeof options_pro[product_id] != "undefined") {
          if (options_pro[product_id]['image_priority'].length != 0) {
              var keys = options_pro[product_id]['image_priority'];
          } else {
              var keys = product_option_values.join('_');
          }
      } else {
          return;
      }

      $(product_option_values).each(function() {
          if (options_pro[product_id][this] !== undefined && options_pro[product_id][this].images.length > 0) {
              if (keys.indexOf(String(this)) != -1) {
                  for (var i = 0; i < options_pro[product_id][this].images.length; i++) {
                      images.push(options_pro[product_id][this].images[i]);
                  }
              }
          }
      });
      if (images.length > 0) {
          $('.thumbnails .image-additional').remove();
          for (var j = 0; j < images.length; j++) {
              if (j == 0) {
                  $('#product_options_form_' + product_id).parents('.product-thumb').find('.image img').attr('src', images[j].main);
              }
          }
      }

      return true;
  }

  function addToCart(product_id) {
      $.ajax({
          url: 'index.php?route=checkout/cart/add',
          type: 'post',
          data: $('form#product_options_form_' + product_id).serialize(),
          dataType: 'json',
          beforeSend: function() {
              $('#button-cart').button('loading');
          },
          complete: function() {
              $('#button-cart').button('reset');
          },
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

                  $('.text-danger').parent().addClass('has-error');
              }

              if (json['success']) {
                  $('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

                  $('#cart > button').html('<span id="cart-total"><i class="fa fa-shopping-cart"></i> ' + json['total'] + '</span>');

                  $('html, body').animate({
                      scrollTop: 0
                  }, 'slow');

                  $('#cart > ul').load('index.php?route=common/cart/info ul li');
              }
          },
          error: function(xhr, ajaxOptions, thrownError) {
              alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
      });
  }
</script>
<?php } ?>