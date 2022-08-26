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
					<?php if($show_callback_number == 1) { ?>
					<td class="text-center"><?php echo $column_callback_number; ?></td>
					<?php } ?>
					<?php if($show_customer == 1) { ?>
					<td><?php echo $column_customer; ?></td>
					<?php } ?>
					<?php if($show_status == 1) { ?>
					<td class="item-status text-center"  width="150"><?php echo $column_status; ?></td>
					<?php } ?>
					<?php if($show_date_added == 1) { ?>
					<td class="text-center"><?php echo $column_date_added; ?></td>
					<?php } ?>
					<?php if($show_message == 1) { ?>
					<td class="text-center"><?php echo $column_message; ?></td>
					<?php } ?>
					<?php if($show_comment == 1) { ?>
					<td class="text-center"><?php echo $column_comment; ?></td>
					<?php } ?>
					<?php if($show_manager == 1) { ?>
					<td class="text-center"><?php echo $column_manager; ?></td>
					<?php } ?>
					<td></td>
				</tr>
				</thead>
				<tbody>
				<?php if ($items) { ?>
				<?php foreach ($items as $item) { ?>
				<tr>
					<?php if($show_callback_number == 1) { ?>
					<td class="text-right"><?php echo $item['callback_id']; ?></td>
					<?php } ?>
					<?php if($show_customer == 1) { ?>
					<td>
						<?php echo $item['customer']; ?>
						<?php if($show_customer_email == 1 && $item['email']) { ?>
						<a href="mailto:<?php echo $item['email']; ?>" style="background: none;padding: 0;color: #1e91cf;"><?php echo $item['email']; ?></a>
						<?php } ?>
						<?php if($show_customer_telephone == 1 && $item['telephone']) { ?>
						<a href="tel:<?php echo $item['telephone']; ?>" style="background: none;padding: 0;color: #1e91cf; white-space: nowrap;"><?php echo $item['telephone']; ?></a>
						<?php } ?>
					</td>
					<?php } ?>
					<?php if($show_status == 1) { ?>
					<!-- <?php echo $item['text_status']; ?> -->
					<td class="item-status">
						<div ><input name="callback_item_status" type="checkbox" <?php echo $item["status"]? 'checked': ''; ?> data-item='<?php echo $item["callback_id"]?>' data-toggle="toggle" data-on="<?php echo $text_status_done ?>" data-off="<?php echo $text_status_new ?>" data-onstyle="success" data-offstyle="danger"></div></td>
					<?php } ?>
					<?php if($show_date_added == 1) { ?>
					<td><?php echo $item['date_added']; ?></td>
					<?php } ?>
					<?php if($show_message == 1) { ?>
					<td><?php echo $item['message']; ?></td>
					<?php } ?>
					<?php if($show_comment == 1) { ?>
					<td>
						<textarea name="callback_item_comment" class="form-control" rows="3" style="width: 200px;" data-item='<?php echo $item["callback_id"]?>'><?php echo $item['comment']; ?></textarea>
					</td>
					<?php } ?>
					<?php if($show_manager == 1) { ?>
					<td>
						<input name="callback_item_manager" class="form-control" style="width: 150px;" value="<?php echo $item['manager']; ?>" data-item='<?php echo $item["callback_id"]?>'>
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
		$('input[name=callback_item_status]').change(function(){
			var callback_id = 0;
			var status = 0;
			if ($(this).prop('checked')) {
				status = 1;
			}
			callback_id = $(this).data('item');

			$.ajax({
				url: 'index.php?route=dashboard/neoseo_callback_widget/changeStatus&token=<?php echo $token;?>',
				type: 'post',
				data: {'status' : status, 'callback_id' : callback_id},
				dataType: 'json',
				error: function (xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		});
		$('textarea[name=callback_item_comment]').change(function(){
			var callback_id = $(this).data('item');
			var comment = $(this).val();
			$.ajax({
				url: 'index.php?route=dashboard/neoseo_callback_widget/changeComment&token=<?php echo $token;?>',
				type: 'post',
				data: {'comment' : comment, 'callback_id' : callback_id},
				dataType: 'json',
				error: function (xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		});
		$('input[name=callback_item_manager]').change(function(){
			var callback_id = $(this).data('item');
			var manager = $(this).val();

			$.ajax({
				url: 'index.php?route=dashboard/neoseo_callback_widget/changeManager&token=<?php echo $token;?>',
				type: 'post',
				data: {'manager' : manager, 'callback_id' : callback_id},
				dataType: 'json',
				error: function (xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		});
	});
</script>
