<div class="cart <?php if (count($products) > 0) { ?>have-item<?php } ?>">

	<div data-toggle="dropdown" data-loading-text="<?php echo $text_loading; ?>" class="cart__list dropdown-toggle">
		<i class="ns-shopping-bag" aria-hidden="true" ></i>
		<div class="cart__total-list"><?php echo $text_items; ?></div>
	</div>
	<ul class="cart__products-list">
		<?php if ($products || $vouchers) { ?>
		<li>
			<?php foreach ($products as $product) { ?>
			<div class="cart-basket-item">
				<div class="cart-basket_image">
					<?php if ($product['thumb']) { ?>
					<a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail"/></a>
					<?php } ?>
				</div>
				<div class="cart-basket_info">
					<div class="cart-basket_title">
						<a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></a>
						<?php if ($product['option']) { ?>
						<?php foreach ($product['option'] as $option) { ?>
						<br/>
						-
						<small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
						<?php } ?>
						<?php } ?>
						<?php if ($product['recurring']) { ?>
						<br/>
						-
						<small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
						<?php } ?>
					</div>
					<div class="cart-basket_price-list">
						<div class="cart-basket_price">
							<?php echo $product['price']; ?>
						</div>
						<div class="cart-basket_quantity">
							<?php echo $product['quantity']; ?> шт
						</div>
						<div class="cart-basket_total-price">
							<?php echo $product['total']; ?>
						</div>
					</div>
					<div class="cart-basket_clean">
						<button class="cart-basket_clean-button" type="button" onclick="cart.remove('<?php echo $product['cart_id']; ?>');">
							<i class="fa fa-times"></i>
						</button>
					</div>
				</div>
			</div>
			<?php } ?>
		</li>
		<li>
			<div class="cart-basket-buttons">
				<a class="cart-button" href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a>


                <!-- NeoSeo QuickOrder - begin -->
                 <?php if(isset($neoseo_quick_order_popup_cart_template)) echo $neoseo_quick_order_popup_cart_template; ?>
                <!-- NeoSeo QuickOrder - end -->

            
				<a class="checkout-button" href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a>
			</div>
		</li>
		<?php } else { ?>
		<li>
			<p class="text-center"><?php echo $text_empty; ?></p>
		</li>
		<?php } ?>
	</ul>
</div>
