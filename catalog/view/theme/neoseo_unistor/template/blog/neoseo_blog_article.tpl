<?php echo $header; ?>
<div class="container">
	<ul class="breadcrumb box-shadow box-corner">
		<?php $cnt = count($breadcrumbs); $i = 0; foreach ($breadcrumbs as $key => $breadcrumb) { ?>
			<li >
				<?php $i++; if( $i != $cnt ) { ?>
					<a  href="<?php echo $breadcrumb['href']; ?>">
						<span ><?php echo $breadcrumb['text']; ?></span>
					</a>
				<?php } else { ?>
					<a  href="<?php echo $breadcrumb['href']; ?>">
						<span ><?php echo $breadcrumb['text']; ?></span>
					</a>
				<?php } ?>
				<meta  content="<?php echo $key+1; ?>" />
			</li>
		<?php } ?>
	</ul>
	<div class="row">
		<?php echo $column_left; ?>
		
		<?php
			if ($column_left && $column_right) {
				$class = 'col-sm-6';
			} elseif ($column_left || $column_right) {
				$class = 'col-sm-9';
			} else {
				$class = 'col-sm-12';
			}
		?>
		<div id="content" class="blog-content <?php echo $class; ?>">
			<?php echo $content_top; ?>
			<div class="article-post box-shadow box-corner">
				<h1><?php echo $heading_title; ?></h1>
				<div class="entry-meta">
					<div class="entry-meta_top">
						<?php if ($date_modified) { ?>
							<span class="entry-date published">
								<?php echo $date_modified; ?>
							</span>
						<?php } ?>
						<?php if ($author) { ?>
							<span class="entry-author">
								<?php echo $text_author; ?>
								<a href="<?php echo $author['href'];?>">
									<?php echo $author['name']; ?>
								</a>
							</span>
						<?php } ?>
					</div>
					<div class="entry-meta_bottom">
						<?php if ($viewed) { ?>
							<span class="entry-views">
								<i class="fa fa-eye"></i>
								<?php echo $viewed; ?>
							</span>
						<?php } ?>
						<?php if ($total_comments) { ?>
							<a href="javascript:void(0)" id='show_blog_comments'  class="entry-comments-link">
								<i class="fa fa-commenting" aria-hidden="true"></i>
								<?php echo $total_comments; ?>
							</a>
						<?php } ?>
					</div>
				</div>
				
				<?php echo $sharing_code; ?>

				<div class="clearfix">
					<div class="aticle-body">
						<div class="article-description">
							<?php echo $description; ?>
						</div>

						<?php if (isset($images)) { ?>
							<?php if (!empty($gallery_heading)) { ?>
								<h3><?php echo $gallery_heading; ?></h3>
							<?php } ?>
							<div class="popup-gallery">
								<?php foreach ($images as $img) { ?>
									<a href="<?php echo $img['image']; ?>">
										<img src="<?php echo $img['thumb']; ?>" alt="" class="img-thumbnail">
									</a>
								<?php } ?>
							</div>
						<?php } ?>
					</div>
				</div>

				<?php if (!empty($related_products)) { ?>
					<h3><?php echo $text_related_products; ?></h3>
					<div class="row product-block">
						<?php foreach ($related_products as $product) { ?>
							<div class="product-layout product-grid col-lg-4 col-md-4 col-sm-6 col-xs-12">
								<div itemscope="" class="product-thumb clearfix">
									<div class="image">
										<a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>">
											<?php if ($product['thumb1']) { ?>
												<img class="hoverable" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive"  over="<?php echo $product['thumb1']; ?>" out="<?php echo $product['thumb']; ?>" />
											<?php } else { ?>
												<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
											<?php } ?>
										</a>
									</div>
									<div>
										<div class="rating-container">
											<span class="rating"<?php if ($article['rating']) { ?> <?php }?>>
												<?php if ($article['rating']) { ?>
													<meta  content="<?php echo $article['md_review_count']; ?>">
													<meta  content="<?php echo $article['rating']; ?>">
													<?php for ($i = 1; $i <= 5; $i++) { ?>
														<?php if ($article['rating'] < $i) { ?>
															<span class="fa fa-stack">
																<i class="fa fa-star-o fa-stack-2x"></i>
															</span>
														<?php } else { ?>
															<span class="fa fa-stack">
																<i class="fa fa-star fa-stack-2x"></i>
																<i class="fa fa-star-o fa-stack-2x"></i>
															</span>
														<?php }?>
													<?php } ?>
												<?php } ?>
											</span>
										</div>
										<div class="button-group">
											<button class="wishlist-button" type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i></button>
											<button class="compare-button" type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i></button>
										</div>
									</div>
									<div>
										<div class="caption">
											<h4 >
												<a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>">
													<?php echo $product['name']; ?>
												</a>
											</h4>
											<h5 class="text-center stock-status-text-<?php echo $product['stock_status_id']; ?>" <?php if (isset($colors_status[$product['stock_status_id']])) { echo "style=\"color: " . $colors_status[$product['stock_status_id']]['font_color'] . ";\""; } ?>>
												<b><?php echo $product['stock_status']; ?></b>
											</h5>
										</div>

										<?php if ($product['price']) { ?>
											<div class="price-and-cart-add">
												<div class="price-container">
													<p class="price" >
														<meta  content="<?php echo rtrim(preg_replace("/[^0-9\.]/", "", ($product['special'] ? $product['special'] : $product['price'])), '.'); ?>" />
														<meta  content="<?php echo $md_currency ?>"/>
														<link  href="http://schema.org/<?php echo ($product['md_availability'] ?'InStock' : 'OutOfStock') ?>" />
														<?php if (!$product['special']) { ?>
															<?php echo $product['price']; ?>
														<?php } else { ?>
															<span class="price-old">
																<?php echo $product['price']; ?>
															</span>
															<span class="price-new">
																<?php echo $product['special']; ?>
															</span>
														<?php } ?>
														<?php if ($product['tax']) { ?>
															<span class="price-tax">
																<?php echo $text_tax; ?> <?php echo $product['tax']; ?>
															</span>
														<?php } ?>
													</p>
												</div>
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
													<button class="cart-add-button" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
														<i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span>
													</button>
													<a class="buy-one-click" href="#">Купить в 1 клик</a>
												</div>
											</div>
										<?php } ?>
									</div>
									<div class="description" ><?php echo $product['description']; ?></div>
								</div>
							</div>
						<?php } ?>
					</div>
				<?php } ?>
			</div>

			<?php if (!empty($comments_block)) { ?>
				<?php echo $comments_block; ?>
			<?php } ?>

			<?php echo $content_bottom; ?>

			<div class="module">
				<?php if (!empty($related_articles)) { ?>
					<div id="related_articles" class="blog-content">
						<h3><?php echo $text_related_articles; ?></h3>
						<div itemscope="" class="row article-block ab-info">
							<?php foreach ($related_articles as $article) { ?>
								<div class="article-layout col-lg-4 col-md-4 col-sm-6 col-xs-12">
									<div class="news box-shadow box-corner article-layout">

										<div class="image">
											<a href="<?php echo $article['href']; ?>" title="<?php echo $article['name']; ?>"><img src="<?php echo $article['thumb']; ?>" alt="<?php echo $article['name']; ?>" title="<?php echo $article['name']; ?>" class="img-responsive" width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>"/></a>
										</div>

										<div class="caption">
											<div class="entry-meta">
											<span class="entry-date published">
											<?php echo $article['date_modified']; ?>
											</span>
												<div class="rating-container">
													<span class="rating"  <?php if ($article['rating']) { ?> <?php }?> >
													<?php if ($article['rating']) { ?>
													<meta  content="<?php echo $article['md_review_count']; ?>">
													<meta  content="<?php echo $article['rating']; ?>">
													<?php for ($i = 1; $i <= 5; $i++) { ?>
													<?php if ($article['rating'] < $i) { ?>
													<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
													<?php } else { ?>
													<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
													<?php }?>
													<?php } ?>
													<?php } ?>
													</span>
												</div>
											</div>

											<h4><a href="<?php echo $article['href']; ?>"><?php echo $article['name']; ?></a></h4>

											<p class="descripts"><?php echo $article['description']; ?></p>
											<div class="post-info">
												<span class="entry-views">
													<i class="fa fa-eye"></i>
													<?php echo $article['viewed']; ?>
												</span>
												<span class="entry-comments-link">
													<i class="fa fa-commenting" aria-hidden="true"></i>
													<?php echo $article['total_comments']; ?>
												</span>
											</div>
										</div>
									</div>
								</div>
							<?php } ?>
						</div>
					</div>
				<?php } ?>
			</div>
		</div>

		<?php echo $column_right; ?>
	</div>
</div>

<script>
	$(document).ready(function () {
		$('#show_blog_comments').click(function () {
			var top = $('#comments-header').offset().top;
			$('html,body').animate({scrollTop: top}, 2000);
		});

		$('.article-image a').magnificPopup({
			type:'image',
			callbacks: {
				resize: changeImgSize,
				imageLoadComplete: changeImgSize,
				change: changeImgSize
			}
		});
		$('.popup-gallery').magnificPopup({
			delegate: 'a',
			type: 'image',
			tLoading: 'Loading image #%curr%...',
			mainClass: 'mfp-img-mobile',
			gallery: {
				enabled: true,
				navigateByImgClick: true
			},
			image: {
				tError: '<a href="%url%">The image #%curr%</a> could not be loaded.'
			},
			callbacks: {
				resize: changeImgSize,
				imageLoadComplete :changeImgSize,
				change: changeImgSize
			}
		});
	});
	function changeImgSize() {
		var img = this.content.find('img');
		img.css('max-height', window.innerHeight);
		img.css('width', 'auto');
		img.css('max-width', 'auto');
	}
</script>

<?php echo $footer; ?>