<div class="tile tile-dash">
	<div class="tile-heading"><a href="<?php echo $setting_widget; ?>" target="_blank" class="widget-link" ></a></div>
	<div class="tile-body">
		<a href="<?php echo $more; ?>" target="_blank"><?php echo $title; ?></a>
		<?php if ( $count_items > 0) { ?>
		<p class="pull-right items-count">
			<a href="<?php echo $more; ?>" target="_blank"><?php echo $count_items; ?></a>
		</p>
		<?php } else {?>
		<p class="pull-right items-count count-zero">
		<a href="<?php echo $more; ?>" target="_blank"><?php echo $count_items; ?></a>
		</p>
		<?php } ?>
	</div>
	<div class="tile-footer">
		<?php if ( $count_items > 0) { ?>
		<a href="#" class="dropdown-toggle dropdown-arrow" data-toggle="dropdown"><?php echo $text_view; ?></a>
		<div id="range" class="dropdown-menu dropdown-menu-right">
			<table class="table" style="color: #666666;">
				<thead>
					<tr>
						<?php if($show_review_number == 1) { ?>
						<td><?php echo $column_review_number; ?></td>
						<?php } ?>
						<?php if($show_product == 1) { ?>
						<td class="text-center"><?php echo $column_product; ?></td>
						<?php } ?>
						<?php if($show_author == 1) { ?>
						<td><?php echo $column_author; ?></td>
						<?php } ?>
						<?php if($show_status == 1) { ?>
						<td class="text-center"><?php echo $column_status; ?></td>
						<?php } ?>
						<?php if($show_date_added == 1) { ?>
						<td class="text-center"><?php echo $column_date_added; ?></td>
						<?php } ?>
						<?php if(($show_text == 1) || ($show_rating == 1)) { ?>
						<td class="text-center"><?php echo $column_text; ?></td>
						<?php } ?>
						<td></td>
					</tr>
				</thead>

				<tbody>
					<?php if ($items) { ?>
					<?php foreach ($items as $item) { ?>
					<tr>
						<?php if($show_review_number == 1) { ?>
						<td class="text-right"><?php echo $item['review_id']; ?></td>
						<?php } ?>
						<?php if($show_product == 1) { ?>
						<td class="text-left">
							<a href="<?php echo $item['product_href']; ?>" style="color: #1e91cf;" target="_blank">
								<?php if($item['product_image']) { ?>
								<img src="<?php echo $item['product_image']; ?>" title="<?php echo $item['product']; ?>" />
								<?php } ?>
								<?php echo $item['product']; ?>
							</a>
						</td>
						<?php } ?>
						<?php if($show_author == 1) { ?>
						<td>
							<?php if($item['customer_href']) { ?>
							<a href="<?php echo $item['customer_href']; ?>" style="color: #1e91cf;" target="_blank"><?php echo $item['author']; ?></a>
							<?php } else{ ?>
							<?php echo $item['author']; ?>
							<?php } ?>
						</td>
						<?php } ?>
						<?php if($show_status == 1) { ?>
						<td class="item-status">
							<div>
								<input name="review_item_status" type="checkbox" <?php echo $item["status"]? 'checked': ''; ?> data-item='<?php echo $item["review_id"]?>' data-toggle="toggle" data-on="<?php echo $text_status_enabled ?>" data-off="<?php echo $text_status_disabled ?>" data-onstyle="success" data-offstyle="danger">
							</div>
						</td>
						<?php } ?>
						<?php if($show_date_added == 1) { ?>
						<td><?php echo $item['date_added']; ?></td>
						<?php } ?>
						<?php if(($show_text == 1) || ($show_rating == 1))  { ?>
						<td class="text-left">
							<?php if($show_rating == 1) { ?>
							<div class="rating-wrap">
								<?php for ($i = 1; $i <= 5; $i++) { ?>
								<?php if ($item['rating'] < $i) { ?>
								<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
								<?php } else { ?>
								<span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
								<?php } ?>
								<?php } ?>
							</div>
							<?php } ?>

							<?php if($show_text == 1) { ?>
							<?php echo $item['text']; ?>
							<?php } ?>
						</td>
						<?php } ?>

						<td class="text-right"><a href="<?php echo $item['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-detail" target="_blank"><i class="fa fa-arrow-right"></i></a></td>
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
		<?php } ?>
	</div>
</div>

<script>
$(function(){
	$('input[name=review_item_status]').change(function(){
		var status = 0;
		if ($(this).prop('checked')) {
			status = 1;
		}
		var  review_id = $(this).data('item');
		
		$.ajax({
			url: 'index.php?route=dashboard/neoseo_review_widget/changeStatus&token=<?php echo $token;?>',
			type: 'post',
			data: {'status' : status, 'review_id' : review_id},
			dataType: 'json',
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
});
</script>