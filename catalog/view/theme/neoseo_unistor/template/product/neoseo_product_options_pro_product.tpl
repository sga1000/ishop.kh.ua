<?php if($product_options_status) { ?>
<script>
	$(function() {
		$("<a class='options-button-reset' onClick='clearOptions(this);'><?php echo $button_reset; ?></a>").appendTo(".options-block");
	});
</script>

<script>
	var product_options_pro = <?php echo json_encode($product_options_pro) ?>;
	var product_options = <?php echo json_encode($options) ?>;
	var stock_checkout = <?php echo json_encode($stock_checkout) ?>;
	var product_current_option_value; //Текущее значение опции
	var product_current_product_option_id; //Текущая опция
	$(document).ready(function() {
		$('#product select, #product input').unbind(); // отбиндим дефолтное событие темы unistor, иначе будет каша

		$(document).on('change', '#product [name^="option"]', function() {
			//Определяем ведующую опцию
			if ($(this).prop('checked') == true) {
				product_current_option_value = $(this).val();
				product_current_product_option_id = $(this).attr('name').replace(/\D+/g, "");
			}

			var product_option_values = [];
			$('#product [name^="option"]:checked, #product option:selected').each(function() {
				var product_option_id = $(this).attr('name').replace(/\D+/g, "");
				if (product_option_id == product_current_product_option_id) {
					product_current_option_value = $(this).val();
				}
				product_option_values.push($(this).val());
			});

			//Определяем зависимость опций
			var dependent_options = [];
			var quantity_options = [];
			$.each(product_options_pro, function(key, value) {
				var options = key.split('_');
				if (options.length >= 2 && options.indexOf(product_current_option_value) != -1) {
					if (product_options_pro[key]['quantity'] > 0 || product_options_pro[key]['snwa_status'] == true ||stock_checkout == 1) {
						$.each(options, function(index, val) {
							if (val != product_current_option_value) {
								dependent_options.push(val)
								quantity_options[val]=product_options_pro[key]['quantity'];
							}
						});
					}
				}else{
					quantity_options[key]=product_options_pro[key]['quantity'];
				}
			});

			product_option_values.sort();
			var key = product_option_values.join('_');
			var article_changed = false;
			var model_changed = false;
			var price_changed = false;
			var label_price = $('.product-price');

			$('.options-block [name^="option"]').each(function() {
				var product_option_id = $(this).attr('name').replace(/\D+/g, "");
				if (product_option_id != product_current_product_option_id) {
					$(this).removeClass('disabled');
					if (product_current_product_option_id) {
						if (dependent_options.indexOf($(this).val()) == -1) {
							$(this).attr('disabled', true);
						} else {
							$(this).attr('disabled', false);
						}
					}
					if (quantity_options[$(this).val()] <= 0) {
						$(this).addClass('disabled');
					}
				} else {
					product_current_product_option_id = product_option_id;
				}
				$('#button-cart').attr('disabled', false);
			});


			if (typeof product_options_pro[key] != "undefined") {
				if (product_options_pro[key]['article'] != "") {
					$('.articul').text(product_options_pro[key]['article']);
					$('[itemprop="articul"] > span').text(product_options_pro[key]['article']);
					article_changed = true;
				}
				if (product_options_pro[key]['model'] != "") {
					$('.product_model').text(product_options_pro[key]['model']);
					$('[itemprop="model"] > span').text(product_options_pro[key]['model']);
					model_changed = true;
				}
				if (product_options_pro[key]['stock_status'] != "") {
					$('.status-text').text(product_options_pro[key]['stock_status']);
				}

				if (product_options_pro[key]['color_status'] != "") {
					$('.status-text').css('color', product_options_pro[key]['color_status']);
				}

				if (product_options_pro[key]['quantity'] > 0 || stock_checkout == 1) {
					showAddToCartProduct();
				} else if(product_options_pro[key]['snwa_status'] == true){
					getProductOptionStatusNWA('<?php echo $product_id;?>', key);
				}else {
					setDefaultProductPreference(product_option_values);
				}

				var price = parseFloat(product_options_pro[key].price);

				if (!isNaN(price)) {
					price_changed = true;
					//label_price.text(label_price.text().replace(',','.'));
				}

				if (price_changed) {
					label_price.unbind('price_change').bind('price_change', function(e, l, p, s, step) {
						if (l > p) {
							l = l - step;
							if (l < p) l = p;
						} else if (l < p) {
							l = l + step;

							if (l > p)l = p;
						}
						$(this).text($(this).text().replace(',','.').replace(/([\d\s\.]+)/gi, (l != p ? Math.round(l).toLocaleString() : l.toLocaleString())+' ').replace(',','.'));
						if (l != p) {
							setTimeout(function() {
								$('.product-price').trigger('price_change', [l, p, s, step]);
							}, s);
						}

					});
					var l_price = parseFloat(label_price.text().replace(',','.').replace(/[^\d\.]+/, ''));

					if (l_price != price) {

						label_price.trigger('price_change', [l_price, price, 25, Math.abs((l_price - price) / 10)]);
					}

				}
			} else if (typeof product_options_pro[key] == "undefined") {
				setDefaultProductPreference(product_option_values,dependent_options);
			} else {
			<?php if (isset($product_status)) { ?>
					$('.status-text').text('<?php echo $product_status; ?>');
				<?php } ?>
			<?php if (isset($product_stock_status_color)) { ?>
					$('.status-text').css('color', '<?php echo $product_stock_status_color; ?>');
				<?php } ?>
				setDefaultProductPreference();
			}

			getProductOptionImage(product_option_values);

			if (article_changed === false) {
				$('.articul').text('<?php echo $model; ?>');
				$('[itemprop="model"] > span').text('<?php echo $model; ?>');
			}

			if (model_changed === false) {
				$('.product_model').text('<?php echo $model; ?>');
				$('[itemprop="model"] > span').text('<?php echo $model; ?>');
			}

			if (price_changed === false) {
			<?php if($special) { ?>
					label_price.text('<?php echo $special; ?>');
				<?php }else{ ?>
					label_price.text('<?php echo $price; ?>');
				<?php } ?>
			}

		});
	});

	function setDefaultProductPreference(product_option_values,dependent_options) {

		if (typeof product_option_values != "undefined" && product_option_values.length === product_options.length) {
			$(product_option_values).each(function() {
				if(dependent_options.length > 0){
					$('#button-cart').attr('disabled', true);
				} else {
					var price = $('input[id*="r-"][value="'+this+'"]').attr('data-price');
					var prefix = $('input[id*="r-"][value="'+this+'"]').attr('data-prefix');
					var label_price = $('.product-price');
					if (isNaN(price) || price == '') { price = 0;}
					label_price.unbind('price_change').bind('price_change', function (e, l, p, s, step) {
						if (l > p) {
							l = l - step;
							if (l < p) l = p;
						} else if (l < p) {
							l = l + step;
							if (l > p) l = p;
						}
						$(this).text($(this).text().replace(',','.').replace(/^[\d\s\.]+/, (l != p ? Math.round(l).toLocaleString() : l.toLocaleString()) + ' '));
						if (l != p) {
							setTimeout(function () {
								$('.product-price').trigger('price_change', [l, p, s, step]);
							}, s);
						}
					});

					var l_price = parseFloat(label_price.text().replace(',','.').replace(/[^\d\.]+/, ''));
					price = parseFloat(price);
					if(prefix == '+' ){
						price = <?php echo (isset($special) && floatval($special) > 0)?floatval($special):floatval($price); ?> + price;
					}
					if(prefix == '-'){
						price = <?php echo (isset($special) && floatval($special) > 0)?floatval($special):floatval($price); ?>- price;
					}
					if (l_price != price) {
						label_price.trigger('price_change', [l_price, price, 25, Math.abs((l_price - price) / 10)]);
					}
				}
			<?php if (isset($product_status)) { ?>
					$('.status-text').text('<?php echo $product_status; ?>');
				<?php } ?>
			<?php if (isset($product_stock_status_color)) { ?>
					$('.status-text').css('color', '<?php echo $product_stock_status_color; ?>');
				<?php } ?>
			});
		}
		$('.status-text').show();
		if ($('#snwa-send-btn').length == 1) {
			$('#button-cart').hide();
		} else {
			$('#button-cart').show();
		}
	}

	function getProductOptionImage(product_option_values) {
		var images = [];
		$(product_option_values).each(function() {
			if (product_options_pro[this] !== undefined && product_options_pro[this].images.length > 0) {
				for (var i = 0; i < product_options_pro[this].images.length; i++) {
					images.push(product_options_pro[this].images[i]);
				}
			}
		});
		if (images.length > 0) {
			var html = '';
			$('.thumbnails .image-additional').remove();
			for (var j = 0; j < images.length; j++) {
				if (j == 0) {
					$('.thumbnails li:not(.image-additional) .thumbnail').attr('href', images[j].popup);
					$('.thumbnails li:not(.image-additional) img').attr('src', images[j].main);
					$('.zoomContainer .zoomLens img').attr('src', images[j].main);
					$('.big_image .thin-0 img').attr('data-zoom-image', images[j].popup);
					$('.zoomContainer .zoomWindowContainer > div:first').css('background-image', 'url(' + images[j].popup + ')');

					html += '<li class="image-additional">';
					html += '<a class="thumbnail active" href="' + images[j].main + '" title="<?php echo $heading_title; ?>" data-image="' + images[j].main + '" data-zoom-image="' + images[j].popup + '">';
					html += '<img id="img-add-org" src="' + images[j].thumb + '" title="<?php echo $heading_title; ?>" alt=""></a></li>';
				} else {
					html += '<li class="image-additional">';
					html += '<a class="thumbnail" href="' + images[j].main + '" title="<?php echo $heading_title; ?>" data-image="' + images[j].main + '" data-zoom-image="' + images[j].popup + '">';
					html += '<img id="img-add-' + j + '" src="' + images[j].thumb + '" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>"></a></li>';
				}
			}

			if ($('#zgalery').length == 1) {
				$('#zgalery ul').append(html);
			} else {
				$('.thumbnails li').append(html);
			}

			var images = [];
			$('.thumbnails .image-additional .thumbnail').each(function() {
				images.push({src: $(this).attr('href')});
			});

			initMagnificPopup();
			imgPropInit();
		} else {
			restoreDefaultImages();
		}

		$('.ZoomContainer img').attr('src',$('.thin-0').attr('href'));
		$('.zoomWindow').css('background-image', 'url(' + $('.thin-0').attr('href') + ')');

		setTimeout(function () {
			$('#zgalery .image-additional a').mouseenter(function(e) {

				$('.image-additional a.active').removeClass('active');
				$(this).addClass('active');
				var sr = $(this).attr('data-zoom-image');
				var hr = $(this).attr('href');

				$('.thumbnails li:first img:first').attr('src',hr).attr('data-zoom-image',sr);
				$('.thumbnails li:first a').attr('href',sr);


				$('.zoomLens img').attr('src',sr);
				$('.zoomWindow').css('background-image','url('+sr+')');

			});
		},1000);



		return true;
	}

	function initMagnificPopup() {
		var images = [];
		$('.thumbnails .image-additional .thumbnail').each(function() {
			images.push({
				src: $(this).attr('href')
			});
		});
		$('.thumbnails .thumbnail').magnificPopup({
			items: images,
			gallery: {
				enabled: true
			},
			type: 'image',
			callbacks: {
				open: function() {
					var activeIndex = parseInt($('#zgalery .image-additional a.active').parent('.image-additional').index());
					var magnificPopup = $.magnificPopup.instance;
					magnificPopup.goTo(activeIndex);
				}
			}

		});
	}

	function imgPropInit() {
		$('.image-additional a').mouseenter(function() {
			if ($(this).hasClass('active'))
				return;
			if ($(this).hasClass('thumb_360')) {
				$('.threesixty-block').show();
				$('.thumbnails .big_image').hide();
			} else {
				$('.big_image img').prop('style', '');
				$('.thumbnails .big_image').show();
				$('.threesixty-block').hide();
			}
			$('.image-additional a.active').removeClass('active');
			var sr = $(this).attr('data-zoom-image');
			var hr = $(this).attr('href');
			$('.thumbnails li:first img:first').attr('src', hr).attr('data-zoom-image', sr);
			$('.thumbnails li:first a').attr('href', sr);
			$(this).addClass('active');
			$('.zoomContainer .zoomLens img').attr('src', sr);
			$('.zoomContainer .zoomWindowContainer > div:first').css('background-image', 'url(' + sr + ')');
		});
	}

	function restoreDefaultImages() {
		var imgcnt = 0;
		var html = '';
	<?php if ($popup) { ?>
			$('.thumbnails li:not(.image-additional) .thumbnail').attr('href', "<?php echo $popup; ?>");
			$('.thumbnails li:not(.image-additional) img').attr('src', "<?php echo $thumb; ?>");
			$('.zoomContainer .zoomLens img').attr('src', "<?php echo $thumb; ?>");
			$('.big_image .thin-0 img').attr('data-zoom-image', "<?php echo $popup; ?>");
			$('.zoomContainer .zoomWindowContainer > div:first').css('background-image', 'url("<?php echo $popup; ?>")');

			html += '<li class="image-additional"><a class="thumbnail active" href="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" data-image="<?php echo $thumb; ?>" data-zoom-image="<?php echo $popup; ?>">';
			html += '<img id="img-add-org" src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></a></li>';
		<?php } else { ?>
			return;
		<?php } ?>

		$('.thumbnails .image-additional').remove();
	<?php if ($images) { ?>
		<?php foreach($images as $image) { ?>
				html += '<li class="image-additional"><a class="thumbnail" href="<?php echo $image['mouseover_thumb']; ?>" title="<?php echo $heading_title; ?>" data-image="<?php echo $image['mouseover_thumb']; ?>" data-zoom-image="<?php echo $image['popup']; ?>">';
				html += '<img id="img-add-' + imgcnt + '" src="<?php echo $image['thumb']; ?>" alt="<?php echo $heading_title; ?>" /></a></li>';
				imgcnt++;
			<?php } ?>
		<?php } ?>

		if ($('#zgalery').length == 1) {
			$('#zgalery ul').append(html);
		} else {
			$('.thumbnails li').append(html);
		}

		initMagnificPopup();
		imgPropInit();
	}

	function getProductOptionStatusNWA(product_id, option_key){
		$.ajax({
			url: 'index.php?route=module/neoseo_notify_when_available/getNotifyProductOptionStatus',
			type: 'post',
			data: {'product_id': product_id, 'options': option_key},
			dataType: 'json',
			success: function (json) {
				if (json.result == 'true') {
					hideAddToCartProduct(product_id, option_key, json['snwa_requests'][product_id]);
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});

	}
	function showAddToCartProduct(){
		$('#button-cart, #quick_order_block').show();
		$("#product input[name='quantity']").parent().show();
		$('#snwa-send-btn').remove();
	}


	function hideAddToCartProduct(product_id, option_key, snwa_request){
		var html = '';
		var checked = false;

		if(snwa_request['status'] == true){
			checked = true;
		}

		$('#button-cart, #quick_order_block').hide();
		$("#product input[name='quantity']").parent().hide();
		$('#snwa-send-btn').remove();

		html = '<button id="snwa-send-btn" type="button" onclick="showNWA('+product_id+',this);" data-checked="'+ checked +'" data-option-id="'+ option_key +'" class="btn btn-primary">';
		html +='<i class="fa fa-bell"></i>';
		html +=' <span class="hidden-xs hidden-sm hidden-md snwa_button_'+product_id+'">'+snwa_request['text_button']+'</span>';
		html +='</button>';

		$('.price-block').after(html);
	}
	$('#product [name^="option"]').trigger('change');
</script>
<?php } ?>