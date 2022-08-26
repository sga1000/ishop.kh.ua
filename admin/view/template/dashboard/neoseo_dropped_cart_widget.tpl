<div class="panel panel-default panel-table panel-left-cart">
	<div class="panel-heading">
		<h3 class="panel-title"><a href="<?php echo $more; ?>"><?php echo $title; ?> (<?php echo $count_items; ?>)</a></h3>
		<a href="<?php echo $setting_widget; ?>" target="_blank" class="widget-link" ></a>
	</div>
	<div class="table-responsive">
		<table class="table">
			<?php if ($items) { ?>
			<thead>
				<tr>
					<?php if($show_dropped_cart_number == 1) { ?>
					<td class="text-center"><?php echo $column_dropped_cart_number; ?></td>
					<?php } ?>
					<?php if($show_customer == 1 || $show_email == 1 || $show_telephone == 1 || $show_notification == 1 || $show_date_modified == 1) { ?>
					<td><?php echo $column_customer; ?></td>
					<?php } ?>
					<?php if($show_total == 1) { ?>
					<td><?php echo $column_total; ?></td>
					<?php } ?>
					<td class="text-right"></td>
				</tr>
			</thead>
			<tbody>
				<?php foreach ($items as $item) { ?>
				<tr>
					<?php if($show_dropped_cart_number == 1) { ?>
					<td class="text-center"><?php echo $item['dropped_cart_id']; ?></td>
					<?php } ?>
					<?php if($show_customer == 1 || $show_email == 1 || $show_telephone == 1 || $show_notification == 1 || $show_date_modified == 1) { ?>
					<td class="customer-name">
						<?php if($show_customer == 1) { ?>
						<?php if($item['customer_view']) { ?>
						<a href="<?php echo $item['customer_view']; ?>" target="_blank"><?php echo $item['customer']; ?></a>
						<?php }else{ ?>
						<span><?php echo $item['customer']; ?></span>
						<?php } ?>
						<?php } ?>
						<?php if($show_email == 1 && $item['email']) { ?>
						<a href="mailto:<?php echo $item['email']; ?>"><?php echo $item['email']; ?></a>
						<?php } ?>
						<?php if($show_telephone == 1 && $item['telephone']) { ?>
						<a href="tel:<?php echo $item['telephone']; ?>"><?php echo $item['telephone']; ?></a>
						<?php } ?>
						<?php if($show_notification == 1) { ?>
						<span><b><?php echo $column_notification; ?></b>
							<b class="notification label <?php echo $item['notification'] > 0 ? 'label-success' : 'label-warning'; ?>"><?php echo $item['notification']; ?></b></span>
						<?php } ?>
						<?php if($show_date_modified == 1) { ?>
						<span><b><?php echo $column_date; ?></b> <?php echo $item['date_modified']; ?></span>
						<?php } ?>
					</td>
					<?php } ?>
					<?php if($show_total == 1) { ?>
					<td><?php echo $item['total']; ?></td>
					<?php } ?>
					<td class="text-right block-notify">
						<div class="block-flex">
							<a href="<?php echo $item['notify']; ?>" data-toggle="tooltip" title="<?php echo $button_notify; ?>" class="btn btn-detail" data-type="notification"><i class="fa fa-envelope"></i></a>
							<a href="<?php echo $item['view']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-detail" target="_blank"><i class="fa fa-arrow-right"></i></a>
						</div>
					</td>
				</tr>
				<?php } ?>
			</tbody>
			<?php } else { ?>
			<tbody>
				<tr>
					<td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
				</tr>
			</tbody>
			<?php } ?>
		</table>
	</div>
</div>
<script type="text/javascript">
	$('a[data-type=notification]').bind('click', function (e) {
		e.preventDefault();
		var el = $(this);
		el.prepend($('<i class="fa fa-refresh fa-spin fa-fw"></i> &nbsp;'));
		$.ajax({
			url: $(this).attr('href'),
			dataType: 'json',
			success: function (data) {
				var container = el.parents('.table-responsive');
				var alert = container.find('.alert');
				if (!alert[0])
					container.prepend($('<div class="alert"></div>'));
				var alert = container.find('.alert');
				alert.empty();
				if (data.result == 'success') {
					alert.attr('class', 'alert alert-success').append($('<i class="fa fa-check-circle"></i>'));
				} else {
					alert.attr('class', 'alert alert-danger').append($('<i class="fa fa-exclamation-circle"></i>'));
				}

				if (data.carts) {
					for (k in data.carts) {
						var span = el.parents('tr:first').find('.notification');
						if (data.carts[k]['notified'] > 0) {
							span.attr('class', 'notification label label-success');
						} else {
							span.attr('class', 'notification label label-danger');
						}
						span.html(data.carts[k]['notified']);
					}
				}
				if (data.message)
					alert.append(' ' + data.message);
				alert.delay(4000).slideUp(200, function () {
					$(this).remove();
				});
				el.find('i.fa-refresh').remove();
			}
		});
	});
</script>
