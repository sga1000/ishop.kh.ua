<div class="side-module box-shadow box-corner">
	<div class="related-product-container">
	<?php if (!empty($heading_title)) { ?>
	<h3><?php echo $heading_title; ?></h3>
	<?php } ?>
	<div class="row">
		<?php if (!empty($related_products)) { ?>
			<?php foreach ($related_products as $product) { ?>
			<div class="product-layout related-products-column col-lg-3 col-md-3 col-sm-6 col-xs-12">
				<div class="product-thumb transition">
					<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
					<div class="caption">
						<h4><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
						<?php if ($product['price']) { ?>
						<p class="price">
							<?php if (!$product['special']) { ?>
							<?php echo $product['price']; ?>
							<?php } else { ?>
							<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
							<?php } ?>
							<?php if ($product['tax']) { ?>
							<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
							<?php } ?>
						</p>
						<?php } ?>
					</div>
				</div>
			</div>
			<?php } ?>
		<?php } ?>
	</div>
	</div>
</div>
