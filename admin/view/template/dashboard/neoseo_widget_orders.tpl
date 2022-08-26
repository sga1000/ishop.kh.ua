<div class="panel panel-default panel-table panel-orders">
	<div class="panel-heading">
		<h3 class="panel-title"><a href="<?php echo $more; ?>"><?php echo $title; ?> (<?php echo $count_items;?>)</a></h3>
		<a href="<?php echo $setting_widget; ?>" target="_blank" class="widget-link" ></a>
	</div>
	<div class="table-responsive">
		<table class="table">
			<thead>
				<tr>
					<?php if($show_order_number == 1) { ?>
					<td class="text-right"><?php echo $column_order_number; ?></td>
					<?php } ?>
					<?php if($show_customer == 1) { ?>
					<td><?php echo $column_customer; ?></td>
					<?php } ?>
					<?php if($show_order_status == 1) { ?>
					<td><?php echo $column_order_status; ?></td>
					<?php } ?>
					<?php if($show_order_total == 1) { ?>
					<td class="text-right"><?php echo $column_order_total; ?></td>
					<?php } ?>
					<?php if($show_date_added == 1) { ?>
					<td class="text-center"><?php echo $column_date_added; ?></td>
					<?php } ?>
					<td class="text-right"></td>
				</tr>
			</thead>
			<tbody>
				<?php if ($orders) { ?>
				<?php foreach ($orders as $order) { ?>
				<tr class="neworder-item">
					<?php if($show_order_number == 1) { ?>
					<td class="text-right"><?php echo $order['order_id']; ?></td>
					<?php } ?>
					<?php if($show_customer == 1) { ?>
					<td class="customer-name">
						<?php if($order['customer_view']) { ?>
						<a href="<?php echo $order['customer_view']; ?>" target="_blank"><?php echo $order['customer']; ?></a>
						<?php }else{ ?>
						<span><?php echo $order['customer']; ?></span>
						<?php } ?>
						<?php if($show_customer_email == 1 && $order['email']) { ?>
						<a href="mailto:<?php echo $order['email']; ?>"><?php echo $order['email']; ?></a>
						<?php } ?>
						<?php if($show_customer_telephone == 1 && $order['telephone']) { ?>
						<a href="tel:<?php echo $order['telephone']; ?>"><?php echo $order['telephone']; ?></a>
						<?php } ?>
					</td>
					<?php } ?>
					<?php if($show_order_status == 1) { ?>
					<td><?php echo $order['status']; ?></td>
					<?php } ?>
					<?php if($show_order_total == 1) { ?>
					<td class="text-right"><?php echo $order['total']; ?></td>
					<?php } ?>
					<?php if($show_date_added == 1) { ?>
					<td class="text-center"><?php echo $order['date_added']; ?></td>
					<?php } ?>
					<td class="text-right">
						<div class="block-flex vieworder-block">
							<?php if($show_order_view == 1) { ?>
							<a href="#" class="dropdown-toggle dropdown-arrow btn-info btn-detail" data-toggle="dropdown" title="Посмотреть" ><i class="fa fa-eye"></i></a>
							<div class="dropdown-menu dropdown-menu-right order-dropdown">
								<h4 class="order__title"><?php echo $text_order_number; ?> <span><?php echo $order['order_id']; ?></span></h4>
								<div class="order__subtitle"><?php echo $text_order_status; ?> <span><?php echo $order['status']; ?></span></div>
								<div class="block-flex">
									<div class="order__info">
										<h4 class="order__table-title"><?php echo $text_order_detail; ?></h4>
										<div class="order__table-item order-shop">
											<div class="icon-detail"><i class="fa fa-shopping-cart"></i></div>
											<a href="<?php echo $order['store_url']?>" target="_blank"><?php echo $order['store_name']; ?></a>
										</div>

										<div class="order__table-item order-date">
											<div class="icon-detail"><i class="fa fa-calendar"></i></div>
											<span><?php echo $order['date_added']; ?></span>
										</div>

										<div class="order__table-item order-payment-method">
											<div class="icon-detail"><i class="fa fa-credit-card"></i></div>
											<span><?php echo $order['payment_method']; ?></span>
										</div>
										<div class="order__table-item order-shipping-method">
											<div class="icon-detail"><i class="fa fa-truck"></i></div>
											<span><?php echo $order['shipping_method']; ?></span>
										</div>
										<?php if( $order['shipping_address']){ ?>
										<div class="order__table-item order-adr">
											<div class="icon-detail"><i class="fa fa-map-marker"></i></div>
											<span><?php echo $order['shipping_address']; ?></span>
										</div>
										<?php } ?>
									</div>

									<div class="customer__info">
										<h4 class="order__table-title"><?php echo $text_customer_detail; ?></h4>

										<div class="order__table-item customer-name">
											<div class="icon-detail"><i class="fa fa-user"></i></div>
											<?php if($order['customer_view']) { ?>
											<a href="<?php echo $order['customer_view']; ?>" target="_blank"><?php echo $order['customer']; ?></a>
											<?php }else{ ?>
											<span><?php echo $order['customer']; ?></span>
											<?php } ?>
										</div>

										<div class="order__table-item customer-status">
											<div class="icon-detail"><i class="fa fa-angle-double-right"></i></div>
											<span><?php echo $order['customer_group']?></span>
										</div>

										<div class="order__table-item customer-mail">
											<div class="icon-detail"><i class="fa fa-envelope"></i></div>
											<?php if($order['email']) { ?>
											<a href="mailto:<?php echo $order['email']; ?>"><?php echo $order['email']; ?></a>
											<?php } ?>
										</div>

										<div class="order__table-item customer-phone">
											<div class="icon-detail"><i class="fa fa-mobile"></i></div>
											<?php if($order['telephone']) { ?>
											<a href="tel:<?php echo $order['telephone']; ?>"><?php echo $order['telephone']; ?></a>
											<?php } ?>
										</div>

									</div>
								</div>

								<div class="order__content">
									<?php if($show_comment == 1) { ?>

									<table class="table" style="color: #666666;">
										<thead>
											<tr>
												<td><?php echo $column_product_name;?></td>
												<td class="text-center"><?php echo $column_product_quantity;?></td>
												<td class="text-right"><?php echo $column_product_price;?></td>
												<td class="text-right"><?php echo $column_product_total;?></td>
											</tr>
										</thead>
										<tbody>
											<?php if($order['products']) { ?>
											<?php foreach($order['products'] as $product) { ?>
											<tr>
												<td style="width: 40%;">
													<div class="block-flex product-name">
														<div class="product__img">
															<img class="img-responsive" src="<?php echo $product['image'];?>" alt="<?php echo $product['name']; ?>">
														</div>
														<div class="product__info">
															<?php if($product['model']) { ?>
															<span><?php echo $text_product_model;?> <?php echo $product['model']; ?></span>
															<?php } ?>
															<a href="<?php echo $product['href']; ?>" target="_blank"><?php echo $product['name']; ?>
																<?php foreach ($product['option'] as $option) { ?>
																<?php if ($option['type'] != 'file') { ?>
																&nbsp;<span> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></span>
																<?php } else { ?>
																&nbsp;<span> - <?php echo $option['name']; ?>: <a href="<?php echo $option['href']; ?>"><?php echo $option['value']; ?></a></span>
																<?php } ?>
																<?php } ?>
														</div>
													</div>
												</td>
												<td class="text-center"><?php echo $product['quantity']; ?></td>
												<td class="text-right"><?php echo $product['price']; ?></td>
												<td class="text-right"><?php echo $product['total']; ?></td>
											</tr>

											<?php } ?>
											<?php if($order['totals']) { ?>
											<?php foreach ($order['totals'] as $total) { ?>
											<tr>
												<td colspan="3" class="text-right" style="font-weight: 900;"><?php echo $total['title']; ?></td>
												<td class="text-right"><?php echo $total['text']; ?></td>
											</tr>
											<?php } ?>
											<?php } ?>
											<?php }else{ ?>
											<tr>
												<td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
											</tr>
											<?php } ?>
										</tbody>
									</table>

									<div class="order__comment">
										<h5 class="order__table-title"><?php echo $column_comment;?></h5>
										<?php echo $order['comment']; ?>
									</div> 
									<?php } ?>
									<?php if($show_order_referrer == 1) { ?>
									<div class="order__referrer">
										<h5 class="order__table-title"><?php echo $column_order_referrer;?></h5>
										<?php echo $order['first_referrer']; ?><br><?php echo $order['last_referrer']; ?>
									</div>
									<?php } ?>
								</div>
							</div>
							<?php } ?>
							<a href="<?php echo $order['view']; ?>" title="Перейти" class="btn btn-info btn-detail"><i class="fa fa-arrow-right"></i></a>
						</div>
					</td>
				</tr>
				<?php } ?>
				<?php } else { ?>
				<tr>
					<td class="text-center" colspan="10"><?php echo $text_no_results; ?></td>
				</tr>
				<?php } ?>
			</tbody>
		</table>
	</div>
</div>
