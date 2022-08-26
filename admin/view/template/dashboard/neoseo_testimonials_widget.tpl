<div class="tile tile-dash">
	<div class="tile-heading"><a href="<?php echo $setting_widget; ?>" target="_blank" class="widget-link" ></a></div>
	<div class="tile-body">
		<a href="<?php echo $more; ?>" target="_blank"><?php echo $title; ?></a>
		<?php if ( $count_items > 0) { ?>
		<p class="pull-right items-count">
			<a href="<?php echo $more; ?>" target="_blank"><?php echo $count_items; ?></a>
		</p>
		<?php } else { ?>
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
						<?php if($show_testimonial_number == 1) { ?>
						<td class="text-right"><?php echo $column_testimonial_number; ?></td>
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
						<?php if(($show_text == 1) || ($show_rating == 1))  { ?>
						<td class="text-center"><?php echo $column_text; ?></td>
						<?php } ?>
						<?php if($show_image == 1) { ?>
						<td class="text-center"><?php echo $column_image; ?></td>
						<?php } ?>
						<?php if($show_youtube == 1) { ?>
						<td class="text-center"><?php echo $column_youtube; ?></td>
						<?php } ?>
						<?php if($show_admin_text == 1) { ?>
						<td class="text-center"><?php echo $column_admin_text; ?></td>
						<?php } ?>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<?php if ($items) { ?>
					<?php foreach ($items as $item) { ?>
					<tr>
						<?php if($show_testimonial_number == 1) { ?>
						<td><?php echo $item['testimonial_id']; ?></td>
						<?php } ?>
						<?php if($show_author == 1) { ?>
						<td><?php echo $item['name']; ?></td>
						<?php } ?>
						<?php if($show_status == 1) { ?>
						<td class="item-status text-center">
							<div>
								<input name="testimonials_item_status" type="checkbox" <?php echo $item["status"]? 'checked': ''; ?> data-item='<?php echo $item["testimonial_id"]?>' data-toggle="toggle" data-on="<?php echo $text_status_enabled ?>" data-off="<?php echo $text_status_disabled ?>" data-onstyle="success" data-offstyle="danger">
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
						
						<?php if($show_image == 1) { ?>
						<td>
							<?php if( $item['image']) { ?>
							<img src="<?php echo $item['image']; ?>" />
							<?php } ?>
						</td>
						<?php } ?>
						<?php if($show_youtube == 1) { ?>
						<td class="text-center">
							<?php if($item['youtube']) { ?>
							<a href="<?php echo $item['youtube']; ?>" target="_blank" class="btn btn-detail"><i class="fa fa-eye"></i></a>
							<?php } ?>
						</td>
						<?php } ?>
						<?php if($show_admin_text == 1) { ?>
						<td class="text-center">
							<textarea name="testimonials_admin_text" class="form-control" rows="3" style="width: 200px;" data-item='<?php echo $item["testimonial_id"]?>'><?php echo $item['admin_text']; ?></textarea>
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
	$('input[name=testimonials_item_status]').change(function(){
		var status = 0;
		if ($(this).prop('checked')) {
			status = 1;
		}
		var  testimonial_id = $(this).data('item');
		
		$.ajax({
			url: 'index.php?route=dashboard/neoseo_testimonials_widget/changeStatus&token=<?php echo $token;?>',
			type: 'post',
			data: {'status' : status, 'testimonial_id' : testimonial_id},
			dataType: 'json',
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
	$('textarea[name=testimonials_admin_text]').change(function(){
		var admin_text = $(this).val();
		var testimonial_id = $(this).data('item');
		
		$.ajax({
			url: 'index.php?route=dashboard/neoseo_testimonials_widget/changeComment&token=<?php echo $token;?>',
			type: 'post',
			data: {'admin_text' : admin_text, 'testimonial_id' : testimonial_id},
			dataType: 'json',
			error: function (xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
	});
});
</script>