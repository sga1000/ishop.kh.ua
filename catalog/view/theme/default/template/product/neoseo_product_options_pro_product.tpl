<?php if($product_options_status) { ?>
<script>
 var options_pro = <?php echo json_encode($product_options_pro) ?>;
 var product_options = <?php echo json_encode($options) ?>;

 $(document).on('change', '#product [name^="option"]', function() {
     var product_option_values = [];
     $('#product [name^="option"]:checked, #product option:selected').each(function() {
         product_option_values.push($(this).val());
     });
     var option_images = [];
     product_option_values.sort();
     var key = product_option_values.join('_');
     var article_changed = false;
     var changed_changed = false;
     if (typeof options_pro[key] != "undefined") {
         if (options_pro[key]['article'] != "") {
             $('.articul').text(options_pro[key]['article']);
             article_changed = true;
         }
         if (options_pro[key].images.length != 0) {
             //TODO images insert;
         } else {
             option_images = mineOptionImages(product_option_values);
         }

         if (options_pro[key]['quantity'] <= 0) {
             return;
         }
         var price = parseFloat(options_pro[key].price);
         price_changed = false;
         if (!isNaN(price) && price != 0) {
             price_changed = true;
         }

         var label_price = $('.price-area');
         if (price_changed) {
             label_price.unbind('price_change').bind('price_change', function(e, l, p, s, step) {
                 if (l > p) {
                     l = l - step;
                     if (l < p) l = p;
                 } else if (l < p) {
                     l = l + step;
                     if (l > p) l = p;
                 }
                 $(this).text($(this).text().replace(/^[\d\s]+/, (l != p ? Math.round(l).toLocaleString() : l.toLocaleString()) + ' '));
                 if (l != p) {
                     setTimeout(function() {
                         $('.price-area').trigger('price_change', [l, p, s, step]);
                     }, s);
                 }
             });
             var l_price = parseFloat(label_price.text().replace(/[^\d\.]+/, ''));
             if (l_price != price) {
                 label_price.trigger('price_change', [l_price, price, 25, Math.abs((l_price - price) / 10)]);
             }
         }
     }
     if (article_changed === false) {
         $('.articul').text('<?php echo $model; ?>');
     }
 });

 function mineOptionImages(product_option_values) {
     var images = [];
     $(product_option_values).each(function() {
         if (options_pro[this] !== undefined && options_pro[this].images.length > 0) {
             for (var i = 0; i < options_pro[this].images.length; i++) {
                 images.push(options_pro[this].images[i]);
             }
         }
     });
     if (images.length > 0) {
         $('.thumbnails .image-additional').remove();
         for (var j = 0; j < images.length; j++) {
             if (j == 0) {
                 $('.thumbnails li:not(.image-additional) .thumbnail').attr('href', images[j].popup);
                 $('.thumbnails li:not(.image-additional) img').attr('src', images[j].main);
             } else {
                 var html = '<li class="image-additional">';
                 html += '<a class="thumbnail" href="' + images[j].popup + '" title="">';
                 html += '<img src="' + images[j].thumb + '" title="" alt=""></a></li>';
                 $('.thumbnails > li:last').after(html);
             }
         }
     } else {
         restoreDefaultImages();
     }

     return true;
 }

 function restoreDefaultImages() {
     <?php if($popup) { ?>
     var html = '';
     html += '<li><a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>">';
     html += '<img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>';
     $('.thumbnails > li').html(html);
     <?php }else { ?>
     return;
     <?php } ?>

     $('.thumbnails .image-additional').remove();

     <?php if ($images) { ?>
     html = '';
     <?php foreach ($images as $image) { ?>
     html += '<li class="image-additional"><a class="thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>">';
     html += '<img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a></li>';
     <?php } ?>
     <?php } ?>
     $('.thumbnails > li:last').after(html);
 }

 $('#product [name^="option"]').trigger('change');
</script>
<?php } ?>