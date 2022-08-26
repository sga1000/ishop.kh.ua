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
		<a href="#" class="dropdown-toggle dropdown-arrow" data-toggle="dropdown"><?php echo $text_view; ?></a>
		<div id="range" class="dropdown-menu dropdown-menu-right">
			<table class="table" style="color: #666666;">
				<thead>
					<tr>
						<?php if($show_notfound_number == 1) { ?>
						<td><?php echo $column_notfound_number; ?></td>
						<?php } ?>
						<?php if($show_ip == 1) { ?>
						<td class="text-center"><?php echo $column_ip; ?></td>
						<?php } ?>
						<?php if($show_browser == 1) { ?>
						<td><?php echo $column_browser; ?></td>
						<?php } ?>
						<?php if($show_request_uri == 1) { ?>
						<td style="width: 250px;"><?php echo $column_request_uri; ?></td>
						<?php } ?>
						<?php if($show_referer == 1) { ?>
						<td><?php echo $column_referer; ?></td>
						<?php } ?>
						<?php if($show_date_record == 1) { ?>
						<td class="text-center"><?php echo $column_date_record; ?></td>
						<?php } ?>
						<?php if($show_add_redirect == 1 && $redirect_manager) { ?>
						<td class="text-center"></td>
						<?php } ?>
					</tr>
				</thead>
				<tbody>
					<?php if ($items) { ?>
					<?php foreach ($items as $item) { ?>
					<tr>
						<?php if($show_notfound_number == 1) { ?>
						<td><?php echo $item['notfound_id']; ?></td>
						<?php } ?>
						<?php if($show_ip == 1) { ?>
						<td><?php echo $item['ip']; ?></td>
						<?php } ?>
						<?php if($show_browser == 1) { ?>
						<td><?php echo $item['browser']; ?></td>
						<?php } ?>
						<?php if($show_request_uri == 1) { ?>
						<td ><?php echo $item['request_uri']; ?></td>
						<?php } ?>
						<?php if($show_referer == 1) { ?>
						<td><?php echo $item['referer']; ?></td>
						<?php } ?>
						<?php if($show_date_record == 1) { ?>
						<td class="text-center"><?php echo $item['date_record']; ?></td>
						<?php } ?>
						<?php if($show_add_redirect == 1 && $redirect_manager) { ?>
						<?php if ($item['isset_redirect']) { ?>
						<td> <span class="btn-detail btn-tile-success"><i class="fa fa-check" aria-hidden="true"></i></span></td>
						<?php }else{ if($item['add_redirect']) { ?>
						<td> <a href="<?php echo $item['add_redirect']; ?>" title="<?php echo $button_add_redirect; ?>" class="btn btn-detail pull-right" target="_blank"><i class="fa fa-plus" aria-hidden="true"></i> </a>
						</td>
						<?php } }?>
						<?php } ?>
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
</div>
